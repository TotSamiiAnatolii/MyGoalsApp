//
//  GradientView.swift
//  MyGoalsApp
//
//  Created by APPLE on 27.03.2023.
//

import UIKit

import UIKit

final class GradientView: UIView {
    
    private var colorTop: CGColor
    private var colorBottom: CGColor

    init(color: TransformedColors, frame: CGRect) {
        colorTop = UIColor.decode(with: color.topColor).cgColor
        colorBottom = UIColor.decode(with: color.bottomColor).cgColor
        super.init(frame: frame)
        setupView()
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
    
    private func setupView() {
         guard let theLayer = self.layer as? CAGradientLayer else {
             return
         }
         theLayer.colors = [colorTop, colorBottom]
         theLayer.locations = [0.0, 1.0]
         theLayer.frame = self.bounds
     }
}
