//
//  HomeViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 14/10/22.
//

import UIKit
import SkeletonView
protocol HomeViewDelegate : NSObjectProtocol{
    func getPokemonList(pokemonList: [PokemonDetailModel])
}

class HomeViewController: CustomViewController, HomeViewDelegate {
    @IBOutlet weak var cvLayout: UICollectionViewFlowLayout!
    private var pokemonList = [PokemonDetailModel]()
    private let presenter = HomewViewPresenter(pokemonBaseService: PokemonBaseService())
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    @IBOutlet weak var skltnView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "PokeDex"
        Skltn()
        self.presenter.setViewDelegate(delegate: self)
        self.enableSerchBar()
        config()
    }
    func Skltn(){
        skltnView.showGradientSkeleton(delay: 0.5)
    }
    func config(){
        collectionView.register(UINib(nibName: PokemonCollectionViewCell.nib, bundle: nil), forCellWithReuseIdentifier: PokemonCollectionViewCell.identifier)
        collectionView.dataSource =  self
        collectionView.delegate = self
        presenter.getPokemonBaseList()
        collectionView.setCollectionViewLayout(createFlowLayout(), animated: true)
        collectionView.backgroundColor = .black
        
    }
    
    func hideSktln(){
        collectionView.isHidden = false
        skltnView.hideSkeleton()
        skltnView.isHidden = true
    }
    func getPokemonList(pokemonList: [PokemonDetailModel]) {
        self.pokemonList = pokemonList
        DispatchQueue.main.async {
            self.hideSktln()
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

