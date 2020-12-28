//
//  GameInfoCoordinator.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/11/20.
//

import Foundation
import UIKit

class GameInfoCoordinator {
  
  var navigationController: UINavigationController?
  
  convenience init(navigationController: UINavigationController) {
    self.init()
    self.navigationController = navigationController
  }
  
  func pushGameInfo() {
    guard let gameInfoController = R.storyboard.main.gameInfoController() else { return }
    
    navigationController?.pushViewController(gameInfoController, animated: true)
  }
}
