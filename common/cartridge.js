import Display from "../core/display.js";
import { Context } from "./context.js";

export default class Cartridge {

	code;

	constructor(code) {
		this.code = code;
	}

	run () {
		const func = new Function("context", this.code + "return { update, draw }");
		return func( Context );
		// func(
		// 	(color) => {
		// 		Display.context.fillStyle = color;
		// 	},
		// 	(x, y, width, height) => {
		// 		Display.context.rect(x, y, width, height);
		// 	},
		// 	() => {
		// 		Display.context.fill();
		// 	}
		// );
		// console.log("Start running");

		// const vm = new VirtualMachine(this.code);
		// vm.run();

		// console.log("Program finished!");
	}
	
}