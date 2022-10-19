//
//  EnumTypeColor.swift
//  PokeDex
//
//  Created by Erick Leal on 17/10/22.
//

import Foundation
import UIKit

enum PokemonTypesColors : String{
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case ice
    case dragon
    case dark
    case psychic
    case fairy
    case unknown
    case shadow
    
    
    func getBackGroundColor() -> UIColor{
        switch self {
        case .normal:
            return .normal()
        case .fighting:
            return .figthing()
        case .poison : return .poison()
        case .ground : return .ground()
        case .rock : return .rock()
        case .bug : return . bug()
        case .ghost : return .ghost()
        case .fire : return .fire()
        case .water : return .water()
        case .grass : return .grass()
        case .electric : return .electric()
        case .ice : return .ice()
        case .dragon : return .dragon()
        case .psychic : return .psychic()
        case .fairy : return .fairy()
        default:
            return .normal()
        }
    }
    
}

enum PokemonStatName : String{
    case hp
    case attack
    case defense
    case specialattack
    case specialdefense
    case speed

    
    func getShortName() -> String{
        switch self {
        case .hp :
            return "HP"
        case .attack : return "ATK"
        case .defense : return "DEF"
        case .specialattack : return "SATK"
        case .specialdefense : return "SDEF"
        case .speed : return "SPD"
        }
    }
    
}
