//
//  ViewController.swift
//  Demo
//
//  Created by twb on 7/21/15.
//  Copyright (c) 2015 twb. All rights reserved.
//

import UIKit
import DialView

class ViewController: UIViewController {

    @IBOutlet var dialView: DialView?

    override func viewWillAppear(animated: Bool) {
        if let dialView = dialView {
            
            func activity(_: Bool) {
                dialView.ringStop = 0
                dialView.ringStart = 0
                
                UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: [], animations: { () -> Void in
                    dialView.ringStop = 6.28
                    }, completion: nil)
            
                UIView.animateKeyframesWithDuration(3.0, delay: 0.0, options: [], animations: { () -> Void in
                    dialView.ringStart = 6.28
                    }, completion: activity)
            }
            
            activity(true)
            
            UIView.animateKeyframesWithDuration(1.0, delay: 0.0, options: [.Autoreverse, .Repeat], animations: { () -> Void in
                dialView.raceWidth = 10
                dialView.ringWidth = 5
            }, completion: nil)
        }
    }
    
}

