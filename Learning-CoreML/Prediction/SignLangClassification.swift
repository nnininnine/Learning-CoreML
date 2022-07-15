//
//  SignLangClassification.swift
//  Learning-CoreML
//
//  Created by 7Peaks (Nine) on 15/7/2565 BE.
//

import ImageIO
import UIKit
import Vision

class SignLangClassification {
  // MARK: Create Image Classifier

  static func createImageClassifier() -> VNCoreMLModel {
    let defaultConfig = MLModelConfiguration()

    let imageClassifierWrapper = try? sign_language_classification(configuration: defaultConfig)

    guard let imageClassifier = imageClassifierWrapper else {
      fatalError("App failed to create an image classifier model instance.")
    }

    let model = imageClassifier.model

    guard let visionModel = try? VNCoreMLModel(for: model) else {
      fatalError("App failed to create a `VNCoreMLModel` instance.")
    }

    return visionModel
  }

  private static let imageClassifier = createImageClassifier()

  // MARK: Prediction

  struct Prediction {
    // predicted class
    let classification: String

    // confidence level
    let confidencePercentage: String
  }

  typealias Predictions = [Prediction]
  typealias ImagePredictionHandler = (_ predictions: Predictions?) -> Void

  private var predictionHandlers = [VNRequest: ImagePredictionHandler]()

  private func createImageClassificationRequest() -> VNImageBasedRequest {
    let imageClassificationRequest = VNCoreMLRequest(model: ImageClassification.imageClassifier, completionHandler: visionRequestHandler)

    imageClassificationRequest.imageCropAndScaleOption = .centerCrop

    return imageClassificationRequest
  }

  private func visionRequestHandler(_ request: VNRequest, error: Error?) {
    // Remove the caller's handler from the dictionary and keep a reference to it.
    guard let predictionHandler = predictionHandlers.removeValue(forKey: request) else {
      fatalError("Every request must have a prediction handler.")
    }

    // Start with a `nil` value in case there's a problem.
    var predictions: [Prediction]?

    // Call the client's completion handler after the method returns.
    defer {
      // Send the predictions back to the client.
      predictionHandler(predictions)
    }

    // Check for an error first.
    if let error = error {
      print("Vision image classification error...\n\n\(error.localizedDescription)")
      return
    }

    // Check that the results aren't `nil`.
    if request.results == nil {
      print("Vision request had no results.")
      return
    }

    // Cast the request's results as an `VNClassificationObservation` array.
    guard let observations = request.results as? [VNClassificationObservation] else {
      // Image classifiers, like MobileNet, only produce classification observations.
      // However, other Core ML model types can produce other observations.
      // For example, a style transfer model produces `VNPixelBufferObservation` instances.
      print("VNRequest produced the wrong result type: \(type(of: request.results)).")
      return
    }

    // Create a prediction array from the observations.
    predictions = observations.map { observation in
      // Convert each observation into an `ImagePredictor.Prediction` instance.
      Prediction(classification: observation.identifier,
                 confidencePercentage: observation.confidencePercentageString)
    }
  }

  func predict(with image: UIImage, completionHandler: @escaping ImagePredictionHandler) throws {
    let orientation = CGImagePropertyOrientation(image.imageOrientation)

    guard let predictImage = image.cgImage else {
      fatalError("Image doesn't have underlying CGImage.")
    }

    let predictRequest = createImageClassificationRequest()
    predictionHandlers[predictRequest] = completionHandler

    let handler = VNImageRequestHandler(cgImage: predictImage, orientation: orientation)

    let requests: [VNRequest] = [predictRequest]

    // Start predict
    try handler.perform(requests)
  }
}
