//
//  HerousViewController.swift
//  StarWarsApi
//
//  Created by  BoDim on 24.01.2022.
//

import UIKit

class HeroesViewController: UITableViewController {

    var heroes: [Heroes] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sendRequest()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        heroes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        var content = cell.defaultContentConfiguration()
        content.text = heroes[indexPath.row].name ?? ""
        cell.contentConfiguration = content
        
        return cell
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let AboutVC = segue.destination as? AboutViewController else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        AboutVC.url = heroes[indexPath.row].url
    }
    

}

//MARK: Private methods
extension HeroesViewController {
    
    private func sendRequest() {
        
        NetworkManager.shared.fetchDataHeroes { heroes in
            DispatchQueue.main.async {
                self.heroes = heroes
                self.tableView.reloadData()
            }
        }
    }
}
