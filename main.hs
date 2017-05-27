module Main where

import System.Environment

import Zipper
import Tape
import Execution

sourceToList :: [Char] -> [Term]
sourceToList source = foldr charToTermList [] source
  where charToTermList :: Char -> [Term] -> [Term]
        charToTermList '+' tail' = (Incr : tail')
        charToTermList '-' tail' = (Decr : tail')
        charToTermList '>' tail' = (Next : tail')
        charToTermList '<' tail' = (Prev : tail')
        charToTermList ',' tail' = (Read : tail')
        charToTermList '.' tail' = (Write : tail')
        charToTermList '[' tail' = (Open : tail')
        charToTermList ']' tail' = (Close : tail')
        charToTermList _ tail'   = tail'


main :: IO ()
main =
  do
    --sourceFile <- head getArgs
    source <- readFile "./hello.bf" --filepath
    _ <- process (zipperFromList (sourceToList source)) (zipper 0)
    pure ()
    
