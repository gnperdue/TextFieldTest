//
//  ContentView.swift
//  TextFieldTest
//
//  Created by Gabriel Perdue on 1/13/21.
//

import SwiftUI

struct Cycle {
  var w: Double
  var r: Int
}


struct ContentView: View {
  @State private var cycle = Cycle(w: 0.0, r: 0)
  @State private var modalIsPresented = false

  var body: some View {
    
    VStack {
      HStack {
        Text("W = \(cycle.w)")
        Text("R = \(cycle.r)")
      }

      Button(action: {
        print("w = \(cycle.w), r = \(cycle.r)")
      }, label: {
        Label("Print w, r to console", systemImage: "hand.point.up.left")
      })
      .padding()

      
      Button(action: {
        modalIsPresented = true
      }, label: {
        Label("Invoke modal", systemImage: "hand.point.up.left")
      })
    }
    .sheet(isPresented: $modalIsPresented) {
      SheetView(cycle: $cycle)
    }

  }
}

/*
 Attempt solution proposed by Scott Grosch in RayWenderlich Discord
 */
struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var cycle: Cycle
  @State private var wValue: String
  @State private var rValue: String

  init(cycle: Binding<Cycle>) {
    _cycle = cycle
    _wValue = State(initialValue: "\(cycle.wrappedValue.w)")
    _rValue = State(initialValue: "\(cycle.wrappedValue.r)")
    // actually prefer, but here, whatevs - neat to see how to pass above
//    _xValue = State(initialValue: "")
//    _yValue = State(initialValue: "")
  }
  
  var body: some View {
    
    VStack {

      Form {
        Section(header: Text("W").bold()) {
          TextField("Set W", text: $wValue)
            .keyboardType(.decimalPad) // .numberPad? - want a decimal though
        }
        Section(header: Text("R").bold()) {
          TextField("Set R", text: $rValue)
            .keyboardType(.numberPad) // .numberPad? - for ints, I guess
        }
      }

      Button(action: {
        guard let w = Double(wValue), let r = Int(rValue) else {
          // post a pop-up, etc.
          return
        }
        cycle.w = w
        cycle.r = r
        self.mode.wrappedValue.dismiss()
      }, label: {
        Label("Enter data", systemImage: "hand.point.up.left")
      })
      .padding()
    }
    
  }
}


struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
