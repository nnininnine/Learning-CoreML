//
//  PhotoButtonGroup.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 12/7/2565 BE.
//

import SwiftUI

struct PhotoButtonGroup: View {
  // MARK: Properties

  var onTapTakePhoto: () -> Void
  var onTapGallery: () -> Void

  // MARK: Body

  var body: some View {
    HStack(spacing: 24) {
      Button {
        onTapTakePhoto()
      } label: {
        Text("Take Photo")
          .foregroundColor(Color(uiColor: .label))
      }
      .padding()

      Button {
        onTapGallery()
      } label: {
        Text("Gallery")
          .foregroundColor(Color(uiColor: .label))
      }
      .padding()
    }
    .background(.ultraThinMaterial)
    .cornerRadius(12)
  }
}

struct PhotoButtonGroup_Previews: PreviewProvider {
  static var previews: some View {
    PhotoButtonGroup(onTapTakePhoto: {}, onTapGallery: {})
      .preferredColorScheme(.dark)
      .previewLayout(.sizeThatFits)
      .padding()
  }
}
