{-# LANGUAGE OverloadedStrings #-}
module Site ( loginPage
            , playPage
            ) where

import Data.Time.Clock
import Text.Blaze ((!))
import Text.Blaze.Html4.Strict as H
import Text.Blaze.Html4.Strict.Attributes as A


loginPage :: Html
loginPage = appTemplate "login" [] $ H.div $ do
  form ! method "POST" $ do
    "name"
    input ! type_ "text" ! name "name"

playPage :: String -> UTCTime -> Html
playPage name date = appTemplate "game" headers $ do
  p $ toHtml $ "Hello " ++ name ++ " " ++ show date
  p "" ! A.id "winner"
  table ! class_ "board" $ do
    tr $ cell "" >> cell "" >> cell ""
    tr $ cell "" >> cell "" >> cell ""
    tr $ cell "" >> cell "" >> cell ""
  where headers = [ script "" ! src "/static/js/ttt.js"
                  , script "" ! src "http://underscorejs.org/underscore.js"
                  , link ! rel "stylesheet" ! href "/static/css/ttt.css"
                  ]
        cell s = td $ H.span s ! class_ "cell"


appTemplate :: String -> [Html] -> Html -> Html
appTemplate title headers body = do
  html $ do
    H.head $ do
      H.title $ toHtml title
      meta ! httpEquiv "Content-Type" ! content "text/html;charset=utf-8"
      sequence_ headers
    H.body $ body
