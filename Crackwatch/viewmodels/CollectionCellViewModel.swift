//
//  CollectionCellViewModel.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/13/20.
//

import Alamofire
import Foundation

protocol CollectionCellViewModelStrategy {
  
  var count: Int { get }
  
  func getLatestCrackedGames(completion: @escaping (Bool) -> Void)
  func expandedCellViewModel(forIndexPath indexPath: IndexPath) -> GameCellViewModelStrategy
}

class CollectionCellViewModel: CollectionCellViewModelStrategy {
  
  var games: [Game] = []
  
  var count: Int { return games.count }
  
  func getLatestCrackedGames(completion: @escaping (Bool) -> Void) {
    let url = "https://api.crackwatch.com/api/games?page=0&sort_by=crack_date&is_cracked=true"
    
    AF.request(url, method: .get).responseDecodable(of: [Game].self) { response in
      switch response.result {
      
      case .success(let games):
        self.games.append(contentsOf: games)
        completion(true)
        
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
  
  func expandedCellViewModel(forIndexPath indexPath: IndexPath) -> GameCellViewModelStrategy {
    return GameCellViewModel(game: games[indexPath.row])
  }
}
