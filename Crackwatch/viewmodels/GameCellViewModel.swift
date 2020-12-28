//
//  GameCellViewModel.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/13/20.
//

import Foundation
import UIKit

enum CrackStatus: String {
  
  case cracked = "CRACKED D"
  case uncracked = "UNCRACKED D+"
  case unreleased = "UNRELEASED D"
}

protocol GameCellViewModelStrategy  {
  
  var imageUrl: String { get }
  var title: String { get }
  var daysToCrack: String { get }
  
  var statusImage: UIImage { get }
  
  var statusColor: UIColor { get }
}

class GameCellViewModel: GameCellViewModelStrategy {
  
  var game: Game?
  
  var crackStatus: CrackStatus = .unreleased
  
  var imageUrl: String { return game?.imageUrl ?? "" }
  var title: String { return game?.title ?? "" }
  
  var daysToCrack: String {
    guard let releaseDateObject = game?
            .releaseDate?
            .splitString(separator: "T", index: 0)
            .toDateObject(dateFormat: "yyyy-MM-dd")
    else { return "" }
    
    if releaseDateObject > Date() {
      crackStatus = .unreleased
      let days = releaseDateObject.getDayDifference()
      
      return "\(crackStatus.rawValue)\(days)"
    } else {
      if game?.crackDate != nil {
        crackStatus = .cracked
        
        guard let crackDate = game?
                .crackDate?
                .splitString(separator: "T", index: 0)
                .toDateObject(dateFormat: "yyyy-MM-dd")
        else { return "" }
        
        let days = releaseDateObject.getDayDifference(toDate: crackDate)
        let formatDays = days.contains("-") ? days : "+\(days)"
        
        return "\(crackStatus.rawValue)\(formatDays)"
      } else {
        crackStatus = .uncracked
        let days = releaseDateObject.getDayDifference()
        
        return "\(crackStatus.rawValue)\(days)"
      }
    }
  }
  
  var statusImage: UIImage {
    switch crackStatus {
    case .cracked:
      return R.image.icCracked() ?? UIImage()
    case .uncracked:
      return R.image.icUncracked() ?? UIImage()
    case .unreleased:
      return R.image.icUnreleased() ?? UIImage()
    }
  }
  
  var statusColor: UIColor {
    switch crackStatus {
    case .cracked:
      return R.color.cracked() ?? UIColor()
    case .uncracked:
      return R.color.uncracked() ?? UIColor()
    case .unreleased:
      return R.color.unreleased() ?? UIColor()
    }
  }
  
  init(game: Game) {
    self.game = game
  }
}
