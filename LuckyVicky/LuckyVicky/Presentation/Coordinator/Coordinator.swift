//
//  Coordinator.swift
//  LuckyVicky
//
//  Created by EUNJU on 8/28/24.
//

import SwiftUI

protocol Coordinator {
    func push(_ scene: AppScene)
    func pop()
    func popToRoot()
    func present(sheet: AppScene)
    func dismissSheet()
}
