//
//  ViewController.swift
//  Demo
//
//  Created by twb on 7/21/15.
//  Copyright (c) 2015 twb. All rights reserved.
//

import UIKit
import DialView

public class ViewController: UIViewController {

    @IBOutlet var dialView: DialView?
    
    public override func viewDidLoad() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tap")
        view.addGestureRecognizer(tapGestureRecognizer)
        dialView?.userInteractionEnabled = false
    }
    
    @IBAction public func tap() {
        if let dialView = dialView {
            dialView.animating = !dialView.animating
        }
    }
    
}

