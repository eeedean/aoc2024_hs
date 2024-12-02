{-# LANGUAGE OverloadedStrings #-}
module DayOne (dayone) where

import Data.List

import qualified Data.Text as T

testfile :: FilePath
testfile = "input-files/1.test.txt"
realfile :: FilePath
realfile = "input-files/1.real.txt"

dayone :: IO ()
dayone = do
          inFile <- readFile realfile
          let 
            lists  = readLists inFile
            left   = sort $ fst lists
            right  = sort $ snd lists
            distances = zipWith distanceBetween left  right
            result = sum distances
          print result
            
readLists :: String -> ([Int], [Int])
readLists input = unzip $ map splitLine (lines input)

splitLine :: String -> (Int, Int)
splitLine line = (left, right)
            where
              elements = T.splitOn "   " (T.pack line)
              left  = read (T.unpack $ head elements) :: Int
              right = read (T.unpack $ last elements) :: Int

distanceBetween :: Int -> Int -> Int
distanceBetween x y 
              | x < y     = y - x
              | otherwise = x - y
