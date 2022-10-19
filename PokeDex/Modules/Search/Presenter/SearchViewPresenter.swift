//
//  SearchViewPresenter.swift
//  PokeDex
//
//  Created by Erick Leal on 19/10/22.
//

import Foundation
class SearchViewPresenter {
    private let pokemonBaseService : PokemonBaseService
    weak private var searchViewDelegate : SearchViewDelegate?
    
    init(pokemonBaseService: PokemonBaseService){
        self.pokemonBaseService = pokemonBaseService
    }
    
    func setViewDelegate(delegate: SearchViewDelegate){
        self.searchViewDelegate = delegate
    }
    
    func getPokemonSearch(textToSearch : String){
        self.pokemonBaseService.getPokemonBySearch(textToSearch: textToSearch) { response in
            self.searchViewDelegate?.getPokemon(pokemonList: response)
        } onFail: { error in
            self.pokemonBaseService.getPokemonByType(typeToSerach: textToSearch){response in
                self.searchViewDelegate?.getPokemon(pokemonList: response)
            } onFail: { error in
                print(error)
            }
        }
        
    }
    
}
