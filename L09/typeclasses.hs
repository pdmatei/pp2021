{-# LANGUAGE TypeSynonymInstances, FlexibleInstances, MultiParamTypeClasses #-}

import Data.List

data TList = Void | Cons Char TList deriving Show

data Tree = TVoid | Node Tree Char Tree deriving Show

{-
  doua implementari diferite:
  tlist_show :: TList -> String
  ttree_show :: Tree -> String  

-}
-- tshow :: a -> String

class TShow a where    -- am definit o familie(clasa/multime) de tipuri, care se numeste TShow, iar
  tshow :: a -> String -- a se refera la un membru care apartine respectivei clase
                       -- toate tipurile a care apartin familiei TShow "suporta" functia
                       -- tshow :: a -> String

{-
tshow :: TShow a => a -> String
         "type-class constraint" =>
         
         tshow poate fi aplicata peste valori de tip a
         CU CONDITIA ca tipul a sa fie membru al clasei TShow

Cum inrolam un tip de date intr-o clasa?
-}

instance TShow TList where  -- Tipul de date TList va fi membru al clasei TShow
  tshow Void = "[]"
  tshow (Cons x xs) = x:':':(tshow xs)

instance TShow Tree where
  tshow TVoid = ""
  tshow (Node l k r) = "<"++(tshow l)++","++[k]++","++(tshow r)++">"

t = Node (Node TVoid 'c' TVoid) 'a' (Node (Node TVoid 'x' TVoid) 'e' TVoid)

t' = Node (Node TVoid 'c' TVoid) 'a' (Node (Node TVoid 'x' TVoid) 'e' TVoid)

l = Cons 'c' $ Cons 'e' $ Cons 'i' Void
-- In Haskell
-- clasa Show
-- functia show :: (Show a) => a -> String

{-
instance Show Tree where
  show TVoid = ""
  show (Node l k r) = "<"++(show l)++","++[k]++","++(show r)++">"
-}

data What = What deriving Show

lp :: List What
lp = PCons What PVoid

-- tipul (List a) este membru al clasei Show
-- tipul List a poate fi inrolat in clasa Show, doar daca
-- tipul a este membru al clasei Show
instance (Show a) => Show (List a) where   
  show PVoid = "[]"
  show (PCons x xs) = (show x)++":"++(show xs)
                    
                    -- nu are aceeasi implementare ca cea din apelul (show xs)
{-
"Compiler error", type lp is not member of Show

class Eq

instance Eq Bool where -- valorile boolene sunt comparabile INTRE ELE!
instance Eq Integer where -- valorile integer sunt comparabile intre ele!

-}

data List a = PVoid | PCons a (List a)


instance Eq TList where
  Void == Void = True
  Cons x xs == Cons y ys = x == y && xs == ys
  _ == _ = False
{-                            ^
                              apelul de functie "egalitate peste char"
                                        ^
                                        apelul recursiv de functie
-}

instance (Eq a) => Eq (List a) where
  PVoid == PVoid = True
  (PCons x xs) == (PCons y ys) = x == y && xs == ys
  _ == _ = False

{-
   Show, Eq, Num, Ord

   Foldable - cursul viitor!
-}

instance Num String where
  (+) = (++)

-- o inrolare mai putin conventionala
instance Show (a->b) where
  show f = "Functie"

{-
   Cand vrem sa construim o clasa noua?
    
-}
-- <aexpr> ::= <value> | <aexpr> + <aexpr>
data AritmExpr = Value Integer | Plus AritmExpr AritmExpr

-- <bexpr> ::= <aexpr> == <aexpr> | !<bexpr> | <bexpr> && <bexpr>  
data BoolExpr = Equals AritmExpr AritmExpr | BNot BoolExpr | BAnd BoolExpr BoolExpr

-- 1 + 2 == 3
b = ((Value 1) `Plus` (Value 2)) `Equals` (Value 3)

eval_aritm_expr :: AritmExpr -> Integer
eval_aritm_expr (Value x) = x
eval_aritm_expr (Plus e1 e2) = foldr (+) 0 $ map eval_aritm_expr [e1,e2]

eval_bool_expr :: BoolExpr -> Bool
eval_bool_expr (Equals e1 e2) = (eval_aritm_expr e1) == (eval_aritm_expr e2)
eval_bool_expr (BNot e) = not $ eval_bool_expr e
eval_bool_expr (BAnd e1 e2) = (eval_bool_expr e1) && (eval_bool_expr e2)


{-
eval_aritm_expr :: AritmExpr -> Integer
eval_bool_expr :: BoolExpr -> Bool

-}
class Eval a b where    -- Eval este relatie peste doua tipuri a, si b
  eval :: a -> b

instance Eval BoolExpr Integer where
  eval _ = 0

instance Eval AritmExpr Integer where
  eval = eval_aritm_expr 

instance Eval BoolExpr Bool where
  eval (Equals e1 e2) = ((eval e1) :: Integer) == (eval e2)
  eval (BNot e) = not $ eval e
  eval (BAnd e1 e2) = (eval e1) && (eval e2)


data EResult = B Bool | I Integer

class Evalp a where
  evalp :: a -> EResult

instance Evalp BoolExpr where
  evalp (Equals e1 e2) = case (evalp e1, evalp e2) of
                          (I i1, I i2) -> B (i1 == i2)
                          _ -> B False
  evalp (BNot e) = case evalp e of
                    B b -> B $ not b
                    _ -> B False
  evalp (BAnd e1 e2) = case (evalp e1, evalp e2) of
                         (B b1, B b2) -> B (b1 && b2)
                         _ -> B False

instance Evalp AritmExpr where
  evalp (Plus e1 e2) = case (evalp e1, evalp e2) of
                          (I i1, I i2) -> I (i1 + i2)
  evalp (Value x) = I x                        




