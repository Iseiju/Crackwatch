//
//  Date.swift
//  Crackwatch
//
//  Created by Kenneth James Uy on 11/25/20.
//

import Foundation

protocol DateProtocol {
  
  func getDayDifference(toDate: Date) -> String
}

extension Date: DateProtocol {

  func getDayDifference(toDate: Date = Date()) -> String {
    let days = Calendar
      .autoupdatingCurrent
      .dateComponents([.day],
                      from: self,
                      to: toDate)
      .day
    
    return String(days ?? 0)
  }
}
