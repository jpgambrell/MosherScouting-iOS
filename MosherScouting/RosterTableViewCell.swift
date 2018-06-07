//
//  RosterTableViewCell.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/20/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import UIKit

class RosterTableViewCell: UITableViewCell {
    @IBOutlet weak var detailView: UIView!{
        didSet {
            detailView.isHidden = true
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var mockChart: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var grade: UILabel!
    
    
    @IBOutlet weak var summary: UITextView!
    var tableVC = RosterTableViewController()
    var player = PlayerModel()
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        playerImage.make
//    }
    func populateCell(player: PlayerModel) {
        self.player = player
        name.text = player.name
        position.text = player.position
        height.text = player.height
        weight.text = player.weight
        grade.text = player.grade
        summary.text = player.summary
        playerImage.image = UIImage(named: player.playerImageName) ?? UIImage(named: "noimage")
        
        mockChart.setImage(UIImage(named: player.playerMockImageName) ?? UIImage(named: "noimage"), for: .normal)
    }
    @IBAction func showFullProfileVC(_ sender: Any) {
        //UIViewController().performSegue(withIdentifier: "ShowFullProfile", sender: player)
        let sb: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let fullVC = sb.instantiateViewController(withIdentifier: "FullViewController") as! FullViewController
        fullVC.player = self.player
        
        tableVC.navigationController?.pushViewController(fullVC, animated: true)
        
    }
    
    
    @IBAction func mockImageClick(_ sender: Any) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = mockChart.imageView
        }
        
        tableVC.present(ImageViewerController(configuration: configuration), animated: true)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

}
