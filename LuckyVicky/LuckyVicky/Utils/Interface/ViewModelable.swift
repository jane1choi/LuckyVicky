//
//  ViewModelable.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/7/24.
//

import SwiftUI
import Combine

protocol ViewModelable: ObservableObject {
  associatedtype Action
  associatedtype State
  
  var state: State { get }
  
  func action(_ action: Action)
}
