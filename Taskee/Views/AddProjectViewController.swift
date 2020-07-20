//
//  AddProjectViewController.swift
//  Taskee
//
//  Created by Angelina Olmedo on 7/19/20.
//  Copyright © 2020 Angelina Olmedo. All rights reserved.
//

import UIKit

class AddProjectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        title = "Create New Project"

        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddProject(_:)))
        navigationItem.leftBarButtonItem = cancelButton

    }
    
    @objc func cancelAddProject(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
