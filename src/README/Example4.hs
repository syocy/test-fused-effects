module README.Example4 where
import Control.Effect.State
import Control.Effect.Reader
import Control.Carrier.State.Strict
import Control.Carrier.Reader
import Control.Carrier.Lift
import Control.Monad.IO.Class

-- |
-- >>> example4
-- hello
-- (5,())
example4 :: IO (Int, ())
example4 = runM . runReader "hello" . runState 0 $ do
  list <- ask
  liftIO (putStrLn list)
  put (length list)
