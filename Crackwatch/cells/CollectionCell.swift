//
//  CollectionCell.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import UIKit

//protocol CollectionCellDelegate {
//
//  func didTapGame()
//}

class CollectionCell: UITableViewCell {
  
//  var delegate: CollectionCellDelegate?
  
  var cellViewModel: CollectionCellViewModelStrategy?
  
  private let sectionInsets = UIEdgeInsets(top: 12.0,
                                           left: 12.0,
                                           bottom: 12.0,
                                           right: 12.0)
  
  @IBOutlet weak var collectionView: UICollectionView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    initCell()
  }

  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
  private func initCell() {
    collectionView.delegate = self
    collectionView.dataSource = self
    
    collectionView.register(R.nib.expandedGameCell)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
      self.cellViewModel?.getLatestCrackedGames(completion: { _ in
        self.collectionView.reloadData()
      })
    })
  }
  
  private func snapToCenter() {
    let centerPoint = self.convert(self.center, to: collectionView)
    guard let centerIndexPath = collectionView.indexPathForItem(at: centerPoint) else { return }
    collectionView.scrollToItem(at: centerIndexPath, at: .centeredHorizontally, animated: true)
  }
}

extension CollectionCell: UICollectionViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      snapToCenter()
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    snapToCenter()
  }
}

extension CollectionCell: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let paddingSpace = sectionInsets.left * (1 + 1)
    let width = collectionView.frame.width - paddingSpace
    let height = collectionView.frame.height - paddingSpace

    return CGSize(width: width - paddingSpace, height: height)
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    return sectionInsets
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return sectionInsets.left
  }
}

extension CollectionCell: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView,
                      numberOfItemsInSection section: Int) -> Int {
    return cellViewModel?.count ?? 0
  }
  
  func collectionView(_ collectionView: UICollectionView,
                      cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let expandedGameCell = collectionView
      .dequeueReusableCell(withReuseIdentifier: R.nib.expandedGameCell.identifier,
                           for: indexPath) as? ExpandedGameCell
    else { return UICollectionViewCell() }
    
    guard let cellViewModel = cellViewModel?
            .expandedCellViewModel(forIndexPath: indexPath)
    else { return UICollectionViewCell() }
    
    expandedGameCell.delegate = self
    expandedGameCell.set(cellViewModel)
    
    return expandedGameCell
  }
}

extension CollectionCell: ExpandedGameCellDelegate {
  
  func didTapGame() {
//    delegate?.didTapGame()
  }
}
