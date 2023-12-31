//
//  ViewController.swift
//  SecNinjazKeyboard
//
//  Created by Siva Mouniker on 07/07/23.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var defTF: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        defTF.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case defTF:
            returnAction()
        default:
            returnAction()
        }
        return true
    }
    
    func returnAction() {
        
        print("Configure The Return Action Here...")
        resignFirstResponder()
        self.view.endEditing(true)
        
    }
    
    
    
    
    
    
    

}

