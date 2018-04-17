//
//  PlayerManager.swift
//  MosherScouting
//
//  Created by Gambrell, John on 4/17/18.
//  Copyright © 2018 Gambrell, John. All rights reserved.
//

import Foundation
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
    let data = try! Data(contentsOf: Bundle.main.url(forResource: "players", withExtension: "plist")!)
    return try! PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! [Dictionary<String, String>]
}()


func loadPlayerDataFromPlist() -> [PlayerModel] {
    var players = [PlayerModel]()
    for item in items {
        players.append(PlayerModel().populatePlayer(item: item))
        print(item["name"] ?? "")
    }
    return players
}
}

