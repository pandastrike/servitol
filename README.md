# Servitol

A static file server for testing web frontends where you want to fool around with the URL but need predictable content served.

## Install

    npm install servitol


## Run

    servitol path/to/content/ 8080


## How Servitol serves it all

    mkdir path/to/content
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


