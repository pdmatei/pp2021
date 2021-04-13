{-# LANGUAGE FlexibleInstances, MultiParamTypeClasses #-}

-- Cons e un constructor de date (o functie care ia date si produce date)
-- Cons 2 LVoid :: List Integer

-- List e un constructor de tip (o functie care ia un tip si construieste un tip)
-- List Integer
-- List Char
-- List String
-- List [Char]

{- TIPURILE (de date) incapsuleaza constructori de date (sau valori)-}
-- 1, 2, 3 ... Integer
-- List Integer "incapsuleaza" liste de intregi

{- Constructorii de tip "generalizeaza peste" tipuri
   List Integer  [Integer]
   List Char     [Char]

Constructori de tip (si kind-ul lor)

* (kind-ul care desemneaza tipuri)
Char :: *
Integer :: *

* -> * (desemneaza "containere")
List :: * -> *
Tree :: * -> *
Set :: * -> *
[] :: * -> *
Maybe :: * -> *


* -> * -> * 
(,) -- perechi
(->) -- functie
Either -- 

data Either a b = Left a | Right b

l :: [Either Integer Char]
l = [Left 5, Left 6, Right 'a', Left 1]

--
(* -> *) -> *
(mai complicat)


La ce ne sunt utili constructorii de tip? (In programare?)
-}



data Tree a = TVoid | Node (Tree a) a (Tree a)

data List a = LVoid | Cons a (List a)

{- dorim sa implementam o functie care se cheama "member", cu aceeasi signatura (comportament)
   pentru orice container care poate contine valori

   member :: a -> Tree a -> Bool
   member :: a -> List a -> Bool

   "Scriem" o clasa:   
-}
class Contains t c where 
    -- t este "tipul continut" de c
    member :: t -> c -> Bool

instance Contains Integer (List Integer) where
    member _ _ = False  -- dummy implementation

instance (Eq a) => Contains a (List a) where
    member _ _ = False  

-- aceasta inrolare nu ar trebui permisa
instance Contains Char (List Integer) where
    member _ _ = False  

instance Contains (List Integer) Char where
    member _ _ = False  


{-
  
   mapp :: (a -> b) -> List a -> List b
   mapp :: (a -> b) -> Tree a -> Tree b 


-}
--class Mapp t1 t2 c1 c2 where
--  mapp :: (t1 -> t2) -> c1 -> c2

{-
instance Mapp a b (Tree a) (Tree b) where
    ...

instance Mapp a b (List a) (List b) where
    ...

Clasele de mai sus, nu descriu in mod satisfacator, "proprietati" ale CONTAINERELOR
(ale lui List si Tree, care sunt constructori de tip)

-}

{- c are kind-ul * -> * (un container) -}
class Functorr c where -- o clasa constituie o familie de CONSTRUCTORI DE TIP 
    mapp :: (a -> b) -> c a -> c b
    -- fmap

instance Functorr List where
    mapp f LVoid = LVoid
    mapp f (Cons x xs) = Cons (f x) (mapp f xs)

instance Functorr Tree where
    mapp f TVoid = TVoid
    mapp f (Node l k r) = Node (mapp f l) (f k) (mapp f r)

{-
   [] - lista vida, 
   [] - constructorul lista

Functorii desemneaza CONSTRUCTORI DE TIP, care pot fi transformati

-}

-- "containere" care pot fi "traversate"
class Foldablee c where
    foldrr :: (a -> b -> b) -> b -> c a -> b
    -- se numeste elem in Haskell
    memberr :: (Eq a) => a -> c a -> Bool
    memberr x = foldrr ((||).(==x)) False 
{-
          \y ->
          valoare curenta y
          o comparam cu x (True sau False)
          facem && cu acc

-}

instance Foldablee List where
    foldrr op acc LVoid = acc
    foldrr op acc (Cons x xs) = x `op` foldrr op acc xs 


instance Foldablee Tree where
    foldrr op acc TVoid = acc
    foldrr op acc (Node l k r) = k `op` foldrr op (foldrr op acc l) r 


-- data Maybe a = Nothing | Just a

-- valori ce pot fi inclusiv erori
data Result a = Error String | Value a

-- Result poate fi Functor?

instance Functor Result where
    fmap f (Error m) = (Error m)
    fmap f (Value v) = Value $ f v 

-- Result poate fi Foldable?

instance Foldable Result where
    foldr op acc (Error m) = acc
    foldr op acc (Value v) = op v acc



