// Copyright Keefer Taylor, 2019.

import UIKit

/// Informs delegate of user interactions within the view.
public protocol TezosKitDemoViewDelegate: class {
  func demoViewDidTapCheckBalance(_ demoView: TezosKitDemoView)
  func demoViewDidTapSendMeTezButton(_ demoView: TezosKitDemoView)
  func demoViewDidTapInvokeContract(_ demoView: TezosKitDemoView)
  func demoViewDidAskForStorage(_ demoView: TezosKitDemoView)
  func demoViewDidAskToQueryConseil(_ demoView: TezosKitDemoViewDelegate)
}

/// A demo view with some buttons we can press to interact with Tezos.
public class TezosKitDemoView: UIView {
  public var delegate: TezosKitDemoViewDelegate?

  /// UI Elements in the view.
  /// `stackView` is superView to the other elements.
  private let stackView: UIView
  private let addressLabel: UILabel
  private let checkBalanceButton: UIButton
  private let sendMeTezButton: UIButton
  private let invokeContractButton: UIButton

  /// Initialize a new view.
  public override init(frame: CGRect) {
    let stackView = UIStackView()

    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.distribution = .equalCentering
    stackView.alignment = .center

    let addressLabel = UILabel()
    addressLabel.text = "Wallet: --"

    let checkBalanceButton = UIButton()
    checkBalanceButton.sizeToFit()
    checkBalanceButton.setTitle("Check balance", for: .normal)
    checkBalanceButton.backgroundColor = .red
    checkBalanceButton.sizeToFit()

    let sendMeTezButton = UIButton()
    sendMeTezButton.sizeToFit()
    sendMeTezButton.setTitle("Send Me Tez", for: .normal)
    sendMeTezButton.backgroundColor = .red
    sendMeTezButton.sizeToFit()

    let invokeContractButton = UIButton()
    invokeContractButton.sizeToFit()
    invokeContractButton.setTitle("Invoke Contract", for: .normal)
    invokeContractButton.backgroundColor = .red
    invokeContractButton.sizeToFit()

    self.addressLabel = addressLabel
    self.checkBalanceButton = checkBalanceButton
    self.invokeContractButton = invokeContractButton
    self.sendMeTezButton = sendMeTezButton

    stackView.frame = UIScreen.main.bounds
    stackView.addArrangedSubview(addressLabel)
    stackView.addArrangedSubview(checkBalanceButton)
    stackView.addArrangedSubview(sendMeTezButton)
    stackView.addArrangedSubview(invokeContractButton)

    self.stackView = stackView

    super.init(frame: frame)

    self.backgroundColor = .white

    self.addSubview(stackView)

    stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
  }

  public override class var requiresConstraintBasedLayout: Bool {
    return true
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  // MARK: - Buttons

  private func checkBalancePressed() {
    delegate?.demoViewDidTapCheckBalance(self)
  }

  private func invokeContractPressed() {
    delegate?.demoViewDidTapInvokeContract(self)
  }
}
