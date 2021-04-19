//
//  AnimationTransition.swift
//  Practice_RxFlow
//
//  Created by 한상진 on 2021/04/16.
//

import UIKit

fileprivate enum Duration {
    static let oneSecond: TimeInterval = 1
}

/// 한 컨트롤러와 다른 컨트롤러 간의 상호작용 애니메이션을 구동
final class AnimationTransition: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning {
    enum TransitionStyle {
        case push
        case pop
        case present
    }
    
    private let style: TransitionStyle
    private let originPoint: CGPoint?
    var originFrame: CGRect?
    
    init(
        originPoint: CGPoint? = nil,
        originFrame: CGRect? = nil,
        style: TransitionStyle = .push
    ) {
        self.originPoint = originPoint
        self.originFrame = originFrame
        self.style = style
    }
    
    // 애니메이션 동작 시간
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return Duration.oneSecond
    }
    
    // 애니메이션 효과 정의
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        switch style {
        case .push:
            animatePush(using: transitionContext)
        case .present:
            animatePresent(using: transitionContext)
        case .pop:
            animatePop(using: transitionContext)
        }
    }
    
    private func animatePush(using transitionContext: UIViewControllerContextTransitioning) {
        // 필요한 레퍼런스 세팅
        guard let fromVC = transitionContext.viewController(forKey: .from),
              let toVC = transitionContext.viewController(forKey: .to),
              let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
              else {
            return
        }
        
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        // 스냅샷, 컨테이너 뷰 세팅
        
        snapshot.frame = originFrame ?? CGRect()
        snapshot.layer.masksToBounds = true
        
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot)
        toVC.view.isHidden = true
        
        // initial state 설정
        
        let duration = transitionDuration(using: transitionContext)
        
        
        // TODO: Animation 추가
        
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0, 
            options: .calculationModeCubic, 
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/3) { 
//                    fromVC.view.layer.transform
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1/3) { 
//                    fromVC.view.layer.transform
                }
                
                UIView.addKeyframe(withRelativeStartTime: 2/3, relativeDuration: 1/3) { 
//                    fromVC.view.layer.transform
                }
            },
            completion: { _ in
                toVC.view.isHidden = false
                snapshot.removeFromSuperview()
                fromVC.view.layer.transform = CATransform3DIdentity
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        )
    }
    
    private func animatePresent(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
    
    private func animatePop(using transitionContext: UIViewControllerContextTransitioning) {
        
    }
}
