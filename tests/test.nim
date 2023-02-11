# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import mymm_normalizer

test "can process Phont Phyo":
  check normalize("ဖံွ့ဖြိုး") == "ဖွံ့ဖြိုး"

test "can process India":
  check normalize("အိနိ္ဒယ") == "အိန္ဒိယ"

test "can process Ship":
  check normalize("သငေ်္ဘာ") == "သင်္ဘော"