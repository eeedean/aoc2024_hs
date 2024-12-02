module Lib (main) where

import qualified BookStore

main :: IO ()
main = print (BookStore.Book 312974 "Unterm Rad" ["Hermann Hesse"] )



