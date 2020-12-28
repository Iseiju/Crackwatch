//
//  GameListController.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/10/20.
//

import UIKit

protocol GameListControllerDelegate {

  func pushGameInfo(forController controller: GameListController)
}

class GameListController: UIViewController {
  
  var viewModel: GameListViewModelStrategy?
  
  var delegate: GameListControllerDelegate?
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initViews()
  }

  private func initViews() {
    let navBarHeight = self.navigationController?.navigationBar.bounds.size.height
    
    let imageView = UIImageView(image: R.image.icCrackwatch())
    imageView.contentMode = .scaleAspectFit
    imageView.heightAnchor.constraint(equalToConstant: navBarHeight! - 12).isActive = true
    
    self.navigationItem.titleView = imageView
    
    tableView.delegate = self
    tableView.dataSource = self
    
    tableView.register(R.nib.headerCell)
    tableView.register(R.nib.collectionCell)
    tableView.register(R.nib.gameCell)
    
    viewModel?.getGames(completion: { _ in
      self.tableView.reloadData()
    })
  }
}

extension GameListController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
      return UIScreen.main.bounds.size.height / 2.5
    } else {
      return UITableView.automaticDimension
    }
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    guard let headerCell = tableView
            .dequeueReusableCell(withIdentifier: R.nib.headerCell.identifier) as? HeaderCell
    else { return 0.0 }

    return headerCell.cellHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerCell = tableView
      .dequeueReusableCell(withIdentifier: R.nib.headerCell.identifier) as? HeaderCell
    
    if section == 0 {
      headerCell?.setTitle(sectionTitle: "Latest Cracks")
    } else {
      headerCell?.setTitle(sectionTitle: "Games")
    }
    
    return headerCell
  }
  
  func tableView(_ tableView: UITableView,
                 willDisplay cell: UITableViewCell,
                 forRowAt indexPath: IndexPath) {
    guard let count = viewModel?.count else { return }
    guard indexPath.section == 1 else { return }
    
    if indexPath.row == count - 1 {
      viewModel?.getGames(completion: { _ in
        self.tableView.reloadData()
      })
    }
  }
}

extension GameListController: UITableViewDataSource {
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return section == 0 ? 1 : viewModel?.count ?? 0
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
      guard let collectionCell = tableView
              .dequeueReusableCell(withIdentifier: R.nib.collectionCell.identifier,
                                   for: indexPath) as? CollectionCell
      else { return UITableViewCell() }
      
      collectionCell.cellViewModel = viewModel?.collectionCellViewModel
      
      return collectionCell
    } else {
      guard let gameCell = tableView
              .dequeueReusableCell(withIdentifier: R.nib.gameCell.identifier,
                                   for: indexPath) as? GameCell
      else { return UITableViewCell() }
      
      guard let cellViewModel = viewModel?
              .cellViewModels(forIndexPath: indexPath)
      else { return UITableViewCell() }
      
      gameCell.delegate = self
      gameCell.tag = indexPath.row
      gameCell.set(cellViewModel)
      
      return gameCell
    }
  }
}

extension GameListController: GameCellDelegate {
  
  func didTapGame(forIndex index: Int) {
    print(index)
  }
}
