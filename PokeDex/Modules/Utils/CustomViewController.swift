//
//  CustomViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 18/10/22.
//

import UIKit

class CustomViewController: UIViewController, UISearchBarDelegate {
    
    
    let searchBarController = UISearchController()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func enableSerchBar(){
        searchBarController.searchBar.delegate = self
        navigationItem.searchController = searchBarController

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let textToSearch = searchBarController.searchBar.text else{return}
        let cv = SearchViewController.getViewController(textToSearch: textToSearch)
        pushViewController(vc: cv)

    }
    
    
    func setDefaultNavigationBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .red
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    func setNavBarBackGroundColor(color : UIColor){
        self.navigationController?.navigationBar.prefersLargeTitles = false
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        appearance.backgroundColor = color
        self.navigationController?.navigationBar.standardAppearance = appearance
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        self.navigationController?.navigationBar.tintColor = .black
        
    }
    
    func setTitle(title:String){
        self.title = title
        
    }
    
    func pushViewController(vc:UIViewController){
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getPokemonTypColor(itemType: Types) -> UIColor{
        if let safeColor = PokemonTypesColors(rawValue: itemType.type?.name ?? "unkwnow")?.getBackGroundColor() {
            return safeColor
        }
        return .normal()
    }
}
