
-- the type Formula is monomorphic - it is a "single-form" type.
-- the type list is polymorphic -> generic, because lists may contain any type of value. (Always the same!)


data List a = Void | Cons a (List a)

{- a is called a type variable, and it is equivalent to a type parameter.
   it stands for "any type".


-}

-- head :: [a] -> a 
lhead :: List a -> a
lhead (Cons e _) = e

ltail :: List a -> List a
ltail (Cons _ t) = t

size :: List a -> Integer
size Void = 0
size (Cons _ t) = 1 + size t

append :: List a -> List a -> List a
append Void l = l
append (Cons e l) l' = Cons e $ append l l'

lreverse :: List a -> List a
lreverse Void = Void
lreverse (Cons e l) = (lreverse l) `append` Cons e Void

-- exercise:
toHaskell :: List a -> [a]
fromHaskell :: [a] -> List a

