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
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var height: UILabel!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var summaryView: UIView!
    
    
    
    func populateCell(player: PlayerModel) {
        name.text = player.name
        position.text = player.position
        height.text = player.height
        weight.text = player.weight
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

}
