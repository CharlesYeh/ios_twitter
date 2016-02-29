//
//  MenuViewController.swift
//  Twitter
//
//  Created by Charles Yeh on 2/25/16.
//  Copyright © 2016 Charles Yeh. All rights reserved.
//

import UIKit

struct MenuRow {
    let name: String
    let viewController: UIViewController
    let setup: () -> Void
}

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hamburgerViewController: HamburgerViewController!
    
    @IBOutlet weak var menuTableView: UITableView!
    var menus: [MenuRow]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuTableView.delegate = self
        menuTableView.dataSource = self
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        
        let profileVC = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        let timelineNC = storyboard.instantiateViewControllerWithIdentifier("TimelineNavController") as! UINavigationController
        let timelineVC = timelineNC.topViewController! as! TimelineViewController
        
        menus = [
            MenuRow(name: "Profile", viewController: profileVC, setup: {
                profileVC.user = TwitterClient.currentUser
            }),
            MenuRow(name: "Timeline", viewController: timelineNC, setup: {
                timelineVC.hamburgerViewController = self.hamburgerViewController
                timelineVC.endpoint = "home_timeline"
                timelineVC.loadData()
            }),
            MenuRow(name: "Mentions", viewController: timelineNC, setup: {
                timelineVC.hamburgerViewController = self.hamburgerViewController
                timelineVC.endpoint = "mentions_timeline"
                timelineVC.loadData()
            })
        ]
        
        showMenuItem(1)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let row = menus[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("menuCell") as! MenuTableViewCell
        cell.nameLabel.text = row.name
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return menus.count
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        showMenuItem(indexPath.row)
    }
    
    func showMenuItem(row: Int) {
        hamburgerViewController.closeMenu()

        menus[row].setup()
        hamburgerViewController.contentViewController = menus[row].viewController
        hamburgerViewController.contentViewController.view.frame = hamburgerViewController.contentView.bounds
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
