#!/bin/sh

set -ev

if ! test -d Eve; then
    printf "%s\\n" "getting eve ..."
    git clone --depth=1 https://github.com/witheve/Eve
else
    printf "%s\\n" "updating eve ..."
    (cd Eve && git pull)
fi

printf "%s\\n" "compiling eve editor ..."
(cd Eve/ui && sudo tsc)

printf "%s\\n" "updating rust if necessary ..."
(cd Eve/runtime && sudo HOME=/home/vagrant multirust override nightly-2015-08-10) || {
    cat /tmp/multirust.log
    exit 1
}
rm -rf /tmp/multirust.log

printf "%s\\n" "compiling eve server ..."
(cd Eve/runtime && sudo HOME=/home/vagrant RUST_BACKTRACE=1 cargo build --release)

printf "%s\\n" "starting eve ..."
(cd Eve/runtime && sudo HOME=/home/vagrant RUST_BACKTRACE=1 cargo run --bin=server --release &)
sleep 5s #give some time to Eve startup

printf "%s\\n" "DONE: go to http://localhost:8080/editor to experience Eve"

# vim: set ts=8 sw=4 tw=0 ft=sh :
