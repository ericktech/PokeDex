//
//  PokemonBaseService.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import Foundation
import Alamofire
class PokemonBaseService {
    var urlSession : URLSession
    private let apiBaseURL = "https://pokeapi.co/api/v2/pokemon/"
    init(){
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
    }
    func getList(completion : @escaping(_ response : PokemonBaseModel) -> Void, onFail: @escaping(_ error: PokemonBaseApiError) -> Void){
        guard let safeUrl = URL(string: apiBaseURL) else {return}
        let urlRequest = URLRequest(url: safeUrl)
        urlSession.dataTask(with: urlRequest){data, response, error in
            let jsonDecoder = JSONDecoder()
            
            let response = try? jsonDecoder.decode(PokemonBaseModel.self, from: data ?? Data())
            guard let safeResponse = response else {return onFail(.noData)}
            
            
            completion(safeResponse)
        }.resume()
    }
    
    
    func getPokemons(url:String, onSucces: @escaping(PokemonDetailModel) -> Void, onFail :@escaping(_ error: PokemonBaseApiError) -> Void){
        
        guard let safeUrl = URL(string: url) else {return}
        let urlRequest = URLRequest(url: safeUrl)
        
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
                                print(error)
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
