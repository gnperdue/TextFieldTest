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

class ObservablePoint: ObservableObject {
  @Published var x: Double
  @Published var y: Double
  init(x: Double, y: Double) {
    self.x = x
    self.y = y
  }
}

struct ContentView: View {
  @State private var point = Point(x: 0.0, y: 0.0)
  @StateObject var obsPoint = ObservablePoint(x: 0.0, y: 0.0)
  @State private var modalIsPresented = false

  var body: some View {
    
    VStack {
      HStack {
        Text("X = \(point.x)")
        Text("Y = \(point.y)")
      }

      HStack {
        Text("Obs X = \(obsPoint.x)")
        Text("Obs Y = \(obsPoint.y)")
      }
      
      Button(action: {
        print("x = \(point.x), y = \(point.y)")
        print("obs x = \(obsPoint.x), obs y = \(obsPoint.y)")
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
      ObsSheetView(point: obsPoint)
//      SheetView(point: $point)
    }

  }
}

struct ObsSheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @ObservedObject var point: ObservablePoint
  
  var body: some View {
    
    VStack {
      Text("ObservablePoint")
      
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

struct SheetView: View {
  @Environment(\.presentationMode) var mode: Binding<PresentationMode>
  @Binding var point: Point
  
  var body: some View {
    
    VStack {
      Text("Plain old Point struct")

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
