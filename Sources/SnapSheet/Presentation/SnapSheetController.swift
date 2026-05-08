//
//  SnapSheetController.swift
//  SnapSheet
//
//  Created by Cedrick on 5/7/26.
//

import UIKit

public class SnapSheetController: UIViewController {
    
    private let contentViewController: UIViewController
    private let height: SnapSheetHeight

    public init(contentViewController: UIViewController, height: SnapSheetHeight = .fraction(0.5)) {
        self.contentViewController = contentViewController
        self.height = height
        super.init(nibName: nil, bundle: nil)
        
        modalPresentationStyle = .custom
        transitioningDelegate = self
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        contentViewController.didMove(toParent: self)
    }
}

//MARK: - UIViewControllerTransitioningDelegate

extension SnapSheetController: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        SnapSheetBottomController(presentedViewController: presented, presenting: presenting, attributes: SnapSheetAttributes(height: .fraction(0.5)))
    }
}
