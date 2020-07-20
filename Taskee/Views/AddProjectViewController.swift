//
//  AddProjectViewController.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/19/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var colorPicker: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        title = "Create New Project"

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddProject(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveProject(_:)))
        navigationItem.rightBarButtonItem = saveButton

    }
    
    @objc func cancelAddProject(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveProject(_ sender: UIBarButtonItem) {
        let mainVC = (self.presentingViewController as! UINavigationController).topViewController as! ProjectsTableViewController
        mainVC.projects.append(mainVC.createNewProject(name: nameTextBox.text ?? "New Project"))
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
