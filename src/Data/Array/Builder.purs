module Data.Array.Builder where

import Prelude
import Data.Maybe (Maybe)
import Data.Nullable (Nullable)
import Data.Nullable as Nullable

newtype Builder a = Builder (Array a -> Array a)

instance semigroupBuilder :: Semigroup (Builder a) where
  -- | We want to make the overhead minimal so we don't use `<<<`
  append = appendBuilders

instance monoidBuilder :: Monoid (Builder a) where
  mempty = Builder identity

foreign import unsafeCons :: forall a. a -> Array a -> Array a

foreign import unsafeConsArray :: forall a. Array a -> Array a -> Array a

foreign import unsafeSnoc :: forall a. a -> Array a -> Array a

foreign import unsafeSnocArray :: forall a. Array a -> Array a -> Array a

appendCons :: forall a. a -> Builder a -> Builder a
appendCons e1 e2 = cons e1 <> e2

appendBuilders :: forall a. Builder a -> Builder a -> Builder a
appendBuilders (Builder b1) (Builder b2) = Builder (\arr -> b1 (b2 arr))

infixr 5 appendBuilders as <+>

-- | Like a `List.Cons` - it expects
-- | that the second argument is a `Builder`.
-- | So usually you want to do something like:
-- |
-- | ```
-- | x = build $ e1 :> e2 :> e3 :> mempty
-- | ```
infixr 6 appendCons as :>

appendSnoc :: forall a. Builder a -> a -> Builder a
appendSnoc e1 e2 = snoc e2 <> e1

-- | ```
-- | x = build $ mempty <: e1 <: e2 <: e3
-- | ```
infixl 7 appendSnoc as <:

snocArray :: forall a. Array a -> Builder a
snocArray suffix = Builder (unsafeSnocArray suffix)

appendSnocArray :: forall a. Builder a -> Array a -> Builder a
appendSnocArray b a = snocArray a <> b

-- | ```
-- | build $ <> -3 :> [-2, -1] +> 0 :> 1 :> 2 :> mempty <+ [3,4] <: 5 <: 6 <+ [7, 8] <: 9 <: 10
-- | ```
infixl 7 appendSnocArray as <+

-- | ```
-- | cons 1 <> consArray [2,3,4] <> cons 5 <> mempty
-- | ```
consArray :: forall a. Array a -> Builder a
consArray prefix = Builder (unsafeConsArray prefix)

appendConsArray :: forall a. Array a -> Builder a -> Builder a
appendConsArray a b = consArray a <> b

infixr 6 appendConsArray as +>

cons :: forall a. a -> Builder a
cons a = Builder (unsafeCons a)

snoc :: forall a. a -> Builder a
snoc a = Builder (unsafeSnoc a)

foreign import buildImpl :: forall a. Builder a -> Nullable (Array a)

build :: forall a. Builder a -> Maybe (Array a)
build b = Nullable.toMaybe (buildImpl b)

unsafeBuild :: forall a. Builder a -> Array a
unsafeBuild (Builder f) = f []
