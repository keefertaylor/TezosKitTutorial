// Copyright Keefer Taylor, 2019.

import TezosKit
import UIKit

/// Main entry point of the demo application.
class TezosKitDemoViewController: UIViewController {
  /// A Tezos Node Client which will interact with the Tezos network.
  private let tezosNodeClient: TezosNodeClient

  /// A wallet which is funded.
  private let fundedWallet: Wallet

  /// A wallet that the demo will work with.
  private let wallet: Wallet

  /// The view for this view controller.
  private let demoView: TezosKitDemoView

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    /// Create a wallet.
    /// Use a pre-generated mnemonic so that the Wallet address stays the same in case the
    /// demo messes up and needs to be restarted.
    /// Normally, to get a random wallet, you write:
    ///   let wallet = Wallet()
    let mnemonic =
      "service return smoke bulk husband powder stove coral rose urban educate then slender recycle movie"
    self.wallet = Wallet(mnemonic: mnemonic)!

    /// Keep a reference to a wallet that has some Tez in it already.
    /// You can get alphanet wallets from the alphanet fauce, http://faucet.tzalpha.net.
    self.fundedWallet = .fundedWallet

    /// Create a TezosNodeClient which interacts with the Tezos network.
    /// Point it at alphanet.
    self.tezosNodeClient = TezosNodeClient(remoteNodeURL: .alphanetURL)

    /// Create a demo view.
    demoView = TezosKitDemoView(walletAddress: wallet.address)

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    /// Set this view controller to receive events from the view.
    demoView.delegate = self
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = demoView
  }

  // MARK: - Helpers

  /// Show an alert to the user.
  private func showAlert(title: String, message: String) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )

    let dismissAction = UIAlertAction(
      title: "Got it!",
      style: .default
    )
    alert.addAction(dismissAction);
    self.present(alert, animated: true, completion: nil)
  }

  /// Show a generic error.
  private func showError() {
    self.showAlert(title: "Error", message: "Try again later.")
  }
}

// MARK: _ TezosKitDemoViewDelegate

extension TezosKitDemoViewController: TezosKitDemoViewDelegate {
  public func demoViewDidTapCheckBalance(_ demoView: TezosKitDemoView) {
  }

  public func demoViewDidTapSendMeTezButton(_ demoView: TezosKitDemoView) {
  }

  public func demoViewDidTapInvokeContract(_ demoView: TezosKitDemoView) {
  }

  public func demoViewDidAskForStorage(_ demoView: TezosKitDemoView) {
  }
}
