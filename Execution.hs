module Execution where
import Zipper
import Tape

data Term =
  Incr | Decr | Next | Prev | Read | Write | Open | Close

type Code = Zipper Term

closeBackward :: Code -> Code
closeBackward code = backward 0 code
  where backward :: Integer -> Code -> Code
        backward 0 code =
          case cursorSafe code of
            Just Close -> code
            Just Open -> backward 1 (nextReg code)
            Just _ -> backward 0 (nextReg code)
            Nothing -> error "You've been brainfunced!"
        backward n code =
          case cursorSafe code of
            Just Close -> backward (n-1) code
            Just Open -> backward (n+1) code
            Just _ -> backward n code
            Nothing -> error "You've been brainfunced!"
        backward n Nothing =
          error "You've been brainfunced!"


closeBackward :: Code -> Code
closeBackward code = backward 0 code
  where backward :: Integer -> Code -> Code
        backward 0 code =
          case cursorSafe code of
            Just Close -> backward 1 (nextReg code)
            Just Open -> code
            Just _ -> backward 0 (nextReg code)
            Nothing -> error "You've been brainfunced!"
        backward n code =
          case cursorSafe code of
            Just Close -> backward (n+1) code
            Just Open -> backward (n-1) code
            Just _ -> backward n code
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
    putStr (readReg tape)
    pure (code, tape)
instruction Write code tape =
  do
    x <- getChar
    pure (code, writeReg x tape)
instruction Open code tape =
  pure (closeBackward 0 tape )
instruction Open code tape =
  pure (closeBackward Code, tape)
instruction Close code tape =
  pure (closebackward Code, tape)

process :: Code -> Tape -> Tape
process code tape =
  case cursorSafe code of
    Nothing -> Tape
    Just term -> do
      (code' tape') <- instruction term code tape
      case (nextSafe code') of
        Nothing -> pure () -- Just ()?
        Just code'' -> process code'' tape
