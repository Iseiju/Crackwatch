//
//  HeaderCell.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/13/20.
//

import UIKit

class HeaderCell: UITableViewCell {
  
  var cellHeight: CGFloat { return CGFloat(parentView.bounds.size.height) }
  
  @IBOutlet weak var parentView: UIView!
  
  @IBOutlet weak var sectionTitleLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  func setTitle(sectionTitle: String) {
    sectionTitleLabel.text = sectionTitle
  }
}
