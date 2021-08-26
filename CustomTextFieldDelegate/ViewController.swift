//
//  ViewController.swift
//  CustomTextFieldDelegate
//
//  Created by Ацкий Станислав on 25.08.2021.
//

import UIKit

class ViewController: UIViewController {
    
    private var textField: CustomTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField = CustomTextField()
        textField.delegate = self
    }
}

extension ViewController: UITextFieldDelegate {
    
}

