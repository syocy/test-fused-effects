#!/usr/bin/env cabal
{- cabal:
build-depends: base ^>=4.13.0.0
             , shake
-}
import Development.Shake
import Development.Shake.Command
import Development.Shake.FilePath
import Development.Shake.Util
import Control.Monad
import System.Exit

main :: IO ()
main = shakeArgs shakeOptions{shakeFiles="_build"} $ do
  want ["test-fused-effects.pdf"]

  let testLog = "dist-newstyle/build/x86_64-linux/ghc-8.8.1/test-fused-effects-0.1.0.0/t/doctest/test/test-fused-effects-0.1.0.0-doctest.log"

  "test-fused-effects.pdf" %> \out -> do
    copyFileChanged "main.pdf" out

  "main.pdf" %> \out -> do
    need [testLog, "main.tex"]
    cmd "llmk main.tex"

  testLog %> \out -> do
    cmd_ "cabal v2-build"
    cmd "cabal v2-test"

  phony "scratch" $ do
    _ <- need ["test-fused-effects.pdf"]
    _ <- need ["clean"]
    pure ()

  phony "clean" $ do
    cmd_ "llmk -c"
    cmd_ "cabal v2-clean"
    cmd_ "cabal clean"
    removeFilesAfter "_build" ["//*"]
    removeFilesAfter "." ["//main.pdf", "//*.nav", "//*.snm", "//*.gz", "//tags", "//.ghc.environment*", "//*~"]
