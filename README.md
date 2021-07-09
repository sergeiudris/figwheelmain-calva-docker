# tmp.figwheel-calva-docker

- an example of running a figwheel-main from Docker with Calva
- a temporary repo for the issue https://github.com/BetterThanTomorrow/calva/issues/296

<br/>

- steps taken:
  - create a figwheel project
    - `lein new figwheel-main hello-world.core -- --reagent +deps`
  - create a file for bash functions (not to type them every time)
    - [`f`](./f)
    - add some functions (self explanetary)
  - create a Dockerfile
    - [Dockerfile](./Dockerfile)
  - run `bash f dock`
    - this will build a Docker image
    - and log you into a container
    - root of the repo is a volume inside a container
  - run `bash f dev`
    - if you see an error `Could not locate nrepl/cmdline__ ..`
      - run `rm -rf .cpcache`
    - last output in console will be `nREPL server started on port 7888 on host 0.0.0.0 - nrepl://0.0.0.0:7888`
  - now we need to connect Calva to it
  - open this repo with VSCode
  - connect from calva ( ctrl+alt+c ctrl+alt+c)
  - select `clojure CLI + Figwheel Main`
  - type in `localhost:7888`
  - a popup will appear `Please select which builds to start with`
  - select `dev`, press ok
  - open the app on `localhost:9500`
  - open `src/hello_world/core.cljs` in editor
  - in Calva window (on the right side) 
    - type `(ns hello-world.core)`
      - of course, there is a calva setting to do it automatically when you switch files
    - type `get-app-element` to confirm you have access to app vars
      - if error, you forgot to open `localhost:9500`
      - if you see `#object[hello_world$core$get_app_element]` - you are in
  - now you can read-eval-print in you app

<br/>

- disclaimer
  - personally I use shadow-cljs
  - because of the [`npm modules`](https://shadow-cljs.github.io/docs/UsersGuide.html#_using_npm_packages) amazing feature   
  - running from Docker is straight forward, just open the ports
  - had no issues or problems with dev/prod builds with shadow-cljs
    - including :chrome-extension target

