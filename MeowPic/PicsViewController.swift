//
//  PicsViewController.swift
//  MeowPic
//
//  Created by Jack Taylor on 11/10/2016.
//  Copyright © 2016 Jack Taylor. All rights reserved.
//

import UIKit

class PicsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func logoutTapped(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
