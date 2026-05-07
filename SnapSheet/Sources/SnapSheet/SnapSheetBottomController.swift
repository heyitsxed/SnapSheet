//
//  SnapSheetBottomController.swift
//  SnapSheet
//
//  Created by Cedrick on 5/7/26.
//

import UIKit

final class SnapSheetBottomController: UIPresentationController {
    
    private let dimmingView = UIView()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        
        let height = containerView.bounds.height * 0.5
        let y = containerView.bounds.height - height
        let width = containerView.bounds.width
        
        return CGRect(x: 0, y: y, width: width, height: height)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0
        
        containerView.addSubview(dimmingView)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        dimmingView.frame = containerView?.bounds ?? .zero
        presentedView?.frame = frameOfPresentedViewInContainerView
        
        presentedView?.layer.cornerRadius = 20
        presentedView?.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        presentedView?.clipsToBounds = true
    }
    
    @objc func dismissSheet() {
        presentedViewController.dismiss(animated: true)
    }
}
