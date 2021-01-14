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

struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var point: Point
  
  var body: some View {
    
    VStack {

      Form {
        Section(header: Text("X").bold()) {
          TextField("Set X", value: $point.x, formatter: NumberFormatter())
        }
        Section(header: Text("Y").bold()) {
          TextField("Set Y", value: $point.y, formatter: NumberFormatter())
        }
      }

      Button(action: {
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
