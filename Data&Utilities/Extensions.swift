//
//  Extensions.swift
//  RupeSoKeyboard
//
//  Created by Siva Mouniker on 07/07/23.
//

import UIKit

extension UIView {
    
    /** This helps to add VisualForamt Constraints by reducing Duplications in CODE*/
    func addConstraintsWithFormatString(formate: String, views: UIView...) {
        
        var viewsDictionary = [String: UIView]()
        
        for (index, view) in views.enumerated() {

            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }

        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: formate, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))

    }

}



