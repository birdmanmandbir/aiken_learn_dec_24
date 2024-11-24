use aiken/crypto.{VerificationKeyHash}
use aiken/collection/list
use cardano/transaction.{OutputReference, Transaction}

pub type SimpleDatum {
  signer1: VerificationKeyHash,
  signer2: VerificationKeyHash,
}

validator simple {
  spend(
    datum: Option<SimpleDatum>,
    _redeemer: Int,
    _utxo: OutputReference,
    txinfo: Transaction,
  ) {
    // if not, fail immediately
    expect Some(datum) = datum
    signed_by_signers(datum.signer1, datum.signer2, txinfo.extra_signatories)
  }
}

fn signed_by_signers(
  signer1: VerificationKeyHash,
  signer2: VerificationKeyHash,
  extra_signatures: List<VerificationKeyHash>,
) -> Bool {
  is_signed_by(signer1, extra_signatures) && is_signed_by(signer2, extra_signatures)
}

fn is_signed_by(signer: VerificationKeyHash, signatories: List<VerificationKeyHash>) -> Bool {
  list.has(signatories, signer)
}
