{join, resolve, dirname} = require "path"
{isFile, isDirectory, exists, async, call} = require "fairmont"
http = require "http"
url = require "url"
Static = require "node-static"


module.exports = class Servitol

  constructor: (@root, {@port=8888}) ->
    @staticServer = new Static.Server @root, cache: 0

  run: ->
    @httpServer = http.createServer (request, response) =>
      request.addListener "end", =>
        @serveFile request, response
      .resume()
    .listen @port

  serveFile: async (request, response) ->
    {pathname} = url.parse request.url
    filepath = yield @route pathname
    @staticServer.serveFile filepath, 200, {}, request, response

  route: async (pathname) ->
    pathname = pathname.slice 1

    # If the file actually exists at the requested path, use it.
    # Unless it's a directory, in which case try to use its index.
    target = join @root, pathname
    if yield isFile target
      return pathname
    if yield isDirectory target
      if yield exists join @root, pathname, "index.html"
        return join pathname, "index.html"

    dir = dirname pathname
    dirindex = join dir, "index.html"
    # Otherwise, if the directory exists and has an index file, use that.
    if yield exists join @root, dirindex
      return dirindex

    # Otherwise, use the root index.
    return "index.html"

