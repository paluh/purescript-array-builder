# purescript-array-builder

Monoidal array builder which should have much better performance than pure concatenation because it mutates the underling array.

## Performance characteristics

Please be aware that `JS` engines are generaly optimized for `push` (`snoc`) operation - O(1) vs `unshift` (`cons`) operation - O(n). We have here characteristic which is opposite to the `Data.List`.

### Operation execution details

Runtime cost of operations (when you execute the actual `build`):

* Every `Array.Builder.cons` / `Array.Builder.snoc` is a one lower level JS `Array` method call.

* Every `<>` we have four "runtime" calls - type class `dict` passing call + two calls performed by `append` calls + the actual JS `Array.push` call.

* If you don't like the typeclass overhead of `<>` you can use `appendBuilders` directly which saves you one call plus a dict lookup ;-)

The above operations have also "construction" cost of a one `Builder` call per operation.

## Limitations

Use it for relatively small arrays (length < 10000) otherwise you can get `Nothing` from `build`... or just a crash (call stack overflow) in the case of `unsafeBuild`.

## Usage

Let me start with imports. This README is a part of the test suite so we need them.

```purescript
module Test.README where

import Prelude

-- We are working with constant sized arrays
-- here so `unsafeBuild` is actually pretty safe ;-)
import Data.Array ((..))
import Data.Array.Builder (cons, snoc, unsafeBuild, (:>), (+>), (<:), (<+))
import Effect (Effect)
import Test.Assert (assert)
```

`<>` is right associative so it works in practice as follows:


```purescript
suite ∷ Effect Unit
suite = do
  assert $ unsafeBuild (cons 8 <> cons 9 <> cons 10 <> mempty) == [8, 9, 10]
```

and

```purescript
  assert $ unsafeBuild (snoc 8 <> snoc 9 <> snoc 10 <> mempty) == [10, 9, 8]
```

I'm not a huge fun of custom operators but in the case of concatenation (like `List`, `Array`) I feel that
they are pretty useful. So we have right (`:>` and `+>`) and left (`<:` and `<+`) associative `cons`/`snoc`
operators provided by the lib which "should" behave as you would expect when mixed:

```purescript
  assert $ unsafeBuild (-3 :> [-2, -1] +> 0 :> mempty <: 1 <+ [2, 3] <: 4) == -3..4
```

This API works nicely with tools like `Monoid.guard`, `foldMap` etc. because we have a "pretty" performant `Monoid` here.

## Testing
  ``` shell
  $ npm test
  ```

