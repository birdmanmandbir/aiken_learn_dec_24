#! /bin/bash

wallet_name="wall1"
cardano-cli address key-gen \
  --verification-key-file ${wallet_name}.vkey \
  --signing-key-file ${wallet_name}.skey

cardano-cli address build \
  --payment-verification-key-file ${wallet_name}.vkey \
  --out-file ${wallet_name}.addr \
  --testnet-magic 2

cardano-cli address key-hash \
  --payment-verification-key-file ${wallet_name}.vkey \
  --out-file ${wallet_name}.hash
