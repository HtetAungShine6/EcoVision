//
//  RootView.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 24/2/25.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var navigationManager = NavigationManager()
    
    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            HomeView(cameraService: CameraService())
                .environmentObject(navigationManager)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                    case .calculatorView:
                        CalculatorView()
                            .environmentObject(navigationManager)
                    case .detectionResult(let label, let image):
                        ResultView(detectionResult: label, capturedImage: image)
                            .environmentObject(navigationManager)
                    case .articleView:
                        ArticlesListView()
                            .environmentObject(navigationManager)
                    case .articleDetailView(let article):
                        ArticleDetailView(article: article)
                            .environmentObject(navigationManager)
                    }
                }
        }
    }
}
