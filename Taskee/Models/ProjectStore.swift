//
//  ProjectStore.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/15/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit
import CoreData

class ProjectStore: NSObject {
    
    let persistentContainer: NSPersistentContainer = {
        // creates the NSPersistentContainer object
        // must be given the name of the Core Data model file “SavedProjects”
        let container = NSPersistentContainer(name: "Taskee")

        // loads the saved database if it exists, creates it if it does not, and returns an error under failure conditions
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data (\(error)).")
            }
        }
        return container
    }()
    
    // MARK: - Save Core Data Context
    func saveContext() {
        let viewContext = persistentContainer.viewContext
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchPersistedData(completion: @escaping (FetchItemsResult) -> Void) {

        let fetchRequest: NSFetchRequest<Project> = Project.fetchRequest()
        let viewContext = persistentContainer.viewContext

        do {
            let allItems = try viewContext.fetch(fetchRequest)
            completion(.success(allItems))
        } catch {
            completion(.failure(error))
        }
    }

}

enum FetchItemsResult {
    case success([Project])
    case failure(Error)
}
