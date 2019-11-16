module README.Example3 where
import Control.Effect.State
import Control.Effect.Reader
import Control.Carrier.State.Strict
import Control.Carrier.Reader

-- |
-- >>> example3
-- (5,())
example3 :: (Int, ())
example3 = run . runReader "hello" . runState 0 $ do
  list <- ask
  put (length (list :: String))
