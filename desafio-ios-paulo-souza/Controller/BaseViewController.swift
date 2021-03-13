//
//  BaseViewController.swift
//  desafio-ios-paulo-souza
//
//  Created by Paulo Alfredo Coraini de Souza on 12/03/21.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func alert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
}
