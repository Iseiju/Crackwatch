//
//  GameCell.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/10/20.
//

import MaterialComponents
import UIKit

protocol GameCellDelegate {

  func didTapGame(forIndex index: Int)
}

class GameCell: UITableViewCell {

  var delegate: GameCellDelegate?

  var cellViewModel: GameCellViewModelStrategy?
  
  @IBOutlet weak var cardView: MDCCard!
  
  @IBOutlet weak var statusView: UIView!
  
  @IBOutlet weak var posterImageView: UIImageView!
  @IBOutlet weak var statusImageView: UIImageView!
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var daysToCrackLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    cardView.cornerRadius = 4.0
    cardView.inkView.isHidden = true
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func set(_ cellViewModel: GameCellViewModelStrategy) {
    self.cellViewModel = cellViewModel
    
    let url = URL(string: self.cellViewModel?.imageUrl ?? "" )
    
    posterImageView.kf.indicatorType = .activity
    posterImageView.kf.setImage(with: url, options: [.transition(.fade(0.2))])
    
    titleLabel.text = self.cellViewModel?.title
    daysToCrackLabel.text = self.cellViewModel?.daysToCrack
    daysToCrackLabel.textColor = self.cellViewModel?.statusColor
    statusView.backgroundColor = self.cellViewModel?.statusColor
    statusImageView.image = self.cellViewModel?.statusImage
    statusImageView.tintColor = self.cellViewModel?.statusColor
  }
  
  @IBAction func didTapGame(_ sender: Any) {
    delegate?.didTapGame(forIndex: self.tag)
  }
}
