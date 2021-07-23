//
//  ActivityIndicatorView.swift
//  GhibliApps
//
//  Created by Gus Adi on 22/07/21.
//

import Foundation
import UIKit

final class ActivityIndicatorView: UIActivityIndicatorView {
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        setUp()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        color = .white
        backgroundColor = .darkGray
        layer.cornerRadius = 5.0
        hidesWhenStopped = true
    }
}
