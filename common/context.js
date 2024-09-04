import Display from "../core/display.js";

export class Context {
	
	static _colors = {
		0:  [ 0,   0,   0 ], // black
		1:  [ 255, 255, 255 ], // white

		2:  [ 62,  73,  106 ], // dark blue-gray
		3:  [ 86,  108, 134 ], // blue-gray
		4:  [ 148, 176, 194 ], // light blue-gray

		5:  [ 132, 152, 171 ], // gray
		6:  [ 187, 204, 216 ], // light-gray

		7:  [ 59,  6,  58 ], // dark purple
		8:  [ 105, 23, 73 ], // purple
		9:  [ 222, 58, 104 ], // red

		10: [ 156, 50,  71 ], // dark brown
		11: [ 158, 82,  82 ], // brown

		12: [ 119, 176, 42 ], // green
		13: [ 198, 216, 49 ], // lime

		14: [ 239, 125, 87 ], // orange
		15: [ 255, 231, 133 ], // yellow

		16: [ 32,  77,  140 ], // dark grayish blue
		17: [ 72,  84,  168 ], // grayish blue
		18: [ 113, 153, 217 ], // light grayish blue
		19: [ 160, 208, 248 ], // sky blue
		20: [ 195, 228, 255 ], // light blue
	};
	
	static setColor (colorIndex) {
		const color = this._colors[colorIndex % 21];
		const rgb = `rgb(${color[0]},${color[1]},${color[2]})`;
		Display.context.fillStyle = rgb;
		Display.context.strokeStyle = rgb;
	}

	static stroke () {
		Display.context.stroke();
	}

	static fill () {
		Display.context.fill();
	}

	static beginPath () {
		Display.context.beginPath();
	}

	static closePath () {
		Display.context.closePath();
	}

	static rectangle (x, y, width, height) {
		Display.context.beginPath();
		Display.context.rect(
			x,
			y,
			width,
			height
		);
		Display.context.closePath();
	}
	
}