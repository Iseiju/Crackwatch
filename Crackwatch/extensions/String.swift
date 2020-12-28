//
//  String.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/25/20.
//

import Foundation

protocol StringProtocol {
  
  func toDateObject(dateFormat: String) -> Date
}

extension String: StringProtocol {
  
  func toDateObject(dateFormat: String) -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = .autoupdatingCurrent
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter.date(from: self) ?? Date()
  }
  
  func splitString(separator: Character, index: Int) -> String {
    return self.split(separator: separator)[index].trimmingCharacters(in: .whitespacesAndNewlines)
  }
}
