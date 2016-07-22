//
//  ViewController.swift
//  InteractiveAnimationWithPop
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit
import pop

enum PaneState:Int {
    case open
    case closed
}

class ViewController: UIViewController,DraggableViewDelegate {
    
    var paneState:PaneState!
    var pane:DragView!
    var animation:POPSpringAnimation!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       self.view.backgroundColor = UIColor.whiteColor()
        initView()
    }

  
    func initView() -> Void {
        let size = self.view.bounds.size
        
        
        let rect = CGRectMake(0, size.height*0.75, size.width, size.height)
        let view = DragView(frame: rect)
        view.backgroundColor = UIColor.redColor()
        view.delegate = self
        self.view.addSubview(view)
      self.pane = view
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }

    //MARK: - Actions
    func didTap(gestrue:UITapGestureRecognizer) -> Void {
        self.paneState = paneState==PaneState.open ? PaneState.closed : PaneState.open
        self.animatePaneWithInitialVelocity(self.animation.velocity.CGPointValue())
        
    }

    /**
     移动的目的地
     
     - returns: <#return value description#>
     */
    func targetPoint() -> CGPoint {
        let size = self.view.bounds.size
        
        let point = self.paneState == PaneState.closed ? CGPointMake(size.width/2, size.height * 1.25) : CGPointMake(size.width/2, size.height/2 + 100)
        
        print("point:\(point)")
       return point
        
        
    }
    
    //MARK: - 动画
    func animatePaneWithInitialVelocity(initialVelocity:CGPoint) -> Void {
        //移除所有的动画效果
        self.pane.pop_removeAllAnimations()
        let animation = POPSpringAnimation(propertyNamed:kPOPViewCenter)
        animation.velocity = NSValue.init(CGPoint: initialVelocity)
        animation.toValue = NSValue(CGPoint:targetPoint())
        animation.springSpeed = 15
        animation.springBounciness = 6
        self.pane.pop_addAnimation(animation, forKey: "animation")
        
        self.animation = animation
        
    }
    
    //MARK: -  DraggableViewDelegate
    
    /**
     拖拽过程进行检测
     
     - parameter view:
     - parameter velocity:
     */
    func draggableView(view:DragView,velocity:CGPoint){
        print("====velocity:\(velocity)")
        self.paneState = velocity.y>=0 ? PaneState.closed : PaneState.open
        self.animatePaneWithInitialVelocity(velocity)
    }
    
    /**
     开始拖拽
     
     - parameter view:
     */
    func draggableViewBeganDragging(view:DragView){
    
        view.layer.pop_removeAllAnimations()
    }
}

