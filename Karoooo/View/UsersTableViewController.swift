//
//  UsersTableViewController.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import UIKit

class UsersTableViewController: UITableViewController {
    
    let viewModel = UserListViewModel()
    
    lazy var activityIndicator : UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.tintColor = UIColor.systemOrange
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        prepareViewModel()
        getUsers()
    }
    
    private func showActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.startAnimating()

        view.addSubview(activityIndicator)
    }
    
    private func prepareViewModel() {
        viewModel.displayUsers = { [weak self] in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()
                self?.tableView.reloadData()
            }
        }
    }
    
    private func getUsers() {
        showActivityIndicator()
        viewModel.getUsers()
    }
    
    // MARK: - Table view data source & delegate
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.userCellViewModels.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserListTableViewCell.identifier, for: indexPath) as? UserListTableViewCell else { fatalError("Can't find cell.") }
        
        cell.cellViewModel = viewModel.userCellViewModels[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "details", sender: indexPath.row)
    }
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "details" else { return }
        
        guard let vc = segue.destination as? UsersDetailsTableViewController else { return }
        
        guard let index = sender as? Int else { return }
        guard let userDetailViewModel = viewModel.userDetailViewModel(for: index) else { return }
        
        vc.viewModel = userDetailViewModel
    }
}
