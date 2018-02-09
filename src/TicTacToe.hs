{-# LANGUAGE OverloadedStrings #-}

module TicTacToe ( Game(..)
                 , playGame
                 ) where

import Data.Aeson.Types
import Data.Maybe (listToMaybe)

data Cell = X | O | Empty deriving (Eq, Show)
data Game = Game { grid :: [Cell]
                 , winner :: Cell
                 } deriving (Show)

instance ToJSON Game where
  toJSON game = object [ "grid"   .= grid game
                       , "winner" .= winner game
                       ]

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
                         <*> (maybe Empty id <$> v .:? "winner")
  parseJSON invalid    = typeMismatch "Game" invalid

playGame :: Game -> Game
playGame game = if Empty `elem` grid game
                then let grid' = playMove $ grid game
                     in Game grid' $ findWinner grid'
                else game { winner = findWinner $ grid game}
  where
    playMove   grid = replaceFirst Empty O grid

    replaceFirst a b [] = []
    replaceFirst a b (x:xs)
      | a == x    = b:xs
      | otherwise = x:replaceFirst a b xs

findWinner l = maybe Empty head $ listToMaybe wins
  where
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