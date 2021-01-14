//
//  ContentView.swift
//  TextFieldTest
//
//  Created by Gabriel Perdue on 1/13/21.
//

import SwiftUI

struct Point {
  var x: Double
  var y: Double
}


struct ContentView: View {
  @State private var point = Point(x: 0.0, y: 0.0)
  @State private var modalIsPresented = false

  var body: some View {
    
    VStack {
      HStack {
        Text("X = \(point.x)")
        Text("Y = \(point.y)")
      }

      Button(action: {
        print("x = \(point.x), y = \(point.y)")
      }, label: {
        Label("Print x, y to console", systemImage: "hand.point.up.left")
      })
      .padding()

      
      Button(action: {
        modalIsPresented = true
      }, label: {
        Label("Invoke modal", systemImage: "hand.point.up.left")
      })
    }
    .sheet(isPresented: $modalIsPresented) {
      SheetView(point: $point)
    }

  }
}

/*
 Attempt solution proposed by Scott Grosch in RayWenderlich Discord
 */
struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var point: Point
  @State private var xValue: String
  @State private var yValue: String

  init(point: Binding<Point>) {
    _point = point
    _xValue = State(initialValue: "\(point.wrappedValue.x)")
    _yValue = State(initialValue: "\(point.wrappedValue.y)")
    // actually prefer, but here, whatevs - neat to see how to pass above
//    _xValue = State(initialValue: "")
//    _yValue = State(initialValue: "")
  }
  
  var body: some View {
    
    VStack {

      Form {
        Section(header: Text("X").bold()) {
          TextField("Set X", text: $xValue)
            .keyboardType(.decimalPad) // .numberPad? - want a decimal though
        }
        Section(header: Text("Y").bold()) {
          TextField("Set Y", text: $yValue)
            .keyboardType(.decimalPad) // .numberPad? - for ints, I guess
        }
      }

      Button(action: {
        guard let x = Double(xValue), let y = Double(yValue) else {
          // post a pop-up, etc.
          return
        }
        point.x = x
        point.y = y
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
