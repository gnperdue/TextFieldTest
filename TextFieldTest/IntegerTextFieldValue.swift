//
//  IntegerTextFieldValue.swift
//  TextFieldTest
//
//  Created by Gabriel Perdue on 1/14/21.
//

import Foundation

// Note: `IntegerTextFieldValue` originally written by Scott Grosch. See
//  https://gist.github.com/grosch/b41f9a0a2be00f47c62f99e82936860e
public class IntegerTextFieldValue: ObservableObject {
  @Published var value = "" {
    didSet {
      let numbersOnly = value.filter { $0.isNumber }
      if value != numbersOnly {
        value = numbersOnly
      }
    }
  }
}

public class DoubleTextFieldValue: ObservableObject {

  /// trim an input string into something we may cast to Double
  func trimStr(str: String) -> String {
    // if no ".", then just check for numbers
    guard let first = str.firstIndex(of: ".") else {
      return str.filter { $0.isNumber }
    }
    // if more than one ".", remove after second "."
    let next = str[str.index(after: first)...].firstIndex(of: ".")
    if let next = next {
      let newStr = String.init(str.prefix(upTo: next))
      // filter for numbers or "." and return
      return newStr.filter { $0.isNumber || $0 == "." }
    }
    // if only one ".", filter for numbers or "." and return
    return str.filter { $0.isNumber || $0 == "." }
  }
  
  @Published var value = "" {
    didSet {
      let trimmedValue = trimStr(str: value)
      if trimmedValue != value {
        value = trimmedValue
      }
    }
  }
}
