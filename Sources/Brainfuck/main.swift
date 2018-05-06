import Foundation

enum CommandCategory {
    case normal(ArraySlice<Character>)
    case loop(ArraySlice<Character>)
}

var bytes = [UInt8].init(repeating: 0, count: 30000)
var bytesPtr: Int = 0

func categorize(commands: ArraySlice<Character>) -> [CommandCategory] {
    guard !commands.isEmpty else { return [] }
    
    if commands.first == "[" {
        let loopCommands = commands.prefix(while: { $0 != "]" }).dropFirst()
        let remaining = commands.drop(while: { $0 != "]" }).dropFirst()
        return [CommandCategory.loop(loopCommands)] + categorize(commands: remaining)
    }
    else {
        let normalComamnds = commands.prefix(while: { $0 != "[" })
        let remaining = commands.drop(while: { $0 != "[" })
        return [CommandCategory.normal(normalComamnds)] + categorize(commands: remaining)
    }
}

func exec(category: CommandCategory) {
    switch category {
    case .normal(let commands):
        commands.forEach(exec)
    case .loop(let commands):
        while bytes[bytesPtr] != 0 {
            commands.forEach(exec)
        }
    }
}

func exec(command: Character) {
    switch command {
    case ">":
        bytesPtr += 1
    case "<":
        bytesPtr -= 1
    case "+":
        bytes[bytesPtr] += 1
    case "-":
        bytes[bytesPtr] -= 1
    case ".":
        let char = Character(Unicode.Scalar.init(bytes[bytesPtr]))
        print(char, terminator: "")
    case ",":
        bytes[bytesPtr] = UInt8(getchar())
    //    case "[":
    //    case "]":
    default: break
    }
}

let program: String = readLine(strippingNewline: true)!
//let program: String = "+++++++++[>++++++++>+++++++++++>+++++<<<-]>.>++.+++++++..+++.>-.------------.<++++++++.--------.+++.------.--------.>+."
let commands: [Character] = program.map { $0 }
let categories: [CommandCategory] = categorize(commands: ArraySlice(commands))
categories.forEach(exec)
