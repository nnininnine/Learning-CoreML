//
//  SimpleTokenization.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 15/7/2565 BE.
//

import SwiftUI

struct SimpleTokenizationView: View {
  // MARK: Properties

  @State private var text: String = ""

  // MARK: Body

  var body: some View {
    VStack(alignment: .leading) {
      Text(text)
      Spacer()
      TextField("Enter text here <3", text: $text)
        .textFieldStyle(.roundedBorder)
    }
    .padding()
    .navigationTitle("Simple Tokenization")
    .navigationBarTitleDisplayMode(.inline)
  }
}

struct SimpleTokenization_Previews: PreviewProvider {
  static var previews: some View {
    SimpleTokenizationView()
      .previewDevice("iPhone 13")
  }
}
