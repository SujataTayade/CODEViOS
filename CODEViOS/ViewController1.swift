//
//  ViewController1.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 30/06/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit

class ViewController1: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var nameTableView: UITableView!
    @IBOutlet weak var addButtonBottom: NSLayoutConstraint!
    @IBOutlet weak var addButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var superviewscroll: UIView!
    var lastKnowContentOfsset = CGFloat()
    
    
    
    let words: [String] = ["Test1", "Test2", "Test3", "Test4", "Test5", "Test1", "Test2", "Test3", "Test4", "Test5", "Test1", "Test2", "Test3", "Test4", "Test5", "Test1", "Test2", "Test3", "Test4", "Test5"]
    let allbtncolors = [UIColor.purple, UIColor.black, UIColor.blue, UIColor.brown, UIColor.green, UIColor.purple, UIColor.black, UIColor.blue, UIColor.brown, UIColor.green]
    

    
    @IBAction func addNewEntry(_ sender: Any) {
        print("AddNewEntry")
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(words.count)
        return allbtncolors.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath)
        
        //let word = words[indexPath.row]
        //let split = word.components(separatedBy: "::")
        
        for eachSupview in cell.contentView.subviews{
            for eachbview in eachSupview.subviews{
                let useView = eachbview
                if(useView.tag == 5){
                    useView.layer.cornerRadius = 10
//                    useView.layer.shadowPath = UIBezierPath(rect: useView.bounds).cgPath
                    useView.layer.shadowRadius = 5
                    useView.layer.shadowColor = UIColor.gray.cgColor
                    useView.layer.shadowOffset = .zero
                    useView.layer.shadowOpacity = 1
                    useView.backgroundColor = UIColor.systemGray6
//                    useView.backgroundColor = allbtncolors[indexPath.row]
//                    useView.alpha = 0.4
//                    useView.frame.size.height = eachSupview.frame.size.height * 0.5
//                    useView.frame.size.width = eachSupview.frame.size.width * 0.5
                    for eachlabel in eachbview.subviews{
                        if eachlabel is UILabel{
                            let useLabel = eachlabel as! UILabel
                            useLabel.text = "\(indexPath.row)"
                            useLabel.textColor = allbtncolors[indexPath.row]
                        }
                    }
                }
            }
        }
        //print(split[0])
        
//        cell.textLabel?.text = "\(indexPath.row) \(split[0])"
//        cell.textLabel?.textColor = UIColor.white
//        cell.textLabel?.tintColor = UIColor.white
//        cell.tintColor = UIColor.white
//        cell.contentView.tintColor = UIColor.white
//        cell.detailTextLabel?.text = ""
        
//        print(cell)
        return cell
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == nameTableView {
            let contentOffset = scrollView.contentOffset.y
            //print("Table contentOffset: ", contentOffset)
            if(contentOffset <= 0){
                NotificationCenter.default.post(name: Notification.Name("showBottomViewNotification"), object: nil)
               // print("scrolling Up")
            }
            else if (contentOffset > self.lastKnowContentOfsset) {
                NotificationCenter.default.post(name: Notification.Name("hideBottomViewNotification"), object: nil)
               // print("scrolling Down")
               // print("dragging Up")
            } else {
                NotificationCenter.default.post(name: Notification.Name("showBottomViewNotification"), object: nil)
               // print("scrolling Up")
                //print("dragging Down")
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView == nameTableView {
            self.lastKnowContentOfsset = scrollView.contentOffset.y
            //print("Table lastKnowContentOfsset: ", scrollView.contentOffset.y)
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print(" viewDidAppear ViewController1")
        NotificationCenter.default.post(name: Notification.Name("showBottomViewNotification"), object: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        print(" viewWillAppear ViewController1")
        NotificationCenter.default.post(name: Notification.Name("showBottomViewNotification"), object: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        lastKnowContentOfsset = 0
        nameTableView.isScrollEnabled = true
        nameTableView.bounces = true
        nameTableView.isDirectionalLockEnabled = true
        // Do any additional setup after loading the view.
        createScrollView()
        //print(" viewDidLoad ViewController1")
    }
    func createScrollView(){
          //Remove view if already present
          for view in superviewscroll.subviews {
             // if view is UIView{
                 view.removeFromSuperview()
                  break;
             // }
          }
        //superviewscroll.backgroundColor = UIColor.red
        //Create Scroll View Vertical
        var scView:UIScrollView!
        scView = UIScrollView(frame: CGRect(x: 0, y: 5, width: view.bounds.width, height: superviewscroll.frame.size.height - 10))
        scView.showsHorizontalScrollIndicator = false;
        //scView.center.y = superviewscroll.center.y
        scView.showsVerticalScrollIndicator = true
        //scView.backgroundColor = UIColor.white
        scView.translatesAutoresizingMaskIntoConstraints = false //#112b36 //17, 40, 54
        //scView.backgroundColor = UIColor(red: 17, green: 40, blue: 54)
       
        
        var useheight = CGFloat()
        var usewidth  = CGFloat()
        
        useheight = scView.frame.size.height
        usewidth  = 180

        var xOffset:CGFloat = 10
        //let yOffset:CGFloat = 10
       
       for i in 0 ... self.allbtncolors.count-1 {
            var shadowView = UIView()
            shadowView = UIView(frame: CGRect(x: xOffset, y: 0, width: usewidth, height: useheight))
            //shadowView.backgroundColor = UIColor(hue: CGFloat(arc4random_uniform(100)) / 100, saturation: 1, brightness: 1, alpha: 1)
            shadowView.center.y = useheight / 2
            shadowView.tag = i + 1
            let innerView = UIView(frame: CGRect(x: 0, y: 0, width: shadowView.frame.width - 5, height: shadowView.frame.height - 5))
            innerView.backgroundColor = UIColor(hue: CGFloat(arc4random_uniform(100)) / 100,
                                                saturation: 1, brightness: 0.8, alpha: 1)
            //innerView.backgroundColor = UIColor(patternImage: UIImage(named: "cubeskin")!)
            innerView.layer.cornerRadius = 11
            innerView.center = CGPoint(x: shadowView.frame.size.width/2, y: shadowView.frame.size.height/2)
            shadowView.addSubview(innerView)
        
            scView.addSubview(shadowView)
            xOffset = xOffset + shadowView.frame.size.width + 10
        }
        scView.contentSize = CGSize(width: xOffset, height: scView.frame.height)
        superviewscroll.addSubview(scView)
       
    }
    
     func createEachView(usewidth: CGFloat, useheight: CGFloat) -> (UIView){
            var shadowView = UIView()
            shadowView = UIView(frame: CGRect(x: 0, y: 0, width: usewidth, height: useheight))
            shadowView.backgroundColor = UIColor.yellow
            shadowView.layer.shadowColor = UIColor.black.cgColor
            shadowView.layer.shadowOffset = CGSize.zero
            shadowView.layer.shadowOpacity = 0.5
            shadowView.layer.shadowRadius = 5
            shadowView.layer.cornerRadius = 5
   
            let innerView = UIView(frame: CGRect(x: 0, y: 0, width: shadowView.frame.width - 5, height: shadowView.frame.height - 5))
            innerView.backgroundColor = UIColor(hue: CGFloat(arc4random_uniform(100)) / 100,
            saturation: 1, brightness: 1, alpha: 1)
            //innerView.backgroundColor = UIColor(patternImage: UIImage(named: "cubeskin")!)
            innerView.layer.cornerRadius = 5
            innerView.center = CGPoint(x: shadowView.frame.size.width/2, y: shadowView.frame.size.height/2)
            shadowView.addSubview(innerView)
       
            return shadowView
           
    }
       

}
