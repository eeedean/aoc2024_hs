{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE TupleSections #-}
module DayOne (dayone) where

import Data.List
import Data.Maybe

import qualified Data.Text as T
import Data.IntMap (IntMap)
import qualified Data.IntMap as IntMap

testfile :: FilePath
testfile = "input-files/1.test.txt"
realfile :: FilePath
realfile = "input-files/1.real.txt"

dayone :: IO ()
dayone = do
          inFile <- readFile realfile
          putStrLn $ "summed up distance between lists is " ++ show (firstPart inFile)
          putStrLn $ "similarity score of lists is " ++ show (secondPart inFile)

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

secondPart :: String -> Int
secondPart content = do
                      let
                        lists = readLists content
                        left = fst lists
                        countsOfRight = countAmounts $ snd lists
                      sum $ map (calcSimilarity countsOfRight) left

calcSimilarity :: IntMap Int -> Int -> Int
calcSimilarity counts key = key * fromMaybe 0 (counts IntMap.!? key)


countAmounts :: [Int] -> IntMap Int
countAmounts list = let
                      amounts :: [(Int, Int)]
                      amounts = map (, 1) list
                    in IntMap.fromListWith (+) amounts
