import Foundation

 let program: String = readLine(strippingNewline: true)!
// let program: String = "+++++++++[>++++++++>+++++++++++>+++++<<<-]>.>++.+++++++..+++.>-.------------.<++++++++.--------.+++.------.--------.>+."

Brainfuck(outputter: DefaultOutputter()).start(program: program)
