//
//  RosterTableViewController.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/20/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import UIKit
import SafariServices

class RosterTableViewController: UITableViewController, SFSafariViewControllerDelegate {
    let searchController = UISearchController(searchResultsController: nil)
    let playerManager = PlayerManager()
    
    var filteredItems = [PlayerModel]()
    var filterActive: Bool = false
    var items: [PlayerModel] = []
   
    @IBOutlet weak var unlockButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        setupUI()
        setupSearchBar()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 140
        
    }
    
    func setupUI() {
        
        items = playerManager.loadPlayerDataFromPlist()

        if playerManager.isVerified() {
             self.navigationItem.rightBarButtonItem = nil
        } else {
              showCodeAlert()
        }
    }
    
    func setupSearchBar() {
        searchController.searchBar.backgroundColor = UIColor().hexStringToUIColor(hex:"#163252")
        searchController.delegate = self
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.dimsBackgroundDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Name, Number, or Position"
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.becomeFirstResponder()
        navigationItem.titleView = self.searchController.searchBar
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    @IBAction func infoButtonClick(_ sender: Any) {
        showCodeAlert()
    }
    
    func showCodeAlert() {
        let alertController = UIAlertController(title: "Redeem Code", message: "Enter the code emailed to you to unlock the full Roster.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Code"
        }
        let confirmAction = UIAlertAction(title: "Unlock", style: .default) { [weak alertController] _ in
            guard let alertController = alertController, let textField = alertController.textFields?.first else { return }
           
            if let code = textField.text?.uppercased() {
                
                if (self.redeemCode(code: code)) {
                    let keychain = KeychainSwift()
                    keychain.set(code, forKey: "code")
                    self.items = self.playerManager.loadPlayerDataFromPlist()
                    self.tableView.reloadData()
                    self.navigationItem.rightBarButtonItem = nil
                    self.showCodeConfirmAlert()
                }
                else {
                    self.showErrorAlert()
                }
            }
            /////
            
            //compare the current password and do action here
        }
        alertController.addAction(confirmAction)
        
        let buyAction = UIAlertAction(title: "Purchase Code with Guide", style: .default) { (alert) in
            let urlString = "http://www.cowboysrosterguide.com/downloads/dallas-cowboys-roster-guide/"
            
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
                vc.delegate = self
                
                self.present(vc, animated: true)
            }
        }
        alertController.addAction(buyAction)

        let cancelAction = UIAlertAction(title: "Continue Free Trial", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
        
    }
    func showErrorAlert(){
        let alert = UIAlertController(title: "Unable To Redeem Code", message: "Unable to verify code.  Please check the code and try again.", preferredStyle: .alert)
      
        let okAction = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.showCodeAlert()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func showCodeConfirmAlert () {
        let alert = UIAlertController(title: "Code Redeemed", message: "You now have access to the full Roster.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
      
        alert.addAction(okAction)
        present(alert, animated: true, completion : nil)
    }
    
    func redeemCode(code: String) -> Bool {
        return PlayerManager().codes.contains(code) ? true : false
       
    }
    
    
    
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
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true)
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


