//
//  ViewController.swift
//  TaniwhaTextField
//
//  Created by Liguo Jiao on 06/23/2017.
//  Copyright (c) 2017 Liguo Jiao. All rights reserved.
//

import UIKit
import TaniwhaTextField

class ViewController: UIViewController {

    @IBOutlet weak var taniwha: TaniwhaTextField!
    @IBOutlet weak var marimari: TaniwhaTextField!

    weak var codingUITextField: TaniwhaTextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        taniwha.placeholder = "Tena Koe"
        marimari.placeholder = "Kia Ora"

        let textField = TaniwhaTextField(bottomLineAlphaAfter: 0, placeholderTextColor: .red)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.setPlaceholder("CodingUI Example")
        textField.placeholderFont = .systemFont(ofSize: 11)
        textField.font = .systemFont(ofSize: 12)
        
        self.view.addSubview(textField)
        self.codingUITextField = textField
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: marimari.bottomAnchor, constant: 8*3),
            textField.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 2/3),
            textField.heightAnchor.constraint(equalToConstant: 39),
            textField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

