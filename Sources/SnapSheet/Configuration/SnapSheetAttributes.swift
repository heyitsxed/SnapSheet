//
//  SnapSheetAttributes.swift
//  SnapSheet
//
//  Created by Cedrick on 5/8/26.
//

import UIKit

public enum SnapSheetHeight {
    case fixed(CGFloat)
    case fraction(CGFloat)
}

public struct SnapSheetAttributes {
    let height: SnapSheetHeight
    let dimmingColor: UIColor
    let cornerRadius: CGFloat
    let showGrabber: Bool
    let grabberColor: UIColor
    
    public init(
        height: SnapSheetHeight,
        dimmingColor: UIColor = .black.withAlphaComponent(0.3),
        cornerRadius: CGFloat = 20,
        showGrabber: Bool = true,
        grabberColor: UIColor = UIColor(red: 199/255.0, green: 199/255.0, blue: 204/255.0, alpha: 1.0)) {
            
            self.height = height
            self.dimmingColor = dimmingColor
            self.cornerRadius = cornerRadius
            self.showGrabber = showGrabber
            self.grabberColor = grabberColor
        }
}
