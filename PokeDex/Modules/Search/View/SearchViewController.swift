//
//  SearchViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 19/10/22.
//

import UIKit
protocol SearchViewDelegate : NSObjectProtocol{
    func getPokemon(pokemonList: [PokemonDetailModel])
}
class SearchViewController: CustomViewController, SearchViewDelegate {

    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var pokemonList = [PokemonDetailModel]()
    
    private let presenter = SearchViewPresenter(pokemonBaseService: PokemonBaseService())
    public var textToSearch : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.setViewDelegate(delegate: self)
        config()
    }
    func config(){
        collectionView.register(UINib(nibName: PokemonCollectionViewCell.nib, bundle: nil), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.dataSource =  self
        collectionView.delegate = self
        presenter.getPokemonSearch(textToSearch: textToSearch)
        collectionView.setCollectionViewLayout(createFlowLayout(), animated: true)
        collectionView.backgroundColor = .black
        
    }
    static func getViewController(textToSearch: String) -> SearchViewController{
        let storyBoard = UIStoryboard(name: "SearchStoryboard", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController else {
            return SearchViewController()
        }
        controller.textToSearch = textToSearch
        return controller
    }
    
    func getPokemon(pokemonList: [PokemonDetailModel]) {
        self.pokemonList = pokemonList
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}
extension SearchViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let safeCount = pokemonList.count
        return safeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        let safeData = pokemonList[indexPath.row]
        cell.config(pokemon: safeData)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing : CGFloat = Constants.share.collectionViewSpacing * (Constants.share.numberOfItemInARow + 1)
        let itemWidth : CGFloat = (collectionView.bounds.width - totalSpacing) / Constants.share.numberOfItemInARow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func createFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = Constants.share.collectionViewSpacing
        layout.minimumInteritemSpacing = Constants.share.collectionViewSpacing
        layout.sectionInset = UIEdgeInsets(top: Constants.share.collectionViewSpacing, left: Constants.share.collectionViewSpacing, bottom: Constants.share.collectionViewSpacing, right: Constants.share.collectionViewSpacing)
        return layout
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController.getViewController(pokemon: pokemonList[indexPath.row])
        self.pushViewController(vc: detailsVC)
        
    }
}
