//
//  Extension.swift
//  PokeDex
//
//  Created by Erick Leal on 15/10/22.
//

import Foundation
import UIKit
extension UIImageView {
    func loadFrom(URLAddress: String?) {
        guard let safeUrl = URLAddress else {return}
        guard let url = URL(string: safeUrl) else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let loadedImage = UIImage(data: imageData) {
                    self?.image = loadedImage
                }
            }
        }
    }
}
