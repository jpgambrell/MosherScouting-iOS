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
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var mockchart: UIImageView!
    
    @IBOutlet weak var summary: UITextView!
    
    func populateCell(player: PlayerModel) {
        name.text = player.name
        position.text = player.position
        height.text = player.height
        weight.text = player.weight
        grade.text = player.grade
        summary.text = player.summary
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

}
