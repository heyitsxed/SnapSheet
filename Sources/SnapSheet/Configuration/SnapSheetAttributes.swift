//
//  SnapSheetAttributes.swift
//  SnapSheet
//
//  Created by Cedrick on 5/8/26.
//

import UIKit

public struct SnapSheetAttributes {
    let height: SnapSheetHeight
    let dimmingColor: UIColor
    let cornerRadius: CGFloat
    
    public init(height: SnapSheetHeight, dimmingColor: UIColor = .black.withAlphaComponent(0.3), cornerRadius: CGFloat = 20) {
        self.height = height
        self.dimmingColor = dimmingColor
        self.cornerRadius = cornerRadius
    }
}
