module DayTwo (daytwo) where

testfile :: FilePath
testfile = "input-files/2.test.txt"
realfile :: FilePath
realfile = "input-files/2.real.txt"

type Report = [Int]

daytwo :: IO ()
daytwo = do
          inFile <- readFile realfile
          putStrLn $ "count of safe reports is " ++ show (firstPart inFile)

firstPart :: String -> Int
firstPart content = do
                    let
                      reports = map readReport (lines content)
                    length $ filter isSafe reports


readReport :: String -> Report
readReport content = let
                      numbers = words content
                     in
                     map read numbers

isSafe :: Report -> Bool
isSafe report = let
                  decreasing = fst $ foldr       stepIncreases  (True, last report) (init report)
                  increasing = fst $ foldl (flip stepIncreases) (True, head report) (tail report)
                in
                decreasing || increasing

stepIncreases :: Int -> (Bool, Int) -> (Bool, Int)
stepIncreases l (b, r) = let 
                        diff = l - r 
                      in 
                      (b && ((diff <= 3) && (diff > 0)), l)

