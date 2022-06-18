module Test.Main where

import Prelude

import Effect (Effect)
import Test.README as README

main :: Effect Unit
main = README.suite
