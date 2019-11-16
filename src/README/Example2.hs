module README.Example2 where
import Control.Effect.Class
import Control.Effect.State
import Control.Effect.Reader
import Control.Carrier.State.Strict
import Control.Carrier.Reader

-- |
-- >>> run example2
-- (5,())
example2 :: (Algebra sig m, Effect sig) => m (Int, ())
example2 = runReader "hello" . runState 0 $ do
  list <- ask
  put (length (list :: String))
