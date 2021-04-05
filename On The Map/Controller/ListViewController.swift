//
//  ListViewController.swift
//  On The Map
//
//  Created by Renan Baialuna on 05/04/21.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableview: UITableView!
    var students: [StudentLocation] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        self.students = appDelegate.students
        
        
        tableview.delegate = self
        tableview.dataSource = self
    }
}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "cell") as! StudentTableViewCell
        cell.title.text = students[indexPath.row].lastName
        cell.subTitle.text = students[indexPath.row].firstName
        
        return cell
    }
    
    
}
