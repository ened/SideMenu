//
//  SecondViewController.swift
//  SideMenuExample
//
//  Created by kukushi on 21/02/2018.
//  Copyright © 2018 kukushi. All rights reserved.
//

import UIKit

class WorkWithOtherViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Scroll View and Others"
    }

    @IBAction func pushViewControllerButtonDidClicked(_ sender: Any) {
        guard let viewController = storyboard?.instantiateViewController(withIdentifier: "PushedViewController") else {
            return
        }
        viewController.view.backgroundColor = .white
        navigationController?.pushViewController(viewController, animated: true)
    }

    @IBAction func menuButtonDidClicked(_ sender: Any) {
        sideMenuController?.revealMenu()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

}

class PushedViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    var items = [String](repeating: "Cell", count: 100)

    override func viewDidLoad() {
        super.viewDidLoad()

        printSideMenu(#function)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        printSideMenu(#function)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        printSideMenu(#function)
    }

    private func printSideMenu(_ function: String) {
        let representation = sideMenuController != nil ? String(describing: sideMenuController!) : "nil"
        print("In `\(function)`, sideMenuControlLer is: \(representation)")

        if sideMenuController == nil {
            let representation2 = navigationController != nil ? String(describing: navigationController!) : "nil"
            print("    - And navigationController is: \(representation2)")
        }
    }
}

extension PushedViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlainCell", for: indexPath)
        cell.textLabel?.text = "\(items[indexPath.row]) \(indexPath.row)"
        return cell
    }

    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCellEditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            items.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
