//
//  UserListViewController.swift
//  TableView
//
//  Created by Priyank Ahuja on 16/04/20.
//  Copyright © 2020 Priyank Ahuja. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var userTableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var users: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchUserData()
    }
    
    func configureTableView() {
        
        userTableView.tableFooterView = UIView()
        userTableView.delegate = self
        userTableView.dataSource = self
        
        userTableView.estimatedRowHeight = 105
        userTableView.rowHeight = UITableView.automaticDimension
    }
    
}

//MARK: UITableViewDataSource protocol methods
extension UserListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = userTableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as? UserTableViewCell {
            if let user = self.users?[indexPath.row]{
                cell.configureCell(user: user)
                return cell
            }
        }
        return UserTableViewCell()
    }
    
}

//MARK: API CALLS
extension UserListViewController{
    
    func fetchUserData() {
        self.showLoader()
        DataService.instance.fetchUsers { (success, data) in
            self.hideLoader()
            if let users = data as? [User],success{
                self.users = users
                self.userTableView.reloadData()
            }
        }
    }
    
}

//MARK: LOADER METHODS
extension UserListViewController{
    
    func showLoader(_ message: String = "Loading") {
        self.view.isUserInteractionEnabled = false
        activityIndicatorView.startAnimating()
        activityIndicatorView.isHidden = false
    }
    
    func hideLoader() {
        self.view.isUserInteractionEnabled = true
        activityIndicatorView.stopAnimating()
        activityIndicatorView.isHidden = true
    }
    
}
