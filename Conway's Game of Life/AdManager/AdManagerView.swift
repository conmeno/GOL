//
//  AdManagerView.swift
//  Gummy Fighter
//
//  Created by Phuong Nguyen on 2/4/16.
//  Copyright © 2016 PhuongNguyen. All rights reserved.
//

import Foundation
import UIKit



class AdManagerView: UIViewController
{
    
    
    var isAd1 = true
    var isAd2 = true
    var isAd3 = false
    var isAd4 = false
    
    
    @IBOutlet weak var sw1: UISwitch!
    
    @IBOutlet weak var sw2: UISwitch!
    
    @IBOutlet weak var sw3: UISwitch!
    
    @IBOutlet weak var sw4: UISwitch!
    @IBOutlet weak var textDevice: UITextView!
    
    @IBAction func sw1Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad1")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAd1 = sender.on

    }
    
    @IBAction func sw2Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad2")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAd2 = sender.on
    }
    
    
    @IBAction func sw3Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad3")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAd3 = sender.on
    }
    
    
    @IBAction func sw4Action(sender: UISwitch) {
        NSUserDefaults.standardUserDefaults().setObject(sender.on, forKey:"ad4")
        NSUserDefaults.standardUserDefaults().synchronize()
        isAd4 = sender.on
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CheckAdOptionValue()
        
        
        
      
        
        setupDevice()
        
    }
    
    func setupDevice()
    {
    
        var myIDFA: String = ""
        // Check if Advertising Tracking is Enabled
        if ASIdentifierManager.sharedManager().advertisingTrackingEnabled {
            // Set the IDFA
            myIDFA = ASIdentifierManager.sharedManager().advertisingIdentifier.UUIDString
        }
        
        let venderID = UIDevice.currentDevice().identifierForVendor!.UUIDString
        
        
        textDevice.text = "IDFA: \n" + myIDFA + "\nVendorID: \n" + venderID
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
        
        
        //ad3 ...
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad3") != nil)
        {
            isAd3 = NSUserDefaults.standardUserDefaults().objectForKey("ad3") as! Bool
            
        }
        
        if(NSUserDefaults.standardUserDefaults().objectForKey("ad4") != nil)
        {
            isAd4 = NSUserDefaults.standardUserDefaults().objectForKey("ad4") as! Bool
            
        }
        
        sw1.on = isAd1
        sw2.on = isAd2
        sw3.on = isAd3
        sw4.on = isAd4
        
    }


}
