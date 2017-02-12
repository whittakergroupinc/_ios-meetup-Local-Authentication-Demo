//
//  ViewController.swift
//  iOS Meetup Local Authentication Demo
//
//  Created by David Whittaker on 2/12/17.
//  Copyright © 2017 The Whittaker Group, Inc. All rights reserved.
//


import UIKit
import LocalAuthentication

class ViewController: UIViewController {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        // Custom initialization
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // Test the local authentication framework
    @IBAction func testTouchID(_ sender : AnyObject) {
        
        // Create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.alert)
        // Add the cancel button to the alert
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
        
        // Create the Local Authentication Context
        let touchIDAuthenticationContext = LAContext()
        var touchIDError : NSError?
        let reasonString = "Local Authentication Testing"
        
        // Check if we can access local device authentication
        guard touchIDAuthenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &touchIDError) else {
            
            // Unable to access local device authentication
            
            // Set the error title
            alert.title = "Error"
            
            // Set the error alert message with more information
            switch touchIDError!.code {
            case LAError.touchIDNotEnrolled.rawValue:
                alert.message = "Touch ID is not enrolled"
            case LAError.touchIDNotAvailable.rawValue:
                alert.message = "Touch ID not available"
            case LAError.passcodeNotSet.rawValue:
                alert.message = "Passcode has not been set"
            default:
                alert.message = "Local Authentication not available"
            }
            
            // Show the alert
            self.present(alert, animated: true, completion: nil)
            return
            
        }
        
        // Check what the authentication response was
        touchIDAuthenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: reasonString,
            reply: { (success, error) -> Void in
                // Check if we passed or failed
                if success {
                    // User authenticated using Local Device Authentication Successfully!
                    
                    // Show a success alert
                    alert.title = "Success!"
                    alert.message = "You have authenticated!"
                    self.present(alert, animated: true, completion: nil)
                    
                } else {
                    // Unsuccessful
                    
                    // Set the title of the unsuccessful alert
                    alert.title = "Unsuccessful!"
                    
                    // Set the message of the alert
                    switch error!._code {
                        
                    case LAError.appCancel.rawValue:
                        alert.message = "Authentication was cancelled by application"
                        
                    case LAError.authenticationFailed.rawValue:
                        alert.message = "The user failed to provide valid credentials"
                        
                    case LAError.invalidContext.rawValue:
                        alert.message = "The context is invalid"
                        
                    case LAError.passcodeNotSet.rawValue:
                        alert.message = "Passcode is not set on the device"
                        
                    case LAError.systemCancel.rawValue:
                        alert.message = "Authentication was cancelled by the system"
                        
                    case LAError.touchIDLockout.rawValue:
                        alert.message = "Too many failed attempts."
                        
                    case LAError.touchIDNotAvailable.rawValue:
                        alert.message = "TouchID is not available on the device"
                        
                    case LAError.userCancel.rawValue:
                        alert.message = "The user did cancel"
                        
                    case LAError.userFallback.rawValue:
                        alert.message = "The user chose to use the fallback"
                        
                    default:
                        alert.message = "Did not find error code on LAError object"
                    }
                    
                    // Show the alert
                    self.present(alert, animated: true, completion: nil)
                }
                
            
        })
        
    }
}


