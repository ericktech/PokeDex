//
//  PokemonBaseModel.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//
import Foundation

class PokemonByTypeModel: Codable {
    var pokemon: [PokemonElement]?

    init(pokemon: [PokemonElement]?) {
        self.pokemon = pokemon
    }
}

// MARK: - PokemonElement
class PokemonElement: Codable {
    var pokemon: ResultPokemonBaseModel?
    var slot: Int?

    init(pokemon: ResultPokemonBaseModel?, slot: Int?) {
        self.pokemon = pokemon
        self.slot = slot
    }
}

class PokemonBaseModel: Codable {
    var count: Int?
    var next: String?
    var previous: String?
    var results: [ResultPokemonBaseModel]?
    
    init(count: Int?, next: String?, previous: String?, results: [ResultPokemonBaseModel]?) {
        self.count = count
        self.next = next
        self.previous = previous
        self.results = results
    }
    init(){}
}

// MARK: - Result
class ResultPokemonBaseModel: Codable {
    let name: String?
    let url: String?
    init(name: String?, url: String?) {
        self.name = name
        self.url = url
    }
}

enum PokemonBaseApiError:Error{
    case noData
    case canNotProcessData
}
