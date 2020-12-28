//
//  GameListViewModel.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/13/20.
//

import Alamofire
import Foundation

protocol GameListViewModelStrategy {
  
  var count: Int { get }
  var collectionCellViewModel: CollectionCellViewModel { get }
  
  func getGames(completion: @escaping (Bool) -> Void)
  func cellViewModels(forIndexPath indexPath: IndexPath) -> GameCellViewModelStrategy
}

class GameListViewModel: GameListViewModelStrategy {
  
  var games: [Game] = []
  
  var pageCount = 0
  var count: Int { return games.count }
  
  lazy var collectionCellViewModel = CollectionCellViewModel()
  
  func getGames(completion: @escaping (Bool) -> Void) {
    let url = "https://api.crackwatch.com/api/games?page=\(pageCount)"
    
    AF.request(url, method: .get).responseDecodable(of: [Game].self) { response in
      switch response.result {
      
      case .success(let games):
        self.games.append(contentsOf: games)
        self.pageCount += 1
        completion(true)
        
      case .failure(let error):
        print(error.localizedDescription)
        completion(false)
      }
    }
  }
  
  func cellViewModels(forIndexPath indexPath: IndexPath) -> GameCellViewModelStrategy {
    return GameCellViewModel(game: games[indexPath.row])
  }
}
