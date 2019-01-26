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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set background colour: self.view.backgroundColor = Color Literal
        self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7254901961, blue: 0.462745098, alpha: 1)
    }

    // function for when Pour button is pressed
    @IBAction func pourButtonTapped(_ sender: Any) {
        
        // tell raspberry pi to pour pint
        
        // animation of app screen
        animateGrow()
        
        // make the button unresponsive for a period of time so that clicking won't trigger an action
        
    }
    
    func animateGrow() {
        UIView.animate(withDuration: 1) {
            self.heightConstraint.constant = self.view.frame.height
            self.view.layoutIfNeeded()
        }
    }
}

