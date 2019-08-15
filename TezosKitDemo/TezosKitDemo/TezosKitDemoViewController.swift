// Copyright Keefer Taylor, 2019.

import TezosKit
import UIKit

/// Main entry point of the demo application.
class TezosKitDemoViewController: UIViewController {
  /// A Tezos Node Client which will interact with the Tezos network.
  private let tezosNodeClient: TezosNodeClient

  /// A wallet which is pre-funded.
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

// MARK: - TezosKitDemoViewDelegate

extension TezosKitDemoViewController: TezosKitDemoViewDelegate {
  public func demoViewDidTapCheckBalance(_ demoView: TezosKitDemoView) {
    tezosNodeClient.getBalance(wallet: wallet) { result in
      switch (result) {
      case .success(let balance):
        self.showAlert(title: "Balance of \(self.wallet.address)", message: "\(balance.humanReadableRepresentation)")

      // Log errors in case of failure.
      case .failure(let error):
        print("Error: \(error)")
        self.showError()
      }
    }
  }

  public func demoViewDidTapSendMeTezButton(_ demoView: TezosKitDemoView) {
    let amount = Tez(20)
    let to = wallet.address
    let from = fundedWallet.address
    let signatureProvider = fundedWallet

    tezosNodeClient.send(
      amount: amount,
      to: to,
      from: from,
      signatureProvider: signatureProvider
    ) { result in
      switch (result) {
      case .success(let operationHash):
        self.showAlert(title: "Sent Tez", message: "On their way!")
        print("Operation Hash: \(operationHash)")

      // Log errors in case of failure.
      case .failure(let error):
        print("Error: \(error)")
        self.showError()
      }
    }
  }

  public func demoViewDidAskForStorage(_ demoView: TezosKitDemoView) {
    tezosNodeClient.getContractStorage(address: String.smartContractAddress) { result in
      switch (result) {
      case .success(let storage):
        self.showAlert(title: "Contract Storage", message: "\(storage)")

      // Log errors in case of failure.
      case .failure(let error):
        print("Error: \(error)")
        self.showError()
      }
    }
  }

  public func demoViewDidTapInvokeContract(_ demoView: TezosKitDemoView) {
    let contractAddress = String.smartContractAddress
    let michelsonParam = StringMichelsonParameter(string: "TezosKit")
    let operationFees = OperationFees(fee: Tez(1), gasLimit: 100000, storageLimit: 10000)
    let amount = Tez.zeroBalance
    let source = wallet.address
    let signatureProvider = wallet

    self.tezosNodeClient.call(
      contract: contractAddress,
      amount: amount,
      parameter: michelsonParam,
      source: source,
      signatureProvider: signatureProvider,
      operationFees: operationFees
    ) { result in
      switch (result) {
      case .success(let operationHash):
        self.showAlert(title: "Called smart contract", message: "Done!")
        print("Operation Hash: \(operationHash)")

      // Log errors in case of failure.
      case .failure(let error):
        print("Error: \(error)")
        self.showError()
      }
    }

  }
}
