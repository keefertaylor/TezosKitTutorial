// Copyright Keefer Taylor, 2019.

import TezosKit
import UIKit

class ViewController: UIViewController {
  private let demoView: TezosKitDemoView

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    demoView = TezosKitDemoView(frame: .zero)
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

    demoView.delegate = self
  }

  @available(*, unavailable) required init?(coder aDecoder: NSCoder) {
    fatalError()
  }

  public override func loadView() {
    self.view = demoView
  }
}

extension ViewController: TezosKitDemoViewDelegate {
  public func demoViewDidTapCheckBalance(_ demoView: TezosKitDemoView) {
    // TODO: Implement balance checking
  }

  public func demoViewDidTapInvokeContract(_ demoView: TezosKitDemoView) {
    // TODO: Demonstrate contract invoking
  }

  public func demoViewDidAskForStorage(_ demoView: TezosKitDemoView) {
    // TODO: Demonstrate retrieving storage
  }

  public func demoViewDidTapSendMeTezButton(_ demoView: TezosKitDemoView) {
    // TODO: Send me some tez!
  }

  public func demoViewDidAskToQueryConseil(_ demoView: TezosKitDemoViewDelegate) {
    // TODO: Query conseil 
  }
}