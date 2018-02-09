{-# LANGUAGE OverloadedStrings #-}
module Main where

import Control.Monad
import Control.Monad.IO.Class (liftIO)
import Data.Aeson
import Data.Aeson.Types
import qualified Data.ByteString.Lazy.Char8 as L
import Happstack.Server
import qualified Text.Blaze.Html4.Strict as H

import Site
import TicTacToe

main :: IO ()
main = simpleHTTP nullConf $ handlers

handlers :: ServerPartT IO Response
handlers = do
  decodeBody myPolicy
  msum [ nullDir              >> msum [ method [GET]  >> sendPage loginPage
                                      , method [POST] >> verifyLogin
                                      ]
       , dir "play" $ nullDir >> method [POST] >> replyGame
       ]
  where
    verifyLogin = do method POST
                     name <- look "name"
                     sendPage $ playPage name
    sendPage = ok . toResponse
    myPolicy = defaultBodyPolicy "/tmp/" 0 1000 1000
    replyGame = do
      body <- getBody
      let json = decode body :: Maybe Game
      maybe
        (badRequest $ toResponse $ L.pack "Bad request.")
        (ok . toResponse . encode . playGame)
        json

getBody :: ServerPart L.ByteString
getBody = do
    req  <- askRq
    body <- liftIO $ takeRequestBody req
    case body of
        Just rqbody -> return . unBody $ rqbody
        Nothing     -> return ""
