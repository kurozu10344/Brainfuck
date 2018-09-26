import Foundation

let brainfuck = Brainfuck(outputter: DefaultOutputter())

//if let file = CommandLine.arguments.dropFirst().first {
let file = "./helloworld.bf"
    do {
        let program = try String(contentsOfFile: file, encoding: .utf8)
        brainfuck.start(program: program)
    } catch {
        print(error)
    }
//}
//else {
//    let program: String = readLine(strippingNewline: true)!
//    // let program: String = "+++++++++[>++++++++>+++++++++++>+++++<<<-]>.>++.+++++++..+++.>-.------------.<++++++++.--------.+++.------.--------.>+."
//    brainfuck.start(program: program)
//}
