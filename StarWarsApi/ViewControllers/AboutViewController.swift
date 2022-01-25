//
//  AboutViewController.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var aboutDetailLabel: UILabel!
    
    var url: String!
    var hero: Hero?
    
    override func viewDidLoad() {
        super.viewDidLoad()

       sendRequest()
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
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setAboutData() {
        aboutDetailLabel.text = hero?.description
    }

}
