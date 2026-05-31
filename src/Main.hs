module Main where

import Data.Set (Set)
import qualified Data.Set as Set
import Data.Map (Map)
import qualified Data.Map as Map
import Data.List (foldl')
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
sortedFrequencies = undefined

similarity :: Map String Int -> Map String Int -> (Int, Int, Double)
similarity = undefined

printReport :: [(String, Int)] -> Int -> Int -> Double -> IO ()
printReport = undefined
