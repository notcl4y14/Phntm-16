import Display from "./display.js";
import Runner from "./runner.js";

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

	Display.canvas.width = canvasWidth;
	Display.canvas.height = canvasHeight;
	
	const width_scale = window.innerWidth / canvasWidth
	const height_scale = window.innerHeight / canvasHeight
	const scale = Math.min(width_scale, height_scale)
	
	const left = centerWidth - (canvasWidth * scale) / 2;
	const top = centerHeight - (canvasHeight * scale) / 2;

	Display.canvas.style.left = `${left}px`
	Display.canvas.style.top = `${top}px`
	Display.canvas.style.width = `${canvasWidth * scale}px`
	Display.canvas.style.height = `${canvasHeight * scale}px`
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
	}
}

window.onkeyup = (key) => {
	switch (key.code) {
		case "Tab":
			Runner.speed = 1;
			break;
	}
}