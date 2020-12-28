//
//  ExpandedGameCell.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import Kingfisher
import MaterialComponents
import UIKit

protocol ExpandedGameCellDelegate {
  
  func didTapGame()
}

class ExpandedGameCell: UICollectionViewCell {
  
  var delegate: ExpandedGameCellDelegate?
  
  var cellViewModel: GameCellViewModelStrategy?

  @IBOutlet weak var cardView: MDCCard!
  
  @IBOutlet weak var posterImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var daysToCrackLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    cardView.cornerRadius = 4.0
    cardView.inkView.isHidden = true
  }
  
  func set(_ cellViewModel: GameCellViewModelStrategy) {
    self.cellViewModel = cellViewModel
    
    let url = URL(string: self.cellViewModel?.imageUrl ?? "")
    
    posterImageView.kf.indicatorType = .activity
    posterImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    
    titleLabel.text = self.cellViewModel?.title
    daysToCrackLabel.text = self.cellViewModel?.daysToCrack
  }
  
  @IBAction func didTapGame(_ sender: Any) {
    delegate?.didTapGame()
  }
}
