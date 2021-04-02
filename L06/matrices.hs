m = [[1,2,3],[4,5,6],[7,8,9]]
m' = [[1,0,1],[0,1,0],[0,0,1]]

-- ----------------------------
--     Displaying a matrix:
-- ----------------------------

-- [1,2,3] --> "1 2 3 \n"

-- v0:
--convertIntegers = map show

-- v1:
--displayLine :: [Integer]->String
--displayLine = (foldr (\x acc->x++" "++acc) "\n") .
--              (map show)

{-

   (++) :: String -> String -> String
   (++" ") :: String -> String

   (++) "1" "2" must become (++) "1 " "2"
        - whitespace must be added to the first string
        - the second one must remain unchanged.

   ((++).(++" ")) "1" "2"

   (++) ((++" ") "1") "2"

-}  
--v2
displayLine :: [Integer]->String
displayLine = (foldr ((++).(++" ")) "\n") .
              (map show)  

-- v3
--displayMatrix :: [[Integer]] -> [String]
--displayMatrix = map displayLine

-- v4: rethink the binding. Build a function which receives a separator to "bind"
-- a list of strings into a string
--bind s = foldr ((++).(++s)) []

displayMatrix ::[[Integer]] -> String
displayMatrix = (bind "\n"). 
                (map ((bind " ").
                      (map show))) -- convert a line of strings
                  where bind s = foldr ((++).(++s)) []

--sh = putStrLn . displayMatrix

-- ----------------------------
--     Matrix multiplication
-- ----------------------------

-- step 1: transposition
-- m = [[1,2,3], [4,5,6], [7,8,9]]
-- transpose m = [[1,4,7], [2,5,8], [3,6,9]]

transpose ([]:_) = []
transpose m = (map head m):(transpose (map tail m))


-- step 2: multiplication. The value function
value ln col = foldr (+) 0 $ zipWith (+) ln col
-- composition cannot be used here, because zipWith must take two parameters, and perform
-- the fold on the resulting list.

-- however, we can use $ to make the code nicer.
-- ($) :: (a->b) -> a -> b
-- $ is 'infix function application'
-- f $ expr means (f expr). It is useful, because it will treat expr as a parameter
-- and avoid ambiguity.

-- Example: length "Matei" ++ "Popovici"
-- function calls have the highest precedence, hence, the compiler will treat this as:
-- (length "Matei") ++ "Popovici"m and yield an error

-- using $ we can "relax" the precedence:
-- length $ "Matei" ++ "Popovici"  will evaluate the concatenation first.

-- step 3: putting it all together:
{-
mult m1 m' = map (\lx-> map (value lx) m2) m1
              where m2 = transpose m'
                    value ln col = foldr (+) 0 $ zipWith (+) ln col
-}

-- step 4: making it shorter
--mult m1 m' = map (\lx-> map (\cy-> foldr (+) 0 $ zipWith (+) lx cy) $ transpose m') m1


-- step 4: or easier to read
mult m1 m' = map 
              (\lx-> map 
                     (\cy-> foldr (+) 0 $ zipWith (+) lx cy) 
                     $ transpose m') 
              m1
              

-- sum of two matrices:
msum = zipWith $ zipWith (+)
