//
//  HomeViewPresenter.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import Foundation
class HomewViewPresenter {
    private let pokemonBaseService : PokemonBaseService
    weak private var homeViewDelegate : HomeViewDelegate?
    
    init(pokemonBaseService: PokemonBaseService){
        self.pokemonBaseService = pokemonBaseService
    }
    
    func setViewDelegate(delegate: HomeViewDelegate){
        self.homeViewDelegate = delegate
    }
    
    func getPokemonBaseList(){
        self.pokemonBaseService.getPokemonList { response in
            self.homeViewDelegate?.getPokemonList(pokemonList: response)
        } onFail: { error in
            print(error)
        }

    }
}
