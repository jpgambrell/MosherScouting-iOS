//
//  RosterTableViewController.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/20/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import UIKit

class RosterTableViewController: UITableViewController {
    let searchController = UISearchController(searchResultsController: nil)
    var filteredItems = [PlayerModel]()
    var filterActive: Bool = false
    var items: [PlayerModel] =  {
        return PlayerManager().loadPlayerDataFromPlist()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    func setupSearchBar() {
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
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterActive && filteredItems.count > 0 {
            return filteredItems.count
        }
        else {
            return items.count
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? RosterTableViewCell {
           
            cell.detailView?.isHidden = !(cell.detailView?.isHidden)!
            
            if !(cell.detailView?.isHidden)! {
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
           // tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RosterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath) as! RosterTableViewCell
       
        
        let viewItems = (filterActive && filteredItems.count > 0) ? filteredItems : self.items
        cell.populateCell(player: viewItems[indexPath.row])
        return cell
    }
    
    
}
extension RosterTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    //MARK: Search Bar
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        print("searchString: \(searchString)")
        if !(searchString == "") {
            filteredItems = items.filter({ (item) -> Bool in
                let name = item.name
                return name.lowercased().range(of:searchString.lowercased()) != nil ? true : false
            })
            self.tableView.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        filterActive = false
        self.filteredItems = [];
        self.dismiss(animated: true, completion: nil)
        self.tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        filterActive = true
        self.tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !filterActive {
            filterActive = true
            self.tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
}


extension UIView {
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

