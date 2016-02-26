//
//  ViewController.swift
//  Dispatch Groups
//
//  Created by Retika Kumar on 2/26/16.
//  Copyright © 2016 kumar.retika. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tunnel = dispatch_group_create()
        dispatch_group_enter(tunnel)
        dispatch_async(dispatch_queue_create("queue1", nil)) { () -> Void in
            self.getNewPhotos{ () -> Void in
                print("Get all done")
                dispatch_group_leave(tunnel)
            }
        }
        dispatch_group_enter(tunnel)
        dispatch_async(dispatch_queue_create("queue2", nil)) { () -> Void in
            self.uploadPhotos {() -> Void in
                print("upload all done")
                dispatch_group_leave(tunnel)
                
            }
            
        }
        dispatch_group_notify(tunnel, dispatch_get_main_queue()) { () -> Void in
            print("Both functions are done")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func getNewPhotos(completion: () ->Void){
        let random = Double(arc4random_uniform(11))
        print("\(__FUNCTION__) about to sleep for \(random) seconds")
        NSThread.sleepForTimeInterval(random)
        completion()
    }
    
    
    func uploadPhotos(completion: () ->Void){
        let random = Double(arc4random_uniform(11))
        print("\(__FUNCTION__) about to sleep for \(random) seconds")
        NSThread.sleepForTimeInterval(random)
        completion()
        
    }
    
    
    
    
    
}

