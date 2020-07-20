//
//  AddTaskViewController.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/20/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class AddTaskViewController: UIViewController {
    
    var projectToDisplay: Project!

    @IBOutlet weak var taskNameTextField: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        title = "Create New Task for \(projectToDisplay.projectName ?? "Project")"

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddTask(_:)))
        navigationItem.leftBarButtonItem = cancelButton
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveTask(_:)))
        navigationItem.rightBarButtonItem = saveButton

    }
    
    @objc func cancelAddTask(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTask(_ sender: UIBarButtonItem) {
        let mainVC = (self.presentingViewController as! UINavigationController).topViewController as! ProjectViewController
        (mainVC.projectToDisplay.tasks as! Tasks).addTask(name: taskNameTextField.text ?? "New Task", completed: false, dueDate: dueDatePicker.date as NSDate)
        // get the top level view controller
        ((mainVC.presentingViewController as! UINavigationController).topViewController as! ProjectsTableViewController).store.saveContext()
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
