//
//  AboutViewController.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var imageHero: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var aboutDetailLabel: UILabel!
    
    var url: String!
    private var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        aboutDetailLabel.isHidden = true
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        sendRequest()
    }
    
    private func fetchImage() {
        let url = getImageUrlHero(hero?.name ?? "")
        NetworkManager.shared.fetchImage(from: url) { result in
            switch result {
            case .success(let data):
                self.imageHero.image = UIImage(data: data)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func sendRequest() {
        NetworkManager.shared.fetchDataWithAlamofire(url) { result in
            switch result {
            case .success(let hero):
                let properties = HeroResult.getHeroProperties(from: hero)
                let heroProperties = heroProperties.getHero(from: properties)
                guard let hero = heroProperties else { return }
                self.hero = hero
                self.setAboutData()
                self.fetchImage()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setAboutData() {
        aboutDetailLabel.text = hero?.description
        aboutDetailLabel.isHidden.toggle()
    }

    private func getImageUrlHero(_ name: String) -> String {
        switch name {
        case "Luke Skywalker":
            return ImageHeroes.luke.rawValue
        case "R2-D2":
            return ImageHeroes.r2d2.rawValue
        case "Darth Vader":
            return ImageHeroes.dart.rawValue
        case "Leia Organa":
            return ImageHeroes.leia.rawValue
        case "Owen Lars":
            return ImageHeroes.owen.rawValue
        case "Beru Whitesun lars":
            return ImageHeroes.beru.rawValue
        case "R5-D4":
            return ImageHeroes.r5d4.rawValue
        case "Biggs Darklighter":
            return ImageHeroes.biggs.rawValue
        case "Obi-Wan Kenobi":
            return ImageHeroes.obiwan.rawValue
        default:
            return ImageHeroes.c3po.rawValue
        }
    }
}
