//
//  Tasks.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/15/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import Foundation
import UIKit.UIImage
import Contacts.CNContact

class Tasks: NSObject, NSCoding {
    var storedTasks: [TaskModel] = []
    
    // Protocol requires having Keys for our variables
    enum Keys: String {
        case storedTasks = "storedTasks"
    }
    
    init(tasks: [TaskModel]?) {
        self.storedTasks = tasks ?? [TaskModel]()
    }
    
    func addTask(name: String?, completed: Bool?, dueDate: NSDate?) {
        let newTask: TaskModel
        if let taskName = name {
            newTask = TaskModel(name: taskName, completed: completed ?? false, dueDate: dueDate ?? NSDate.now as NSDate)
        } else {
            newTask = TaskModel(name: "New Task", completed: false, dueDate: dueDate ?? NSDate.now as NSDate)
        }
        self.storedTasks.append(newTask)
    }

    // Protocol requires an encode method to encode our variables based on the Key
    func encode(with aCoder: NSCoder) {
        aCoder.encode(storedTasks, forKey: "storedTasks")
    }

    // Protocol requires an init method which acts as a decoder for our variables based on the Key
    required init?(coder aDecoder: NSCoder) {
        storedTasks = aDecoder.decodeObject(forKey: "storedTasks") as? [TaskModel] ?? [TaskModel]()
        super.init()
    }
}
