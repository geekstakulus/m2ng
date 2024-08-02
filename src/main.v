module main

import os

fn main() {
	if os.args.len > 1 {
		println(os.args[1])
		return
	}

	println('USAGE: m2ng filename')
}
