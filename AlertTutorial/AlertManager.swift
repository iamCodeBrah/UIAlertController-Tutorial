//
//  AlertManager.swift
//  AlertTutorial
//
//  Created by YouTube on 2023-07-16.
//

import UIKit


class AlertManager {
    private static func showTextAlert(on vc: UIViewController, with title: String, with message: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    public static func showNoWifiWarning(on vc: UIViewController) {
        self.showTextAlert(on: vc, with: "No Wifi", with: "You have now wifi")
    }
}

// MARK: - Button Alerts
extension AlertManager {
    
    static func showButtonAlert(on vc: UIViewController,
                                        title: String,
                                        message: String? = nil,
                                        buttons: [UIAlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        buttons.forEach({ alert.addAction($0) })
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func showDeleteConfirmation(on vc: UIViewController, completion: @escaping (Bool) -> Void) {
        
        let button1 = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            completion(false)
        }
        
        let button2 = UIAlertAction(title: "Delete", style: .destructive) { _ in
            completion(true)
        }
        
        self.showButtonAlert(on: vc, title: "Delete Post", message: nil, buttons: [button1, button2])
    }
}



// MARK: - TextField Alerts
extension AlertManager {
    
    struct AlertAction {
        let title: String
        let style: UIAlertAction.Style
        let handler: (([String]) -> Void)
    }
    
    private static func showTextFieldAlert(on vc: UIViewController,
                                           title: String,
                                           message: String? = nil,
                                           textFields: [(UITextField) -> Void],
                                           actions: [AlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        textFields.forEach({ alert.addTextField(configurationHandler: $0) })
        
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
                let strings = (alert.textFields ?? []).compactMap { $0.text?.isEmpty == false ? $0.text : nil }
                action.handler(strings)
            }))
        }
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func signInAlert(on vc: UIViewController,
                            completion: @escaping ([String]) -> Void) {
        
        var textFields: [(UITextField) -> ()] = []
        
        textFields.append { (textField) in
            textField.placeholder = "Username"
            textField.autocapitalizationType = .words
        }
        
        textFields.append { (textField) in
            textField.placeholder = "Password"
            textField.autocapitalizationType = .words
            textField.isSecureTextEntry = true
        }
        
        let actions: [AlertAction] = [
            AlertAction(title: "Cancel", style: .cancel, handler: { _ in completion([]) }),
            AlertAction(title: "Confirm", style: .default, handler: completion)
        ]
        
        self.showTextFieldAlert(on: vc, title: "Sign In", message: nil, textFields: textFields, actions: actions)
    }
}
