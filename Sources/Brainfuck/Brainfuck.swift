import Foundation

private enum CommandCategory {
    case normal(ArraySlice<Character>)
    case loop(ArraySlice<Character>)
}

class Brainfuck {
    
    let outputter: Outputter
    
    private var bytes = [UInt8].init(repeating: 0, count: 30000)
    private var bytesPtr: Int = 0

    init(outputter: Outputter) {
        self.outputter = outputter
    }

    func start(program: String) {
        let commands: [Character] = program.map { $0 }
        let categories: [CommandCategory] = categorize(commands: ArraySlice(commands))
        categories.forEach(exec)
    }

    private func categorize(commands: ArraySlice<Character>) -> [CommandCategory] {
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
    
    private func exec(category: CommandCategory) {
        switch category {
        case .normal(let commands):
            commands.forEach(exec)
        case .loop(let commands):
            while bytes[bytesPtr] != 0 {
                commands.forEach(exec)
            }
        }
    }
    
    private func exec(command: Character) {
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
            outputter.output(byte: bytes[bytesPtr])
        case ",":
            bytes[bytesPtr] = UInt8(getchar())
        // case "[":
        // case "]":
        default: break
        }
    }

}
