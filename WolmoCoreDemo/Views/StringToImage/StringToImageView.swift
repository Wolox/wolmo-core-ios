//
//  stringToImageView.swift
//  WolmoCoreDemo
//
//  Created by Diego Quiros on 05/10/2018.
//  Copyright © 2018 Wolox. All rights reserved.
//

import Foundation
import UIKit
import WolmoCore

final class StringToImageView: UIView, NibLoadable {

    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var wideImage1: UIImageView!
    @IBOutlet weak var wideImage2: UIImageView!
    @IBOutlet weak var tallImage1: UIImageView!
    @IBOutlet weak var tallImage2: UIImageView!
    override func awakeFromNib() {
      super.awakeFromNib()
        let font = UIFont(name: "Times New Roman", size: 19.0)!
        let font2 = UIFont(name: "GillSans-LightItalic", size: 50.0)!
        image1.draw(string: "\u{1F496}")
        image2.draw(string: "%")
        image3.draw(string: "\u{1F47b}")
        wideImage1.draw(string: "\u{1F480}testing\u{1F480}", font: font)
        wideImage2.image = "Wolox".toImage(font: font2)?.tintedWith(.blue)
        tallImage1.image = "\u{2714}".toImage(fontSize: 120)?.tintedWith(.green)
        tallImage2.draw(string: "100", fontSize: 120)
  }

}
