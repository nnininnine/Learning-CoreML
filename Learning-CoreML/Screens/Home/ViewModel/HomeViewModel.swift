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
    Module(name: "ImageClassification", view: AnyView(ContentView()))
  ]

  // MARK: Methods
}
