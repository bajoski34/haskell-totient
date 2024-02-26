module Main where

import Control.DeepSeq
import Control.Exception
import Criterion.Measurement
import Numeric
import System.Environment
import TotientRange

{-
On a normal computer:

    cabal build

then:

    cabal exec -- haskell-totient 1 10000

On the Robotarium e.g. using 4 CPU cores on a compute node:

    cabal build

then:

    srun --cpus-per-task=4 cabal exec -- haskell-totient 1 10000 +RTS -N4 -RTS

To check that your code produces the correct output,
uncomment and use the `main` function at the bottom.
To measure your runtime in seconds, uncomment and use
the `main` function directly beneat this comment.
-}

-- | time an IO action.
time_ :: IO a -> IO Double
time_ act = do
  initializeTime
  start <- getTime
  _ <- act
  end <- getTime
  return $! end - start

-- | use this function to print the execution time, in seconds.
main :: IO ()
main = do
  args <- getArgs
  let lower = read (head args) :: Int -- lower limit of the interval
      upper = read (args !! 1) :: Int -- upper limit of the interval
      -- change the next line for your parallel versions of sum totient
      theProgram = sumTotientSequential (lower, upper)
  theTime <- time_ (evaluate (force theProgram))
  putStrLn (showFFloat (Just 2) theTime "")

-- -- | Use this function for checkout that sum totient prints the
-- -- correct result.
-- main :: IO ()
-- main = do
--   args <- getArgs
--   let lower = read (head args) :: Int -- lower limit of the interval
--       upper = read (args !! 1) :: Int -- upper limit of the interval
--       result =
--         -- sequential version
--         sumTotientSequential (lower, upper)
--   -- replace (comment out) code above in the definition for `result`,
--   -- i.e. replace the sum function call line, with parallel versions
--   -- of sum totient and put them below
--   putStrLn
--     ( "Sum of Totients between ["
--         ++ show lower
--         ++ ".."
--         ++ show upper
--         ++ "] is "
--         ++ show result
--     )
