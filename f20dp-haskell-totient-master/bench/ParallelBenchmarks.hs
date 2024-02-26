module Main where

import Control.Concurrent
import Control.Parallel.Strategies
import Criterion
import Criterion.Main
import Criterion.Types
import TotientRange
import Prelude hiding (readFile)

main :: IO ()
main = do
  numCores <- getNumCapabilities
  defaultMainWith
    ( defaultConfig
        { reportFile = Just ("totient-results-" ++ show numCores ++ "-cores.html"),
          csvFile = Just ("totient-results-" ++ show numCores ++ "-cores.csv")
        }
    )
    [ -- totient range 1 .. 10
      bgroup
        ("totient-range 1..10," ++ show numCores ++ " cores")
        [ bench "sequential 1..10" $
            nf
              sumTotientSequential
              (1, 10),
          bench "evalList 1..10" $
            nf
              sumTotientEvalList
              (1, 10)
          bench "parList 1..10" $
            nf
              sumTotientParList
              (1, 10)
              -- add parallel benchmarks here for 1..10 once you've
              -- implemented them in src/TotientRange.hs
        ],
      -- totient range 1 .. 1000
      bgroup
        ("totient-range 1..1000," ++ show numCores ++ " cores")
        [ bench "sequential 1..1000" $
            nf
              sumTotientSequential
              (1, 1000),
          bench "evalList 1..1000" $
            nf
              sumTotientEvalList
              (1, 1000)
          bench "parList 1..1000" $
            nf
              sumTotientParList
              (1, 1000)
              -- add parallel benchmarks here for 1..1000 once you've
              -- implemented them in src/TotientRange.hs
        ],
      -- totient range 1 .. 3000
      bgroup
        ("totient-range 1..3000," ++ show numCores ++ " cores")
        [ bench "sequential 1..3000" $
            nf
              sumTotientSequential
              (1, 3000),
          bench "evalList 1..3000" $
            nf
              sumTotientEvalList
              (1, 3000)
          bench "parList 1..3000" $
            nf
              sumTotientParList
              (1, 3000)
              -- add parallel benchmarks here for 1..3000 once you've
              -- implemented them in src/TotientRange.hs
        ]
    ]
