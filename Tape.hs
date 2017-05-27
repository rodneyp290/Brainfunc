-- tape something something something
module Tape where
import Zipper

Type Tape = Zipper Integer

alterReg :: Tape -> Tape
alterReg f tape  =
  case cursorSafe tape of
    Just cursor -> replace (f cursor) tape
    Nothing -> error "test"

incrReg :: Tape -> Tape
incrReg t = alterReg (+1) t

decrReg :: Tape -> Tape
decrReg t = alterReg (-1) t

nextReg :: Tape -> (Maybe Tape)
nextReg tape =
  case nextSafe tape of
    Just tape' -> tape'
    Nothing -> insertAfter 0 tape

prevReg :: Tape -> (Tape)
prevReg tape =
  case prevSafe tape of
    Just tape' -> tape'
    Nothing -> insertBefore 0 tape


readReg :: Tape -> Int