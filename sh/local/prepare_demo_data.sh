#!/bin/bash
if [ "$DIR_CAPILLARIES_ROOT" = "" ]; then
  echo Error, missing DIR_CAPILLARIES_ROOT=~/src/capillaries
  exit 1
fi

cd "$DIR_CAPILLARIES_ROOT"
echo "Preparing Capillaries demo data from " \"$(pwd)\"

# Assuming HOME is set by ExecLocal
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export GOCACHE="$HOME/.cache/go-build"
export GOMODCACHE="$HOME/go/pkg/mod"

rm -fR /tmp/capi_cfg
rm -fR /tmp/capi_in
rm -fR /tmp/capi_out

mkdir /tmp/capi_cfg
mkdir /tmp/capi_in
mkdir /tmp/capi_out

cp -r ./test/data/cfg/* /tmp/capi_cfg
cp -r ./test/data/in/* /tmp/capi_in
cp -r ./test/data/out/* /tmp/capi_out

# Generate big data

pushd ./test/code/lookup/bigtest
./1_create_data.sh
popd

pushd ./test/code/portfolio/bigtest
./1_create_data.sh
popd

pushd ./test/code/fannie_mae/bigtest
./1_copy_data.sh
popd


