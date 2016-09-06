//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


var size = CGSize(width: 100, height: 421)

for row in 10.stride(to: Int(size.height - 10), by: 40) {
    print("row location: \(row)")
}
