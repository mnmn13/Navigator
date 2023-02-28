//
//  SignUpViewController.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

class SignUpViewController: UIViewController {
    
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var password1TF: UITextField!
    @IBOutlet weak var password2TF: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    var viewModel: SignUpViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextFields()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    private func setupTextFields() {
        emailTF.delegate = self
        password1TF.delegate = self
        password2TF.delegate = self
        
        emailTF.autocapitalizationType = .none
        emailTF.autocorrectionType = .no
        emailTF.returnKeyType = .continue
        emailTF.layer.cornerRadius = 15
        
        password1TF.autocorrectionType = .no
        password1TF.autocapitalizationType = .none
        password1TF.returnKeyType = .send
        password1TF.layer.cornerRadius = 15
        password1TF.isSecureTextEntry = true
        
        password2TF.autocorrectionType = .no
        password2TF.autocapitalizationType = .none
        password2TF.returnKeyType = .send
        password2TF.layer.cornerRadius = 15
        password2TF.isSecureTextEntry = true
    }
    
    @IBAction func registerTapped(_ sender: UIButton) {
        
        alertLabel.text = viewModel.validate(email: emailTF.text, password1: password1TF.text, password2: password2TF.text, view: view)
        
        
    }
}

extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            password1TF.becomeFirstResponder()
        } else if textField == password1TF {
            password2TF.becomeFirstResponder()
            //            loginTappedExtension()
        } else if textField == password2TF {
            alertLabel.text = viewModel.validate(email: emailTF.text, password1: password1TF.text, password2: password2TF.text, view: view)
        }
        return true
    }
}
