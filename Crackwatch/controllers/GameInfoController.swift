//
//  GameInfoController.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import Kingfisher
import UIKit

class GameInfoController: UIViewController {
  
  var viewModel: GameInfoViewModelStrategy?

  @IBOutlet weak var posterImageView: UIImageView!
  
  @IBOutlet weak var posterImageViewHeight: NSLayoutConstraint!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
  }
  
  private func initViews() {
    posterImageViewHeight.constant = UIScreen.main.bounds.size.height / 3
    
    let url = URL(string: self.viewModel?.imageUrl ?? "" )
    
    posterImageView.kf.indicatorType = .activity
    posterImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
  }
}
