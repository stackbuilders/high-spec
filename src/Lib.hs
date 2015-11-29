{-# LANGUAGE CPP                      #-}
{-# LANGUAGE DataKinds                #-}
{-# LANGUAGE DeriveGeneric            #-}
{-# LANGUAGE TypeFamilies             #-}
{-# LANGUAGE TypeOperators            #-}
{-# LANGUAGE ForeignFunctionInterface #-}

-- leave exports public so that they are easy to play with in GHCI
module Lib where

import           Foreign.C
import           Servant

foreign import ccall unsafe calculate_discount :: CInt -> CInt -> CInt

calculateDiscount :: Integer -> Integer -> Integer
calculateDiscount userId bookCount =
  fromIntegral $ calculate_discount (fromIntegral userId)
                                    (fromIntegral bookCount)

type BookStoreAPI = "user" :> Capture "userid" Integer
                           :> "discount"
                           :> Capture "book-count" Integer
                           :> Get '[JSON] Integer

handleCalculateDiscount :: Monad m => Integer -> Integer -> m Integer
handleCalculateDiscount id bookCount = return $ calculateDiscount id bookCount

bookStoreAPI :: Proxy BookStoreAPI
bookStoreAPI = Proxy

server :: Server BookStoreAPI
server = handleCalculateDiscount
