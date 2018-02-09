{-# LANGUAGE OverloadedStrings #-}
module Site ( loginPage
            , playPage
            ) where

import Text.Blaze ((!))
import Text.Blaze.Html4.Strict as H
import Text.Blaze.Html4.Strict.Attributes as A


loginPage :: Html
loginPage = appTemplate "login" [] $ H.div $ do
  form ! method "POST" $ do
    "name"
    input ! type_ "text" ! name "name"

playPage :: String -> Html
playPage name = appTemplate "game" [] $ do
  p $ toHtml ("hi " ++ name)
  table ! class_ "board" $ do
    tr $ td "a" >> td "a" >> td "a"
    tr $ td "a" >> td "a" >> td "a"
    tr $ td "a" >> td "a" >> td "a"


appTemplate :: String -> [Html] -> Html -> Html
appTemplate title headers body = do
  html $ do
    H.head $ do
      H.title $ toHtml title
      meta ! httpEquiv "Content-Type" ! content "text/html;charset=utf-8"
      sequence_ headers
    H.body $ body
