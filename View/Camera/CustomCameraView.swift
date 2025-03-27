//
//  CustomCameraView.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 26/1/25.
//

import SwiftUI

struct CustomCameraView: View {
    
    let cameraService = CameraService()
    @Binding var captureImage: UIImage?
    var completion: (UIImage?) -> Void
    
    @Environment(\.presentationMode) private var presentationMode
    @StateObject private var detectionViewModel = DetectionViewModel()
    @State private var frameColor: Color = .green
    
    var body: some View {
        ZStack {
            CameraView(cameraService: cameraService) { result in
                switch result {
                case .success(let photo):
                    if let data = photo.fileDataRepresentation() {
                        let newImage = UIImage(data: data)
                        captureImage = newImage
                        completion(newImage)
                        cameraService.stop()
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        print("Error: No Image Data Found!")
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                        cameraService.stop()
                    }) {
                        Image(systemName: "xmark")
                            .padding()
                            .background(Circle().fill(Color.black.opacity(0.6)))
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                .padding(.top, 20)
                .padding(.leading, 20)
                
                Text("Please capture the photo to detect the carbon footprint.")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.top, 120)
                
                Spacer()
                
                Spacer()
                
                Button(action: {
                    cameraService.capturePhoto()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 80, height: 80)
                        Image(systemName: "checkmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                    }
                }
                .padding(.bottom, 30)
            }
        }
    }
}
