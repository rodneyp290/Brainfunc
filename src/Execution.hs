module Execution where

import Data.Char (ord,chr)
import Data.Bool (bool)
import System.IO

import Zipper
import Tape

data Term =
  Incr | Decr | Next | Prev | Read | Write | Open | Close

type Code = Zipper Term

openForward :: Code -> Code
openForward code = forward 0 (nextSafe code)
  where forward :: Integer -> (Maybe Code) -> Code
        forward 0 (Just code') =
          case cursorSafe code' of
            Just Close -> code'
            Just Open -> forward 1 (nextSafe code')
            Just _ -> forward 0 (nextSafe code')
            Nothing -> error "You've been brainfunced!"
        forward n (Just code') =
          case cursorSafe code' of
            Just Close -> forward (n-1) (nextSafe code')
            Just Open -> forward (n+1) (nextSafe code')
            Just _ -> forward n (nextSafe code')
            Nothing -> error "You've been doubling brainfunced!"
        forward _ Nothing =
          error "You've been bbbbbrrrraaaiinffffffuuuuunnnnccceed!"


closeBackward :: Code -> Code
closeBackward code = backward 0 (prevSafe code)
  where backward :: Integer -> (Maybe Code) -> Code
        backward 0 (Just code') =
          case cursorSafe code' of
            Just Close -> backward 1 (prevSafe code')
            Just Open -> code'
            Just _ -> backward 0 (prevSafe code')
            Nothing -> error "You've been reverse brainfunced!"
        backward n (Just code') =
          case cursorSafe code' of
            Just Close -> backward (n+1) (prevSafe code')
            Just Open -> backward (n-1) (prevSafe code')
            Just _ -> backward n (prevSafe code')
            Nothing -> error "You've been doubling reverse brainfunced!"
        backward _ Nothing =
          error "You've been reverse bbbbbrrrraaaiinffffffuuuuunnnnccceed!"

instruction :: Term -> Code -> Tape -> IO (Code, Tape)
instruction Incr code tape = pure (code, incrReg tape)
instruction Decr code tape = pure (code, decrReg tape)
instruction Next code tape = pure (code, nextReg tape)
instruction Prev code tape = pure (code, prevReg tape)
instruction Read code tape =
  do
    putChar (chr ((fromInteger (readReg tape))::Int))
    hFlush stdout
    pure (code, tape)
instruction Write code tape =
  do
    putStr "λ> " 
    hFlush stdout
    x <- getChar
    pure (code, writeReg (toInteger (ord x)) tape)
instruction Open code tape =
  pure (bool (code, tape) (openForward code, tape) 
            ((readReg tape) == 0)
       )
instruction Close code tape =
  pure (bool (code, tape) (closeBackward code, tape)
            ((readReg tape) /= 0)
       )

process :: Code -> Tape -> IO (Tape)
process code tape =
  case cursorSafe code of
    Nothing -> pure (tape)
    Just term -> do
      (code', tape') <- instruction term code tape
      case (nextSafe code') of
        Nothing -> pure (tape)
        Just code'' -> process code'' tape'
