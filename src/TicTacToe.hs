{-# LANGUAGE OverloadedStrings #-}

module TicTacToe ( Game(..)
                 , playGame
                 ) where

import Data.Aeson.Types
import Data.List
import Data.Maybe

data Cell = X | O | Empty deriving (Eq, Show)
data Game = Game { grid :: [Cell]
                 , winner :: Maybe Cell
                 } deriving (Show)

instance ToJSON Game where
  toJSON game = object $
    [ "grid" .= grid game ] ++
    (maybe [] ((:[]) . ("winner" .=)) $ winner game)

instance ToJSON Cell where
  toJSON X = String "X"
  toJSON O = String "O"
  toJSON Empty = String " "

instance FromJSON Cell where
  parseJSON (String "X") = return X
  parseJSON (String "O") = return O
  parseJSON (String " ") = return Empty

instance FromJSON Game where
  parseJSON (Object v) = Game
                         <$> v .:  "grid"
                         <*> v .:? "winner"
  parseJSON invalid    = typeMismatch "Game" invalid

playGame :: Game -> Game
playGame game = if isJust $ findWinner $ grd
                then ggame $ grd
                else ggame $ playMove $ grd
  where
    ggame g = Game g $ findWinner g
    grd = grid game


playMove :: [Cell] -> [Cell]
playMove grid = if not (null maxi)
                then playAt $ head maxi
                else if not (null mini)
                     then playAt $ head mini
                     else playRandomMove grid
  -- maybe (playRandomMove grid) id $ listToMaybe $ winningMoves grid O
  where mini = winningMoves grid X
        maxi = winningMoves grid O
        playAt = set grid O

playRandomMove :: [Cell] -> [Cell]
playRandomMove grid = set grid O $ head $ moves grid

winningMoves :: [Cell] -> Cell -> [Int]
winningMoves grid player = filter (winning . playAt) $ moves grid
  where winning = (Just player==) . findWinner
        playAt = set grid player


moves :: [Cell] -> [Int]
moves = elemIndices Empty

set :: [a] -> a -> Int -> [a]
set (x:xs) x' 0 = x':xs
set (x:xs) x' i = x:set xs x' (i-1)


findWinner :: [Cell] -> Maybe Cell
findWinner l = maybe drawOrNoWinner (Just . head) $ listToMaybe wins
  where
    drawOrNoWinner = if any (==Empty) l then Nothing else Just Empty
    wins = filter (not . (==Empty) . head) $ filter allSame rows
    allSame [] = True
    allSame (x:xs) = all (==x) xs
    rows = map (map (l !!)) threes
    threes = [ [0, 1, 2]
             , [3, 4, 5]
             , [6, 7, 8]
             , [0, 3, 6]
             , [1, 4, 7]
             , [2, 5, 8]
             , [0, 4, 8]
             , [6, 4, 2]
             ]
