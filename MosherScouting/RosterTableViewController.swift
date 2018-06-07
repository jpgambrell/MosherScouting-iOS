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
        definesPresentationContext = true
        setupSearchBar()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    func setupSearchBar() {
        searchController.searchBar.backgroundColor = UIColor().hexStringToUIColor(hex:"#163252")
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by player name, number, or position"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        navigationItem.titleView = self.searchController.searchBar
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
               // tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            }
            tableView.beginUpdates()
            tableView.endUpdates()
           // tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> RosterTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RosterCell", for: indexPath) as! RosterTableViewCell
         cell.tableVC = self
         cell.detailView.isHidden = true
        let viewItems = (filterActive && filteredItems.count > 0) ? filteredItems : self.items
        cell.populateCell(player: viewItems[indexPath.row])
        return cell
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//         let vc = segue.destination as! FullViewController
//        let currentPlayer = sender as! PlayerModel
//         vc.player = currentPlayer
//    }
    
}
extension RosterTableViewController: UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    //MARK: Search Bar
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text ?? ""
        print("searchString: \(searchString)")
        if !(searchString == "") {
            filteredItems = items.filter({ (item) -> Bool in
                let name = item.searchHash
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
    
    func makeCircular() {
        self.layer.cornerRadius = min(self.frame.size.height, self.frame.size.width) / 2.0
        self.clipsToBounds = true
    }
}

extension UIColor {
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}


