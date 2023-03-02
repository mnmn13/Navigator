//
//  SignInViewController.swift
//  NavigatorApp
//
//  Created by MN on 21.02.2023.
//  Copyright © 2023 Nikita Moshyn. All rights reserved.
//

import Foundation
import UIKit

class SignInViewController: UIViewController {
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var alertLabel: UILabel!
    
    var viewModel: SignInViewModelType!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupTextFields()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    private func setupTextFields() {
        emailTF.delegate = self
        passwordTF.delegate = self
        
        emailTF.autocapitalizationType = .none
        emailTF.autocorrectionType = .no
        emailTF.returnKeyType = .continue
        emailTF.layer.cornerRadius = 15
        
        passwordTF.autocorrectionType = .no
        passwordTF.autocapitalizationType = .none
        passwordTF.returnKeyType = .send
        passwordTF.layer.cornerRadius = 15
        passwordTF.isSecureTextEntry = true
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
        loginButtonExtension()
        
//        viewModel.testLogin()
    }
    
    private func loginButtonExtension() {
        alertLabel.text = viewModel.validate(email: emailTF.text, password: passwordTF.text, view: view)
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        viewModel.signUp()
        
    }
    
    @IBAction func enterAppWithoutLoginTapped(_ sender: UIButton) {
        viewModel.testLogin()
    }
    
}

extension SignInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == emailTF {
            passwordTF.becomeFirstResponder()
        } else if textField == passwordTF {
            loginButtonExtension()
        }
        return true
    }
    
}
 
