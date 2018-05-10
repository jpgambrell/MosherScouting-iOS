//
//  FullViewController.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/25/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import UIKit

class FullViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var birthDate: UILabel!
    @IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var mockchart: UIImageView!
    
    @IBOutlet weak var summary: UITextView!
    
    @IBOutlet weak var stat1Title: UILabel!
    @IBOutlet weak var stat2Title: UILabel!
    @IBOutlet weak var stat3Title: UILabel!
    @IBOutlet weak var stat4Title: UILabel!
    @IBOutlet weak var stat5Title: UILabel!
    @IBOutlet weak var stat6Title: UILabel!
    @IBOutlet weak var stat7Title: UILabel!
    
    @IBOutlet weak var stat1Value: UILabel!
    @IBOutlet weak var stat2Value: UILabel!
    @IBOutlet weak var stat3Value: UILabel!
    @IBOutlet weak var stat4Value: UILabel!
    @IBOutlet weak var stat5Value: UILabel!
    @IBOutlet weak var stat6Value: UILabel!
    @IBOutlet weak var stat7Value: UILabel!
    
  
    @IBOutlet weak var fortyDash: UILabel!
    @IBOutlet weak var handSize: UILabel!
    @IBOutlet weak var tenYardSplit: UILabel!
    @IBOutlet weak var benchPress: UILabel!
    @IBOutlet weak var vertJump: UILabel!
    @IBOutlet weak var broJump: UILabel!
    @IBOutlet weak var threeCode: UILabel!
    @IBOutlet weak var twentyShuttle: UILabel!
    @IBOutlet weak var sparQ: UILabel!
    
    var player = PlayerModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 2000)
        setupProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupProfileData(){
        let positionAttr = PlayerManager().getTitlesBy(position: player.position)
        
        name.text = player.name
        birthDate.text = player.birthdate
        grade.text = player.grade
        
        
        stat1Title.text = positionAttr[0]
        stat2Title.text = positionAttr[1]
        stat3Title.text = positionAttr[2]
        stat4Title.text = positionAttr[3]
        stat5Title.text = positionAttr[4]
        stat6Title.text = positionAttr[5]
        stat7Title.text = positionAttr[6]
        
         stat1Value.text = player.stat1
         stat2Value.text = player.stat2
         stat3Value.text = player.stat3
         stat4Value.text = player.stat4
         stat5Value.text = player.stat5
         stat6Value.text = player.stat6
         stat7Value.text = player.stat7
        
        
        fortyDash.text = player.fortyYdDash
        handSize.text = player.handSize
        tenYardSplit.text = player.tenYardSplit
        benchPress.text = player.benchPress
        vertJump.text = player.verticalJump
        broJump.text = player.broadJump
        threeCode.text = player.threeCone
        twentyShuttle.text = player.twentyYdShuttle
        sparQ.text = player.sparq
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
