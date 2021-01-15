//
//  IntegerTextFieldView.swift
//  TextFieldTest
//
//  Created by Gabriel Perdue on 1/14/21.
//

import SwiftUI

struct IntegerTextFieldView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var cycle: Cycle
  @State private var wValue = DoubleTextFieldValue()
  @State private var rValue = IntegerTextFieldValue()

  var body: some View {
    Text("mellow")
  }
}

struct IntegerTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    IntegerTextFieldView(cycle: .constant(.init(w: 0.0, r: 0)))
  }
}
