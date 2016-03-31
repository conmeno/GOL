//
//  ViewController.swift
//  Conway's Game of Life
//
//  Created by Ilija Tovilo on 26/08/14.
//  Copyright (c) 2014 Ilija Tovilo. All rights reserved.
//


import UIKit
import GoogleMobileAds
class ViewController: UIViewController, UIScrollViewDelegate,GADBannerViewDelegate, GADInterstitialDelegate,AmazonAdInterstitialDelegate,AmazonAdViewDelegate  {
    
    
    
    @IBOutlet
    var _scrollView: UIScrollView!
    let _gameView = CGOLView(gridWidth: 50, gridHeight: 50)
    var _timer: NSTimer?
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
      setupAD()
        
        _scrollView.addSubview(_gameView)
        _scrollView.contentSize = _gameView.bounds.size
        _scrollView.minimumZoomScale = min(
            _gameView.bounds.size.width / _scrollView.bounds.size.width,
            _gameView.bounds.size.height / _scrollView.bounds.size.height
        )
    }
    
    @IBAction func StartDrag(sender: AnyObject) {
        
        let storyboard = UIStoryboard(name: "StoryboardAD", bundle: nil)
        
        let WebDetailView = storyboard.instantiateViewControllerWithIdentifier("AdView1") as UIViewController
        
        self.presentViewController(WebDetailView, animated: true, completion: nil)

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
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    
    
    var isStopAD = true
    var gBannerView: GADBannerView!
    var interstitial: GADInterstitial!
    var timerVPN:NSTimer?
    var timerAmazon:NSTimer?
    var interstitialAmazon: AmazonAdInterstitial!
    var isAd1 = false//admob full
    var isAd2 = true//admob Banner
    var isAd3 = false//amazon
    var isAd4 = false//adcolony
    var isAd5 = false//startapp
    var amazonLocationY:CGFloat = 20.0
        var timerAdColony:NSTimer?
    let data = Data()
    func setupAD()
    {
        CheckAdOptionValue()
        if(showAd())
        {
            if(isAd1)
            {
                self.interstitial = self.createAndLoadAd()
                showAdmob()
            }
            if(isAd2)
            {
                ShowAdmobBanner()
                self.timerVPN = NSTimer.scheduledTimerWithTimeInterval(20, target: self, selector: "timerVPNMethodAutoAd:", userInfo: nil, repeats: true)
            }
                    
            if(isAd3)
            {
                amazonLocationY = self.view.bounds.height - 50
                
                interstitialAmazon = AmazonAdInterstitial()
                interstitialAmazon.delegate = self
                
                loadAmazonFull()
                showAmazonFull()
            }else
            {
                amazonLocationY = self.view.bounds.height
            }
            
            if(isAd4)
            {
                showAdcolony()
                self.timerAdColony = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerAdColony:", userInfo: nil, repeats: true)
            }

            
            
            showAmazonBanner()
            self.timerAmazon = NSTimer.scheduledTimerWithTimeInterval(30, target: self, selector: "timerMethodAutoAmazon:", userInfo: nil, repeats: true)
            
        }
    }
    
    func showAdcolony()
    {
        AdColony.playVideoAdForZone(data.AdcolonyZoneID, withDelegate: nil)
    }
    func timerAdColony(timer:NSTimer) {
        
        if(showAd())
        {
            showAdcolony()
        }
    }

    func ShowAdmobBanner()
    {
        //let viewController = appDelegate1.window!.rootViewController as! GameViewController
        let w = self.view.bounds.width
        //let h = viewController.view.bounds.height
        gBannerView = GADBannerView(frame: CGRectMake(0, 20 , w, 50))
        gBannerView?.adUnitID = data.gBanner
        gBannerView?.delegate = self
        gBannerView?.rootViewController = self
        self.view?.addSubview(gBannerView)
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID , data.TestDeviceID];
        gBannerView?.loadRequest(request)
        //gBannerView?.hidden = true
        
    }
    

    
    
    func createAndLoadAd() -> GADInterstitial
    {
        let ad = GADInterstitial(adUnitID: data.gFull)
        
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
    
    
 
    
    func buttonAction(sender:UIButton!)
    {
        print("New game")
        
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
    
    func CheckAdOptionValue()
    {
        //ad1 admob
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad1") != nil)
        {
            isAd1 = NSUserDefaults.standardUserDefaults().objectForKey("ad1") as! Bool
            
        }
        
        //ad2 charboost
        
                if(NSUserDefaults.standardUserDefaults().objectForKey("ad2") != nil)
                {
                    isAd2 = NSUserDefaults.standardUserDefaults().objectForKey("ad2") as! Bool
        
                }
        
        
       // ad3 ...
        
                if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
                {
                    isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
        
                }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
                if(NSUserDefaults.standardUserDefaults().objectForKey("ad5") != nil)
                {
                    isAd5 = NSUserDefaults.standardUserDefaults().objectForKey("ad5") as! Bool
        
                }
        
   
        
        
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
    
    
    
    
    
    
    //GADBannerViewDelegate
    func adViewDidReceiveAd(view: GADBannerView!) {
        print("adViewDidReceiveAd:\(view)");
        
        //relayoutViews()
    }
    
    func adView(view: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("\(view) error:\(error)")
        
        //relayoutViews()
    }
    
    func adViewWillPresentScreen(adView: GADBannerView!) {
        print("adViewWillPresentScreen:\(adView)")
        
        //relayoutViews()
    }
    
    func adViewWillLeaveApplication(adView: GADBannerView!) {
        print("adViewWillLeaveApplication:\(adView)")
    }
    
    func adViewWillDismissScreen(adView: GADBannerView!) {
        print("adViewWillDismissScreen:\(adView)")
        
        // relayoutViews()
    }
    
    
    
    
    //amazon
    ///////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////
    @IBOutlet var amazonAdView: AmazonAdView!
    func showAmazonBanner()
    {
        amazonAdView = AmazonAdView(adSize: AmazonAdSize_320x50)
        loadAmazonAdWithUserInterfaceIdiom(UIDevice.currentDevice().userInterfaceIdiom, interfaceOrientation: UIApplication.sharedApplication().statusBarOrientation)
        amazonAdView.delegate = nil
        self.view.addSubview(amazonAdView)
    }
    
    
    func loadAmazonAdWithUserInterfaceIdiom(userInterfaceIdiom: UIUserInterfaceIdiom, interfaceOrientation: UIInterfaceOrientation) -> Void {
        
        let options = AmazonAdOptions()
        options.isTestRequest = false
        let x = (self.view.bounds.width - 320)/2
        //viewController.view.bounds.height - 50
        if (userInterfaceIdiom == UIUserInterfaceIdiom.Phone) {
            amazonAdView.frame = CGRectMake(x, amazonLocationY, 320, 50)
        } else {
            amazonAdView.removeFromSuperview()
            
            if (interfaceOrientation == UIInterfaceOrientation.Portrait) {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_728x90)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-728.0)/2.0, amazonLocationY, 728.0, 90.0)
            } else {
                amazonAdView = AmazonAdView(adSize: AmazonAdSize_1024x50)
                amazonAdView.frame = CGRectMake((self.view.bounds.width-1024.0)/2.0, amazonLocationY, 1024.0, 50.0)
            }
            self.view.addSubview(amazonAdView)
            amazonAdView.delegate = nil
        }
        
        amazonAdView.loadAd(options)
    }
    func timerMethodAutoAmazon(timer:NSTimer) {
        print("auto load amazon")
        if(showAd())
        {
            showAmazonBanner()
        }
        
        
    }
    
    ////////////////////////////////////////////////////////////////////////
    //////////////////////////////////////////////////////////////////////////////////////////
    
    //////////////////////
    //amazonfull
    //////////////////////
    func loadAmazonFull()
    {
        let options = AmazonAdOptions()
        
        options.isTestRequest = false
        
        interstitialAmazon.load(options)
    }
    func showAmazonFull()
    {
        interstitialAmazon.presentFromViewController(self)
        
    }
    
    /////////////////////////////////////////////////////////////
    // Mark: - AmazonAdViewDelegate
    // Mark: - AmazonAdViewDelegate
    func viewControllerForPresentingModalView() -> UIViewController {
        return self
    }
    
    func adViewDidLoad(view: AmazonAdView!) -> Void {
        self.view.addSubview(amazonAdView)
    }
    
    func adViewDidFailToLoad(view: AmazonAdView!, withError: AmazonAdError!) -> Void {
        print("Ad Failed to load. Error code \(withError.errorCode): \(withError.errorDescription)")
    }
    
    func adViewWillExpand(view: AmazonAdView!) -> Void {
        print("Ad will expand")
    }
    
    func adViewDidCollapse(view: AmazonAdView!) -> Void {
        print("Ad has collapsed")
    }
    
    ///////////
    //full delegate
    // Mark: - AmazonAdInterstitialDelegate
    func interstitialDidLoad(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial loaded.", terminator: "")
        //loadStatusLabel.text = "Interstitial loaded."
        showAmazonFull()
    }
    
    func interstitialDidFailToLoad(interstitial: AmazonAdInterstitial!, withError: AmazonAdError!) {
        Swift.print("Interstitial failed to load.", terminator: "")
        //loadStatusLabel.text = "Interstitial failed to load."
    }
    
    func interstitialWillPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be presented.", terminator: "")
    }
    
    func interstitialDidPresent(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been presented.", terminator: "")
    }
    
    func interstitialWillDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial will be dismissed.", terminator: "")
        
    }
    
    func interstitialDidDismiss(interstitial: AmazonAdInterstitial!) {
        Swift.print("Interstitial has been dismissed.", terminator: "");
        //self.loadStatusLabel.text = "No interstitial loaded.";
        //loadAmazonFull();
    }

    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
    //===========================ADVERTISING======FOR-ADVERTISING=======ADVERTISING===========================================
    //============================================SIMPLE=VERSION==============================================================
    //========================================================================================================================
    //========================================================================================================================
    //========================================================================================================================
}

