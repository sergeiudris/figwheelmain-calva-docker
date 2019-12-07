#!/bin/bash

dock() {
    sudo xhost +
    docker build -t tmp.figwheelmain-calva-docker .
    docker run  --rm \
                --env DISPLAY=${DISPLAY} \
                -v /tmp/.X11-unix:/tmp/.X11-unix \
                --name fcd \
                -it \
                -p 7888:7888 \
                -p 9500:9500 \
                -v "$(pwd)":/opt/app \
                 tmp.figwheelmain-calva-docker \
                 bash
}

calva_jackin_copied_as_is(){
  # in VSCode bottom left corner has nREPL button
  # opens Calva menu
  # when you select start ... using jack-in... the OUTPUT tab shows this:
  clojure -Sdeps '{:deps {nrepl {:mvn/version "0.6.0"} cider/cider-nrepl {:mvn/version "0.22.4"} cider/piggieback {:mvn/version "0.4.1"} com.bhauman/figwheel-main {:mvn/version "0.2.3"}}}' \
  -A:fig:build
}

dev(){
  # changed version 
  clojure \
  -Sdeps '{:deps {nrepl {:mvn/version "0.6.0"} cider/cider-nrepl {:mvn/version "0.21.1"} cider/piggieback {:mvn/version "0.4.1"} figwheel-sidecar {:mvn/version "0.5.18"}}}' \
  -A:fig \
  -m nrepl.cmdline  \
  --middleware "[cider.nrepl/cider-middleware cider.piggieback/wrap-cljs-repl]" \
  --bind "0.0.0.0" --port 7888
}

"$@"