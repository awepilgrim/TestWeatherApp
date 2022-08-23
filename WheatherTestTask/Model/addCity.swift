//
//  addCity.swift
//  WheatherTestTask
//
//  Created by Олег Семёнов on 08.08.2022.
//

import UIKit

extension UIViewController {
    
    func alertPlusCity(name: String, placeholder: String, completion: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let alertOk = UIAlertAction(title: "ОК", style: .default) { action in
            
            let tftext = alertController.textFields?.first
            guard let text = tftext?.text else { return }
            completion(text)
        }
        
        alertController.addTextField { tf in
            tf.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Отмена", style: .default) { _ in }
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}
