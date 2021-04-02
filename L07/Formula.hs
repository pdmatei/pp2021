
-- the name of the ADT
data Formula =
    Atom String | -- Atom : String -> Formula
    Not Formula | -- 
    And [Formula] |
    Or [Formula]

f = And [Or [Atom "a", Not $ Atom "b"], Or [Not $ Atom "a", Atom "b"]]

{- Explanation:
class Not implements Formula{
    private Formula f;
    public Not(Formula f){
        this.f = f;
    }
    ...
}

In Java, we explicity handle the object construction process.

Haskell programmers do not need to explicitly allocate memory to store object data.
This is done implicitly, by "calling" the appropriate data constructor:

Not :: Formula -> Formula
Not $ Atom "a"

In Java, we can introspect the constructed object directly, e.g. using 
"this.f", in the previous example.

In Haskell, we use pattern matching to introspect the object.

-}
depth :: Formula -> Integer
depth (Atom _) = 0
depth (Not f) = 1 + depth f
depth (Or l) = 1 + (maximum $ map depth l)
depth (And l) = 1 + (maximum $ map depth l)

isAtom (Atom _) = True
isAtom _ = False

isLiteral (Atom _) = True
isLiteral (Not f) = isAtom f
isLiteral _ = False

isClause (Or l) = foldl (&&) True $ map isLiteral l
isClause (And _) = False
isClause f = isLiteral f

isCNF (And l) = foldl (&&) True $ map isClause l
isCNF f = isClause f



