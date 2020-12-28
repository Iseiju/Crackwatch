//
//  GameInfoViewModel.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/26/20.
//

import Foundation

protocol GameInfoViewModelStrategy {
  
  var imageUrl: String { get }
}

class GameInfoViewModel: GameInfoViewModelStrategy {
  
  var game: Game?
  
  var imageUrl: String { return game?.imageUrl ?? "" }
  
  init(game: Game) {
    self.game = game
  }
}
