Celluar Automata for Haxe
=========================

Naive implementation of some celluar automata using Haxe.
Currently implemented:
* Forest fire
* Generational
* Game of Life

Rendering using HTML5 canvas. Requirements:
* HTML5 capable browser
* Haxe 3+ ( tested on Haxe 3.3 )
* HTTP-server ( like NodeJS http-server )

To install NodeJS http-server you need **node** and **npm**. Just type
```
npm install http-server -g
```

To build HTML5 project type:
```
haxe build-html5.hxml
```

Run local server into root project folder:
```
http-server
```

Goto http://127.0.0.1:8080/ in your favorite browser.
