//
//  PokemonBaseService.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import Foundation
import Alamofire
class PokemonBaseService {
    private let apiBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    private let apiByType = "https://pokeapi.co/api/v2/type/"
    
    
    func getPokemonBySearch(textToSearch:String, onSucces: @escaping([PokemonDetailModel]) -> Void, onFail :@escaping(_ error: PokemonBaseApiError) -> Void){
        let url = apiBaseURL + textToSearch.lowercased()
        AF.request(url, method: .get,parameters: nil,encoding: URLEncoding(destination: .queryString),headers: nil).responseData{ response in
            if(response.response?.statusCode == 200){
                do{
                    if let data = response.data{
                        let responseModel = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
                        var pokemonList = [PokemonDetailModel]()
                        pokemonList.append(responseModel)
                        onSucces(pokemonList)
                    }
                }catch{
                    onFail(.noData)
                }
            }else{onFail(.noData)}
        }
    }
    
    
    
    
    func getPokemons(url:String, onSucces: @escaping(PokemonDetailModel) -> Void, onFail :@escaping(_ error: PokemonBaseApiError) -> Void){
        
        guard let safeUrl = URL(string: url) else {return}
        
        AF.request(safeUrl, method: .get, parameters: nil,encoding: URLEncoding(destination: .queryString), headers: nil).responseData { response in
            if(response.response?.statusCode == 200){
                do{
                    if let data = response.data{
                        let responseModel = try JSONDecoder().decode(PokemonDetailModel.self, from: data)
                        onSucces(responseModel)
                    }
                }catch let error as NSError{
                    print(String(describing: error))
                    onFail(.canNotProcessData)}
            }else{onFail(.noData)}
        }
    }
    
    func getPokemonByType(typeToSerach:String,completion : @escaping(_ response: [PokemonDetailModel]) -> Void, onFail :@escaping(_ error: PokemonBaseApiError) -> Void){
        let url = apiByType + typeToSerach.lowercased()
        AF.request(url, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: nil).responseData{response in
            if(response.response?.statusCode == 200){
                do{
                    if let data = response.data{
                        let responseModel = try JSONDecoder().decode(PokemonByTypeModel.self, from: data)
                        var pokemonList = [PokemonDetailModel]()
                        let myGroup = DispatchGroup()
                        responseModel.pokemon?.forEach{item in
                            myGroup.enter()
                            guard let safeUrl = item.pokemon?.url else {return}
                            self.getPokemons(url: safeUrl, onSucces: {response in
                                pokemonList.append(response)
                                myGroup.leave()
                                
                            }, onFail: {error in
                                myGroup.leave()
                            })
                            
                            myGroup.notify(queue: .main) {
                                completion(pokemonList)
                            }
                        }
                    }else{
                        onFail(.noData)
                    }
                }catch {
                    onFail(.noData)
                }
            }
        }
    }
    
    func getPokemonList(completion : @escaping(_ response: [PokemonDetailModel]) -> Void, onFail :@escaping(_ error: PokemonBaseApiError) -> Void){
        
        AF.request(apiBaseURL, method: .get, parameters: nil, encoding: URLEncoding(destination: .queryString), headers: nil).responseData{response in
            if(response.response?.statusCode == 200){
                do{
                    if let data = response.data{
                        let responseModel = try JSONDecoder().decode(PokemonBaseModel.self, from: data)
                        var pokemonList = [PokemonDetailModel]()
                        let myGroup = DispatchGroup()
                        
                        responseModel.results?.forEach{item in
                            myGroup.enter()
                            guard let safeUrl = item.url else {return}
                            self.getPokemons(url: safeUrl, onSucces: {response in
                                pokemonList.append(response)
                                myGroup.leave()
                                
                            }, onFail: {error in
                                myGroup.leave()
                            })
                        }
                        myGroup.notify(queue: .main) {
                            completion(pokemonList)
                        }
                    }else{
                        onFail(.noData)
                    }
                }catch {
                    onFail(.noData)
                }
            }
        }
        
    }
    
    
}
