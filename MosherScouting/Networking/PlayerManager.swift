//
//  PlayerManager.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/17/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import Foundation

struct AttributeTitles {
    var position : String = ""
    var titles = Array<String>()
}

struct PlayerModel {
    var name : String = ""
    var position : String = ""
    var height : String = ""
    var weight : String = ""
    var birthdate : String = ""
    var college : String = ""
    var mockdraftchart : String = ""
    var stat1 : String = ""
    var stat2 : String = ""
    var stat3 : String = ""
    var stat4 : String = ""
    var stat5 : String = ""
    var stat6 : String = ""
    var stat7 : String = ""
    var fortyYdDash : String = ""
    var handSize : String = ""
    var tenYardSplit : String = ""
    var benchPress : String = ""
    var verticalJump : String = ""
    var broadJump : String = ""
    var threeCone : String = ""
    var twentyYdShuttle : String = ""
    var sparq : String = ""
    var grade : String = ""
    var summary : String = ""
    var filmNotes : String = ""
    
    func populatePlayer(item : Dictionary<String, String>) -> PlayerModel {
        var p = PlayerModel()
        p.name  = item["name"] ?? ""
        p.position = item["position"] ?? ""
        p.height = item["height"] ?? ""
        p.weight =  item["weight"] ?? ""
        p.birthdate =   item["birthdate"] ?? ""
        p.college =   item["college"] ?? ""
        p.mockdraftchart =  item["mockdraftchart"] ?? ""
        p.stat1 = item["stat1"] ?? ""
        p.stat2 =  item["stat2"] ?? ""
        p.stat3 =  item["stat3"] ?? ""
        p.stat4 =  item["stat4"] ?? ""
        p.stat5 =  item["stat5"] ?? ""
        p.stat6 =  item["stat6"] ?? ""
        p.stat7 = item["stat7"] ?? ""
        p.fortyYdDash = item["40 yard dash"] ?? ""
        p.handSize =  item["hand size"] ?? ""
        p.tenYardSplit =  item["10 yard split"] ?? ""
        p.benchPress =  item["bench press"] ?? ""
        p.verticalJump =  item["vertical jump"] ?? ""
        p.broadJump =  item["broad jump"] ?? ""
        p.threeCone =  item["3 cone"] ?? ""
        p.twentyYdShuttle = item["20 yard shuttle"] ?? ""
        p.sparq =  item["sparq %"] ?? ""
        p.grade =  item["2017 grade"] ?? ""
        p.summary =  item["summary"] ?? ""
        p.filmNotes =  item["film notes"] ?? ""
        return p
    }
}
class PlayerManager {
    var items: [Dictionary<String, String>] =  {
        let data = try! Data(contentsOf: Bundle.main.url(forResource: "playersBeforeDraft", withExtension: "plist")!)
        return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [Dictionary<String, String>]
    }()
    
    var statTitles: [AttributeTitles] = {
        var att = [AttributeTitles]()
        let rbAtt = ["TOTAL CARRIES", "RUSHING YARDS","YARDS/CARRY","RUSH TOUCHDOWNS","RECEPTIONS","REC YARDS","REC TDs"]
        let olAtt = ["GAMES PLAYED", "GAMES STARTED","TOTAL SNAPS","PENALTIES","PENALTY YARDS","SACKS GIVEN UP","SACK YARDAGE"]
        let dlAtt = ["TACKLES", "TACKLES FOR LOSS","SACKS","FORCED FUMBLES","TOTAL PRESSURES","QB HITS","PASS DEFLECTIONS"]
        let lbAtt = ["TACKLES", "TACKLES FOR LOSS","SACKS","FORCED FUMBLES","INTERCEPTIONS","PASS DEFLECTIONS","MISSED TACKLES"]
        let dbAtt = ["TOTAL SNAPS", "TACKLES","INTERCEPTIONS","PASS DEFLECTIONS","FORCED FUMBLES","MISSED TACKLES", "YARDS ALLOWED"]
        
        
        
        att.append(AttributeTitles(position: "QUARTERBACK", titles: ["COMPLETION %", "YARDS","YARDS/ATTEMPT","TOUCHDOWNS","INT","PASSER RATING","QBR"]))
        att.append(AttributeTitles(position: "RUNNING BACK", titles: rbAtt ))
        att.append(AttributeTitles(position: "FULLBACK", titles: rbAtt))
       
         att.append(AttributeTitles(position: "TIGHT END", titles:  ["TARGETS", "RECEPTIONS","YARDS","YARDS/RECEPTION","TOUCHDOWNS","YARDS AFTER CATCH","DROPS"]))
        att.append(AttributeTitles(position: "LEFT TACKLE", titles:  olAtt))
        att.append(AttributeTitles(position: "TACKLE/GUARD", titles:  olAtt))
        att.append(AttributeTitles(position: "RIGHT GUARD", titles:  olAtt))
        att.append(AttributeTitles(position: "RIGHT TACKLE", titles:  olAtt))
        att.append(AttributeTitles(position: "GUARD CENTER", titles:  olAtt))
        att.append(AttributeTitles(position: "TACKLE", titles:  olAtt))
        att.append(AttributeTitles(position: "GUARD", titles:  olAtt))
        att.append(AttributeTitles(position: "LEFT GUARD", titles:  olAtt))
        
         att.append(AttributeTitles(position: "DEFENSIVE END", titles:  dlAtt))
        att.append(AttributeTitles(position: "DEFENSIVE TACKLE", titles:  dlAtt))
        att.append(AttributeTitles(position: "1 TECHNIQUE", titles:  dlAtt))
        att.append(AttributeTitles(position: "3 TECHNIQUE", titles:  dlAtt))
        
        att.append(AttributeTitles(position: "LINEBACKER", titles:  lbAtt))
        att.append(AttributeTitles(position: "SAM LINEBACKER", titles:  lbAtt))
        
        att.append(AttributeTitles(position: "CORNERBACK", titles:  dbAtt))
        att.append(AttributeTitles(position: "FREE SAFETY", titles:  dbAtt))
        att.append(AttributeTitles(position: "STRONG SAFETY", titles:  dbAtt))
        att.append(AttributeTitles(position: "DEFENSIVE BACK", titles:  dbAtt))
        
        att.append(AttributeTitles(position: "KICKER", titles:  ["FG%", "XP%", "20-29", "30-39","40-49","50+","KICKS BLOCKED"]))
        att.append(AttributeTitles(position: "PUNTER", titles:  ["TOTAL PUNTS", "NET YARDS/PUNT", "PUNTS INSIDE 20", "LONGEST PUNT","TOUCHBACKS","AVG HANG TIME","PUNTS BLOCKED"]))
        att.append(AttributeTitles(position: "LONG SNAPPER", titles:  ["TACKLES", "TOTAL SNAPS", "CAREER TACKLES", "FUMBLE RECOVERIES","PRO BOWLS","GAMES PLAYED","YEARS PLAYED"]))
        return att
    }()


func loadPlayerDataFromPlist() -> [PlayerModel] {
    var players = [PlayerModel]()
    for item in items {
        players.append(PlayerModel().populatePlayer(item: item))
        print(item["name"] ?? "")
    }
    return players
}
    
    func getTitlesBy(position: String) -> [String] {
        let a = statTitles.filter { $0.position == position}
        return a.first?.titles ?? []
    }
    
}


