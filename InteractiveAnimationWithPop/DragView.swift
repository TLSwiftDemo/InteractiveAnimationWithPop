//
//  DragView.swift
//  InteractiveAnimationWithPop
//
//  Created by Andrew on 16/7/22.
//  Copyright © 2016年 Andrew. All rights reserved.
//

import UIKit

protocol DraggableViewDelegate {
    
    /**
     拖拽过程进行检测
     
     - parameter view:
     - parameter velocity:
     */
    func draggableView(view:DragView,velocity:CGPoint);
    
    /**
     开始拖拽
     
     - parameter view:
     */
    func draggableViewBeganDragging(view:DragView);
}

class DragView: UIView {
    
    var delegate:DraggableViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() -> Void {
        let recognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        self.addGestureRecognizer(recognizer)
        
        self.layer.cornerRadius = 6
        
    }
    
    func didPan(recognizer:UIPanGestureRecognizer) -> Void {
        
        //获取坐标
        let point = recognizer.translationInView(self.superview)
        self.center = CGPointMake(self.center.x, self.center.y+point.y)
        
        recognizer.setTranslation(CGPointZero, inView: self.superview)
        
        if(recognizer.state == .Ended){
            //获取手指移动的速度
            var velocity:CGPoint = recognizer.velocityInView(self.superview)
            velocity.x = 0
         delegate?.draggableView(self, velocity: velocity)
        }else if(recognizer.state == .Began){
         delegate?.draggableViewBeganDragging(self)
        }
        
    }

}









