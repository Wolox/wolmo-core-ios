//
//  stringToImageController.swift
//  WolmoCoreDemo
//
//  Created by Diego Quiros on 05/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit

final class StringToImageController: UIViewController {

  private let _view: StringToImageView = StringToImageView.loadFromNib()!

  @available(*, unavailable, message: "use init(viewModel:) instead")
  required public init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }

  @available(*, unavailable, message: "use init(viewModel:) instead")
  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
      fatalError("init(nibName:bundle:) has not been implemented")
  }

  init() {
    super.init(nibName: .none, bundle: .none)
  }

  override public func loadView() {
    view = _view
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

}
