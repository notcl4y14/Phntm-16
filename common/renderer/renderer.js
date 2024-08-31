import OperationType from "./optype.js";

export default class Renderer {

	buffer;

	constructor () {
		this.buffer = [];
	}

	add (operation) {
		this.buffer.push( operation );
	}

	clear () {
		this.buffer = [];
	}

	apply (context) {
		for (const op of this.buffer) {
			switch (op.type) {
				case OperationType.Fill:
					context.fill();
					break;
				
				case OperationType.Stroke:
					context.stroke();
					break;
				
				case OperationType.Color:
					context.fillStyle = op.values[0];
					context.strokeStyle = op.values[0];
					break;

				case OperationType.Clear:
					context.fillRect(0, 0, context.canvas.width, context.canvas.height);
					break;

				case OperationType.Rectangle:
					context.rect(op.values[0], op.values[1], op.values[2], op.values[3]);
					break;
			}
		}
	}
	
}