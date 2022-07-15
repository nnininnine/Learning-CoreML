//
//  SimpleTokenization.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 15/7/2565 BE.
//

import SwiftUI
import SwiftUIChipGroup

struct SimpleTokenizationView: View {
  // MARK: Properties

  @StateObject private var vm: SimpleTokenizationViewModel = .init()

  // MARK: Body

  var body: some View {
    VStack(alignment: .leading) {
      ScrollView {
        ChipGroup(
          chips: vm.wordTokenization.map { ChipItem(name: $0) },
          width: UIScreen.main.bounds.width - 80,
          selection: .none
        )
      }
      .frame(maxWidth: UIScreen.main.bounds.width - 32)
      TextField("Enter text here <3", text: $vm.text)
        .textFieldStyle(.roundedBorder)
    }
    .padding(.horizontal, 16)
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
