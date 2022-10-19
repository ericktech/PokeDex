//
//  PokemonCollectionViewCell.swift
//  PokeDex
//
//  Created by Erick Leal on 15/10/22.
//

import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblNumber: UILabel!
    static let identifier = "PokemonCollectionViewCell"
    static let nib = "PokemonCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func config(pokemon: PokemonDetailModel?){
        guard let safePokemon = pokemon else {return}
        guard let safePokTypes = safePokemon.types else {return}
        configureCell(safePokemon: safePokemon)
        configureBackGrodunColorCell(pokeType: safePokTypes)
    }
    
    func configureBackGrodunColorCell(pokeType: [Types]){
        if let itemType = pokeType.first(where: {$0.slot == 1}){
            contentView.backgroundColor = PokemonTypesColors(rawValue: itemType.type?.name ?? "unkwnow")?.getBackGroundColor()
        }
    }
    
    func configureCell(safePokemon :PokemonDetailModel){
        
        if let safeId = safePokemon.id{
            self.lblNumber.text = "#\(safeId)"
        }
        
        self.lblName.text = safePokemon.name
        imgView.loadFrom(URLAddress: safePokemon.sprites?.frontDefault)
        contentView.layer.cornerRadius = 10.0;
        imgView.contentMode = .scaleAspectFill
    }
    
    
}


