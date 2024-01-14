# M2NG: Modula-2 New Generation Compiler

Welcome to M2NG,
the Modula-2 New Generation Compiler project! 
M2NG is an ambitious initiative aimed at reviving and modernizing Modula-2 codebases 
while providing the flexibility to transpile them into various contemporary languages,
as well as to compile it to portable architectures such as the `JVM`, 
`WebAssembly`,
and platform specific architectures such as the x86 and x86-64.

The original single-pass Modula-2 compiler generated M-Code bytecode,
and this compiler will not support that.

Whether you're working with legacy Modula-2 code 
or are interested in taking advantage of more modern programming languages,
M2NG has got you covered.

## Project Overview

### Stage 1: Implement a Working Parser in Go

- **Objective**: Implement a working parser with AST and Semantic Analysis, 
    and ensure successful compilation.
- **Status**: [In Progress]
- **Details**: This compiler will follow Wirth's one-pass compiler architecture,
but with proper modular programming.
The original single-pass compiler did not have a proper modularization.
At this stage I will implement the lexical analyzer,
which is already work-in-progress,
the syntax analyzer with error recovery and AST generation,
a Symbol Table and Semantic Analyzer.

### Stage 1: Compile to JVM Bytecode

- **Objective**: Implement a code generator for the JVM. 
- **Status**: [Planned]
- **Details**: The JVM is a popular architcture for being portable.
As such,
it will be the first target architecture,
so that the compiler can then be re-implemented in Modula-2 NG,
and compile itself.

### Stage 4: Zig Code Generator

- **Objective**: Implement a Zig code generator to provide Modula-2-like features in the Zig programming language.
- **Status**: [Planned]
- **Details**: Zig is known for its versatility and efficiency,
making it a suitable candidate to replicate Modula-2's original features.
We're planning to develop a Zig code generator to cater to this need.

### Stage 5: Go Code Generator

- **Objective**: Create a Go code generator to transpile Modula-2 code into the Go programming language.
- **Status**: [Planned / In Progress / Completed]
- **Details**: Go is widely used for its simplicity and efficiency.
With this stage,
we aim to provide a pathway to convert Modula-2 code into Go,
unlocking all the advantages of the Go ecosystem.

### Stage 2: Wasm Code Generator

- **Objective**: Develop a WebAssembly (Wasm) code generator for M2NG.
- **Status**: [Planned / In Progress / Completed]
- **Details**: We're planning to extend M2NG's capabilities by enabling code generation for WebAssembly.
This will allow you to execute your Modula-2 code within web browsers and other environments that support Wasm.

## Getting Started

To get started with M2NG,
please refer to the documentation in the docs directory.
Each stage will have its dedicated section with instructions on how to contribute,
run the code,
and provide feedback.

We welcome contributions from the community to help advance each stage of the project and make M2NG a powerful tool for modernizing Modula-2 projects.

## License

This project is licensed under the [MIT] License - see the [LICENSE.md](LICENSE.md) file for details.
```
