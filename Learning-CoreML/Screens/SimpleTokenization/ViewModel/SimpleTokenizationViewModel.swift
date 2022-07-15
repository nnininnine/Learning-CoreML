//
//  SimpleTokenizationViewModel.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 15/7/2565 BE.
//

import NaturalLanguage

class SimpleTokenizationViewModel: ObservableObject {
  // MARK: Properties

  @Published var text: String = "" {
    didSet {
      wordTokenization = tokenize(text)
    }
  }

  @Published var wordTokenization: [String] = []

  private let tokenizer: NLTokenizer = .init(unit: .word)

  // MARK: Methods

  private func tokenize(_ text: String) -> [String] {
    tokenizer.string = text
    let result: [String] = tokenizer.tokens(for: text.startIndex ..< text.endIndex).map { String(text[$0]) }
    return result
  }
}
