//
//  DialLayer.swift
//  DialView
//

import UIKit

public class DialLayer: CALayer {

    // MARK: Keys
    
    public static let RingColorKey = "ringColor"
    public static let RaceColorKey = "raceColor"
    public static let RingWidthKey = "ringWidth"
    public static let RaceWidthKey = "raceWidth"
    public static let RingStartKey = "ringStart"
    public static let RingStopKey = "ringStop"
        
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

    public var raceColor: UIColor = UIColor.clearColor()
    public var ringColor: UIColor = UIColor.clearColor()

    public var raceWidth: CGFloat = 0.0
    
    public var ringWidth: CGFloat = 10.0
    public var lineCap: CGLineCap? = .Round
    
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
        CGContextSetFillColorWithColor(context, backgroundColor)
        CGContextFillRect(context, bounds)
        
        CGContextSetLineWidth(context, raceWidth)
        CGContextSetStrokeColorWithColor(context, raceColor.CGColor)
        CGContextAddArc(context, bounds.midX, bounds.midY, (bounds.width / 2) - (raceWidth), 0, 360, 0)
        CGContextStrokePath(context)
        
        if let lineCap = lineCap {
            CGContextSetLineCap(context, lineCap)
        }
        
        CGContextSetLineWidth(context, ringWidth)
        CGContextSetStrokeColorWithColor(context, ringColor.CGColor)
        CGContextAddArc(context, bounds.midX, bounds.midY, (bounds.width / 2) - (raceWidth), ringStart, ringStop, 0)
        CGContextStrokePath(context)
    }
    
}