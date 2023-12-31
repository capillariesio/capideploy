#!/bin/bash
if [ "$DIR_CAPILLARIES_ROOT" = "" ]; then
  echo Error, missing DIR_CAPILLARIES_ROOT=~/src/capillaries
  exit 1
fi

cd "$DIR_CAPILLARIES_ROOT"
echo "Building Capillaries webui from " \"$(pwd)\"

export PATH=$PATH:$HOME/.nvm/versions/node/v20.9.0/bin

# Just build for http://localhost:6543, sh/webapi/config.sh will patch bundle.js on deployment
# If, for some reason, patching is not an option, build UI with this env variable set:
# export CAPILLARIES_WEBAPI_URL=http://$EXTERNAL_IP_ADDRESS:6543

cd ./ui
npm run build

pushd build
tar -czvf all.tgz *
popd
