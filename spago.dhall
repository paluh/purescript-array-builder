{ name = "array-builder"
, dependencies =
  [ "arrays"
  , "assert"
  , "console"
  , "effect"
  , "foldable-traversable"
  , "maybe"
  , "nullable"
  , "prelude"
  ]
, license = "BSD-3-Clause"
, packages = ./packages.dhall
, repository = "https://github.com/paluh/array-builder.git"
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
