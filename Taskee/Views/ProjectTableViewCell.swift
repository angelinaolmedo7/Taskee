//
//  ProjectTableViewCell.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/19/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class ProjectTableViewCell: UITableViewCell {
    
    // reuse stuff
    static let identifier = "ProjectCell"
    // Returning the xib file after instantiating it
    static var nib: UINib {
           return UINib(nibName: String(describing: self), bundle: nil)
    }

    @IBOutlet weak var projectNameLabel: UILabel!

    func configure(_ project: Project) {
        self.projectNameLabel.text = project.projectName
    }
    
}
