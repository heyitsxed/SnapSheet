//
//  SnapSheetBottomController.swift
//  SnapSheet
//
//  Created by Cedrick on 5/7/26.
//

import UIKit

public enum SnapSheetHeight {
    case fixed(CGFloat)
    case fraction(CGFloat)
}

final class SnapSheetBottomController: UIPresentationController {
    
    private lazy var dimmingView: UIView = {
        let view = UIView()
        view.alpha = 0
        view.isUserInteractionEnabled = true
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissSheet))
        view.addGestureRecognizer(tap)
        return view
    }()
    
    private let grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray3
        view.layer.cornerRadius = 2.5
        return view
    }()
    
    private let height: SnapSheetHeight
    
    private var panGesture: UIPanGestureRecognizer!
    
    init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?, height: SnapSheetHeight) {
        
        self.height = height
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let containerView else { return .zero }
        
        let totalHeight = containerView.bounds.height
        let sheetHeight: CGFloat
        
        switch height {
        case .fixed(let value):
            sheetHeight = value
            
        case .fraction(let percent):
            sheetHeight = totalHeight * percent
        }
        
        let y = totalHeight - sheetHeight
        let width = containerView.bounds.width
        
        return CGRect(x: 0, y: y, width: width, height: sheetHeight)
    }
    
    override func presentationTransitionWillBegin() {
        guard let containerView else { return }
        
        containerView.addSubview(dimmingView)
        
        dimmingView.frame = containerView.bounds
        
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_ :)))
        presentedViewController.view.addGestureRecognizer(panGesture)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        })
    }
    
    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        
        guard let presentedView else { return }
        
        
        dimmingView.frame = containerView?.bounds ?? .zero
        presentedView.frame = frameOfPresentedViewInContainerView
        
        presentedView.layer.cornerRadius = 20
        presentedView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMinYCorner
        ]
        
        presentedView.clipsToBounds = true
        
        if grabberView.superview == nil {
            presentedView.addSubview(grabberView)
            grabberView.frame = CGRect(
                x: (presentedView.bounds.width - 40) / 2,
                y: 8,
                width: 40,
                height: 5
            )
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let containerView,
              let presentedView else { return }
        
        let translation = gesture.translation(in: containerView)
        let velocity = gesture.velocity(in: containerView)
        
        switch gesture.state {
            
        case .changed:
            if translation.y > 0 {
                presentedView.frame.origin.y += translation.y
                gesture.setTranslation(.zero, in: containerView)
            }
            
        case .ended:
            let shouldDismiss = translation.y > 150 || velocity.y > 1000
            
            if shouldDismiss {
                presentedViewController.dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.3) {
                    presentedView.frame = self.frameOfPresentedViewInContainerView
                }
            }
            
        default:
            break
        }
    }
    
    @objc func dismissSheet() {
        presentedViewController.dismiss(animated: true)
    }
}
