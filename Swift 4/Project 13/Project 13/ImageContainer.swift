//
//  ImageContainer.swift
//  Project 13
//
//  Created by Javier Jara on 10/13/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import UIKit

@IBDesignable
class ImageContainer: UIView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}
