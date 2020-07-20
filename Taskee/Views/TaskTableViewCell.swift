//
//  TaskTableViewCell.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/20/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskFinishedIndicator: UIImageView!
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    
    // reuse stuff
    static let identifier = "TaskCell"
    // Returning the xib file after instantiating it
    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }

    func configure(_ task: TaskModel) {
        self.taskTitleLabel.text = task.name
        self.dueDateLabel.text = "Due: \( DateFormatter.localizedString(from: task.dueDate as Date, dateStyle: .short, timeStyle: .short))"
        switch task.completed {
        case true:
            self.taskFinishedIndicator.image = UIImage(systemName: "checkmark.circle.fill")
        case false:
            self.taskFinishedIndicator.image = UIImage(systemName: "circle")
        }
    }
    
}
