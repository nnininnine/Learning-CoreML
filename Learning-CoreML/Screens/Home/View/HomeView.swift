//
//  HomeView.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 14/7/2565 BE.
//

import SwiftUI

struct HomeView: View {
  // MARK: Properties

  @StateObject private var vm: HomeViewModel = .init()

  // MARK: Body

  var body: some View {
    NavigationView {
      List {
        ForEach(vm.modules) { module in
          NavigationLink(destination: module.view) {
            Text(module.name)
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
