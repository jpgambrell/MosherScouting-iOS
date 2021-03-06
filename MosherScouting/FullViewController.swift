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
    @IBOutlet weak var birthDate: UILabel!
    //@IBOutlet weak var summaryView: UIView!
    @IBOutlet weak var playerImage: UIImageView!
    @IBOutlet weak var playerLogo: UIImageView!
    
    @IBOutlet weak var height: UILabel!
    
    @IBOutlet weak var weight: UILabel!
    
    @IBOutlet weak var position: UILabel!
    
    
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var mockchart: UIButton!
    
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
    
    @IBOutlet weak var filmNotes: UITextView!
    var player = PlayerModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = true
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 2000)
        //self.navigationController?.navigationBar.backgroundColor = UIColor().hexStringToUIColor(hex:"#163252")
        self.navigationController?.navigationBar.barTintColor = UIColor().hexStringToUIColor(hex:"#163252")
         self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        setupProfileData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupProfileData(){
        let positionAttr = PlayerManager().getTitlesBy(position: player.position)
        self.title = player.name
        position.text = player.position
        birthDate.text = player.birthdate
        grade.text = player.grade
        height.text = player.height
        weight.text = player.weight
        
        
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
        filmNotes.text = player.filmNotes
        
        playerImage.image = UIImage(named: player.playerImageName) ?? UIImage(named: "noimage")
        
        mockchart.setImage(UIImage(named: player.playerMockImageName) ?? UIImage(named: "noimage"), for: .normal)
        
        playerLogo.image = UIImage(named: player.playerLogoImageName) ?? UIImage(named: "noimage")
        
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func mockDraftClick(_ sender: Any) {
        let configuration = ImageViewerConfiguration { config in
            config.imageView = mockchart.imageView
        }
        
        present(ImageViewerController(configuration: configuration), animated: true)
        
    }
    
}
