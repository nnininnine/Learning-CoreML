//
//  SimpleTokenizationViewModel.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 15/7/2565 BE.
//

import NaturalLanguage

class SimpleTokenizationViewModel {
  // MARK: Properties

  @Published var text: String = ""
  @Published var wordTokenization: [String] = []

  private let tokenizer: NLTokenizer = .init(unit: .word)

  // MARK: Methods
}
