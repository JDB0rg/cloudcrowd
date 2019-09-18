//
//  ViewController.swift
//  Clouds
//
//  Created by Madison Waters on 5/24/19.
//  Copyright © 2019 EmPact. All rights reserved.
//

import UIKit

class CloudHomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var cloudLogoView: UIView!
    @IBOutlet weak var cloudTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    let reuseIdentifier = "ChangeThisThing"
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CloudHomeTableViewCell else { fatalError() }
    }
}

