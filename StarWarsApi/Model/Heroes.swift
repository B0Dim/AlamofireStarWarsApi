//
//  Herous.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import Foundation

enum Link: String {
    case heroes = "https://www.swapi.tech/api/people"
}

enum ImageHeroes: String {
    case luke = "https://static.tvtropes.org/pmwiki/pub/images/luke_the_hero_small.png"
    case c3po = "https://media.istockphoto.com/photos/-picture-id477975108?k=20&m=477975108&s=170667a&w=0&h=jbRct72usQSKuJ3uoxcw4CRpjYkpdRquIim4P_nw45c="
    case r2d2 = "https://upload.wikimedia.org/wikipedia/ru/3/39/R2-D2_Droid.png"
    case dart = "https://s7.orientaltrading.com/is/image/OrientalTrading/VIEWER_ZOOM/darth-vader-cardboard-stand-up~13577316"
    case leia = "https://static.tvtropes.org/pmwiki/pub/images/leia_41.jpg"
    case owen = "https://static.wikia.nocookie.net/starwars/images/e/eb/OwenCardTrader.png/revision/latest?cb=20171108050140"
    case beru = "https://static.wikia.nocookie.net/starwars/images/c/cc/BeruCardTrader.png/revision/latest?cb=20170713063118"
    case r5d4 = "https://static.wikia.nocookie.net/starwars/images/c/cb/R5-D4_Sideshow.png/revision/latest?cb=20160809033145"
    case biggs = "https://static.wikia.nocookie.net/rustarwars/images/2/20/Biggs.jpg/revision/latest?cb=20120903152541"
    case obiwan = "https://idsb.tmgrup.com.tr/ly/uploads/images/2021/11/14/thumbs/800x531/159258.jpg"
}

struct HeroesResult: Decodable {
    let total_pages: Int?
    let next: String?
    let results: [Heroes]
    
    static func getHeroes(from value: Any) -> [Heroes] {
        guard let data = value as? [String: Any] else { return  [] }
        guard let results = data["results"] as? Array<Any> else { return [] }
        return results.compactMap { Heroes(dataHeroes: $0 as? [String : Any] ?? [:]) }
    }
}

struct Heroes: Decodable {
    let name: String?
    let url: String?
        
    init(dataHeroes: [String: Any]) {
        name = dataHeroes["name"] as? String
        url = dataHeroes["url"] as? String
    }
}

struct HeroResult: Decodable {
    let result: heroProperties
    let description: String?
    
    static func getHeroProperties(from value: Any) -> [String: Any] {
        guard let data = value as? [String: Any] else { return [:] }
        guard let result = data["result"] as? [String: Any] else { return [:] }
        return result
    }
}

struct heroProperties: Decodable {
    let properties: Hero
    
    static func getHero(from value: Any) -> Hero? {
        guard let data = value as? [String: Any] else { return nil }
        guard let properties = data["properties"] as? [String: Any] else { return nil }
        return Hero(dataHero: properties)
    }
}

struct Hero: Decodable {
    let height: String?
    let mass: String?
    let hair_color: String?
    let skin_color: String?
    let eye_color: String?
    let birth_year: String?
    let gender: String?
    let name: String?
    
    init(dataHero: [String: Any]) {
        height = dataHero["height"] as? String
        mass = dataHero["mass"] as? String
        hair_color = dataHero["hair_color"] as? String
        skin_color = dataHero["skin_color"] as? String
        eye_color = dataHero["eye_color"] as? String
        birth_year = dataHero["birth_year"] as? String
        gender = dataHero["gender"] as? String
        name = dataHero["name"] as? String
    }
    
    var description: String {
        """
        Name: \(name ?? "")
        Height: \(height ?? "")
        Mass: \(mass ?? "")
        Hair color: \(hair_color ?? "")
        Skin color: \(skin_color ?? "")
        Eye color: \(eye_color ?? "")
        Birth year: \(birth_year ?? "")
        Gender: \(gender ?? "")
        """
    }
}
