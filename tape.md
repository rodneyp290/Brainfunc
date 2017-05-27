# Tape

`Type Tape = Zipper Integer`

# Brainfunc Gramma
```
data Term = Incr | Decr | Next | Prev | Read | Write | Open | Close
--           +      -      >      <      ,      .       [      ]
```

`type Code = Zipper Term`

## Functions
- incrRegister :: Zipper a -> Zipper a
- decrRegister :: Zipper a -> Zipper a
- nextRegister :: Zipper a -> Zipper a
- prevRegister :: Zipper a -> Zipper a
- readRegister :: Zipper a -> Zipper a
- openLoop
- closeLoop

## Program stuct/type
`Type Program = Zipper Term`

## instruction (execution) function
`instruction :: Term -> Code -> Tape -> (Code, Tape)`

```
openForward :: Code -> Code
openForward c = forward 0 (next c)
  where forward :: Integer -> Maybe Code -> Code
        forward 0 (Just c) =
          case cursorSafe c of
               Nothing -> error "You've been brainfunced!"
               (Just Clse) -> c
               (Just Open) -> forward 1 (next c)
               (Just _) -> forward 0 (next c)
        forward n (Just c) =
          case cursorSafe c of
              Nothing -> Error "You've been brainfunced!"
              (Just Clse) -> c
              (Just Open) -> forward 1 (next c)
              (Just _) -> forward n (next c)
        forward n Nothing =
          error "You've been brainfunced!"
```



## tape creation
```hs
tape::Tape
tape = Zipper zeros 0 zeros
where zeros = 0:zeros
```




## Alterative: Syntax Tree
```
Program =
