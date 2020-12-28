//
//  GameListCoordinator.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import Foundation
import UIKit

class GameListCoordinator {
  
  var presentedController: UIViewController?
  
  convenience init(presentedController: UIViewController) {
    self.init()
    self.presentedController = presentedController
  }
  
  func presentMain() {
    guard let gameListController = R.storyboard.main.mainController() else { return }
    
    gameListController.viewModel = GameListViewModel()
    gameListController.delegate = self
    
    let navController = initNavController(controller: gameListController)
    presentedController?.present(navController, animated: true, completion: nil)
  }
  
  private func initNavController(controller: UIViewController) -> UINavigationController {
    let navController = UINavigationController(rootViewController: controller)
    navController.navigationBar.tintColor = .white
    navController.navigationBar.barTintColor = .black
    navController.modalPresentationStyle = .fullScreen
    
    return navController
  }
}

extension GameListCoordinator: GameListControllerDelegate {
  
  func pushGameInfo(forController controller: GameListController) {
    guard let navController = controller.navigationController else { return }
    let gameInfoCoordinator = GameInfoCoordinator(navigationController: navController)
    gameInfoCoordinator.pushGameInfo()
  }
}
