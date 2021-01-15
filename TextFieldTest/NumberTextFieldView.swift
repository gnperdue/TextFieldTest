//
//  IntegerTextFieldView.swift
//  TextFieldTest
//
//  Created by Gabriel Perdue on 1/14/21.
//

import SwiftUI

struct NumberTextFieldView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var cycle: Cycle
  @StateObject private var wValue = DoubleTextFieldValue()
  @StateObject private var rValue = IntegerTextFieldValue()

  var body: some View {
    VStack {

      Form {
        Section(header: Text("W").bold()) {
          TextField("Set W", text: $wValue.value)
            .keyboardType(.decimalPad) // .numberPad? - want a decimal though
            .onChange(of: wValue.value) { cycle.w = Double($0) ?? 0.0 }
        }
        Section(header: Text("R").bold()) {
          TextField("Set R", text: $rValue.value)
            .keyboardType(.numberPad) // .numberPad? - for ints, I guess
            .onChange(of: rValue.value) { cycle.r = Int($0) ?? 0 }
        }
      }

      Button(action: {
        self.mode.wrappedValue.dismiss()
      }, label: {
        Label("Enter data", systemImage: "hand.point.up.left")
      })
      .padding()
    }
    .onAppear {
      wValue.value = "\($cycle.wrappedValue.w)"
      rValue.value = "\($cycle.wrappedValue.r)"
    }
  }
}

struct NumberTextFieldView_Previews: PreviewProvider {
  static var previews: some View {
    NumberTextFieldView(cycle: .constant(.init(w: 0.0, r: 0)))
  }
}
