//
//  BaseViewController.swift
//  CODEViOS
//
//  Created by Sujata Tayade on 29/06/20.
//  Copyright © 2020 Sujata Tayade. All rights reserved.
//

import UIKit
import SideMenu

class BaseViewController: UIViewController, UIScrollViewDelegate {

    let pagingViewController = MultiPageViewController()
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.delegate = self
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    var viewControllers: [UIViewController] = [];
    
    //Bottom Buttons
    let allimages = ["Checked_Purple", "Checked_Black", "Checked_Blue", "Checked_Sand", "Checked_Green"]
    let allimagesbg = ["Checked_Purple", "Checked_Black", "Checked_Blue", "Checked_Sand", "Checked_Green"]
    let allbtnlabels = ["Purple","Black","Blue","Sand","Green"]
    let allbtncolors = [UIColor.purple, UIColor.black, UIColor.blue, UIColor.brown, UIColor.green]
    
    var btnCheckheight: NSInteger = 70
    var btnheight: NSInteger = 25
    var btnfontsize: NSInteger = 15
    var btnfontcolorselected: UIColor = UIColor.blue
    var btnfontcolor: UIColor = UIColor.black
    
    
    let mainPageView = UIView()
    
    let bottomMenuView = UIView()
    var selectedBtn = NSInteger()
    var prevSelectedBtn = NSInteger()
    var addconstant = Float()
    var hiddenv = NSInteger()
    
    
    func initScrollView() {
        scrollView.frame = CGRect(x: 0, y: 0, width: mainPageView.frame.width, height: mainPageView.frame.height - CGFloat(Int(self.view.frame.size.width) * 2))
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(viewControllers.count), height: mainPageView.frame.height - CGFloat(Int(self.view.frame.size.width) * 2))
        scrollView.isPagingEnabled = true
        scrollView.isDirectionalLockEnabled = true;
        scrollView.bounces = false
        for i in 0 ..< viewControllers.count {
            viewControllers[i].view.frame = CGRect(x: self.view.frame.width * CGFloat(i), y: 0, width: mainPageView.frame.width, height: scrollView.frame.size.height)
            scrollView.addSubview(viewControllers[i].view)
        }
    }
    private func setupPageControl() {
        pageControl.numberOfPages = viewControllers.count
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = UIColor.orange
        pageControl.pageIndicatorTintColor = UIColor.lightGray.withAlphaComponent(0.8)
        view.insertSubview(pageControl, at: 0)
        view.bringSubviewToFront(pageControl)
    }
    @IBAction func showBottomView(_ sender: Any) {
        if(bottomMenuView.center.y > view.frame.size.height){
            if(hiddenv != 1){
                hiddenv = 1
                print("showBottomView hiddenv = 1")
            }
        }
        if(hiddenv == 1){
           bottomMenuView.animShow()
           hiddenv = 0
        }
        
    }
    @IBAction func hideBottomView(_ sender: Any) {
        if(hiddenv != 1){
           bottomMenuView.animHide()
           hiddenv = 1
        }
    }
    
    func addnotiobservers(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.showBottomView(_:)), name:NSNotification.Name(rawValue: "showBottomViewNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.hideBottomView(_:)), name: NSNotification.Name(rawValue: "hideBottomViewNotification"), object: nil)
    }
    
    func addViewControllersToScroll() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let aViewController = storyboard.instantiateViewController(withIdentifier: "ViewController1") as! ViewController1;
        aViewController.view.backgroundColor = UIColor.systemGray5
        aViewController.addButtonBottom.constant = CGFloat(50 + btnCheckheight)
        
        let bViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2;
        //bViewController.view.backgroundColor = UIColor.black
        bViewController.tableTextColor = UIColor.black
        let cViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2;
        cViewController.tableTextColor = UIColor.systemBlue
        let dViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2;
        dViewController.tableTextColor = UIColor.brown
        let eViewController = storyboard.instantiateViewController(withIdentifier: "ViewController2") as! ViewController2;
        eViewController.tableTextColor = UIColor.green

        viewControllers = [aViewController, bViewController, cViewController, dViewController, eViewController]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let sideMenuNavigationController = segue.destination as? SideMenuNavigationController else { return }
        sideMenuNavigationController.settings = makeSettings()
    }
    private func selectedPresentationStyle() -> SideMenuPresentationStyle {
        let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
        return modes[0]
    }
    private func setupSideMenu() {
        // Define the menus
        SideMenuManager.default.leftMenuNavigationController = storyboard?.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as? SideMenuNavigationController
        //SideMenuManager.default.leftMenuNavigationController?.leftSide = false
        
        // Enable gestures. The left and/or right menus must be set up above for these to work.
        // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
        SideMenuManager.default.addPanGestureToPresent(toView: navigationController!.navigationBar)
        //SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: view, forMenu: SideMenuManager.PresentDirection.left)
        
    }
    private func makeSettings() -> SideMenuSettings {
        
        let presentationStyle = selectedPresentationStyle()
//        presentationStyle.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        presentationStyle.menuStartAlpha = 1
        presentationStyle.menuScaleFactor = 1
        presentationStyle.onTopShadowOpacity = 1
        presentationStyle.presentingEndAlpha = 1
        presentationStyle.presentingScaleFactor = 1

        var settings = SideMenuSettings()
        settings.presentationStyle = presentationStyle
        settings.menuWidth = min(view.frame.width, view.frame.height) * 0.7
        let styles:[UIBlurEffect.Style?] = [nil, .dark, .light, .extraLight]
        settings.blurEffectStyle = styles[3]
        settings.statusBarEndAlpha = 1
        return settings
    }
//    override func viewDidAppear(_ animated: Bool) {
//        hiddenv = 1
//    }
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnCheckheight = Int(self.view.frame.size.width)/6
        btnCheckheight = 69
        
        setupSideMenu()
        
        //let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame.height ?? 37))
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 37))
        statusBarView.backgroundColor = UIColor.systemGray5
        //self.navigationController?.view.frame.size.height = 300
        self.navigationController?.view.addSubview(statusBarView)
        // Do any additional setup after loading the view.
        
        //Add Notification observers
        addnotiobservers()
        
        //Add view controllers to scroll view
        addViewControllersToScroll()
        
        //Initialize scroll view
        initScrollView()
        
        //Setup page control
        self.setupPageControl()
        pageControl.numberOfPages = viewControllers.count
        pageControl.currentPage = 0
        view.bringSubviewToFront(pageControl)
        
        addconstant = 0
        selectedBtn = 1
        prevSelectedBtn = 0
        
        
        //Create Bottom button
        //bottomMenuView.frame = CGRect(x: 0, y: Int(self.view.frame.size.height), width: Int(self.view.frame.size.width), height: Int(self.view.frame.size.width)/6)
        bottomMenuView.frame = CGRect(x: 0, y: Int(self.view.frame.size.height), width: Int(self.view.frame.size.width), height: btnCheckheight)
        bottomMenuView.alpha = 1
        bottomMenuView.backgroundColor = UIColor.clear
        self.view.addSubview(bottomMenuView)
        
        let bottomSMenuView = UIView()
        bottomSMenuView.frame = CGRect(x: 0, y: 0, width: Int(bottomMenuView.frame.size.width), height: Int(bottomMenuView.frame.size.height))
        bottomSMenuView.alpha = 0.95
        bottomSMenuView.backgroundColor = UIColor.white
        bottomMenuView.addSubview(bottomSMenuView)
        
        
        createBottomMenuButtons()
        self.bottomMenuView.animShow()
        hiddenv = 0
        
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
        bottomSubMenuView.frame = CGRect(x: Int(addconstantx), y: 0, width: Int(bottomMenuView.frame.size.width)/6, height: self.btnCheckheight)
        bottomSubMenuView.backgroundColor = UIColor.clear
        bottomSubMenuView.alpha = 1
        bottomSubMenuView.center.y = bottomMenuView.frame.size.height/2
        bottomMenuView.addSubview(bottomSubMenuView)
        
        
        let eachmenub = UIButton()
        eachmenub.tag = btntag
        eachmenub.titleLabel?.font = UIFont(name: "GillSans-Italic", size: CGFloat(btnfontsize))
        //eachmenub.setTitle("B\(btntag)", for: .normal)
        eachmenub.setImage(UIImage(named: allimages[btntag-1]), for: .normal)
        bottomSubMenuView.backgroundColor = UIColor.clear
        eachmenub.setTitleColor(allbtncolors[btntag-1], for: .normal)
        eachmenub.frame = CGRect(x: 0, y: 0, width: self.btnheight, height:self.btnheight)
        eachmenub.imageView?.contentMode = .scaleAspectFit
        eachmenub.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        eachmenub.setTitle("", for: .normal)
        if(selectedBtn == btntag){
            addconstant = Float(Int(bottomMenuView.frame.size.width)/6)
            eachmenub.frame.size.height = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
            eachmenub.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3) * 0.8
            eachmenub.setTitle("\(self.allbtnlabels[btntag-1])", for: .normal)
            eachmenub.imageEdgeInsets = UIEdgeInsets(top: 15, left: 0, bottom: 15, right: 15)
            eachmenub.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
            eachmenub.layer.cornerRadius = eachmenub.frame.size.height
            eachmenub.layer.borderWidth = 1
            eachmenub.layer.borderColor = UIColor.clear.cgColor

        }

        eachmenub.center.y = bottomSubMenuView.frame.size.height/2
        eachmenub.center.x = bottomSubMenuView.frame.size.width/2
        //print(eachmenub.frame)
        
        for eachbview in self.bottomMenuView.subviews{
            for eachimg in eachbview.subviews{
                if eachimg is UIButton{
                    let assignimg = eachimg as! UIButton
                    //assignimg.backgroundColor = UIColor.clear
                    let imgselectedtag = assignimg.tag
                    
                    if(selectedBtn == imgselectedtag){
                        assignimg.setTitle("\(self.allbtnlabels[imgselectedtag-1])", for: .normal)
                        assignimg.imageEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 15)
                        assignimg.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
                        assignimg.layer.cornerRadius = assignimg.frame.size.height/2
                        assignimg.layer.borderWidth = 1
                        assignimg.layer.borderColor = UIColor.clear.cgColor
                        eachbview.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
                        
                        self.addconstant = Float(Int(self.bottomMenuView.frame.size.width)/6)
                        assignimg.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3) * 0.8
                        assignimg.frame.size.height = eachbview.frame.size.height * 0.7
                        eachimg.center.y = eachbview.frame.size.height/2
                        eachimg.center.x = eachbview.frame.size.width/2
//                        print(eachimg.frame)
                    }
                   
                }
            }
        }
        
        //eachmenub.center.y = bottomMenuView.center.y
        eachmenub.addTarget(self, action: #selector(BaseViewController.pressed(sender:)), for: .touchUpInside)
        bottomSubMenuView.addSubview(eachmenub)
        
        
    }

    @objc func pressed(sender: UIButton!) {
        //print("Pressed")
        selectedBtn = sender.tag
       // print(selectedBtn)
        if(prevSelectedBtn == selectedBtn){
            
        }
        else{
            prevSelectedBtn = selectedBtn
            eachwidthchange()
            UIView.animate(withDuration: 0.5) {
                self.scrollView.contentOffset.x = self.view.frame.width * CGFloat(self.selectedBtn-1)
            }
        }
        
    }
    func eachwidthchange(){
        var pretag = 0
        for eachbview in self.bottomMenuView.subviews{
            for eachimg in eachbview.subviews{
                if eachimg is UIButton{
                    let assignimg = eachimg as! UIButton
                    //assignimg.backgroundColor = UIColor.clear
                    assignimg.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                    let imgselectedtag = assignimg.tag
                    if Int(assignimg.frame.size.width) != Int(self.btnheight){
//                    if(assignimg.tag == selectedBtn){
                        pretag = assignimg.tag
                    }
                    assignimg.setImage(UIImage(named: allimages[imgselectedtag-1]), for: .normal)
                    assignimg.setTitleColor(allbtncolors[imgselectedtag-1], for: .normal)
                    if(selectedBtn == imgselectedtag){
                        assignimg.setImage(UIImage(named: allimagesbg[imgselectedtag-1]), for: .normal)
                        assignimg.setTitle("\(self.allbtnlabels[imgselectedtag-1])", for: .normal)
                       // assignimg.setTitleColor(self.btnfontcolorselected, for: .normal)
                        assignimg.imageEdgeInsets = UIEdgeInsets(top: 9, left: 0, bottom: 9, right: 15)
                        assignimg.backgroundColor = UIColor.yellow.withAlphaComponent(0.2)
                        assignimg.layer.cornerRadius = assignimg.frame.size.height
                        assignimg.layer.borderWidth = 1
                        assignimg.layer.borderColor = UIColor.clear.cgColor
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
                        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: .transitionFlipFromRight , animations: {
                            
                            eachbview.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3)
                            
                            self.addconstant = Float(Int(self.bottomMenuView.frame.size.width)/6)
                            assignimg.frame.size.width = CGFloat(Int(self.bottomMenuView.frame.size.width)/3) * 0.8
                            assignimg.setImage(UIImage(named: self.allimagesbg[imgselectedtag-1]), for: .normal)
                            //assignimg.setTitleColor(self.btnfontcolorselected, for: .normal)
                            assignimg.setTitleColor(self.allbtncolors[imgselectedtag-1], for: .normal)
                            //assignimg.setBackgroundImage(UIImage(named: self.allimagesbg[imgselectedtag-1]), for: .normal)  //uncomment
                            //assignimg.setTitle("Sujata\(imgselectedtag)", for: .normal)
                            //assignimg.setBackgroundImage(UIImage(named: "buttonbg"), for: .normal)
                            assignimg.frame.size.height = eachbview.frame.size.height * 0.7
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
                          //  print(eachimg.frame)
                            
                        })
                    }
                    else{
                        
                    }
                }
            }
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y > 0 || scrollView.contentOffset.y < 0 {
//                 scrollView.contentOffset.y = 0
//              }
        //UIView.setAnimationsEnabled(false)
//        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//        pageControl.currentPage = Int(pageIndex)
        
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        
        selectedBtn = Int(pageIndex) + 1
        
        if(prevSelectedBtn == selectedBtn){
            
        }
        else{
            prevSelectedBtn = selectedBtn
            pageControl.currentPage = Int(pageIndex)
            eachwidthchange()
        }
        
        
    }
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {

    }

}
extension UIView{
   
    func animShow(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.y -= self.bounds.height
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 0.5, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
    
    
}

//extension BaseViewController : UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
//            pageControl.currentPage = Int(pageIndex)
//            print("CurrentPage \(Int(pageIndex))")
//   
//
//        }
//    
//    open func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        if scrollView.isEqual(self.view) {
//            // Call didMoveToPage delegate function
//            //let currentController = viewControllers[1]
//            UIView.animate(withDuration: 0.6, animations: { () -> Void in
//                        let xOffset : CGFloat = self.scrollView.frame.width
//                        self.scrollView.setContentOffset(CGPoint(x: xOffset, y: self.scrollView.contentOffset.y), animated: false)
//                               })
//        }
//    }
//    
//    func scrollViewDidEndTapScrollingAnimation() {
//        // Call didMoveToPage delegate function
////        let currentController = controllerArray[currentPageIndex]
////        delegate?.didMoveToPage?(currentController, index: currentPageIndex)
////
////        // Remove all but current page after decelerating
////        for key in pagesAddedDictionary.keys {
////            if key != currentPageIndex {
////                removePageAtIndex(key)
////            }
////        }
////
////        startingPageForScroll = currentPageIndex
////        didTapMenuItemToScroll = false
////
////        // Empty out pages in dictionary
////        pagesAddedDictionary.removeAll(keepingCapacity: false)
//    }
//}
