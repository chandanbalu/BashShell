#!/bin/bash

foo() {
  local VARIABLE=$1
  eval echo $VARIABLE
}

main() {
  foo "I like tacos!"
}

if [[ "$(basename "$0" .sh)" == "mainBash" ]]; then
    main
fi
exit 0
