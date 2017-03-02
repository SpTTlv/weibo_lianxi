//
//  PopoverAnimator.swift
//  02微博Swift
//
//  Created by Cxd-lvdongjie on 2017/3/2.
//  Copyright © 2017年 Cxd-lvdongjie. All rights reserved.
//

import UIKit

class PopoverAnimator: NSObject {

    var isPresented : Bool = false

    var presentedFrame : CGRect = CGRect.zero
    
    
    var callBack : ((_ presented: Bool) -> ())
    
    // MARK:- 自定义构造函数
    init(callBack : @escaping (_ presented : Bool) -> () ) {
        
        self.callBack = callBack
        
    }
    
    
    
}
// MARK:- 转场动画代理
extension PopoverAnimator : UIViewControllerTransitioningDelegate{
    //改变弹出View的尺寸
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        let presentedVc = XLPresentationController(presentedViewController: presented, presenting: presenting)
        presentedVc.presetnedFrame = presentedFrame

        return presentedVc
    }
    
    //自定义弹出动画
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        callBack(isPresented)
        return self
    }
    
    //自定义消失动画
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        callBack(isPresented)
        return self
    }
    
}

// MARK:- 自定义弹出和消失的动画
extension PopoverAnimator : UIViewControllerAnimatedTransitioning{
    ///动画执行的时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    //获取转场的上下文:可以通过转场上下文  获取 弹出的View 跟 消失的上下文
    //UITransitionContextFromViewKey: 获取消失的View
    //UITransitionContextToViewKey  : 获取弹出的View
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        isPresented ? animationForPresentedView(transitionContext: transitionContext) : animationForDismissedView(transitionContext: transitionContext)
        
    }
    
    
    //自定义弹出动画
    func animationForPresentedView(transitionContext: UIViewControllerContextTransitioning){
        //1.获取弹出的View
        let presentView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        //2.将弹出的View添加到containerView中
        transitionContext.containerView.addSubview(presentView)
        
        //3.执行动画
        presentView.transform = CGAffineTransform(scaleX: 1.0, y: 0.1)
        presentView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            presentView.transform = CGAffineTransform.identity
        }) { (_) in
            //必须告诉转场上下文 已经完成了动画
            transitionContext.completeTransition(true)
        }
        
    }
    
    //自定义消失动画
    func animationForDismissedView(transitionContext: UIViewControllerContextTransitioning){
        
        //1.获取弹出的View
        let dismissView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.transform = CGAffineTransform(scaleX: 1.0, y: 0.001)
        }) { (_) in
            
            dismissView.removeFromSuperview()
            //必须告诉转场上下文 已经完成了动画
            transitionContext.completeTransition(true)
        }
        
        
    }
    
    
    
}
