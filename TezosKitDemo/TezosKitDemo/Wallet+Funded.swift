// Copyright Keefer Taylor, 2019.

import TezosKit

/// An extension on the Wallet object which provides access to a pre-funded wallet.
/// You can get your own at the Tezos Alphanet Faucet, see: http://faucet.tzalpha.net.
extension Wallet {
  public static let fundedWallet = Wallet(mnemonic: "predict corn duty process brisk tomato shrimp virtual horror half rhythm cook")!
}
