//
//  ViewController.swift
//  Conway's Game of Life
//
//  Created by Ilija Tovilo on 26/08/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//


import UIKit
import GoogleMobileAds
class ViewController: UIViewController, UIScrollViewDelegate,GADBannerViewDelegate, GADInterstitialDelegate  {
    
    
    
    @IBOutlet
    var _scrollView: UIScrollView!
    let _gameView = CGOLView(gridWidth: 50, gridHeight: 50)
    var _timer: NSTimer?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(Utility.showOtherAd)
        {
            let myad = MyAd(root: self)
            myad.ViewDidload()
            
        }
        
        
        if(Utility.isAd2)
        {
            setupDidload()
        }

       
        
        _scrollView.addSubview(_gameView)
        _scrollView.contentSize = _gameView.bounds.size
        _scrollView.minimumZoomScale = min(
            _gameView.bounds.size.width / _scrollView.bounds.size.width,
            _gameView.bounds.size.height / _scrollView.bounds.size.height
        )
    }
    
    
    
    
    
    
    
    @IBAction func StartDrag(sender: AnyObject) {
        
        Utility.OpenView("AdView1",view: self)
    }
    
    
    @IBAction
    private func _startStop() {
        if let timer = _timer {
            timer.invalidate()
            _timer = nil
        } else {
            _timer = NSTimer.scheduledTimerWithTimeInterval(
                1.0 / 5,
                target: self,
                selector: "_update",
                userInfo: nil,
                repeats: true
            )
        }
    }
   

    private dynamic func _update() {
        _step()
    }
    
    @IBAction
    private func _step() {
        _gameView.step()
    }
    
    @IBAction
    private func _clear() {
        _gameView.clear()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return _gameView
    }
    
    
    ///=======================================================================================================
    //BEGIN FOR AD
    ///=======================================================================================================
    var timerVPN:NSTimer?
    var gBannerView: GADBannerView!
    func setupDidload()
    {
        
        
        ShowAdmobBanner()
        self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        
    }
    func ShowAdmobBanner()
    {
        
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        //let h = self.view.bounds.height
        //        if(!AdmobBannerTop)
        //        {
        //            AdmobLocationY = h - 50
        //        }
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = Utility.GBannerAdUnit
        print(Utility.GBannerAdUnit)
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        gBannerView?.viewWithTag(999)
        self.view?.addSubview(gBannerView)
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , Utility.AdmobTestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    func CanShowAd()->Bool
    {
        let abc = cclass()
        let VPN = abc.isVPNConnected()
        let Version = abc.platformNiceString()
        if(VPN == false && Version == "CDMA")
        {
            return false
        }
        
        
        return true
    }
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = CanShowAd()
        if(isAd && Utility.isStopAdmobAD)
        {
            
            ShowAdmobBanner()
            Utility.isStopAdmobAD = false
            print("Reopening Ad from admob......")
        }
        if(isAd == false && Utility.isStopAdmobAD == false)
        {
            gBannerView.removeFromSuperview()
            Utility.isStopAdmobAD = true;
            print("Stop showing Ad from admob......")
        }
        
        
    }
    
    ///=======================================================================================================
    //BEGIN FOR AD
    ///=======================================================================================================

}

