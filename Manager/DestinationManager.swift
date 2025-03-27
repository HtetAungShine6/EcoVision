//
//  DestinationManager.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 24/2/25.
//

import SwiftUI

enum Destination: Hashable {
    case calculatorView
    case detectionResult(label: String, image: UIImage)
    case articleView
    case articleDetailView(article: Article)
}
