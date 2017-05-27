
## Process

```
Type Code = Zipper Type
process :: Code -> Tape -> Tape
process code tape =
  case cursorSafe code of
    Nothing -> tape
    Just term  ->
       case (next code') of
         Nothing -> tape
         Just code'' -> process code'' tape'
       where (code', tape') = instruction term code tape  
```

## instructionIO
```
instructionIO :: Term -> Code -> Tape -> IO(Code, Tape)
instructionIO Read code tape =
  do putStrLn (readRegister tape)
     pure (code, tape)

instructionIO Write code tape =
  do
    x <- getLine
    pure (code, writeReg x tape)
instructionIO term code tape = pure ( instruction term code tape )
```

## processIO
```
processIO :: Code -> Tape -> IO ()
processIO code tape =
  case cursorSafe code of
    Nothing -> pure ()
    Just term -> do
      (code', tape') <- instructionIO term code tape
      case (next code') of
        Nothing -> pure ()
        Just code'' -> processIO code'' tape
```
