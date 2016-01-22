//
//  MovementView.swift
//  Muelle Amortiguado
//
//  Created by Carlos Macias Jimenez on 05/10/15.
//  Copyright © 2015 Carlos Macias Jimenez. All rights reserved.
//

import UIKit

struct Position {
    var x = 0.0
    var y = 0.0
}

protocol MovementViewDataSource: class {
    func startTimeOfMovementView(movementView: MovementView) -> Double
    func endTimeOfMovementView(movementView: MovementView) -> Double
    func positionOfMovementView(movementView: MovementView, atTime time: Double) -> Position
}

@IBDesignable
class MovementView: UIView {
    
    @IBInspectable
    var lineWidth: Double = 2.0
    
    @IBInspectable
    var movementColor: UIColor = UIColor.redColor()
    
    var endTime: Double = 10.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Escalas
    var scaleX: Double = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    var scaleY: Double = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }

    var resolution: Double = 1000.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    #if TARGET_INTERFACE_BUILDER
        var dataSource: MovementViewDataSource!
    #else
        weak var dataSource: MovementViewDataSource!
    #endif
    
    override func prepareForInterfaceBuilder() {
        
        class FakeDataSource: MovementViewDataSource {
            
            func startTimeOfMovementView(movementView: MovementView) -> Double {
                return 0.0
            }
            
            func endTimeOfMovementView(movementView: MovementView) -> Double {
                return 200.0
            }
            
            func positionOfMovementView(movementView: MovementView, atTime time: Double) -> Position {
                return Position (x:time, y:time%50)
            }
        }
        
        dataSource = FakeDataSource()
    }
    
    override func drawRect(rect: CGRect) {
        drawMovement()
        drawPathX()
        drawPathY()
    }
    
    private func drawMovement() {
                
        let startTime = dataSource.startTimeOfMovementView(self)
        //let endTime = dataSource.endTimeOfMovementView(self)
        let incrTime = max((endTime - startTime) / resolution , 0.01)
        let path = UIBezierPath()
        
        var position = dataSource.positionOfMovementView(self, atTime: startTime)
        var px = positionForX(position.x)
        var py = positionForY(position.y)
        path.moveToPoint(CGPointMake(px, py))
        
        for var t: Double = startTime ; t < endTime ; t += incrTime {
            position = dataSource.positionOfMovementView(self, atTime: t)
            px = positionForX(position.x)
            py = positionForY(position.y)
            path.addLineToPoint(CGPointMake(px, py))
            
            // print(px,py)
        }
        
        path.lineWidth = CGFloat(lineWidth)
        
        movementColor.set()
        
        path.stroke()
    }
    
    // Dibujamos el eje X
    private func drawPathX() {
        
        let height = bounds.size.height
        let width = bounds.size.width

        let context: CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetLineWidth(context, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
        CGContextMoveToPoint(context, 0, height/2)
        CGContextAddLineToPoint(context, width, height/2)
        CGContextStrokePath(context)
    }

    // Dibujamos el eje Y
    private func drawPathY() {
    
    let height = bounds.size.height
    let width = bounds.size.width
    
    let context: CGContextRef = UIGraphicsGetCurrentContext()!
    CGContextSetLineWidth(context, 1.0)
    CGContextSetStrokeColorWithColor(context, UIColor.blackColor().CGColor)
    CGContextMoveToPoint(context, width/2, 0)
    CGContextAddLineToPoint(context, width/2, height)
    CGContextStrokePath(context)
    }
    
    private func positionForX(x: Double) -> CGFloat {
        let width = bounds.size.width
        return width/2 + CGFloat(x*scaleX)
    }
    
    private func positionForY(y: Double) -> CGFloat {
        let height = bounds.size.height
        return height/2 - CGFloat(y*scaleY)
    }
}
