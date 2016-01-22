//
//  ViewController.swift
//  Muelle Amortiguado
//
//  Created by Carlos Macias Jimenez on 05/10/15.
//  Copyright © 2015 Carlos Macias Jimenez. All rights reserved.
//

import UIKit

class ViewController: UIViewController, MovementViewDataSource {
    
    @IBOutlet weak var massSlider: UISlider!
    @IBOutlet weak var kSlider: UISlider!
    @IBOutlet weak var lamdaSlider: UISlider!
    
    @IBOutlet weak var speedView: MovementView!
    @IBOutlet weak var positionView: MovementView!
    @IBOutlet weak var speedAndPositionView: MovementView!

    var movementModel: MovementModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movementModel = MovementModel()
        
        speedView.dataSource = self
        positionView.dataSource = self
        speedAndPositionView.dataSource = self
        
        speedView.scaleX = 5.0
        speedView.scaleY = 10.0
        
        positionView.scaleX = 5.0
        positionView.scaleY = 10.0
        
        speedAndPositionView.scaleX = 15.0
        speedAndPositionView.scaleY = 15.0
        
        massSlider.sendActionsForControlEvents(.ValueChanged)
        kSlider.sendActionsForControlEvents(.ValueChanged)
        lamdaSlider.sendActionsForControlEvents(.ValueChanged)
    }
    
    // MARK: IB Actions
    @IBAction func massChanged(sender: UISlider) {
        movementModel.m = Double(sender.value)
        
        speedView.setNeedsDisplay()
        positionView.setNeedsDisplay()
        speedAndPositionView.setNeedsDisplay()
    }
    
    @IBAction func kChanged(sender: UISlider) {
        movementModel.k = Double(sender.value)
        
        speedView.setNeedsDisplay()
        positionView.setNeedsDisplay()
        speedAndPositionView.setNeedsDisplay()
    }
    @IBAction func lamdaChanged(sender: UISlider) {
        movementModel.λ = Double(sender.value)
        
        speedView.setNeedsDisplay()
        positionView.setNeedsDisplay()
        speedAndPositionView.setNeedsDisplay()
    }
    
    // MARK: MovementViewDataSource
    func startTimeOfMovementView(movementView: MovementView) -> Double {
        return 0
    }
   
    func endTimeOfMovementView(movementView: MovementView) -> Double {
        return 200.0
    }
    
    func positionOfMovementView(movementView: MovementView, atTime time: Double) -> Position {
        
        switch movementView {
        case speedView:
            return Position(x: time, y: movementModel.speedAtTime(time))
        case positionView:
            return Position(x: time, y: movementModel.positionAtTime(time))
        case speedAndPositionView:
            return Position(x: movementModel.positionAtTime(time), y: movementModel.speedAtTime(time))
        default:
            return Position(x: time, y: time%50)
        }
    }
    
    @IBAction func panView(sender: UIPanGestureRecognizer) {
        
        let pos = sender.translationInView(sender.view)
        
        speedAndPositionView.center = CGPoint(x: speedAndPositionView.center.x + pos.x, y: speedAndPositionView.center.y + pos.y)
        
        sender.setTranslation(CGPointZero, inView: sender.view)
    }
    
    @IBAction func tapView(sender: UITapGestureRecognizer) {
        
        speedAndPositionView.endTime *= 1.4
        speedAndPositionView.setNeedsDisplay()
        
    }
    
    @IBAction func pinchView(sender: UIPinchGestureRecognizer) {
    
        let factor = Double(sender.scale)
        speedAndPositionView.scaleX *= factor
        speedAndPositionView.scaleY *= factor
        
        sender.scale = 1.0
    }
    
    @IBAction func pinchPosView(sender: UIPinchGestureRecognizer) {
        
        let factor = Double(sender.scale)
        positionView.scaleX *= factor
        positionView.scaleY *= factor
        
        sender.scale = 1.0
    }
    
    @IBAction func pinchSpeedView(sender: UIPinchGestureRecognizer) {
        
        let factor = Double(sender.scale)
        speedView.scaleX *= factor
        speedView.scaleY *= factor
        
        sender.scale = 1.0
    }
    
    @IBAction func longPressPosView(sender: UILongPressGestureRecognizer) {
        let red = CGFloat(drand48())
        let blue = CGFloat(drand48())
        let green = CGFloat(drand48())
        
        //generamos el color y asignamos
        positionView.backgroundColor =  UIColor(red: red, green: green, blue: blue, alpha: 1.0)
        positionView.setNeedsDisplay()
    }
    
    
}

