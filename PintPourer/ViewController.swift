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
    @IBOutlet private var pintsText: UIImageView!
    @IBOutlet private var pintsTop: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.7254901961, blue: 0.462745098, alpha: 1)
        
        /* Wait half a second. */
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            /* Animate Pints text from center into correct position. */
            self.animatePintsText()
            /* Move drink bars up to middle of the view. */
            self.animateBarsHeight(height: self.view.frame.height / 2, callback: nil)
        })
        
        /* After everything else is in place, fade in the button. */
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2, execute: {
            self.animateButton(show: true)
        })
    }
    
    /* Event handler for Pour button press. */
    @IBAction func pourButtonTapped(_ sender: Any) {
        /* TODO: Hit AWS Endpoint. */
        
        /* Run Pouring animation and then reset layout. */
        self.animateGrow(height: self.view.frame.height, showButton: false, delayButtonAnimation: true) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                self.resetLayout()
            })
        }
    }
    
    /* Reset layout after pouring animation. */
    func resetLayout() {
        self.animateGrow(height: self.view.frame.height / 2,
                         showButton: true,
                         delayButtonAnimation: true,
                         callback: nil)
        self.heightConstraint.constant = self.view.frame.height / 2
    }
    
    /* Pouring animation. */
    func animateGrow(height: CGFloat, showButton: Bool, delayButtonAnimation: Bool = false, callback: (() -> Void)?) {
        self.changePintsTextOpacity(show: showButton, delay: showButton)
        
        self.animateButton(show: showButton, delay: delayButtonAnimation)
        
        self.animatePouringText(show: !showButton)
        
        self.animateBarsHeight(height: height, callback: callback)
    }
    
    func changePintsTextOpacity(show: Bool, delay: Bool) {
        if delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.pintsText.alpha = show ? 1 : 0
                })
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.pintsText.alpha = show ? 1 : 0
            })
        }
    }
    
    func animatePintsText() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pintsTop.constant = self.view.frame.height / 20
        })
    }
    
    func animateButton(show: Bool, delay: Bool = false) {
        if show && delay {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.pourButton.alpha = show ? 1 : 0
                })
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.pourButton.alpha = show ? 1 : 0
            })
        }
    }
    
    func animatePouringText(show: Bool) {
        UIView.animate(withDuration: 0.3, delay: 0.3, options: .curveLinear, animations: {
            self.pouringText.alpha = show ? 1 : 0
        })
    }
    
    func animateBarsHeight(height: CGFloat, callback: (() -> Void)?) {
        UIView.animate(withDuration: 1, animations: { self.heightConstraint.constant = height
            self.view.layoutIfNeeded()
        }) { _ in
            callback?()
        }
    }
}
