//
//  HamburgerViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/24/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var leftMarginConstraint: NSLayoutConstraint!
    var originalLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            view.layoutIfNeeded()
            
            let menuVC = menuViewController as! MenuViewController
            menuVC.hamburgerViewController = self
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet (oldViewController) {
            view.layoutIfNeeded()
            
            if oldViewController != nil {
                oldViewController.willMoveToParentViewController(nil)
                oldViewController.view.removeFromSuperview()
                oldViewController.didMoveToParentViewController(nil)
            }
            
            contentViewController.willMoveToParentViewController(self)
            contentView.addSubview(contentViewController.view)
            contentViewController.didMoveToParentViewController(self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func closeMenu() {
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.leftMarginConstraint.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onPanMenu(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        let velocity = sender.velocityInView(view)
        
        if sender.state == .Began {
            originalLeftMargin = leftMarginConstraint.constant
        } else if sender.state == .Changed {
            leftMarginConstraint.constant = max(originalLeftMargin + translation.x, 0)
        } else if sender.state == .Ended {
            if velocity.x > 0 {
                // open
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.leftMarginConstraint.constant =  self.view.frame.size.width - 50
                })
            } else {
                // close
                self.closeMenu()
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
