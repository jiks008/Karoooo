//
//  LoginView.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    @IBOutlet weak var btnShowHidePassword: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    var credential = LoginCredential()
    var viewModel: LoginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        // developement purpose only
        credential.username = "admin"
        credential.password = "admin"
        txtFieldUsername.text = self.credential.username
        txtFieldPassword.text = self.credential.password
        //---------------
        */
        
        prepareViewModel()
    }
    
    private func prepareViewModel() {
        viewModel.showError = { [weak self] errorMessage in
            self?.displyAlertController(with: "Error", msg: errorMessage, buttonTitle: "OK", handler: nil)
        }
        
        viewModel.routeToUserList = { [weak self] in
            self?.onSucessfullLogin()
        }
    }
    
    @IBAction func btnShowHidePasswordClicked(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            txtFieldPassword.isSecureTextEntry = false
        } else {
            sender.isSelected = false
            txtFieldPassword.isSecureTextEntry = true
        }
    }
    
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        self.view.endEditing(true)

        if viewModel.isValid(credentials: credential) {
            viewModel.login(with: credential)
        }
    }
    
    func onSucessfullLogin() {
        let navigationController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListNavigationController")
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return}
        appdelegate.window?.rootViewController = navigationController
    }
    
}

// MARK: - UITextViewDelegate Method
extension LoginViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField === txtFieldUsername {
            txtFieldPassword.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField === txtFieldUsername {
            credential.username = textField.text?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
        } else if textField === txtFieldPassword {
            credential.password = textField.text?.trimmingCharacters(in: CharacterSet.whitespaces) ?? ""
        }
    }
}
