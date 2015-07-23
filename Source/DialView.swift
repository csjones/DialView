//
//  DialView.swift
//  DialView
//

import UIKit

@IBDesignable public class DialView: UIView {
    
    // MARK: Keys
    
    public static let RingColorKey = "ringColor"
    public static let RaceColorKey = "raceColor"
    public static let RingWidthKey = "ringWidth"
    public static let RaceWidthKey = "raceWidth"
    public static let RingStartKey = "ringStart"
    public static let RingStopKey = "ringStop"
    
    // MARK: Properties
    
    @IBInspectable public var ringColor: UIColor = UIColor.whiteColor() {
        didSet {
            addAction(forKey: "ringColor", toValue: ringColor)
            dialLayer.ringColor = ringColor
        }
    }
    
    @IBInspectable public var raceColor: UIColor = UIColor.redColor() {
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
    
    @IBInspectable public var raceWidth: CGFloat = 0.0 {
        didSet {
            addAction(forKey: "raceWidth", toValue: raceWidth)
            dialLayer.raceWidth = raceWidth
        }
    }
    
    @IBInspectable public var lineCap: CGFloat? {
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
    
    // MARK: Animation
    
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
    
}
