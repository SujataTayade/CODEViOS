//
//  ViewController2.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 30/06/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var nameTableView: UITableView!
    var lastKnowContentOfsset = CGFloat()
    var tableTextColor: UIColor!
    
    let words: [String] = ["Check1", "Check2", "Check3", "Check4", "Check5", "Check1", "Check2", "Check3", "Check4", "Check5", "Check1", "Check2", "Check3", "Check4", "Check5", "Check1", "Check2", "Check3", "Check4", "Check5"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return words.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        
        let word = words[indexPath.row]
        let split = word.components(separatedBy: "::")
        
        //print(split[0])
        
        cell.textLabel?.text = split[0]
        cell.textLabel?.textColor = tableTextColor
//        do {
//            cell.textLabel?.textColor = tableTextColor
//        }
//        catch{
//            cell.textLabel?.textColor = UIColor.systemGray2
//        }
        
//        cell.textLabel?.tintColor = UIColor.white
//        cell.tintColor = UIColor.white
        cell.detailTextLabel?.text = ""
        
//        print(cell)
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == nameTableView {
            let contentOffset = scrollView.contentOffset.y
           // print("contentOffset: ", contentOffset)
            if (contentOffset > self.lastKnowContentOfsset) {
                NotificationCenter.default.post(name: Notification.Name("hideBottomViewNotification"), object: nil)
                //print("scrolling Down")
               // print("dragging Up")
            } else {
                NotificationCenter.default.post(name: Notification.Name("showBottomViewNotification"), object: nil)
                //print("scrolling Up")
                //print("dragging Down")
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == nameTableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y
//            print("lastKnowContentOfsset: ", scrollView.contentOffset.y)
        }
    }
      
    override func viewDidAppear(_ animated: Bool) {
//        print(" viewDidAppear ViewController2")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lastKnowContentOfsset = 0
        nameTableView.isScrollEnabled = true
        nameTableView.bounces = false
        nameTableView.isDirectionalLockEnabled = true
        // Do any additional setup after loading the view.
//        print(" viewDidLoad ViewController2")
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
