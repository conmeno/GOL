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
        
        let myAd = MyAd(root: self)
        
        myAd.ViewDidload()
       
        
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
}

