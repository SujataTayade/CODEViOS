//
//  ViewController.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 28/06/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let allimages = ["Checked_Purple", "Checked_Black", "Checked_Blue", "Checked_Sand", "Checked_Green"]
        let allimagesbg = ["buttonbgPurple","buttonbgBack","buttonbgBlue","buttonbgSand","buttonbgGreen"]
        
        let bottomMenuView = UIView()
        let mainPageView = UIView()
        var addconstant = Float()
        var selectedBtn = NSInteger()
        var hiddenv = NSInteger()
        var btnheight: NSInteger = 25
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            
            //Create Bottom button
           addconstant = 0
           selectedBtn = 1
           bottomMenuView.frame = CGRect(x: 0, y: Int(self.view.frame.size.height), width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.width)/6)
           bottomMenuView.alpha = 1
           bottomMenuView.backgroundColor = UIColor.systemGray5
           self.view.addSubview(bottomMenuView)
           createBottomMenuButtons()
           self.bottomMenuView.animShow()
            hiddenv = 0
           // self.bottomMenuView.center.y -= self.bottomMenuView.bounds.height
            
        }
        func createBottomMenuButtons(){
            for i in 0...allimages.count-1{
                createEachBottomMenuButton(btntag: i+1, imgname: allimages[i] as NSString)
            }
            addconstant = 0
        }
        func createEachBottomMenuButton(btntag: NSInteger, imgname: NSString){
            let bottomSubMenuView = UIView()
            var addconstantx = Float()
            addconstantx = Float((btntag-1) * Int(bottomMenuView.frame.size.width)/6)
            addconstantx += addconstant
            bottomSubMenuView.frame = CGRect(x: Int(addconstantx), y: 0, width: Int(bottomMenuView.frame.size.width)/6, height: Int(bottomMenuView.frame.size.width)/6)
            bottomSubMenuView.backgroundColor = UIColor.black
            bottomSubMenuView.alpha = 1
            bottomSubMenuView.center.y = bottomMenuView.frame.size.height/2
            bottomMenuView.addSubview(bottomSubMenuView)
            
            
            let eachmenub = UIButton()
            eachmenub.tag = btntag
            eachmenub.titleLabel?.font = UIFont(name: "GillSans-Italic", size: 13)
            //eachmenub.setTitle("B\(btntag)", for: .normal)
            eachmenub.setImage(UIImage(named: allimages[btntag-1]), for: .normal)
            bottomSubMenuView.backgroundColor = UIColor.white
            eachmenub.setTitleColor(UIColor.blue, for: .normal)
            eachmenub.frame = CGRect(x: 0, y: 0, width: self.btnheight, height:self.btnheight)
            eachmenub.imageView?.contentMode = .scaleAspectFit
            if(selectedBtn == btntag){
                bottomSubMenuView.frame.size.width = CGFloat(Int(bottomMenuView.frame.size.width)/6 * 2)
                addconstant = Float(Int(bottomMenuView.frame.size.width)/6)
                eachmenub.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
                //eachmenub.setBackgroundImage(UIImage(named: "buttonbg"), for: .normal)
                //eachmenub.setBackgroundImage(UIImage(named: allimagesbg[btntag-1]), for: .normal) //uncomment
                eachmenub.setTitle("Sujata\(btntag)", for: .normal)
            }
            else{
                eachmenub.setTitle("", for: .normal)
            }
    //        if btntag%2 == 0{
    //            bottomSubMenuView.backgroundColor = UIColor.systemGray5
    //        }
    //        else{
    //            bottomSubMenuView.backgroundColor = UIColor.systemGray4
    //        }
            eachmenub.center.y = bottomSubMenuView.frame.size.height/2
            eachmenub.center.x = bottomSubMenuView.frame.size.width/2
            //eachmenub.center.y = bottomMenuView.center.y
            eachmenub.addTarget(self, action: #selector(BaseViewController.pressed(sender:)), for: .touchUpInside)
            bottomSubMenuView.addSubview(eachmenub)
            
            
        }

        @objc func pressed(sender: UIButton!) {
            //print("Pressed")
            selectedBtn = sender.tag
            print(selectedBtn)
            eachwidthchange()
        }
        func eachwidthchange(){
            var pretag = 0
            for eachbview in self.bottomMenuView.subviews{
                for eachimg in eachbview.subviews{
                    if eachimg is UIButton{
                        let assignimg = eachimg as! UIButton
                        let imgselectedtag = assignimg.tag
                        if Int(assignimg.frame.size.width) != Int(self.btnheight){
    //                    if(assignimg.tag == selectedBtn){
                            pretag = assignimg.tag
                        }
                        if pretag != 0{
                            assignimg.frame = CGRect(x: 0, y: 0, width: self.btnheight, height:self.btnheight)
                            assignimg.center.y = eachbview.frame.size.height/2
                            assignimg.center.x = eachbview.frame.size.width/2
                            assignimg.imageView?.contentMode = .scaleAspectFit
                            assignimg.setImage(UIImage(named: allimages[imgselectedtag-1]), for: .normal)
                        }
                    }
                }
            }
           // Width set to normal
           for eachbview in bottomMenuView.subviews{
                for eachimg in eachbview.subviews{
                    if eachimg is UIButton{
                        let assignimg = eachimg as! UIButton
                        //assignimg.image = UIImage(named: allimages[i])
                        let imgselectedtag = assignimg.tag
                        assignimg.setImage(UIImage(named: allimages[imgselectedtag-1]), for: .normal)
                        eachimg.frame = CGRect(x: 0, y: 0, width: self.btnheight, height:self.btnheight)
                        eachimg.center.y = eachbview.frame.size.height/2
                        eachimg.center.x = eachbview.frame.size.width/2
                        if(selectedBtn == imgselectedtag){
                            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [], animations: {
                                
                                eachbview.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
                                
                                self.addconstant = Float(Int(self.bottomMenuView.frame.size.width)/6)
                                assignimg.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
                                //assignimg.setBackgroundImage(UIImage(named: self.allimagesbg[imgselectedtag-1]), for: .normal)  //uncomment
                                assignimg.setTitle("Sujata\(imgselectedtag)", for: .normal)
                                //assignimg.setBackgroundImage(UIImage(named: "buttonbg"), for: .normal)
                                eachimg.center.y = eachbview.frame.size.height/2
                                eachimg.center.x = eachbview.frame.size.width/2
                                
                                var x = 1
                                var xconstant = 0.0
                                for eachbviewx in self.bottomMenuView.subviews{
                                    for eachimgx in eachbviewx.subviews{
                                        let assignimgx = eachimgx as! UIButton
                                        var addconstantx = Float()
                                        addconstantx = Float((x-1) * Int(self.bottomMenuView.frame.size.width)/6)
                                        addconstantx += Float(xconstant)
                                        eachbviewx.frame.origin.x = CGFloat(addconstantx)
                                        if(imgselectedtag == x){
                                            xconstant = Double(self.bottomMenuView.frame.size.width/6)
                                        }
                                        else{
                                            if(eachimgx.tag == pretag){
                                                eachbviewx.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/6) //remove 10 after test
                                                eachimgx.center.x = eachbviewx.frame.size.width/2 //eachbviewx.center.x
                                            }
                                            else{
                                               assignimgx.setTitle("", for: .normal)
                                            }
                                        }
                                        x += 1
                                    }
                                }
                                
                                self.view.layoutIfNeeded()
                            },completion: { finished in
                                
                            })
                        }
                        else{
                            
                        }
                    }
                }
            }
        }
        
    }
