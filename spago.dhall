{ name = "purescript-array-builder"
, dependencies =
  [ "arrays"
  , "assert"
  , "console"
  , "effect"
  , "either"
  , "exceptions"
  , "maybe"
  , "prelude"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
