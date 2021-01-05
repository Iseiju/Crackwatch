//
//  CardView.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 1/5/21.
//

import Foundation
import UIKit

class CardView: UIView {
  
  override var bounds: CGRect {
    didSet {
      initCardView()
    }
  }
  
  private func initCardView() {
    clipsToBounds = true
    
    layer.cornerRadius = 4.0
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowOffset = CGSize(width: -1, height: 1)
    layer.shadowRadius = 2.0
    layer.shadowPath = UIBezierPath(roundedRect: self.bounds,
                                    cornerRadius: layer.cornerRadius).cgPath
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
  }
}

