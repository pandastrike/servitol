# Servitol

A static file server for testing web frontends where you want to fool around with the URL but need predictable content served.

## Install

    npm install servitol


## Run

    servitol path/to/content/ 8080


## How Servitol serves it all

    mkdir -p path/to/content
    cd !$
    echo "ultimate fallback" > index.html
    echo "exactly what you want" > exact.html
    mkdir "subdir"
    echo "a subdirectory index" > subdir/index.html
    echo "subdirectory exact content" > subdir/exact.html


If the requested path exists, Servitol gives you that file.

If that path doesn't exist, but the directory does, and it has an index.html,
Servitol gives you that.

Otherwise, Servitol gives you `/index.html`

## Test application (currently showing failure)

Included is a test of an attempt to get Polymer's `iron-location`
working bidirectionally.
It console.logs iron-location's idea of the parsed URL, then attempts
to change the URL.path, hoping it will propagate to the window.

    cd servitol/test/polymer
    ../../bin/servitol . 9999

Then visit http://localhost:9999/

