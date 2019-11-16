module Main (main) where

import Test.DocTest
import System.FilePath.Glob

main :: IO ()
main = do
  hs <- glob "src/**/*.hs"
  doctest $ ["-isrc"] <> hs
