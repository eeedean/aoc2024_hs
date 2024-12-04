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
          putStrLn $ "summed up distance between lists is " ++ show (firstPart inFile)

firstPart :: String -> Int
firstPart content = do
                    let
                      lists  = readLists content
                      left   = sort $ fst lists
                      right  = sort $ snd lists
                      distances = zipWith distanceBetween left  right
                    sum distances
            
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
