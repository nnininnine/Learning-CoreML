//
//  Module.swift
//  Learning-CoreML
//
//  Created by 7Peaks on 14/7/2565 BE.
//

import SwiftUI

typealias Modules = [Module]

struct Module: Identifiable {
  var id = UUID()
  var name: String
  var view: AnyView
}
