module Main where

import           Network.Wai.Handler.Warp
import           Network.Wai
import           Lib
import           Servant.Server

app :: Application
app = serve bookStoreAPI server

main :: IO ()
main = run 8081 app


