//
//  HomeView.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 26/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var navigationManager: NavigationManager
    @StateObject private var detectionViewModel = DetectionViewModel()
    @State private var isCameraPresented = false
    @State private var capturedImage: UIImage?
    @State private var classificationResult: String = "No result available"
    
    let cameraService: CameraService
    
    var body: some View {
        ZStack {
            backgroundView
            
            VStack(spacing: 20) {
                appTitle
                Spacer()
                cameraButton
                bottomButtons
                    .padding(.top, -40)
            }
            .padding()
        }
        .sheet(isPresented: $isCameraPresented, onDismiss: {
            cameraService.stop()
        }) {
            CustomCameraView(captureImage: $capturedImage) { newImage in
                if let newImage = newImage {
                    capturedImage = newImage
                    detectionViewModel.classifyImage(newImage) {
                        classificationResult = detectionViewModel.detectionLabel
                        if let image = capturedImage {
                            navigationManager.navigateTo(.detectionResult(label: classificationResult, image: image))
                        }
                    }
                }
            }
        }
        .navigationDestination(for: DetectionResult.self) { result in
            ResultView(detectionResult: result.label, capturedImage: result.image)
        }
    }
    
    private var backgroundView: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.green.opacity(0.3), Color.blue.opacity(0.3)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)
    }

    private var appTitle: some View {
        VStack(spacing: 8) {
            Text("EcoVision")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Capture items and learn about their environmental impact.")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
        .padding(.top, 20)
    }
    
    private var cameraButton: some View {
        VStack {
            Button {
                isCameraPresented.toggle()
            } label: {
                Image(systemName: "camera")
                    .font(.largeTitle)
                    .padding()
                    .background(Color.white.opacity(0.8))
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .scaleEffect(isCameraPresented ? 0.9 : 1.0)
                    .animation(.spring(), value: isCameraPresented)
            }
            
            Text("Scan an Item")
                .font(.headline)
                .foregroundColor(.primary)
                .padding(.top, 5)
        }
    }
    
    private var bottomButtons: some View {
        HStack {
            VStack {
                Button {
                    navigationManager.navigateTo(Destination.articleView)
                } label: {
                    Image(systemName: "book")
                        .font(.title2)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                Text("Articles")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
            
            Spacer().frame(width: 160)
            
            VStack {
                Button {
                    navigationManager.navigateTo(Destination.calculatorView)
                } label: {
                    Image(systemName: "plus.forwardslash.minus")
                        .font(.title2)
                        .padding()
                        .background(Color.white.opacity(0.8))
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                Text("Calculator")
                    .font(.caption)
                    .foregroundColor(.primary)
            }
        }
    }
}

#Preview {
    HomeView(cameraService: CameraService())
}

//struct HomeView: View {
//    
//    @EnvironmentObject var navigationManager: NavigationManager
//    @StateObject private var detectionViewModel = DetectionViewModel()
//    @State private var isCameraPresented = false
//    @State private var capturedImage: UIImage?
//    @State private var classificationResult: String = "No result available"
//    
//    let cameraService: CameraService
//    
//    var body: some View {
//        VStack {
//            Spacer()
//            cameraButton
//            bottomButtons
//                .padding(.top, -40)
//        }
//        .sheet(isPresented: $isCameraPresented, onDismiss: {
//            cameraService.stop()
//        }) {
//            CustomCameraView(captureImage: $capturedImage) { newImage in
//                if let newImage = newImage {
//                    capturedImage = newImage
//                    detectionViewModel.classifyImage(newImage) {
//                        classificationResult = detectionViewModel.detectionLabel
//                        if let image = capturedImage {
//                            navigationManager.navigateTo(.detectionResult(label: classificationResult, image: image))
//                        }
//                    }
//                }
//            }
//        }
//        .navigationDestination(for: DetectionResult.self) { result in
//            ResultView(detectionResult: result.label, capturedImage: result.image)
//        }
//    }
//    
//    private var cameraButton: some View {
//        VStack{
//            Button {
//                isCameraPresented.toggle()
//            } label: {
//                Image(systemName: "camera")
//                    .font(.largeTitle)
//                    .padding()
//                    .background(Color.secondary)
//                    .clipShape(Circle())
//                    .shadow(radius: 10)
//            }
//            
//        }
//    }
//    
//    private var bottomButtons: some View {
//        HStack {
//            Button {
//                navigationManager.navigateTo(Destination.articleView)
//            } label: {
//                Image(systemName: "book")
//                    .font(.title2)
//                    .padding()
//                    .background(Color.secondary)
//                    .clipShape(Circle())
//                    .shadow(radius: 10)
//            }
//            
//            Spacer().frame(width: 140)
//            
//            Button {
//                navigationManager.navigateTo(Destination.calculatorView)
//            } label: {
//                Image(systemName: "plus.forwardslash.minus")
//                    .font(.title2)
//                    .padding()
//                    .background(Color.secondary)
//                    .clipShape(Circle())
//                    .shadow(radius: 10)
//            }
//            
//        }
//    }
//}
//
//#Preview {
//    HomeView(cameraService: CameraService())
//}
