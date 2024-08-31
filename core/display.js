export default class Display {

	static canvas;
	static context;

	static clearColor = "#000000";

	static linkCanvas(canvas) {
		this.canvas = canvas;
		this.context = this.canvas.getContext("2d");
	}

	static updateCanvasSize() {
		this.canvas.width = window.innerWidth;
		this.canvas.height = window.innerHeight;
	}

	static clearScreen() {
		this.context.fillStyle = this.clearColor;
		this.context.fillRect(0, 0, this.canvas.width, this.canvas.height);
	}

}