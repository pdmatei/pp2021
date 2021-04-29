import Data.Array
{-
 schema de recursivitate:

  left    right
  <-        ->
-}

t0 = [2,3,5,1,4]
t1 = [2,3,5,1,4,6,7,1,2,3,5,3,4,7,1,2,3,4,5,6,7,5,3,4,5,6,7,6,3,2]


sol0 prices = max_profit 0 ((length prices) - 1) 1
                where max_profit left right year
                          | left == right = year*(prices !! right)
                          | otherwise = maximum [year*(prices !! left) + (max_profit (left+1) right (year+1)),
                                                 year*(prices !! right) + (max_profit left (right-1) (year+1))
                                                 ]

{- 
   Arrays
   ------

   listArray :: Ix i => (i, i) -> [e] -> Array i e 
   
   (i,i) - bounds (range-ul de valori din array)
   [e] - este lista cu valorile care vor popula un array

   (!) :: Ix i => Array i e -> i -> e 

Ce va contine o matrice 3x3 de profituri?

   max_profit 1 1      max_profit 1 2      max_profit 1 3
   max_profit 2 1      max_profit 2 2      max_profit 2 3
   max_profit 3 1      max_profit 3 2      max_profit 3 3

  [max_profit 1 1, max_profit 1 2, max_profit 1,3, max_profit 2 1, .... max_profit 3 3]

   ?
-}

sol1 l = matrix ! (0,n-1)
          where n = foldr (\_ acc->acc+1) 0 l
                prices = listArray (0, n - 1) l
                bounds = ((0,0) , (n - 1, n - 1))
                --matrix = listArray bounds (map (\(i,j) -> max_profit i j) (range bounds))
                matrix = listArray bounds [max_profit i j | (i,j) <- range bounds] -- list-comprehensions
                year l r = n - (r - l)
                max_profit left right
                          | left == right = (year left right)*(prices ! right)
                          | otherwise = maximum [(year left right)*(prices ! left) + (matrix ! (left+1,right)),
                                                 (year left right)*(prices ! right) + (matrix ! (left,right-1))
                                                 ]

{-
    Game trees

    IA (rosu-negru, ...)

nivelul x: joaca bot-ul

nivelul x+1: joaca adversarul

            nod
    a1 /  a2 |   an \
   nod1     nod2     nodn
   / \ \
  n  n n

 
 -------------------------------

 Alternativa 1:
   - Calcul Lambda apoi Programare Logica in Prolog
   - Avantaje: Calcul Lambda model pt programarea functionala (MT), PL este mai putin notoriu astazi
   - Dezavantaje: vom discuta despre fiecare in limita timpului

 
 Alternativa 2:
   - Programare Logica in Prolog (mai aprofundat)
   - Avantaje: PL: model de programare extrem de diferit (si interesant!)
   - Dezavantaj: no Calcul Lambda






-}



