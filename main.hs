module Main where

import System.Environment

import Zipper
import Execution

sourceToList :: [Char] -> [Term]
sourceToList source = foldr charToTermList [] source
  where charToTermList :: Char -> [Term] -> [Term]
        charToTermList '+' tail' = (Incr : tail')
        charToTermList '-' tail' = (Decr : tail')
        charToTermList '>' tail' = (Next : tail')
        charToTermList '<' tail' = (Prev : tail')
        charToTermList '.' tail' = (Read : tail')
        charToTermList ',' tail' = (Write : tail')
        charToTermList '[' tail' = (Open : tail')
        charToTermList ']' tail' = (Close : tail')
        charToTermList _ tail'   = tail'


main :: IO ()
main =
  do
    args <- getArgs
    program <- getProgName
    case length args of
        0 -> error ("Usage: " ++ program ++ " <source.hs>")
        _ ->
          do
            let sourceFile = head args
            source <- readFile sourceFile
            _ <- process (zipperFromList (sourceToList source)) (zipper 0)
            pure ()
