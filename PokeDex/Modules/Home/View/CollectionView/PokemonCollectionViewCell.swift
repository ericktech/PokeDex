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
    
    static let identifier = "PokemonCollectionViewCell"
    static let nib = "PokemonCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func config(name:String?, urlImg: String?){
        if let safename = name {
            self.lblName.text = safename
        }
        imgView.loadFrom(URLAddress: urlImg)
    }
    
}
