-- tape something something something
module Tape where
import Zipper

type Tape = Zipper Integer

alterReg :: (Integer -> Integer) -> Tape -> Tape
alterReg f tape  = replace (f (readReg tape)) tape

incrReg :: Tape -> Tape
incrReg t = alterReg incr t
  where incr :: Integer -> Integer
        incr n = n + 1

decrReg :: Tape -> Tape
decrReg t = alterReg decr t
  where decr :: Integer -> Integer
        decr n = n - 1

nextReg :: Tape -> Tape
nextReg tape =
  case nextSafe tape of
    Just tape' -> tape'
    Nothing -> insertAfter 0 tape

prevReg :: Tape -> (Tape)
prevReg tape =
  case prevSafe tape of
    Just tape' -> tape'
    Nothing -> insertBefore 0 tape


readReg :: Tape -> Integer
readReg tape =
  case cursorSafe tape of
    Just val -> val
    Nothing -> error "Tape initialised incorrectly. Empty Tape can not be read."

writeReg :: Integer -> Tape -> Tape
writeReg = replace
