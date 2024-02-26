---------------------------------------------------------------------------
-- Sequential Euler Totient Function
---------------------------------------------------------------------------
-- This program calculates the sum of the totients between a lower and an
-- upper limit.
--
-- Phil Trinder, 26/6/03
-- Based on earlier work by Nathan Charles, Hans-Wolfgang Loidl and
-- Colin Runciman
---------------------------------------------------------------------------

module TotientRange where

-- this is the module with:
--   rpar, parallel strategies for lists, etc.
--
-- See:
-- http://hackage.haskell.org/package/parallel-3.2.2.0/docs/Control-Parallel-Strategies.html
import Control.Parallel.Strategies

-----------------------------------
-- Main functions for Totient Range
-----------------------------------
-- The main function, sumTotient
-- 1. Generates a list of integers between lower and upper
-- 2. Applies Euler function to every element of the list
-- 3. Returns the sum of the results

-- sequential
sumTotientSequential :: (Int, Int) -> Int
sumTotientSequential (lower, upper) =
  sum (totients lower upper)

-- sequential, using evalList strategy
sumTotientEvalList :: (Int, Int) -> Int
sumTotientEvalList (lower, upper) =
  sum (totients lower upper `using` evalList rseq)

-- sequential, using parList strategy
sumTotientParList :: (Int, Int) -> Int
sumTotientParList (lower, upper) = 
  sum (totients lower upper `using` parList rseq)

-- TODO: add more sum totient implementations below using the
-- evaluation strategies from the Control.Parallel.Strategies module.
-- Then:
--   1. add them to the bencharmarks in bench/ParallelBenchmarks.hs
--   2. edit the application in app/Main.hs to create a parallel
--      profile for visualising with Threadscope.
--
-- They should always have the same type as the two functions above,
-- to make it easy to add to the bench/ParallelBenchmarks.s file:
--
--   (Int, Int) -> Int

-------------------
-- Totient function
-------------------

totients :: Int -> Int -> [Int]
totients lower upper = map euler [lower, lower + 1 .. upper]

--------
-- euler
--------
-- The euler n function
-- 1. Generates a list [1,2,3, ... n-1,n]
-- 2. Select only those elements of the list that are relative prime to n
-- 3. Returns a count of the number of relatively prime elements

euler :: Int -> Int
euler n = length (filter (relprime n) [1 .. n -1])

-----------
-- relprime
-----------
-- The relprime function returns true if it's arguments are relatively
-- prime, i.e. the highest common factor is 1.

relprime :: Int -> Int -> Bool
relprime x y = hcf x y == 1

------
-- hcf
------
-- The hcf function returns the highest common factor of 2 integers

hcf :: Int -> Int -> Int
hcf x 0 = x
hcf x y = hcf y (rem x y)
