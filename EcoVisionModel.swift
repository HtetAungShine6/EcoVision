//
// EcoVisionModel.swift
//
// This file was automatically generated and should not be edited.
//

import CoreML


/// Model Prediction Input Type
@available(macOS 11.0, iOS 14.0, tvOS 14.0, visionOS 1.0, *)
@available(watchOS, unavailable)
class EcoVisionModelInput : MLFeatureProvider {

    /// Input image as color (kCVPixelFormatType_32BGRA) image buffer, 0 pixels wide by 0 pixels high
    var image: CVPixelBuffer

    /// The maximum allowed overlap (as intersection-over-union ratio) for any pair of output bounding boxes (default: 0.33) as optional double value
    var iouThreshold: Double? = nil

    /// The minimum confidence score for an output bounding box (default: 0.4) as optional double value
    var confidenceThreshold: Double? = nil

    var featureNames: Set<String> { ["image", "iouThreshold", "confidenceThreshold"] }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        if featureName == "image" {
            return MLFeatureValue(pixelBuffer: image)
        }
        if featureName == "iouThreshold" {
            return iouThreshold == nil ? nil : MLFeatureValue(double: iouThreshold!)
        }
        if featureName == "confidenceThreshold" {
            return confidenceThreshold == nil ? nil : MLFeatureValue(double: confidenceThreshold!)
        }
        return nil
    }

    init(image: CVPixelBuffer, iouThreshold: Double? = nil, confidenceThreshold: Double? = nil) {
        self.image = image
        self.iouThreshold = iouThreshold
        self.confidenceThreshold = confidenceThreshold
    }

    convenience init(imageWith image: CGImage, iouThreshold: Double? = nil, confidenceThreshold: Double? = nil) throws {
        self.init(image: try MLFeatureValue(cgImage: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!, iouThreshold: iouThreshold, confidenceThreshold: confidenceThreshold)
    }

    convenience init(imageAt image: URL, iouThreshold: Double? = nil, confidenceThreshold: Double? = nil) throws {
        self.init(image: try MLFeatureValue(imageAt: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!, iouThreshold: iouThreshold, confidenceThreshold: confidenceThreshold)
    }

    func setImage(with image: CGImage) throws  {
        self.image = try MLFeatureValue(cgImage: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

    func setImage(with image: URL) throws  {
        self.image = try MLFeatureValue(imageAt: image, pixelsWide: 299, pixelsHigh: 299, pixelFormatType: kCVPixelFormatType_32ARGB, options: nil).imageBufferValue!
    }

}


/// Model Prediction Output Type
@available(macOS 11.0, iOS 14.0, tvOS 14.0, visionOS 1.0, *)
@available(watchOS, unavailable)
class EcoVisionModelOutput : MLFeatureProvider {

    /// Source provided by CoreML
    private let provider : MLFeatureProvider

    /// Boxes × Class confidence (see user-defined metadata "classes") as multidimensional array of doubles
    var confidence: MLMultiArray {
        provider.featureValue(for: "confidence")!.multiArrayValue!
    }

    /// Boxes × Class confidence (see user-defined metadata "classes") as multidimensional array of doubles
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    var confidenceShapedArray: MLShapedArray<Double> {
        MLShapedArray<Double>(confidence)
    }

    /// Boxes × [x, y, width, height] (relative to image size) as multidimensional array of doubles
    var coordinates: MLMultiArray {
        provider.featureValue(for: "coordinates")!.multiArrayValue!
    }

    /// Boxes × [x, y, width, height] (relative to image size) as multidimensional array of doubles
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    var coordinatesShapedArray: MLShapedArray<Double> {
        MLShapedArray<Double>(coordinates)
    }

    var featureNames: Set<String> {
        provider.featureNames
    }

    func featureValue(for featureName: String) -> MLFeatureValue? {
        provider.featureValue(for: featureName)
    }

    init(confidence: MLMultiArray, coordinates: MLMultiArray) {
        self.provider = try! MLDictionaryFeatureProvider(dictionary: ["confidence" : MLFeatureValue(multiArray: confidence), "coordinates" : MLFeatureValue(multiArray: coordinates)])
    }

    init(features: MLFeatureProvider) {
        self.provider = features
    }
}


/// Class for model loading and prediction
@available(macOS 11.0, iOS 14.0, tvOS 14.0, visionOS 1.0, *)
@available(watchOS, unavailable)
class EcoVisionModel {
    let model: MLModel

    /// URL of model assuming it was installed in the same bundle as this class
    class var urlOfModelInThisBundle : URL {
        let bundle = Bundle(for: self)
        return bundle.url(forResource: "EcoVisionModel", withExtension:"mlmodelc")!
    }

    /**
        Construct EcoVisionModel instance with an existing MLModel object.

        Usually the application does not use this initializer unless it makes a subclass of EcoVisionModel.
        Such application may want to use `MLModel(contentsOfURL:configuration:)` and `EcoVisionModel.urlOfModelInThisBundle` to create a MLModel object to pass-in.

        - parameters:
          - model: MLModel object
    */
    init(model: MLModel) {
        self.model = model
    }

    /**
        Construct a model with configuration

        - parameters:
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(configuration: MLModelConfiguration = MLModelConfiguration()) throws {
        try self.init(contentsOf: type(of:self).urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct EcoVisionModel instance with explicit path to mlmodelc file
        - parameters:
           - modelURL: the file url of the model

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL) throws {
        try self.init(model: MLModel(contentsOf: modelURL))
    }

    /**
        Construct a model with URL of the .mlmodelc directory and configuration

        - parameters:
           - modelURL: the file url of the model
           - configuration: the desired model configuration

        - throws: an NSError object that describes the problem
    */
    convenience init(contentsOf modelURL: URL, configuration: MLModelConfiguration) throws {
        try self.init(model: MLModel(contentsOf: modelURL, configuration: configuration))
    }

    /**
        Construct EcoVisionModel instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<EcoVisionModel, Error>) -> Void) {
        load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration, completionHandler: handler)
    }

    /**
        Construct EcoVisionModel instance asynchronously with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    class func load(configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> EcoVisionModel {
        try await load(contentsOf: self.urlOfModelInThisBundle, configuration: configuration)
    }

    /**
        Construct EcoVisionModel instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
          - handler: the completion handler to be called when the model loading completes successfully or unsuccessfully
    */
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration(), completionHandler handler: @escaping (Swift.Result<EcoVisionModel, Error>) -> Void) {
        MLModel.load(contentsOf: modelURL, configuration: configuration) { result in
            switch result {
            case .failure(let error):
                handler(.failure(error))
            case .success(let model):
                handler(.success(EcoVisionModel(model: model)))
            }
        }
    }

    /**
        Construct EcoVisionModel instance asynchronously with URL of the .mlmodelc directory with optional configuration.

        Model loading may take time when the model content is not immediately available (e.g. encrypted model). Use this factory method especially when the caller is on the main thread.

        - parameters:
          - modelURL: the URL to the model
          - configuration: the desired model configuration
    */
    @available(macOS 12.0, iOS 15.0, tvOS 15.0, watchOS 8.0, visionOS 1.0, *)
    class func load(contentsOf modelURL: URL, configuration: MLModelConfiguration = MLModelConfiguration()) async throws -> EcoVisionModel {
        let model = try await MLModel.load(contentsOf: modelURL, configuration: configuration)
        return EcoVisionModel(model: model)
    }

    /**
        Make a prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as EcoVisionModelInput

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as EcoVisionModelOutput
    */
    func prediction(input: EcoVisionModelInput) throws -> EcoVisionModelOutput {
        try prediction(input: input, options: MLPredictionOptions())
    }

    /**
        Make a prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as EcoVisionModelInput
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as EcoVisionModelOutput
    */
    func prediction(input: EcoVisionModelInput, options: MLPredictionOptions) throws -> EcoVisionModelOutput {
        let outFeatures = try model.prediction(from: input, options: options)
        return EcoVisionModelOutput(features: outFeatures)
    }

    /**
        Make an asynchronous prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - input: the input to the prediction as EcoVisionModelInput
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as EcoVisionModelOutput
    */
    @available(macOS 14.0, iOS 17.0, tvOS 17.0, watchOS 10.0, visionOS 1.0, *)
    func prediction(input: EcoVisionModelInput, options: MLPredictionOptions = MLPredictionOptions()) async throws -> EcoVisionModelOutput {
        let outFeatures = try await model.prediction(from: input, options: options)
        return EcoVisionModelOutput(features: outFeatures)
    }

    /**
        Make a prediction using the convenience interface

        It uses the default function if the model has multiple functions.

        - parameters:
            - image: Input image as color (kCVPixelFormatType_32BGRA) image buffer, 0 pixels wide by 0 pixels high
            - iouThreshold: The maximum allowed overlap (as intersection-over-union ratio) for any pair of output bounding boxes (default: 0.33) as optional double value
            - confidenceThreshold: The minimum confidence score for an output bounding box (default: 0.4) as optional double value

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as EcoVisionModelOutput
    */
    func prediction(image: CVPixelBuffer, iouThreshold: Double?, confidenceThreshold: Double?) throws -> EcoVisionModelOutput {
        let input_ = EcoVisionModelInput(image: image, iouThreshold: iouThreshold, confidenceThreshold: confidenceThreshold)
        return try prediction(input: input_)
    }

    /**
        Make a batch prediction using the structured interface

        It uses the default function if the model has multiple functions.

        - parameters:
           - inputs: the inputs to the prediction as [EcoVisionModelInput]
           - options: prediction options

        - throws: an NSError object that describes the problem

        - returns: the result of the prediction as [EcoVisionModelOutput]
    */
    func predictions(inputs: [EcoVisionModelInput], options: MLPredictionOptions = MLPredictionOptions()) throws -> [EcoVisionModelOutput] {
        let batchIn = MLArrayBatchProvider(array: inputs)
        let batchOut = try model.predictions(from: batchIn, options: options)
        var results : [EcoVisionModelOutput] = []
        results.reserveCapacity(inputs.count)
        for i in 0..<batchOut.count {
            let outProvider = batchOut.features(at: i)
            let result =  EcoVisionModelOutput(features: outProvider)
            results.append(result)
        }
        return results
    }
}
