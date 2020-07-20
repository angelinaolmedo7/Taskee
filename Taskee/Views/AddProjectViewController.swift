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
    
    var selectedColor: UIColor = UIColor.red
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        self.colorPicker.selectedSegmentTintColor = selectedColor
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
        mainVC.projects.append(mainVC.createNewProject(name: nameTextBox.text ?? "New Project", color: selectedColor))
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func colorSelectorChanged(_ sender: Any) {
        /*
         0 - Red
         1 - Orange
         2 - Yellow
         3 - Green
         4 - Blue
         5 - Purple
         */
        switch colorPicker.selectedSegmentIndex {
        case 0:
            self.selectedColor = .red
        case 1:
            self.selectedColor = .orange
        case 2:
            self.selectedColor = .yellow
        case 3:
            self.selectedColor = .green
        case 4:
            self.selectedColor = .blue
        case 5:
            self.selectedColor = .purple
        default:
            self.selectedColor = .black // ~secret color~ (aka if you get this something broke)
        }
        self.colorPicker.selectedSegmentTintColor = self.selectedColor
        
    }
    
}
