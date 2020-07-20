//
//  ViewController.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/15/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit
import CoreData

class ProjectsTableViewController: UITableViewController {
    
    var store: ProjectStore! = ProjectStore()
    var projects: [Project] = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        
        tableView.register(
                    ProjectTableViewCell.nib,
                    forCellReuseIdentifier: ProjectTableViewCell.identifier
        )

        // Save the new items in the Managed Object Context
        store.saveContext()
        updateDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        // Save the Managed Object Context
        store.saveContext()
        updateDataSource()
        tableView.reloadData()
    }
    
    func setupNavBar() {
        title = "Taskee"
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddProject(_:)))
        navigationItem.rightBarButtonItem = addButton
//        navigationItem.leftBarButtonItem = self.editButtonItem
    }

    @objc func pressAddProject(_ sender: UIBarButtonItem) {
      let addProjectVC = AddProjectViewController.instantiate()
      let navigationController = UINavigationController(rootViewController: addProjectVC)
      navigationController.modalPresentationStyle = .fullScreen
      present(navigationController, animated: true, completion: nil)
    }
    
    
    func createNewProject() -> Project {
        let newProject = NSEntityDescription.insertNewObject(forEntityName: "Project", into: store.persistentContainer.viewContext) as! Project
        return newProject
    }
    
    func createNewProject(name: String, color: UIColor=UIColor.red) -> Project {
        let newProject = NSEntityDescription.insertNewObject(forEntityName: "Project", into: store.persistentContainer.viewContext) as! Project
        newProject.projectName = name
        newProject.color = color
        newProject.tasks = TaskModel(name: "Task", completed: false)
        return newProject
    }
    
    func add(saved project: Project) {
        projects.insert(project, at: 0)
//        collectionView.insertItems(at: [IndexPath(row: 0, section: 0)])
    }
    
    func markProjectFinished(at index: Int) {
        deleteProject(at: index)
    }
    
    func deleteProject(at index: Int) {
        projects.remove(at: index)
//        collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedProject = projects[indexPath.row]
        
        let projectDetailVC = ProjectViewController.instantiate()
        projectDetailVC.projectToDisplay = selectedProject
        let navigationController = UINavigationController(rootViewController: projectDetailVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
//            let projectDetailVC = ProjectDetailViewController.instantiate()
//            projectDetailVC.project = selectedProject
//            projectDetailVC.projectIndex = indexPath.row
//            navigationController?.pushViewController(projectDetailVC, animated: true)
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell( withIdentifier: ProjectTableViewCell.identifier, for: indexPath) as! ProjectTableViewCell
        let project = projects[indexPath.row]
        cell.configure(project)
        return cell
    }
        
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
            case .delete:
//            let projectToDelete = projects[indexPath.row]
            let projectIndexToDelete = indexPath.row
            
            self.deleteProject(at: projectIndexToDelete)
            tableView.deleteRows(at: [indexPath], with: .automatic)

            default:
                break
        }
    }
    
    // populate an array with fetched results on success, or to delete all items from that array on failure
    private func updateDataSource() {
        self.store.fetchPersistedData {

            (fetchItemsResult) in

            switch fetchItemsResult {
            case let .success(projects):
                self.projects = projects
            case .failure(_):
                self.projects.removeAll()
            }
            // reload the collection view's data source to present the current data set to the user
            self.tableView.reloadData()
        }
    }
}

extension UIViewController {
  static func instantiate() -> Self {
    return self.init(nibName: String(describing: self), bundle: nil)
  }
}

    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let identifier = segue.identifier {
//            switch identifier {
//            case "show detailed item":
//                guard let detailedItemVc = segue.destination as? ItemDetailedViewController else {
//                    return print("storyboard not set up correctly")
//                }
//
//                guard
//                    let collectionViewCell = sender as? UICollectionViewCell,
//                    let indexPath = collectionView.indexPath(for: collectionViewCell) else {
//                        return print("'show detailed item' was performed by a non-collection view cell")
//                }
//
//                let selectedItem = items[indexPath.row]
//                detailedItemVc.item = selectedItem
//            case "show new item":
//                guard let itemEditorVc = segue.destination as? ItemEditorViewController else {
//                    return print("storyboard not set up correctly")
//                }
//
//                let newItem = createNewItem()
//                itemEditorVc.item = newItem
//            default: break
//            }
//        }
////    }
//
//    @IBAction func unwindToHome(_ segue: UIStoryboardSegue) {
//        guard let identifier = segue.identifier else {
//            return
//        }
//
//        switch identifier {
//        case "unwind from back":
//            break
//        case "unwind from trash":
//            guard
//                let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
//                let selectedItemIndexPath = selectedIndexPaths.first else {
//                    return
//            }
//
//            deleteItem(at: selectedItemIndexPath.row)
//        case "unwind from mark as returned":
//            guard
//                let selectedIndexPaths = collectionView.indexPathsForSelectedItems,
//                let selectedItemIndexPath = selectedIndexPaths.first else {
//                    return
//            }
//
//            markItemAsReturned(at: selectedItemIndexPath.row)
//        case "unwind from saving new item":
//            guard let itemContactVc = segue.source as? ItemContactInfoViewController else {
//                return print("storyboard not set up correctly")
//            }
//
//            add(saved: itemContactVc.item)
//        default:
//            break
//        }
//    }
//}

//extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item cell", for: indexPath) as! ItemCollectionViewCell
//
//        let item = items[indexPath.row]
//        cell.configure(item)
//
//        return cell
//    }
//}
