import Cartridge from "../common/cartridge.js";
import Display from "./display.js";
import Runner from "./runner.js";

const cart = new Cartridge();

const loadCart = (code) => {
	cart.code = code;
	const data = cart.run();

	Runner.updateFunc = data.update;
	Runner.drawFunc = data.draw;

	Runner.ticks = 0;
	Runner.draws = 0;

	Runner.start();
}

window.onload = () => {
	const canvas = document.querySelector("canvas");
	Display.linkCanvas(canvas);
	window.onresize();

	Display.context.fillStyle = "#ffffff";
	Display.context.fillText("Hello World!", 12, 12);
}

window.onresize = () => {
	// https://stackoverflow.com/a/72152735/22146374
	const centerWidth = window.innerWidth / 2;
	const centerHeight = window.innerHeight / 2;
	
	const canvasWidth = 256;
	const canvasHeight = 256;
	
	const width_scale = window.innerWidth / canvasWidth
	const height_scale = window.innerHeight / canvasHeight
	const scale = Math.min(width_scale, height_scale)
	
	const left = centerWidth - (canvasWidth * scale) / 2;
	const top = centerHeight - (canvasHeight * scale) / 2;

	// Runner.scale = scale;

	Display.canvas.width = canvasWidth * scale;
	Display.canvas.height = canvasHeight * scale;

	Display.canvas.style.left = `${left}px`
	Display.canvas.style.top = `${top}px`
	Display.canvas.style.width = `${canvasWidth * scale}px`
	Display.canvas.style.height = `${canvasHeight * scale}px`

	Display.context.scale(scale, scale);

	// Display.context.imageSmoothingEnabled = false;
}

window.onkeydown = (key) => {
	if (key.code[0] == "F" || key.code == "Tab") {
		key.preventDefault();
	}
	
	switch (key.code) {
		case "Tab":
			Runner.speed = 10;
			break;
		case "F4":
			Runner.paused ? Runner.start() : Runner.stop();
			break;
		case "F1":
			const fileInput = document.getElementById("file");
			const fileReader = new FileReader();

			fileReader.onload = (event) => {
				loadCart(event.target.result);
			}

			fileInput.onchange = (event) => {
				fileReader.readAsText(event.target.files[0]);
			}

			fileInput.click();
			break;
	}
}

window.onkeyup = (key) => {
	switch (key.code) {
		case "Tab":
			Runner.speed = 1;
			break;
	}
}