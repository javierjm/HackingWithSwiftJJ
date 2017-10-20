//
//  ViewController.swift
//  Project 15
//
//  Created by Javier Jara on 10/20/17.
//  Copyright © 2017 Roco Soft. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tapButton: UIButton!
    var imageView: UIImageView!
    var currentAnimation = 0 {
        didSet { self.animationLabel.text = "\(currentAnimation)/7" }
    }
    var animationName = "" {
        didSet { self.transformationNameLabel.text = animationName}
    }
    
    @IBOutlet weak var transformationNameLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageView = UIImageView(image: UIImage(named: "penguin"))
        imageView.center = CGPoint(x:512, y:384)
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapped(_ sender: Any) {
        tapButton.isHidden = true
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 5, options: [], animations: {
            [unowned self] in
            switch self.currentAnimation {
            case 0:
                self.imageView.transform = CGAffineTransform(scaleX:2, y:2)
                self.animationName = "Scale 2x"
                break
            case 1:
                self.imageView.transform = CGAffineTransform.identity
                self.animationName = "Identity"
            case 2:
                self.imageView.transform = CGAffineTransform(translationX: -256, y: -256)
                self.animationName = "Translation"
            case 3:
                self.imageView.transform = CGAffineTransform.identity
                self.animationName = "Identity"
            case 4:
                self.imageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
                self.animationName = "Rotate"
            case 5:
                self.imageView.transform = CGAffineTransform.identity
                self.animationName = "Identity"
            case 6:
                self.imageView.alpha = 0.1
                   self.imageView.backgroundColor = UIColor.green
                self.animationName = "Fade In"
            case 7:
                self.imageView.backgroundColor = UIColor.clear
                self.imageView.alpha = 1
                self.animationName = "Fade out"
            default:
                break
            }
            
            }) {[unowned self] (finished: Bool) in
                self.tapButton.isHidden = false
        }
        
        currentAnimation += 1
        
        if currentAnimation > 7 {
            currentAnimation = 0
        }
    }
    
}

