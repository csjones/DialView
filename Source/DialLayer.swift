//
//  DialLayer.swift
//  DialView
//

import UIKit

public class DialLayer: CALayer {

    // MARK: Keys
    
    public static let RingColorKey = "ringColor"
    
    // MARK:
    
    public override static func needsDisplayForKey(key: String) -> Bool {
        if key == "ringStart"
            || key == "ringStop"
            || key == "raceColor"
            || key == "ringColor"
            || key == "raceWidth"
            || key == "ringWidth"
            || key == "lineCap" {
            return true
        } else {
            return super.needsDisplayForKey(key)
        }
    }

    // MARK: Properties

    public var raceColor: UIColor = UIColor.redColor()
    
    public var ringColor: UIColor = UIColor.whiteColor()

    public var raceWidth: CGFloat = 0.0
    
    public var ringWidth: CGFloat = 10.0
    public var lineCap: CGFloat?
    
    public var ringStart: CGFloat = 0.0
    public var ringStop: CGFloat = 0.0
    
    override init(layer: AnyObject) {
        super.init(layer: layer)
        if let layer = layer as? DialLayer {
            ringColor = layer.ringColor
            raceColor = layer.raceColor
            ringWidth = layer.ringWidth
            raceWidth = layer.raceWidth
            lineCap = layer.lineCap
            ringStart = layer.ringStart
            ringStop = layer.ringStop
        }
    }

    override init() {
        super.init()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Drawing
    
    public override func drawInContext(context: CGContext) {
        CGContextSetLineWidth(context, raceWidth)
        CGContextSetStrokeColorWithColor(context, raceColor.CGColor)
        CGContextAddArc(context, bounds.midX, bounds.midY, (bounds.width / 2) - (raceWidth), 0, 360, 0)
        CGContextStrokePath(context)
        
        CGContextSetLineWidth(context, ringWidth)
        CGContextSetStrokeColorWithColor(context, ringColor.CGColor)
        CGContextAddArc(context, bounds.midX, bounds.midY, (bounds.width / 2) - (raceWidth), ringStart, ringStop, 0)
        CGContextStrokePath(context)
    }
    
}