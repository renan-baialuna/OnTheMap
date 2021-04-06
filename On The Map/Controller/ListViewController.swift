//
//  ListViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 05/04/21.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tabController = tabBarController as? TabBarController
        tabController?.reloadDelegate = self
        
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    func reloadTable() {
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.appDelegate.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! StudentTableViewCell
        cell.title.text = appDelegate.students[indexPath.row].lastName
        cell.subTitle.text = appDelegate.students[indexPath.row].firstName
        return cell
    }
}

extension ListViewController: reloadDelegate {
    func reloadData() {
        reloadTable()
    }
}
