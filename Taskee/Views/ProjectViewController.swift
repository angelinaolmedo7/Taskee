//
//  ProjectViewController.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/19/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class ProjectViewController: UIViewController {
    
    
    var projectToDisplay: Project!
    @IBOutlet weak var ProjectTitleLabel: UILabel! // shoulda made lowercase
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var tasksTable: UITableView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavBar()
        
        tasksTable.register(
                    TaskTableViewCell.nib,
                    forCellReuseIdentifier: TaskTableViewCell.identifier
        )

        tasksTable.delegate = self  // GOD why do i always forget these
        tasksTable.dataSource = self
        
        tasksTable.reloadData()
        updateUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Save the Managed Object Context
//        store.saveContext()
//        updateDataSource()
        tasksTable.reloadData()
    }
    
    func setupNavBar() {
        title = projectToDisplay.projectName ?? "Project"
        let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonPressed(_:)))
        navigationItem.leftBarButtonItem = backButton
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddTask(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc func pressAddTask(_ sender: UIBarButtonItem) {
        let addTaskVC = AddTaskViewController.instantiate()
        addTaskVC.projectToDisplay = self.projectToDisplay
        let navigationController = UINavigationController(rootViewController: addTaskVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }

    private func updateUI() {
        self.ProjectTitleLabel.text = projectToDisplay.projectName
        self.colorView.backgroundColor = (projectToDisplay.color as! UIColor)
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}

extension ProjectViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numCells = (projectToDisplay.tasks as! Tasks).storedTasks.count
        return numCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: TaskTableViewCell.identifier, for: indexPath) as! TaskTableViewCell
        let task = (projectToDisplay.tasks as! Tasks).storedTasks[indexPath.row]
        cell.configure(task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedTask = (projectToDisplay.tasks as! Tasks).storedTasks[indexPath.row]
        selectedTask.completed = !selectedTask.completed
        tasksTable.reloadData()
    }
    
            
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        switch editingStyle {
//            case .delete:
//            let projectToDelete = projects[indexPath.row]
//            let projectIndexToDelete = indexPath.row
//                
//            self.deleteProject(at: projectIndexToDelete)
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//
//            default:
//                break
//        }
//    }
    
}

