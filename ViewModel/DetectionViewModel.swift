//
//  DetectionViewModel.swift
//  EcoVision
//
//  Created by Htet Aung Shine on 26/1/25.
//

import SwiftUI
import Vision
import CoreML

class DetectionViewModel: ObservableObject {
    @Published var detectionLabel: String = "No Label available"
    private var model: VNCoreMLModel?
    
    init() {
        self.model = try? VNCoreMLModel(for: EcoVisionModel(configuration: .init()).model)
    }
    
    func classifyImage(_ image: UIImage?, completion: @escaping () -> Void) {
        guard let image = image, let ciImage = CIImage(image: image), let model = model else {
            self.detectionLabel = "Could not detect image."
            completion()
            return
        }
        
        // Create a request to classify the image
        let request = VNCoreMLRequest(model: model) { request, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
            
            if let results = request.results as? [VNRecognizedObjectObservation], let firstResult = results.first {
                DispatchQueue.main.async {
                    if let result = firstResult.labels.first?.identifier {
                        self.detectionLabel = result
                    }
                    completion()
                }
            } else {
                DispatchQueue.main.async {
                    self.detectionLabel = "Could not detect image."
                    completion()
                }
            }
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage, options: [:])
        DispatchQueue.global().async {
            do {
                try handler.perform([request])
            } catch {
                DispatchQueue.main.async {
                    self.detectionLabel = "Image detection failed."
                    completion()
                }
            }
        }
    }
}
