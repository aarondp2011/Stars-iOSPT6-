//
//  StarsViewController.swift
//  Stars (iOSPT6)
//
//  Created by Aaron Peterson on 4/23/20.
//  Copyright © 2020 Aaron Peterson. All rights reserved.
//

import UIKit

class StarsViewController: UIViewController, UITableViewDataSource {
    
    // MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var distanceTextField: UITextField!
    
    let starController = StarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // MARK: IBActions
    @IBAction func printButtonTapped(_ sender: Any) {
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        guard let starName = nameTextfield.text,
            let distanceInLightYears = distanceTextField.text,
            let distance = Double(distanceInLightYears),
            !starName.isEmpty else { return }
        
        starController.createStar(with: starName, distance: distance)
        self.tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return starController.stars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "StarCell") as? StarTableViewCell else {
            return UITableViewCell()
        }
        
        let star = starController.stars[indexPath.row]
        
        cell.star = star
        
        return cell
    }

}

class StarTableViewCell: UITableViewCell {
    // MARK: IBOutlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    var star: Star? {
        didSet {
            self.updateViews()
        }
    }
    
    func updateViews() {
        guard let star = star else { return }
        nameLabel.text = star.name
        distanceLabel.text = "\(star.distance) light years away"
    }
}

