assert = require "assert"
{describe} = require "amen"
{call} = require "fairmont"

Servitol = require ".."

servitol = new Servitol "test/files", {}

describe "Servitol request routing", ({describe, test}) ->

  describe "routes to exact path when a file exists", ({test}) ->
    test "in root", ->
      assert.equal (yield servitol.route "/exact.html"), "exact.html"

    test "in a subdir", ->
      assert.equal (yield servitol.route "/exact/exact.html"), "exact/exact.html"

  describe "path exists as a directory with an index", ({test}) ->
    test "routes to subdir/index.html", ->
      assert.equal (yield servitol.route "/hasindex"), "hasindex/index.html"
      assert.equal (yield servitol.route "/hasindex/"), "hasindex/index.html"


  describe "subdirectory does not exist", ({test}) ->
    test "routes to /index.html", ->
      assert.equal (yield servitol.route "/bogus/bogus.html"), "index.html"

  describe "subdirectory exists", ({describe}) ->
    describe "and has index.html", ({test}) ->
      test "routes to sub/index.html", ->
        assert.equal (yield servitol.route "/hasindex/bogus.html"), "hasindex/index.html"

    describe "and does not have index.html", ({test}) ->
      test "routes to /index.html", ->
        assert.equal (yield servitol.route "/bar/bogus.html"), "index.html"


