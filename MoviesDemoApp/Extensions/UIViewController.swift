//
//  UIViewController.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation
import UIKit

extension UIViewController {
    
    func enableKeyboardDismissingWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    static func instantiateViewControllerFromStoryboard(storyboardName: String, storyboardId: String)-> UIViewController? {
        let storyBoard = UIStoryboard(name: storyboardName, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: storyboardId)
        return viewController
    }
    
    
    @objc func dismissKeyboard(){
        view.endEditing(true)
    }
}
