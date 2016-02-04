//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var tipAmount: Double = 1
var tipAmountRounded = Double(round(tipAmount*100)/100)

var output: String = String(format: "%.2f", tipAmountRounded)

print(output)

