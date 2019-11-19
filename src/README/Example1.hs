module README.Example1 where
import Control.Effect.Class
import Control.Effect.State
import Control.Carrier.State.Strict

-- | State effect を実行
-- >>> run $ example1 [1,2,3]
-- (3,())
example1 :: (Algebra sig m, Effect sig) => [a] -> m (Int, ())
example1 list = runState 0 $ do
  i <- get
  put (i + length list)
