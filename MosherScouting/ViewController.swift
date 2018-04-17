//
//  ViewController.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/3/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //ivars
    var filteredItems = [Dictionary<String, String>]()
    var filterActive: Bool = false
    let searchController = UISearchController(searchResultsController: nil)
   // var items = ["Dak", "Ezekiel", "Rod", "Dez", "Jason", "Tyron", "Zack", "Terrance", "Travis", "Randy", "David","Jaylon", "Sean"];
    var items: [Dictionary<String, String>] =  {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "players", withExtension: "plist")!)
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [Dictionary<String, String>]
    }()
    
    @IBOutlet weak var collectionView: UICollectionView!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Search by player name, number, or position"
        self.searchController.searchBar.sizeToFit()
        
        self.searchController.searchBar.becomeFirstResponder()
        self.navigationItem.titleView = self.searchController.searchBar
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource {
    //MARK: UICollectionViewData Source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if filterActive && filteredItems.count > 0 {
            return filteredItems.count
        }
        else {
            return items.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let viewItems = (filterActive && filteredItems.count > 0) ? filteredItems : self.items
        let player = viewItems[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! PlayerCollectionViewCell
        cell.name.text = player["name"]
        return cell
    }
}

extension ViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    //MARK: Search Bar
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        print("searchString: \(searchString)")
        if !(searchString == "") {
            filteredItems = items.filter({ (item) -> Bool in
                let name = item["name"] ?? ""
                return name.lowercased().range(of:searchString.lowercased()) != nil ? true : false
            })
            self.collectionView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterActive = false
        self.filteredItems = [];
        self.dismiss(animated: true, completion: nil)
         self.collectionView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterActive = true
        self.collectionView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !filterActive {
            filterActive = true
            self.collectionView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
}


