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
    let wallet = Wallet()!

    demoView = TezosKitDemoView(walletAddress: wallet.address)

    self.wallet = wallet
    self.tezosNodeClient = TezosNodeClient(remoteNodeURL: .alphanetURL)
    self.fundedWallet = .fundedWallet

    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)


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

extension TezosKitDemoViewController: TezosKitDemoViewDelegate {
  public func demoViewDidTapCheckBalance(_ demoView: TezosKitDemoView) {
    let address = wallet.address
    tezosNodeClient.getBalance(wallet: wallet) { result in
      switch (result) {
      case .success(let balance):
        self.showAlert(title: "Balance of \(address)", message: "\(balance)")
      default:
        self.showError()
      }
    }
  }

  public func demoViewDidTapInvokeContract(_ demoView: TezosKitDemoView) {
//    let michelsonParam = StringMichelsonParameter(string: "TezosKit Demo!")
//    let operationFees = OperationFees(fee: Tez(1), gasLimit: 1000, storageLimit: 0)
//    self.tezosNodeClient.call(contract: String.smartContractAddress, amount: Tez.zeroBalance, parameter: michelsonParam, source: wallet, signatureProvider: wallet, operationFees: operationFees) { result in
//      switch (result) {
//      case .success:
//      default:
//      }
//    }
  }

  public func demoViewDidAskForStorage(_ demoView: TezosKitDemoView) {
    tezosNodeClient.getContractStorage(address: String.smartContractAddress) { result in
      switch (result) {
      case .success(let storage):
        self.showAlert(title: "Contract Storage", message: "\(storage)")
      case.failure:
        self.showError() 
      }
    }
  }

  public func demoViewDidTapSendMeTezButton(_ demoView: TezosKitDemoView) {
    tezosNodeClient.send(
      amount: Tez(20),
      to: wallet.address,
      from: Wallet.fundedWallet.address,
      signatureProvider: Wallet.fundedWallet
    ) { result in
      switch (result) {
      case .success:
        self.showAlert(title: "Sent Tez", message: "On their way!")
      case .failure:
        self.showError()
      }
    }
  }
}
