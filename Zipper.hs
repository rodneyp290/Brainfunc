module Zipper where

-- Zipper something something something
data Zipper a = Zip | Zipper [a] a [a]

zipper :: a -> Zipper a
zipper cursor = Zipper [] cursor []

zipperFromList :: [a] -> Zipper a
zipperFromList []  = Zip
zipperFromList (h:t) = Zipper [] h t

cursorSafe :: Zipper a -> Maybe a
cursorSafe Zip = Nothing
cursorSafe (Zipper _ c _) = Just c

nextSafe :: Zipper a -> Maybe (Zipper a)
nextSafe Zip = Nothing
nextSafe (Zipper _ _ []) = Nothing
nextSafe (Zipper l c (rh:rt)) = Just (Zipper (c:l) rh rt)

prevSafe :: Zipper a -> Maybe (Zipper a)
prevSafe Zip = Nothing
prevSafe (Zipper [] _ _) = Nothing
prevSafe (Zipper (lh:lt) c r) = Just (Zipper lt lh (c:r) )

insertBefore :: a -> Zipper a -> Zipper a
insertBefore e Zip = zipper e
insertBefore e (Zipper l c r) = Zipper (c:l) e r

insertAfter :: a -> Zipper a -> Zipper a
insertAfter e Zip = zipper e
insertAfter e (Zipper l c r) = Zipper l e (c:r)

replace :: a -> Zipper a -> Zipper a
replace _ Zip = error "Can't replace cursor of empty zipper"
replace e (Zipper l _ r) = Zipper l e r
