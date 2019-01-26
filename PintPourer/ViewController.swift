//
//  ViewController.swift
//  PintPourer
//
//  Created by Aishwarya Pattar on 26/01/2019.
//  Copyright © 2019 Aishwarya Pattar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private var heightConstraint: NSLayoutConstraint!
    @IBOutlet private var pourButton: UIButton!
    @IBOutlet private var pouringText: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background colour: self.view.backgroundColor = Color Literal
        self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7254901961, blue: 0.462745098, alpha: 1)
        
        self.resetLayout()
    }
    
    // function for when Pour button is pressed
    @IBAction func pourButtonTapped(_ sender: Any) {
        
        // tell raspberry pi to pour pint
        
        
        
        
        
        // animation of app screen and resets back to original
        self.animateGrow(height: self.view.frame.height, showButton: false) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.resetLayout()
            })
        }
    }
    
    // this function can be used to reset
    func initialiseApp() {
        self.pouringText.alpha = 0
        self.resetLayout()
    }
    
    func resetLayout() {
        self.animateGrow(height: self.view.frame.height / 2,
                         showButton: true,
                         callback: nil)
        // rectangles height initialised to half the length of the screen
        self.heightConstraint.constant = self.view.frame.height / 2
    }
    
    func animateGrow(height: CGFloat, showButton: Bool, callback: (() -> Void)?) {
        UIView.animate(withDuration: 0.3, animations: {
            self.pourButton.alpha = showButton ? 1 : 0
        })
        
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: {
            self.pouringText.alpha = showButton ? 0 : 1
        })
        
        UIView.animate(withDuration: 1, animations: { self.heightConstraint.constant = height
            self.view.layoutIfNeeded()
        }) { _ in
            callback?()
        }
    }
}


// Things to change:
// 1. Don't like the animation at the start when the app loads
// 2. make the button only appear once the froth is back to its initial position. otherwise you can click the button as soon as it appears and it doesn't have opportunity to return
// 3. Change the wait time so it corresponds with how much time it takes to pour a beer
// 4. Pouring is not centred. it's not constrained so looks shit on iPhone 5S
