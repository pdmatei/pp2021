-- Higher-order functions
import Data.Char

-- map examples
addOne = map (+1)
remHead = map tail 
toString = map (:[])

-- foldr examples
--ppfoldr :: (a -> b -> b) -> b -> [a] -> b
ppfoldr op acc [] = acc
ppfoldr op acc (x:xs) = x `op` (ppfoldr op acc xs)

sum = ppfoldr (+) 0 
makeLower = ppfoldr ((:).toLower) [] 

reverse :: [a] -> [a]
reverse = foldl (\acc x->x:acc) []

{-
    Inchideri functionale (Functional closures)
-}

-- Exemplu: functii care PRIMESC ca parametru alte functii

h :: (Integer -> Integer) -> Integer -> Integer
h f x = 1 + (f x) 


-- Exemplu: functii care intorc alte functii
-- Functia g, ce tip are (w.r.t. Integer, Bool)

-- Integer -> Bool (g NU INTOARCE UN BOOL!)
-- Integer -> Integer -> Bool INTUITIV

--g x = \y -> y == (x+1)

--g = \x -> \y -> y == (x+1)   -- "lambda x, lambda y..."

f = (+)               -- "monomorphism restriction" 
g x y = y == x `f` 1

-- Cum am apela aceasta functie?
-- ((g 5) 1) 
-- (g 5 1)

-- O functie care primeste parametrii PE RAND
-- \x -> \y -> \z .... -> corp
-- SE NUMESTE IN FORMA CURRY.  Haskell Curry.
-- Exemplu de apelare (((f p1) p2)... pn)


-- O functie care primeste parametrii "PE TOTI ODATA"
-- \x y z ...-> corp
-- SE NUMESTE IN FORMA UNCURRY.
-- Exemplu de apelare (f p1 p2 ... pn)

{-
 ==============================

  Majoritatea limbajelor DISTING intre functiile
  curry si uncurry: Racket/Scheme, Scala.

  Exceptie: Haskell NU distinge intre formele 
  curry si uncurry. Efecte:
      - foarte multa munca pt cei care scriu compilatorul
      - foarte multa flexibilitate pt programator
 
 ==============================

           B -----> C
 (:) :: Integer -> [Integer] -> [Integer] 

         A -------> B
 (+1) :: Integer -> Integer

          A --------> C
 (:).(+1) :: Integer -> [Integer] -> [Integer]
    primeste un integer, si intoarce o functie care ia un x, si adauga x+1 la o lista

-}
