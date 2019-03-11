//
//  ToyTableViewController.swift
//  CoreDataSuperExample
//
//  Created by Kevin Yu on 3/5/19.
//  Copyright © 2019 Kevin Yu. All rights reserved.
//

import UIKit

class ToyTableViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var toys = [Toy]()
    var games = [Game]()
    var service = CoreDataService()
    var filteredToys = [Toy]()
    var filteredGames = [Game]()
    var isSearching = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
   //     filteredToys = toys
    //    filteredGames = games
        tableView.dataSource = self
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell") }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 {
            label.text = "Toys" } else {
            label.text = "Games"
            }
        label.backgroundColor = UIColor.lightGray
        
        return label
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadToys()
        loadGames()
    }
    
    func loadToys() {
        toys = service.loadAllToys()
        tableView.reloadData()
    }
    
    func loadGames() {
        games = service.loadAllGames()
        tableView.reloadData()
    }
    
    @IBAction func searchBarButtonAction(_ sender: UIBarButtonItem) {
        toys = service.findAll("Armando")
        tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "gameDetails" {
            let vc = segue.destination as! GameViewController
            vc.myGame = sender as? Game
            vc.service = service
        } else if segue.identifier == "createGame" {
            let vc = segue.destination as! GameViewController
            vc.service = service
        } else if segue.identifier == "toyDetails" {
            let vc = segue.destination as! ToyViewController
            vc.myToy = sender as? Toy
            vc.service = service
        } else if segue.identifier == "createToy" {
            let vc = segue.destination as! ToyViewController
            vc.service = service
        }
    }
}


extension ToyTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            if section == 0 {
                return filteredToys.count }
            else {
                return filteredGames.count }
        }
        
        if section == 0 {
            return toys.count }
        else {
            return games.count }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                 for: indexPath)
        
        if isSearching {
            if indexPath.section == 0 {
                cell.textLabel?.text = filteredToys[indexPath.row].name
                return cell } else {
                cell.textLabel?.text = filteredGames[indexPath.row].name            }
                }
        else {
        if indexPath.section == 0 {
            cell.textLabel?.text = toys[indexPath.row].name
            return cell } else {
            cell.textLabel?.text = games[indexPath.row].name }
            }
        return cell
    }
    
   func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        var toy = ""
//        var game = ""
        
        if searchBar.text == nil || searchBar.text == "" {
        isSearching = false
        view.endEditing(true)
            tableView.reloadData() } else {
            isSearching = true
  //          toy = toys[IndexPath].name
 //           filteredToys[IndexPath].name = toy.filter({$0 == searchBar.text})
        }
    }
}

extension ToyTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toyDetails",
                          sender: toys[indexPath.row])
        self.performSegue(withIdentifier: "gameDetails",
                          sender: games[indexPath.row])    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if indexPath.section == 0
            {
            service.deleteToy(toys[indexPath.row])
            loadToys()
            } else {
            service.deleteGame(games[indexPath.row])
            loadGames()
                
            }
        }
    }
}
