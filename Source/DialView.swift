//
//  DialView.swift
//  DialView
//

import UIKit

@IBDesignable public class DialView: UIView {
    
    // MARK: Properties
    
    @IBInspectable public var ringColor: UIColor = UIColor.clearColor() {
        didSet {
            addAction(forKey: "ringColor", toValue: ringColor)
            dialLayer.ringColor = ringColor
        }
    }
    
    @IBInspectable public var raceColor: UIColor = UIColor.clearColor() {
        didSet {
            addAction(forKey: "raceColor", toValue: raceColor)
            dialLayer.raceColor = raceColor
        }
    }
    
    @IBInspectable public var ringWidth: CGFloat = 10.0 {
        didSet {
            addAction(forKey: "ringWidth", toValue: ringWidth)
            dialLayer.ringWidth = ringWidth
        }
    }
    
    @IBInspectable public var raceWidth: CGFloat = 10.0 {
        didSet {
            addAction(forKey: "raceWidth", toValue: raceWidth)
            dialLayer.raceWidth = raceWidth
        }
    }
    
    @IBInspectable public var lineCap: CGLineCap? = .Round {
        didSet {
            dialLayer.lineCap = lineCap
        }
    }
    
    @IBInspectable public var ringStart: CGFloat = 0.0 {
        didSet {
            addAction(forKey: "ringStart", toValue: ringStart)
            dialLayer.ringStart = ringStart
        }
    }
    
    @IBInspectable public var ringStop: CGFloat = 0.25 {
        didSet {
            addAction(forKey: "ringStop", toValue: ringStop)
            dialLayer.ringStop = ringStop
        }
    }
    
    @IBInspectable public var animating: Bool = false {
        didSet {
            if animating {
                beginAnimating()
            }
        }
    }
    
    public override var backgroundColor: UIColor? {
        didSet {
            if let backgroundColor = backgroundColor {
                layer.backgroundColor = backgroundColor.CGColor
            }
        }
    }

    // MARK: Animation
    
    private func beginAnimating() {
        let width: CGFloat = 3.14 / 2
        let increment: CGFloat = 6.28
        let duration: Double = 0.66
        
        var start: CGFloat = 6.28 * 0.75
        
        func loop() {
            ringStop = start + width
            ringStart = start

            if !animating {
                UIView.animateWithDuration(duration * (1 - Double(width / increment)), delay: 0.0, options: [.CurveLinear], animations: { [weak self] () -> Void in
                    if let sself = self {
                        sself.ringStop = start + increment
                        sself.ringStart = start + increment - width
                    }
                }, completion: { (completed) -> Void in
                    UIView.animateWithDuration(duration * Double(width / increment), delay: 0.0, options: [.CurveLinear], animations: { [weak self] () -> Void in
                        if let sself = self {
                            sself.ringStart = start + increment
                        }
                    }, completion: nil)
                })
                return
            }
            
            UIView.animateWithDuration(duration, delay: 0, options: [.CurveLinear], animations: { [weak self] () -> Void in
                if let sself = self {
                    sself.ringStop = start + width + increment
                    sself.ringStart = start + increment
                }
            }, completion: { (completed) -> Void in
                if !completed {
                    return
                }
                
                start += increment
                loop()
            })
        }
        
        ringStart = start
        ringStop = start
        
        UIView.animateWithDuration(duration * Double(width / increment), delay: 0.0, options: [.CurveLinear], animations: { [weak self] () -> Void in
            self?.ringStop = start + width
        }, completion: { (completed) -> Void in
            loop()
        })
    }
    
    private func addAction(forKey key: String, toValue: AnyObject?) {
        if let baseAction = super.actionForLayer(layer, forKey: "backgroundColor") as? CABasicAnimation {
            let action = CABasicAnimation(keyPath: key)
            
            if let fromValue = dialLayer.presentationLayer()?.valueForKey(key) {
                action.fromValue =  fromValue
            } else {
                action.fromValue =  dialLayer.valueForKey(key)
            }
            
            action.toValue = toValue
            
            action.beginTime = baseAction.beginTime
            action.duration = baseAction.duration
            action.speed = baseAction.speed
            action.timeOffset = baseAction.timeOffset
            action.repeatCount = baseAction.repeatCount
            action.repeatDuration = baseAction.repeatDuration
            action.autoreverses = baseAction.autoreverses
            action.fillMode = baseAction.fillMode
            action.timingFunction = baseAction.timingFunction
            action.delegate = baseAction.delegate

            layer.addAnimation(action, forKey: key)
        }
    }
    
    // MARK: Layer
    
    private var dialLayer: DialLayer {
        get {
            return layer as! DialLayer
        }
    }
    
    public override static func layerClass() -> AnyClass {
        return DialLayer.self
    }
    
    public override func drawRect(rect: CGRect) {}

}
