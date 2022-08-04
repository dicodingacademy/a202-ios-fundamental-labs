import Cocoa

enum Color: String {
  case red = "red"
  case blue = "blue"
  case green = "green"
}

let count = 5

func show(color: Color, count: Int) {
  for _ in 1...count {
    print(color.rawValue)
  }
}

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)

DispatchQueue.main.async {
  utilityQueue.async {
    show(color: .green, count: count)
  }
  backgroundQueue.async {
    show(color: .blue, count: count)
  }
  userInteractiveQueue.async {
    show(color: .red, count: count)
  }
}
