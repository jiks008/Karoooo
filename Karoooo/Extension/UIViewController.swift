//
//  UIViewController.swift
//  Karoooo
//
//  Created by Jignesh Vadadoriya on 22/08/22.
//

import UIKit

extension UIViewController {

    func displyAlertController(with title : String, msg : String , buttonTitle : String ,handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: msg , preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .cancel, handler: handler)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

