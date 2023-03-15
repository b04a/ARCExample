import UIKit
import Foundation

///MemoryLayout<String>.size
//MemoryLayout<Int64>.size
//MemoryLayout<CGFunction>.size
//
//
//struct CheckMemory {
//    let a: String
//    let b: Int64
//    let c: CGFunction
//    let e: Bool
//}
//
//MemoryLayout<CheckMemory>.size
//MemoryLayout<CheckMemory>.stride
//MemoryLayout<CheckMemory>.alignment

/////Example value type (copy method)
//var oneValue = 10
//var twoValue = oneValue
//
//oneValue = 20
//
//print(oneValue == twoValue ? print("One == Two") : print("One != Two"))
//
/////Example refference type (link method)
//class Person {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//}
//
//
//let personOne = Person(name: "Bob")
//personOne.name
//
//let personTwo = personOne
//personTwo.name
//
//personTwo.name = "Billy"
//personOne.name

//MARK: - ARC (Automatic Reference Counting)
//class Person {
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("the Person instance is about to free")
//    }
//}
//
//
//let personOne = Person(name: "Bob")
//personOne.name
//
//let personTwo = personOne
//personTwo.name
//
//personTwo.name = "Billy"
//personOne.name
//
//var referenceOne: Person?
//var referenceTwo: Person?
//
//referenceOne = Person(name: "Jack")
//referenceTwo = referenceOne
//
//referenceOne = nil
//referenceTwo = nil

//MARK: - ARC, problem Retain Cycle
//class Child {
//    let name: String
//    var toy: Toy?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("free memory Child")
//    }
//}
//
//class Toy {
//    let name: String
//    weak var owner: Child?
//
//    init(name: String) {
//        self.name = name
//    }
//
//    deinit {
//        print("free memory Toy")
//    }
//}
//
//var child: Child?
//var toy: Toy?
//
//child = Child(name: "Jane")
//toy = Toy(name: "bear")
//
//
//child?.toy = toy
//toy?.owner = child
//
//
//child = nil
//toy = nil

//weak (opitional type)
//unowned (not opitional type)

//MARK: - ARC in closure

//Ratain cycle in closure
//class Number {
//    var value = 0
//
//    lazy var newNumKEk: (Int) -> String = { [weak self] someNum in
//        guard let self = self else { return "" }
//        self.value += someNum
//        return "\(someNum)"
//    }
//
//    deinit {
//        print("Free memory Number class")
//    }
//}
//
//var newNub123: Number?
//newNub123 = Number()
//newNub123?.newNumKEk(5)
//newNub123?.value
//newNub123 = nil

//Для освобожения памяти в Number надо создать список захвата
//[unowned self] and [weak self]

//Пример сбегающего замыкания
var completions: [() -> Void] = []

func funcWithEspaClosure(completion: @escaping () -> Void) {
    completions.append(completion)
}

class First {
    let second = Second()
    var secondFinished = false
    
    func makeSecondWork() {
        second.work { [unowned self] in
            self.secondFinished = true
        }
    }
    
    deinit {
        print("The First instance as about to free")
    }
}

class Second {
    var finishedWorking: () -> Void = {}
    
    func work(completion: @escaping () -> Void) {
        finishedWorking = completion
        completion()
    }
}

var first: First?
first = First()
first?.makeSecondWork()
first = nil
