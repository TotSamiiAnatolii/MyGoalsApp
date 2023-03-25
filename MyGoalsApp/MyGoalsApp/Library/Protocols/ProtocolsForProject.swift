//
//  ProtocolsForProject.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import Foundation

protocol ConfigurableView {
    
    associatedtype Model
    
    func configure(with model: Model)
}
