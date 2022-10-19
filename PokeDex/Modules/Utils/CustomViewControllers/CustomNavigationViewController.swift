//
//  CustomNavigationViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 18/10/22.
//

import UIKit

class CustomNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultNavigationBar()
        
    }
    func setDefaultNavigationBar(){
        self.navigationBar.prefersLargeTitles = true
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .red
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
    
}
