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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        setupNavBar()
        updateUI()
        
    }
    
    func setupNavBar() {

        let backButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(backButtonPressed(_:)))
        navigationItem.leftBarButtonItem = backButton
        
    }

    private func updateUI() {
        self.ProjectTitleLabel.text = projectToDisplay.projectName
        self.colorView.backgroundColor = projectToDisplay.color as! UIColor
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }

}
