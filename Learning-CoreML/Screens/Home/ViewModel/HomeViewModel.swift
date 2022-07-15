//
//  HomeViewModel.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 14/7/2565 BE.
//

import SwiftUI

class HomeViewModel: ObservableObject {
  // MARK: Properties

  let modules: Modules = [
    Module(name: "Image Classification", view: AnyView(ImageClassificationView())),
    Module(name: "Sign Language Classification", view: AnyView(SignLangClassificationView())),
    Module(name: "Simple Tokenization", view: AnyView(SimpleTokenizationView()))
  ]

  // MARK: Methods
}
