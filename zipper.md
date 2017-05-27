# Zipper

## Structure

`data Zipper a = Zip | Zipper [a] a [a]`

maybe we could use `zeros = 0:zeros`

initial tape
```
tape :: Zipper a
tape = Zipper zeros 0 zeros
```
### cursorSafe (function
#### cases to handle
`Zipper [] a [] ` and a is _nothing_

_maybe_ we should use a Maybe
`data Maybe a = Nothing | Just a`

### prev/next Safe
`Zipper [] a [] ` - what do we put in the headed

### insert/shove before/after (left/right)
and move head to inserted value
 - needed for :
```
shoveLeft Zip a = [a] ???? []
```
- [ ] done

### replace

### zipper
```
zipper :: Zipper
zipper a = Zipper [] a []
```

# zipperFromList
