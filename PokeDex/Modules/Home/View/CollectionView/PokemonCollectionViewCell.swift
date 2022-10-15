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
    
    public func config(name:String?, urlImg: String?, number: String?){
        configureCell()
        if let safename = name {
            self.lblName.text = safename
        }
        if let safeNumber = number {
            self.lblNumber.text = "#\(safeNumber)"
        }
        imgView.loadFrom(URLAddress: urlImg)
    }
    
    func configureCell(){
        contentView.layer.cornerRadius = 10.0;
        contentView.backgroundColor = .systemTeal
        imgView.contentMode = .scaleAspectFill
    }
    
}
