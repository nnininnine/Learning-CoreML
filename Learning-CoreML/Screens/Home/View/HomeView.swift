//
//  HomeView.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 14/7/2565 BE.
//

import SwiftUI

struct HomeView: View {
  var body: some View {
    NavigationView {
      List {
        ForEach(0 ..< 5) { _ in
          Button {
            print("get in module")
          } label: {
            Text("Template")
              .foregroundColor(Color(uiColor: .label))
              .font(.system(size: 18, weight: .medium))
          }
        }
      }
      .navigationTitle("Learning CoreML")
      .navigationBarTitleDisplayMode(.large)
    }
    .navigationViewStyle(.stack)
  }
}

struct HomeView_Previews: PreviewProvider {
  static var previews: some View {
    HomeView()
  }
}
