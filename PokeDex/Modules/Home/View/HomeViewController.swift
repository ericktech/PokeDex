//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import UIKit

protocol HomeViewDelegate : NSObjectProtocol{
    func getPokemonList(pokemonList: [PokemonDetailModel])
}

class HomeViewController: UIViewController, HomeViewDelegate {
    
    @IBOutlet weak var cvLayout: UICollectionViewFlowLayout!
    private var pokemonList = [PokemonDetailModel]()
    private let presenter = HomewViewPresenter(pokemonBaseService: PokemonBaseService())
    
    @IBOutlet weak var collectionView: UICollectionView!
    private let spacing : CGFloat =  30
    private let numberOfItemInARow : CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 4 :2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PokeDex"
        self.presenter.setViewDelegate(delegate: self)
        
        config()
    }
    
    func config(){
        collectionView.register(UINib(nibName: PokemonCollectionViewCell.nib, bundle: nil), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.dataSource =  self
        collectionView.delegate = self
        presenter.getPokemonBaseList()
        collectionView.setCollectionViewLayout(createFlowLayout(), animated: true)
        collectionView.backgroundColor = .black
        
    }
    
    
    func getPokemonList(pokemonList: [PokemonDetailModel]) {
        self.pokemonList = pokemonList
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension HomeViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let safeCount = pokemonList.count
        return safeCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PokemonCollectionViewCell.identifier, for: indexPath) as! PokemonCollectionViewCell
        let safeData = pokemonList[indexPath.row]
        cell.config(name: safeData.name , urlImg: safeData.sprites?.frontDefault, number: safeData.id?.description)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let totalSpacing : CGFloat = spacing * (numberOfItemInARow + 1)
        let itemWidth : CGFloat = (collectionView.bounds.width - totalSpacing) / numberOfItemInARow
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func createFlowLayout() -> UICollectionViewFlowLayout{
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        layout.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
        return layout
        
    }
}

