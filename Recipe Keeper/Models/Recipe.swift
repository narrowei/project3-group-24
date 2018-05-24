//
//  Recipe.swift
//  Reciper Keeper
//
//  Created by Alice Mai Tu on 13/5/18.
//  Copyright © 2018 Alice Mai Tu. All rights reserved.
//

import Foundation
import RealmSwift

enum Cuisine: String {
    case Australian
    case Chinese
    case Italian
    case Russian
    case Thai
    case Vietnamese
    
    static var allCases: [Cuisine] = [.Australian,.Chinese,.Italian,.Russian,.Thai,.Vietnamese]
}

class Step: Object {
    
    @objc dynamic var stepDescription: String = ""
    @objc dynamic var needTimer: Bool = false
    @objc dynamic var timer: Int = 0
    
    convenience init (description: String, needTimer: Bool, timer: Int) {
        self.init()
        self.stepDescription = description
        self.needTimer = needTimer
        self.timer = timer
    }
}

class Recipe: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var time: Int = 0
    @objc dynamic var cuisine: String = ""
    
    var ingredients: List<String>? = List<String>()
    var instruction: List<Step>? = List<Step>()
    
    convenience init (name: String, time: Int, cuisine: String, ingredients: List<String>, instruction: List<Step>) {
        self.init()
        self.name = name
        self.time = time
        self.cuisine = cuisine
        self.ingredients = ingredients
        self.instruction = instruction
        
    }
    
    override static func primaryKey() -> String? {
        return "name" //unique name
    }
}

