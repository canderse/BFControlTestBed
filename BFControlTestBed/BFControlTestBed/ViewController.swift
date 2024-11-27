//
//  ViewController.swift
//  BFControlTestBed
//
//  Created by Christian Andersen on 28/11/2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        chackBox.checkboxUnknowenType = .unknownCircle
    }

    @IBOutlet weak var chackBox: BFCheckBox!
   
    @IBAction func chackBoxValueChanged(_ sender: Any) {
    }
    
    
}

