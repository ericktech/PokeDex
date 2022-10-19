//
//  Constans.swift
//  PokeDex
//
//  Created by Erick Leal on 19/10/22.
//

import Foundation
import UIKit
class Constants{
    static let share : Constants = Constants()
    let collectionViewSpacing : CGFloat =  10
    let numberOfItemInARow : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 :2
    let piBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    let apiByType = "https://pokeapi.co/api/v2/type/"
}
