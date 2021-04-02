import Data.List

{- Un set de exemple, folosind TDA-uri, de la unele cat mai simple -}

-- tipul de date "lista cu elemente de tip integer"
data TList = Void |                
             Cons Integer TList  
{-
Void si Cons se numesc  constructori de DATE (data constructors)
                       (constructori de baza)                       
-}


tlength :: TList -> Integer
tlength Void = 0
tlength (Cons x xs) = 1 + (tlength xs)

{-
Pattern-urile in Haskell pot fi exprimate doar in raport cu constructorii de date
ai unui tip. (Sau combinatii ale lor)
Constructorii pt liste standard: [], (:)


type ADT = Void | Cons ADT Integer ADT
-- folositi type doar pentru "sinonime".
type Student = String
type Name = String
type Age = Integer
type Grade = Integer 
f :: Student -> Name -> Age -> String -> Grade -> String

-}

data Tree = TVoid | Node Tree Integer Tree

height :: Tree -> Integer
height TVoid = 0
height (Node l k r) = 1 + maximum (map height [l,r])

{-
    Polimorfism:
        - mai multe forme.

    In limbaje de programare:
        - genericitate    List<T> (type errasure)
        - polimorfism "parametric" (de tip)

-}
-- exemplu: liste polimorfice

data PList a = PVoid | PCons a (PList a) 
-- 

toHaskell :: PList a -> [a]
toHaskell PVoid = []
toHaskell (PCons x xs) = x:(toHaskell xs)

{-
     tipul PList a este parametrizat in raport cu variabla a
     a - se numeste variabila de tip
       - seminificatia "orice tip"

    conventie generala: variabile de tip: a,b,c, ..., t...
                        valorile (variabile, param): x,y,z, ...
-}
plength :: PList a -> Integer
plength PVoid = 0
plength (PCons x xs) = 1 + (plength xs)
{-
    tipul definit mai sus, nu este PList CI este "PList a"
-}


fromHaskell :: [a] -> PList a
fromHaskell [] = PVoid
fromHaskell (x:xs) = PCons x $ fromHaskell xs

fromHaskell' :: [a] -> PList a
fromHaskell' = foldr PCons PVoid

{-
===========================================

      Sorting 

===========================================

sortBy :: (a -> a -> Ordering) -> [a] -> [a]
           comparator
           cmp x y = 

data Ordering = LT | EQ | GT
-}

byLength :: [String] -> [String]
byLength = sortBy cmp
              where cmp :: String -> String -> Ordering
                    cmp s1 s2
                        | length s1 > length s2 = GT
                        | length s1 == length s2 = EQ
                        | otherwise = LT

{-
===========================================

      Modeling exceptions in Haskell

===========================================

Cand vrem sa folosim exceptii:
   - cand o computatie (functie) poate intoarce o valoare "Normala"
     SAU
     - o valoare "non-standad" - o eroare (cu mesaj/cod)

-}
data Result a = Error String | -- constructorul pentru o valoare de tip eroare
                Value a  -- constructorul pentru valoare "normala"
                deriving Show
            
phead :: [a] -> Result a
phead [] = Error "Empty list"
phead (x:xs) = Value x

-- Write a function which extracts the first character from a list of strings
-- the function returns an error if one string is empty.

{-
extract ["Matei", "Mihai", ""] = Error "Emptystring found"
extract ["Matei", "Mihai"] = Value ['M', 'M']

In doi pasi:
1) Aplicam functia phead pe lista primita ca parametru
   ["Matei", "Mihai", ""] 
         | map phead
         V
    [Value 'M', Value 'M', Error "Empty list"]

2) Cautam eroarea, si construim lista cu valori.

-}
--extract :: [String] -> Result [Char]
extract = (foldr op (Value [])).(map phead)
              where op (Error _) acc = Error "Emptystring found"
                    op x (Error m) = Error m
                    op (Value c) (Value s) = Value (c:s)

{-
Value [] :: Result [a]
[] :: [a]

 in exemplul nostru, op are signatura:
    op :: Result Char -> Result [Char] -> Result [Char]
    x :: Result Char
    acc :: Result [Char]


Type-classes in Haskell   --> polimorfism ad-hoc     ----> supraincarcare
-----------------------
                          --> polimorfism parametric ----> genericitate (templating)

                          --> subtype polymorfism  ----> inheritance

                          --> ...
-}
