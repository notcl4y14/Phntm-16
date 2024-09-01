const tileWidth = 256 / 10;
const tileHeight = 256 / 10;

function update() {
	return;
}

function draw() {
	let x = 0;
	let y = 0;
	
	context.setColor(0);
	context.rectangle(0, 0, 256, 256);

	for (let i = 0; i <= 20; i++) {
		if (i > 0 && i % 10 == 0) {
			x = 0;
			y += 1;
		}

		context.setColor(i);
		context.rectangle(
			x * tileWidth,
			y * tileHeight,
			tileWidth,
			tileHeight
		);
		context.fill();

		x += 1;
	}
}