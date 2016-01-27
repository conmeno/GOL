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
    
    
    
    
 
    
    
    ////////////////////////////
    let data = Data()
    //@IBOutlet weak var topView: UIView!
    
    // var timerAd:NSTimer?
    var AdNumber = 0
    
    var gBannerView: GADBannerView!
    //    var startAppBanner: STABannerView?
    //    var startAppAd: STAStartAppAd?
    
    var timerVPN:NSTimer?
    
    var isStopAD = true
    
    //@IBOutlet weak var textDevice: UITextView!
    
    var interstitial: GADInterstitial!
    //var mmFULL:MMInterstitialAd!
    
    //new funciton
   // @IBOutlet weak var AdOption: UIView!
   // @IBOutlet weak var AdmobCheck: UISwitch!
    //@IBOutlet weak var AmazonCheck: UISwitch!
    //@IBOutlet weak var ChartboostCheck: UISwitch!
    
    var isAdmob = true;
    var isChart = false
    
    var isShowFullAdmob = false
    //var isShowFllAmazon = false
    var isShowChartboostFirst = false
    var timerAdmobFull:NSTimer?
    ///////////////////////////////////
    
    
    
    
    
    
    @IBOutlet
    var _scrollView: UIScrollView!
    let _gameView = CGOLView(gridWidth: 50, gridHeight: 50)
    var _timer: NSTimer?
    
    //////////////////////////////////////////////
    //////////////////////////////////////////////
    //EDIT
    //////////////////////////////////////////////
    //////////////////////////////////////////////
    
    
    
                            
    override func viewDidLoad() {
        super.viewDidLoad()
        //CheckAdOptionValue()
        if(showAd())
        {
            ShowAdmobBanner()
             isStopAD = false
            
           self.interstitial = self.createAndLoadAd()
            showAdmob()
           //Chartboost.showInterstitial("First stage")
            
        }
        //self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
        
        //self.timerAdmobFull = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: "timerAdmobFull:", userInfo: nil, repeats: true)

        
        
        //AdOption.hidden = true
        //topView.hidden = true
        
        
       
        
        _scrollView.addSubview(_gameView)
        _scrollView.contentSize = _gameView.bounds.size
        _scrollView.minimumZoomScale = min(
            _gameView.bounds.size.width / _scrollView.bounds.size.width,
            _gameView.bounds.size.height / _scrollView.bounds.size.height
        )
    }
    
    func timerVPNMethodAutoAd(timer:NSTimer) {
        print("VPN Checking....")
        let isAd = showAd()
        if(isAd && isStopAD)
        {
            
            ShowAdmobBanner()
            isStopAD = false
            print("Reopening Ad from admob......")
        }
        
        if(isAd == false && isStopAD == false)
        {
            gBannerView.removeFromSuperview()
            isStopAD = true;
            print("Stop showing Ad from admob......")
        }
    }
//    
    func timerAdmobFull(timer:NSTimer) {
        //var isShowFullAdmob = false
        //var isShowFllAmazon = false
        //var isShowChartboostFirst = false
        if(showAd())
        {
            
            showAd()
        }
        
                
            
        
    }
    
    
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: data.gFull)
        //ad.delegate = self
        let request = GADRequest()
        
        request.testDevices = [kGADSimulatorID, data.TestDeviceID]
        
        ad.loadRequest(request)
        
        return ad
    }
    func showAdmob()
    {
        if (self.interstitial.isReady)
        {
            self.interstitial.presentFromRootViewController(self)
            self.interstitial = self.createAndLoadAd()
        }
    }
    func ShowAdmobBanner()
    {
        let w = view?.bounds.width
       // let h = view?.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w!, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view.addSubview(gBannerView)
        //self.view.addSubview(bannerView!)
        //adViewHeight = bannerView!.frame.size.height
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        gBannerView?.hidden = true
        
    }
    
    func showAd()->Bool
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
    
    
    
    func showAds()
    {
        
        Chartboost.showInterstitial("Home" + String(AdNumber))
        
        AdNumber++
        
        if(AdNumber > 7)
        {
            //adView.backgroundColor = UIColor.redColor()
        }
        print(AdNumber)
    }
    func timerMethodAutoAd(timer:NSTimer) {
        print("auto play")
        // adView.backgroundColor = UIColor.redColor()
        
        showAds()
        
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
}

