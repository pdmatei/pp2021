{-
   Expressions:
   int x = 1;

-}
x :: Int
x = 1 + 2
y = x + 1

{-

(!) Programming in Haskell is "time-less". Objects are immutable. This means, here,
    that x and y will be permanently bound to their values throughout program execution
    and cannot be changed.


  Functions are as their mathematical counterparts:

  f: Integer x Integer -> Integer
  f(x,y) = x + y

  The Haskell implementation is:
-}
f :: Integer -> Integer -> Integer
f x y = x + y

{-
  Note that the cross product (x) has been replaced by ->, for reasons which will
  become clearer later on.

  Haskell functions can only return an expression (it's value), cannot perform
  any side effects, and a function call such as (f 5 4) will always return the same
  value no matter where it is called.
-}

{-
  How do we compute sum without side-effects?

  int f (int[] v){
   int sum = 0;
   int n = v.length;
   for (int i=0; i<n; i++)
      sum+=v[i];
   return sum;
  }

  -}

{-
Let us start of by writing the for of the previous function:
The most primitve rewriting in Haskell is:

for :: Integer -> 
       Integer -> 
       Integer -> 
       [Integer] -> Integer
for i n sum v = if i<n then for (i+1) n (sum + (v !! i)) v else sum


Now, let us learn about a new construct called "guards":


for i n sum v
    | i < n = for (i+1) n (sum + (v !! i))
    | otherwise = sum

this implementation is not really functional in style, for some of the following reasons:
   - using indexes for traversal is not really nice (there are several nicer ways, some outside the scope of this lecture)
   - the datastructure used here, a list, can be introspected using head and tail (arrays can be used for other specific applications)

Let us replace indexing (!!) by the usage of head and tail. Now the index i and the 
length n are no longer necessary.

for sum v
    | v == [] = sum
    | otherwise = for (sum + (head v)) (tail v)


------------------------------
Part 2:  Pattern matching
------------------------------


'head' and 'tail' are rarely used as above. More and more programming languages
have adopted PATTERNS as a means for function definitions.

for sum [] = sum
for sum (x:xs) = for (sum + x) xs

Patterns are different from guards and can be used together. Patterns
in Haskell work exactly as ADT base constructors. They allow us to define
function behaviour dependent on how values are constructed.

Patterns are allways evaluated in THEIR ORDER OF DEFINITION (unlike those written for axioms).

We will go into more detail about them later. Now, we will just learn to use them on lists.
Our final solution for the java implementation above will be:

f v = for 0 v
    where for sum [] = sum
          for sum (x:xs) = for (sum + x) xs

where is a construction which allows us to define LOCAL functions or other values
within the body of the function f. 

------------------------------------------------
Part 3:  Combining guards, patterns, and where
------------------------------------------------

Suppose we would like to define a function which checks if a list has at least two elements.
One way to write it is:


atLeast :: [Integer] -> Bool
atLeastTwo v
  | v == [] = False
  | otherwise = atleastOne (tail v)
                  where atLeastOne v
                            | v == [] = False
                            | otherwise = True

This writing style illustrates nesting of guards with where, but it is not really
a good way to write such a function.

We may replace guards with patterns:

atLeastTwo [] = False
atLeastTwo (x:xs) = atLeastOne xs
                    where atLeastOne [] = False
                          atLeastOne _ = True

In some patterns, the actual value is less important, so it may be replaced by _

We can use the : list constructor to create more complex patterns:

atLeastTwo [] = False
atLeastTwo [x] = False
atLeastTwo (x:y:xs) = True

Here, you should distinguish 
[x] - which is a list of a single element, from:
(x:xs) - which is a list containg a head (x) and a tail (xs)

Also, we can exploit pattern order definition to write a more compact version:

atLeastTwo (_:_:_) = True
atLeastTwo _ = False

The first pattern is more specific (a list of at least two elements). If it is not
satisfied, the second pattern _ (anything) will be matched.

(*) Quiz question:
f [] = 0
f (x:xs) = 1
f (x:y:xs) = 2

Write the mathematical function which is implemented above.

(**) What does this function do:
f [] = []
f (x:y) = (f y)++[x]

(***) What is the type of this function:

g [] = []
g ([x]:y) = x:(g y)


(*v) Write a function which checks if a list is sorted.
     Write a function which determines the maximum of a list.

-}







