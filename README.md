# purescript-array-builder

Monoidal array builder which should have much better performance than pure concatenation because it mutates the underling array.

Every `Array.Builder.cons` / `Array.Builder.snoc` or concatenation of builders `<>` is lower level JS `Array` method call
plus overhead of additional function call on the PS side.

Please be aware that `JS` engines are generaly optimized for `push` (`snoc`)
operation - O(1) vs `unshift` (`cons`) operation - O(n).
We have here the opposit characteristic then in the case of `Data.List`.

Use it for relatively small arrays (length < 10000) otherwise you can get `Nothing`...
or just crash (stack overflow) in the case of `unsafeBuild`.

## Usage

`<>` is right associative and we execute its right hand
side argument to first so it works should work in
a pretty natural way:

```purescript
unsafeBuild $ cons 8 <> cons 9 <> cons 10 <> mempty == [8, 9, 10]
```

and

```purescript
unsafeBuild $ snoc 8 <> snoc 9 <> snoc 10 <> mempty == [10, 9, 8]
```

There are right (`:>` and `+>`) and right (`<:` and `<+`)
associative operators provided by the lib which "should" behave
as you would expect when mixed:

```purescript
unsafeBuild $ -3 :> [-2, -1] +> 0 :> mempty <: 1 <+ [1, 2] <: 3
```

This API works nicely with tools like `Monoid.guard`, `foldMap` etc. because we have a performant `Monoid` here.
