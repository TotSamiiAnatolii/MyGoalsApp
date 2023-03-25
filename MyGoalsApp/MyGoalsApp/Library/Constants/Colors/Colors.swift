//
//  Colors.swift
//  MyGoalsApp
//
//  Created by APPLE on 25.03.2023.
//

import UIKit

struct TransformedColor: Hashable {
    let visualColor: UIColor
    let topColor: UIColor
    let bottomColor: UIColor
    let buttonColor: UIColor
    
    static func == (lhs: TransformedColor, rhs: TransformedColor) -> Bool {
        return lhs.visualColor == rhs.visualColor &&
        lhs.topColor == rhs.topColor &&
        lhs.bottomColor == rhs.bottomColor &&
        lhs.buttonColor == rhs.buttonColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(buttonColor)
    }
}

enum Colors {
    
    static let mainBackgroundColor: UIColor = .systemGroupedBackground
    
    static let shadowColor = #colorLiteral(red: 0.9192931218, green: 0.9015458062, blue: 0.9502355146, alpha: 1).cgColor

    static let circularProgress = #colorLiteral(red: 0.9675037381, green: 0.9675037381, blue: 0.9675037381, alpha: 1).cgColor
    
    static let noActivSaveButton = #colorLiteral(red: 0.8515508448, green: 0.8515508448, blue: 0.8515508448, alpha: 1).withAlphaComponent(0.5)
    
    static let activSaveButton = #colorLiteral(red: 0.5110705838, green: 0.8379505613, blue: 0.2887354145, alpha: 1)
    
    static let greenColor = TransformedColor(visualColor: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1), topColor: #colorLiteral(red: 0.5383084722, green: 1, blue: 0.6667337669, alpha: 1), bottomColor: #colorLiteral(red: 0.4304287014, green: 0.9164578129, blue: 0.3466848981, alpha: 1), buttonColor: #colorLiteral(red: 0.2999537254, green: 0.6386538218, blue: 0.2415950107, alpha: 1))
    
    static let redColor = TransformedColor(visualColor: #colorLiteral(red: 0.7803921569, green: 0.1093301586, blue: 0.1270790009, alpha: 1), topColor: #colorLiteral(red: 1, green: 0.5026804161, blue: 0.4438348723, alpha: 1), bottomColor: #colorLiteral(red: 0.9885790772, green: 0.1358378635, blue: 0.1563622861, alpha: 1), buttonColor: #colorLiteral(red: 0.5, green: 0.06870359015, blue: 0.07908435943, alpha: 1))
    
    static let orangeColor = TransformedColor(visualColor: #colorLiteral(red: 0.9447348714, green: 0.4976223111, blue: 0.2278396785, alpha: 1), topColor: #colorLiteral(red: 0.9447348714, green: 0.5443016016, blue: 0.3945157231, alpha: 1), bottomColor: #colorLiteral(red: 0.9303960578, green: 0.4872104329, blue: 0.2229998766, alpha: 1), buttonColor: #colorLiteral(red: 0.7052134365, green: 0.369291487, blue: 0.1690274889, alpha: 1))
    
    static let blueColor = TransformedColor(visualColor: #colorLiteral(red: 0.1246440932, green: 0.2728896141, blue: 0.9629107118, alpha: 1), topColor: #colorLiteral(red: 0.4193620298, green: 0.57496772, blue: 0.9629107118, alpha: 1), bottomColor: #colorLiteral(red: 0.2769281026, green: 0.4309771291, blue: 0.9629107118, alpha: 1), buttonColor: #colorLiteral(red: 0.1060482348, green: 0.2322563882, blue: 0.8418022661, alpha: 1))
    
    static let grayColor = TransformedColor(visualColor: #colorLiteral(red: 0.530977609, green: 0.530977609, blue: 0.530977609, alpha: 1), topColor: #colorLiteral(red: 0.9452728759, green: 0.9452728759, blue: 0.9452728759, alpha: 1), bottomColor: #colorLiteral(red: 0.6195419292, green: 0.6195419292, blue: 0.6195419292, alpha: 1), buttonColor: #colorLiteral(red: 0.4594316808, green: 0.4594316808, blue: 0.4594316808, alpha: 1))
    
    static let darkGrayColor = TransformedColor(visualColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1), topColor: #colorLiteral(red: 0.7846692925, green: 0.7846692925, blue: 0.7846692925, alpha: 1), bottomColor: #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), buttonColor: #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1))
}
