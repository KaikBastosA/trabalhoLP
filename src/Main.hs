module Main where

import Data.Set (Set)
import qualified Data.Set as Set
import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (foldl', sortBy)
import System.Environment (getArgs, getProgName)
import System.Exit (exitFailure)
import System.IO (hPutStrLn, stderr)

main :: IO ()
main = do
  args <- getArgs
  case args of
    [resPath, sepPath, c1Path, c2Path] ->
      run resPath sepPath c1Path c2Path
    _ -> do
      programName <- getProgName
      hPutStrLn stderr ("Uso: " ++ programName ++ " <res> <sep> <c1> <c2>")
      exitFailure

run :: FilePath -> FilePath -> FilePath -> FilePath -> IO ()
run resPath sepPath c1Path c2Path = do
  resContent <- readFile resPath
  sepContent <- readFile sepPath
  c1Content <- readFile c1Path
  c2Content <- readFile c2Path

  let reservedWords = Set.fromList (words resContent)
      separators = Set.fromList sepContent
      freq1 = weightedFrequencies reservedWords separators c1Content
      freq2 = weightedFrequencies reservedWords separators c2Content
      (mValue, totalF1, score) = similarity freq1 freq2

  printReport (sortedFrequencies freq1) mValue totalF1 score

tokenize :: Set Char -> String -> [String]
tokenize separators = go [] []
  where
    go current tokens [] =
      reverse (finish current tokens)
    go current tokens (ch : rest)
      | Set.member ch separators = go [] (finish current tokens) rest
      | otherwise = go (ch : current) tokens rest

    finish [] tokens = tokens
    finish current tokens = reverse current : tokens

weightedFrequencies :: Set String -> Set Char -> String -> Map String Int
weightedFrequencies reservedWords separators content =
  foldl' addToken Map.empty (tokenize separators content)
  where
    addToken frequencies token =
      Map.insertWith (+) token (tokenWeight token) frequencies

    tokenWeight token
      | Set.member token reservedWords = 2
      | otherwise = 1
    
sortedFrequencies :: Map String Int -> [(String, Int)]
sortedFrequencies =
  sortBy compareEntry . Map.toList
  where
    compareEntry (wordA, freqA) (wordB, freqB) =
      case compare freqB freqA of
        EQ -> compare wordA wordB
        ordering -> ordering

similarity :: Map String Int -> Map String Int -> (Int, Int, Double)
similarity freq1 freq2 =
  (mValue, totalF1, score)
  where
    totalF1 = sum (Map.elems freq1)
    mValue =
      sum
        [ f1
        | (word, f1) <- Map.toList freq1,
          let f2 = Map.findWithDefault 0 word freq2,
          isSimilarEnough f1 f2
        ]
    score
      | totalF1 == 0 = 0
      | otherwise = fromIntegral mValue / fromIntegral totalF1

isSimilarEnough :: Int -> Int -> Bool
isSimilarEnough f1 f2 = 10 * abs (f1 - f2) <= f1

printReport :: [(String, Int)] -> Int -> Int -> Double -> IO ()
printReport frequencies mValue totalF1 score = do
  putStrLn "Frequencias de c1:"
  mapM_ printFrequency frequencies
  putStrLn ""
  putStrLn ("m: " ++ show mValue)
  putStrLn ("soma(f1): " ++ show totalF1)
  printf "similaridade: %.4f\n" score
  where
    printFrequency (word, frequency) =
      putStrLn (word ++ " " ++ show frequency)
