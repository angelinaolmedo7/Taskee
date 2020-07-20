//
//  Task.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/15/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit

class TaskModel: NSObject, NSCoding {

    var name: String
    var completed: Bool

    // Protocol requires having Keys for our variables
    enum Keys: String {
        case name = "name"
        case completed = "completed"
    }

    init(name: String, completed: Bool!) {
        self.name = name
        self.completed = completed
    }

    // Protocol requires an encode method to encode our variables based on the Key
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(completed, forKey: "completed")
    }

    // Protocol requires an init method which acts as a decoder for our variables based on the Key
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: "name") as! String
        completed = aDecoder.decodeObject(forKey: "completed") as? Bool ?? false
        super.init()
    }
}
