//
//  ContentView.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 12/7/2565 BE.
//

import SwiftUI

struct ContentView: View {
  // MARK: Properties

  // MARK: Body

  var body: some View {
    NavigationView {
      Image(systemName: "photo")
        .resizable()
        .scaledToFit()
        .padding()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        // MARK: Overlay button

        .overlay(HStack {}, alignment: .bottom)

        .navigationTitle("CoreML")
        .navigationBarTitleDisplayMode(.inline)
    } //: NavigationView
    .navigationViewStyle(.stack)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
      .previewDevice("iPhone 13")
  }
}
