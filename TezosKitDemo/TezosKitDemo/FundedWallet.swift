// Copyright Keefer Taylor, 2019.

import TezosKit

extension String {
  public static let fundedMnemonic = "success, couple, scout, neck, album, excuse, erase, discover, door, level, galaxy, scare, mask, ceiling, ahead"
}

/// An extension on the Wallet object which provides access to a pre-funded wallet.
extension Wallet {
  public static let fundedWallet = Wallet(mnemonic: .fundedMnemonic)
}
