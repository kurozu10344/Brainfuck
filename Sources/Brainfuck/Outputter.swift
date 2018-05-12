import Foundation

protocol Outputter {
    func output(byte: UInt8)
}

class DefaultOutputter: Outputter {
    func output(byte: UInt8) {
        let char = Character(Unicode.Scalar.init(byte))
        print(char, terminator: "")
    }
}
