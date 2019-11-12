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
  want ["main.pdf"]

  let testLog = "dist-newstyle/build/x86_64-linux/ghc-8.8.1/test-fused-effects-0.1.0.0/t/test-fused-effects-test/test/test-fused-effects-0.1.0.0-test-fused-effects-test.log"

  "main.pdf" %> \out -> do
    need [testLog]
    cmd_ "llmk main.tex"

  testLog %> \out -> do
    need ["src/**.hs", "test/**.hs"]
    Exit c <- cmd "cabal v2-test"
    when (c /= ExitSuccess) $ fail "cabal v2-test fail"

  phony "clean" $ do
    cmd_ "llmk -c"
    cmd_ "cabal v2-clean"
    cmd_ "cabal clean"
    removeFilesAfter "_build" ["//*"]
    removeFilesAfter "." ["//*.pdf", "//*.nav", "//*.snm", "//*.gz", "//tags"]
