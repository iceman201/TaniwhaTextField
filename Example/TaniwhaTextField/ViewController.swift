//
//  ViewController.swift
//  TaniwhaTextField
//
//  Created by iceman201 on 06/23/2017.
//  Copyright (c) 2017 iceman201. All rights reserved.
//

import UIKit
import TaniwhaTextField

class ViewController: UIViewController {

    @IBOutlet var taniwha: TaniwhaTextField!
    
    @IBOutlet var marimari: TaniwhaTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taniwha.placeholder = "Tena Koe"
        marimari.placeholder = "Kia Ora"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

