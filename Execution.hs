module Execution where

import Data.Char (ord,chr)

import Zipper
import Tape

data Term =
  Incr | Decr | Next | Prev | Read | Write | Open | Close

type Code = Zipper Term

openForward :: Code -> Code
openForward code = forward 0 (Just code)
  where forward :: Integer -> (Maybe Code) -> Code
        forward 0 (Just code) =
          case cursorSafe code of
            Just Close -> code
            Just Open -> forward 1 (nextSafe code)
            Just _ -> forward 0 (nextSafe code)
            Nothing -> error "You've been brainfunced!"
        forward n (Just code) =
          case cursorSafe code of
            Just Close -> forward (n-1) (nextSafe code)
            Just Open -> forward (n+1) (nextSafe code)
            Just _ -> forward n (nextSafe code)
            Nothing -> error "You've been brainfunced!"
        forward n Nothing =
          error "You've been brainfunced!"


closeBackward :: Code -> Code
closeBackward code = backward 0 (Just code)
  where backward :: Integer -> (Maybe Code) -> Code
        backward 0 (Just code) =
          case cursorSafe code of
            Just Close -> backward 1 (nextSafe code)
            Just Open -> code
            Just _ -> backward 0 (nextSafe code)
            Nothing -> error "You've been brainfunced!"
        backward n (Just code) =
          case cursorSafe code of
            Just Close -> backward (n+1) (nextSafe code)
            Just Open -> backward (n-1) (nextSafe code)
            Just _ -> backward n (nextSafe code)
            Nothing -> error "You've been brainfunced!"
        backward n Nothing =
          error "You've been brainfunced!"

instruction :: Term -> Code -> Tape -> IO (Code, Tape)
instruction Incr code tape = pure (code, incrReg tape)
instruction Decr code tape = pure (code, decrReg tape)
instruction Next code tape = pure (code, nextReg tape)
instruction Prev code tape = pure (code, prevReg tape)
instruction Read code tape =
  do
    putChar (chr ((fromInteger (readReg tape))::Int))
    pure (code, tape)
instruction Write code tape =
  do
    putStr "λ> " 
    x <- getChar
    pure (code, writeReg (toInteger (ord x)) tape)
instruction Open code tape =
  pure (closeBackward code, tape)
instruction Close code tape =
  pure (closeBackward code, tape)

process :: Code -> Tape -> IO (Tape)
process code tape =
  case cursorSafe code of
    Nothing -> pure (tape)
    Just term -> do
      (code', tape') <- instruction term code tape
      case (nextSafe code') of
        Nothing -> pure (tape)
        Just code'' -> process code'' tape
