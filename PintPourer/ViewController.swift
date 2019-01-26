//
//  ViewController.swift
//  PintPourer
//
//  Created by Aishwarya Pattar on 26/01/2019.
//  Copyright © 2019 Aishwarya Pattar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
   
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pourButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background colour: self.view.backgroundColor = Color Literal
        self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7254901961, blue: 0.462745098, alpha: 1)
        
        initialiseApp()
    }

    // function for when Pour button is pressed
    @IBAction func pourButtonTapped(_ sender: Any) {
        
        // tell raspberry pi to pour pint
        
        // animation of app screen and resets back to original
        animateGrow(height: self.view.frame.height) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.initialiseApp()
            })
        }
    }
    
    
    // this function can be used to reset
    func initialiseApp() {
        
        animateGrow(height: self.view.frame.height / 2, callback: nil)
        //rectangles height initialised to half the length of the screen
        self.heightConstraint.constant = self.view.frame.height/2
        
        // initialise position of button
        
        
    }
    
    func animateGrow(height: CGFloat, callback: (() -> Void)?) {
        UIView.animate(withDuration: 1, animations: {
            self.heightConstraint.constant = height
            self.view.layoutIfNeeded()
        }) { _ in
            callback?()
        }
    }
}

