//
//  Herous.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import Foundation

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
        name: \(name ?? "")
        height: \(height ?? "")
        mass: \(mass ?? "")
        hair_color: \(hair_color ?? "")
        skin_color: \(skin_color ?? "")
        eye_color: \(eye_color ?? "")
        birth_year: \(birth_year ?? "")
        gender: \(gender ?? "")
        """
    }
}
