import Display from "./display.js";

export default class Runner {

	static draws = 0;
	static ticks = 0;

	static targetFPS = 60;
	static targetUPS = 60;

	static speed = 1;

	static paused = true;

	static update() {
		return;
	}

	static draw() {
		Display.context.fillStyle = "#000000";
		Display.context.fillRect(0, 0, Display.canvas.width, Display.canvas.height);

		const size = Math.sin(this.ticks / 100) * 100;
		Display.context.fillStyle = "#ffffff";
		Display.context.fillRect(128, 128, size, size);
	}
	
	static async start() {
		Runner.paused = false;
		Runner.run();
	}

	static async stop() {
		Runner.paused = true;
	}

	static async run() {
		let lastTime = performance.now();
		
		let frameTime = 1000 / this.targetFPS;
		let updateTime = 1000 / this.targetUPS;

		let frameDelta = 0;
		let updateDelta = 0;

		let framesPerSecond = 0;
		let updatesPerSecond = 0;

		let timer = performance.now();

		while (!this.paused) {
			const now = performance.now();
			frameDelta += (now - lastTime) / frameTime;
			updateDelta += (now - lastTime) / (1000 / (this.targetUPS * this.speed));
			lastTime = now;

			while (updateDelta >= 1) {
				Runner.update();
				this.ticks += 1;
				updatesPerSecond += 1;
				updateDelta -= 1;
			}

			while (frameDelta >= 1) {
				Runner.draw();
				this.draws += 1;
				framesPerSecond += 1;
				frameDelta -= 1;
			}

			if (performance.now() - timer >= 1000) {
				console.log("FPS: " + framesPerSecond + " | UPS: " + updatesPerSecond);
				updatesPerSecond = 0;
				framesPerSecond = 0;
				timer += 1000;
			}

			await new Promise(resolve => setTimeout(resolve, 10));
		}
	}
}