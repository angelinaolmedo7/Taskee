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

struct Tasks {
    var storedTasks: [TaskModel] = []
    
    init(tasks: [TaskModel]) {
        self.storedTasks = tasks
    }
    
    mutating func addTask(name: String?, completed: Bool?) {
        let newTask: TaskModel
        if let taskName = name {
            newTask = TaskModel(name: taskName, completed: completed ?? false)
        } else {
            newTask = TaskModel(name: "New Task", completed: false)
        }
        self.storedTasks.append(newTask)
    }
}
