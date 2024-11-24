# utxoin = txhash#txix
# remember to update the values/address with the correct address
utxoin="832cf06b2e388a4569bfce92b79c0a506b5f45df76ba3c4cc7e6e7bff6086770#8"
output_address=$(cat .compiled/simple.addr)
change_address=$nami3
output="500000000"
PREVIEW="--testnet-magic 2"

# conway is an era of the cli tool, we can also use "latest" for the latest era
cardano-cli conway transaction build \
  $PREVIEW \
  --tx-in $utxoin \
  --tx-out $output_address+$output \
  --tx-out-datum-hash-file ./values/datum.json \
  --change-address $change_address \
  --out-file simple.unsigned

cardano-cli conway transaction sign \
  $PREVIEW \
  --tx-body-file simple.unsigned \
  --signing-key-file $HOME/Dev/Wallets/Adr08.skey \
  --out-file simple.signed

cardano-cli conway transaction submit \
  $PREVIEW \
  --tx-file simple.signed
