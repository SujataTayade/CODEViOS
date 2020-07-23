//
//  SideMenuTableViewController.swift
//  SideMenu
//
//  Created by Jon Kent on 4/5/16.
//  Copyright © 2016 CocoaPods. All rights reserved.
//

import SideMenu

class SideMenuTableViewController: UITableViewController {
    let words: [String] = ["Profile", "Home", "Login/Register", "Settings", "Applications", "Subscribe", "Rate this app", "Share this app", "Contact us", "Privacy policy", "Exit", "", "", ""]
    let allimages = ["Checked_Purple", "Checked_Black", "Checked_Blue", "Checked_Sand", "Checked_Green"]
    let allbtncolors = [UIColor.purple, UIColor.black, UIColor.blue, UIColor.brown, UIColor.green]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // refresh cell blur effect in case it changed
        tableView.reloadData()
        
        guard let menu = navigationController as? SideMenuNavigationController, menu.blurEffectStyle == nil else {
            return
        }
        
        // Set up a cool background image for demo purposes
//        let imageView = UIImageView(image: #imageLiteral(resourceName: "Checked_Black"))
//        imageView.contentMode = .scaleAspectFit
//        imageView.backgroundColor = UIColor.black.withAlphaComponent(1)
//        tableView.backgroundView = imageView
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.white
        //tableView.backgroundView?.backgroundColor = UIColor.white
//        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 37))
//        statusBarView.backgroundColor = UIColor.white
//        self.navigationController?.view.frame.size.height = 300
//        self.navigationController?.view.addSubview(statusBarView)
//        self.navigationController?.navigationBar.barTintColor = UIColor(named: "#4a5866")
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: ""), for: UIBarMetrics.default)
//           self.navigationController?.navigationBar.shadowImage = UIImage(named: "")
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(words.count)
        return words.count
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 200
        }
        return 60
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = super.tableView(tableView, cellForRowAt: indexPath) as! UITableViewVibrantCell
//
//
//        if let menu = navigationController as? SideMenuNavigationController {
//            cell.blurEffectStyle = menu.blurEffectStyle
//        }
        tableView.backgroundColor = UIColor.red
        tableView.alpha = 1
        if(indexPath.row == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: "sidemenuprofilecell", for: indexPath)
//            cell.imageView?.image = nil
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "sidemenucell", for: indexPath)
        cell.textLabel?.text = words[indexPath.row]
        cell.backgroundColor = UIColor.white
//        var imageView : UIImageView
//        imageView  = UIImageView(frame:CGRect(x: 0, y: 0, width: 20, height: 20));
//        imageView.image = UIImage(named: allimages[1])
//        self.view.addSubview(imageView)
//        cell.imageView?.image = imageView.image
        cell.separatorInset = .zero
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
        
    
}
