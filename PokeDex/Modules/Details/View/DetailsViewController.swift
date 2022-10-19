//
//  DetailsViewController.swift
//  PokeDex
//
//  Created by Erick Leal on 17/10/22.
//

import UIKit
import FSPagerView

class DetailsViewController: CustomViewController {
    public var pokemon = PokemonDetailModel()
    
    var pagerView = FSPagerView()
    var pagercontrol : FSPageControl!
    
    @IBOutlet weak var stastStkView: UIStackView!
    @IBOutlet weak var ribbonStckView: UIStackView!
    @IBOutlet weak var viewMain: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        initializeStkView()
        initalizeStastStkView()
        initViewPager()

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.setDefaultNavigationBar()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configView()
    }
    
    func initViewPager(){
        let pagerViewHeigth = CGFloat(200)
        pagerView = FSPagerView(frame: CGRect(x: 0, y: 15, width: UIScreen.main.bounds.width, height: pagerViewHeigth))
        pagerView.dataSource = self
        pagerView.delegate = self
        pagerView.itemSize = CGSize(width: UIScreen.main.bounds.width, height: viewMain.frame.height - 30 )
        pagerView.automaticSlidingInterval = CGFloat(2)
        pagerView.interitemSpacing = CGFloat(40)
        pagerView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        self.viewMain.addSubview(pagerView)
    }
    
    func initalizeStastStkView(){
        pokemon.stats?.forEach({item in
            let label = UILabel()
            guard let safeName = item.stat?.name else {return}
            label.text = PokemonStatName(rawValue: safeName.replacingOccurrences(of: "-", with: ""))?.getShortName()
            label.textColor = .black
            let progresView = UIProgressView()
            progresView.transform = progresView.transform.scaledBy(x: 1, y: 5)
            guard let safeBaseStat = item.baseStat else {return}
            progresView.setProgress(Float(Double(safeBaseStat) / 270), animated: true)
            progresView.progressTintColor = .red
            let statLabel = UILabel()
            statLabel.text = "\(safeBaseStat.description)/270"
            statLabel.textColor = .black
            
            let verticakStck = UIStackView(arrangedSubviews: [label,progresView,statLabel])
            verticakStck.alignment = .center
            verticakStck.distribution = .fill
            verticakStck.axis = .horizontal
            verticakStck.spacing = 25
            verticakStck.translatesAutoresizingMaskIntoConstraints = false
            stastStkView.addArrangedSubview(verticakStck)
            
        })
    }
    
    func initializeStkView(){
        ribbonStckView.spacing = 15
        pokemon.types?.forEach({item in
            let label = UILabel()
            label.text = item.type?.name
            label.backgroundColor = self.getPokemonTypColor(itemType: item)
            label.layer.cornerRadius = 15
            label.layer.masksToBounds = true
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
            label.addGestureRecognizer(tap)
            ribbonStckView.addArrangedSubview(label)
        })
    }
    @objc
    func tapFunction(sender:UITapGestureRecognizer) {
        let label = sender.view as? UILabel
        if let safeText = label?.text {
            let cv = SearchViewController.getViewController(textToSearch: safeText)
            pushViewController(vc: cv)
        }
    }
    func configView(){
        if let itemType = pokemon.types?.first(where: {$0.slot == 1}){
            let safeColor = self.getPokemonTypColor(itemType: itemType)
            self.setNavBarBackGroundColor(color: safeColor)
            self.viewMain.backgroundColor = safeColor
            
        }
        self.setTitle(title: pokemon.name ?? "")
        viewMain.roundCorners([.bottomLeft,.bottomRight], radius: 20)
    }
    
    
    static func getViewController(pokemon : PokemonDetailModel) -> DetailsViewController{
        let storyBoard = UIStoryboard(name: "DetailsStoryBoard", bundle: nil)
        guard let controller = storyBoard.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return DetailsViewController()
        }
        controller.pokemon = pokemon
        return controller
    }
    
}

extension DetailsViewController : FSPagerViewDelegate, FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 2
        
    }
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.backgroundColor = .none
        var url = ""
        if (index == 1){
            if let safeurl = pokemon.sprites?.frontDefault {url = safeurl}
        }else{
            if let safeurl = pokemon.sprites?.frontShiny{ url = safeurl}
        }
        
        cell.imageView?.loadFrom(URLAddress: url)
        cell.imageView?.contentMode = .scaleAspectFit
        cell.imageView?.layer.shadowColor = .none
        return cell
    }
}
