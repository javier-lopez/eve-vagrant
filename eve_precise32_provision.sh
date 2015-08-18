#!/bin/sh
set -ev

###base
if ! command -v git >/dev/null 2>&1; then
    printf "%s\\n" "installing git + curl ..."
    sudo apt-get update
    sudo apt-get install -y --no-install-recommends git curl
fi

if ! test -d Eve; then
    printf "%s\\n" "getting eve ..."
    git clone --depth=1 https://github.com/witheve/Eve
else
    printf "%s\\n" "updating eve ..."
    (cd Eve && git pull)
fi

printf "%s\\n" "installing eve dependencies ..."

if ! command -v node >/dev/null 2>&1; then
    printf "%s\\n" "installing node ..."
    printf "%s\\n" "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main" \
        > chris-lea-nodejs-precise.list
    sudo mv chris-lea-nodejs-precise.list /etc/apt/sources.list.d/
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B9316A7BC7917B12
    sudo apt-get update
    sudo apt-get install -y --force-yes --no-install-recommends nodejs
fi

if ! command -v tsc >/dev/null 2>&1; then
    printf "%s\\n" "installing typescript ..."
    sudo npm install -g typescript
fi

if ! multirust -v tsc >/dev/null 2>&1; then
    printf "%s\\n" "installing multirust ..."
    sudo ./Eve/install-multirust.sh >/tmp/multirust.log || {
        cat /tmp/multirust.log
        exit 1
    }
    rm -rf /tmp/multirust.log
fi

###eve
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
