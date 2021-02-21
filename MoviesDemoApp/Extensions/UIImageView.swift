//
//  UIImageView.swift
//  MoviesDemoApp
//
//  Created by OBSS_Mutluhan Boz  on 18.02.2021.
//

import Foundation
import UIKit

typealias optionalVoidClosure = (() -> ())?

extension UIImageView {
    func loadRemoteImage(from url: URL, completion: optionalVoidClosure = nil) {

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                    completion?()
                }
            }
           
        }
    }

    

}
