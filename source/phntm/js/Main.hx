package phntm.js;

import js.Browser;
import phntm.rendering.Display;

class Main
{
	private static var canvas : js.html.CanvasElement;
	private static var context : js.html.CanvasRenderingContext2D;

	private static var display : Display;

	public static function main () : Void
	{
		Browser.window.onresize = () -> fitCanvasToWindow();
		
		canvas = Browser.document.createCanvasElement();
		context = canvas.getContext("2d");

		Browser.document.body.appendChild(canvas);

		display = new Display(128, 128);
		display.setColor(10, 10, [255, 255, 255, 255]);
		display.setColor(11, 10, [255, 255, 255, 255]);
		display.setColor(11, 11, [255, 255, 255, 255]);
		display.setColor(10, 11, [255, 255, 255, 255]);

		fitCanvasToWindow();
		applyDisplay();
	}

	private static function applyDisplay ()
	{
		var displayDim = display.getSize();
		var index = -1;
		var imageData : js.html.ImageData = context.createImageData(displayDim[0], displayDim[1]);

		while (++index < display.getArea())
		{
			var color : Array<Int> = display.getColor(
				index % displayDim[0],
				Std.int(index / displayDim[0])
			);

			var pixelIndex = index * 4;
			
			imageData.data[pixelIndex] = color[0];
			imageData.data[pixelIndex + 1] = color[1];
			imageData.data[pixelIndex + 2] = color[2];
			imageData.data[pixelIndex + 3] = color[3];
		}

		context.putImageData(imageData, 0, 0, 0, 0, canvas.width, canvas.height);
	}

	private static function fitCanvasToWindow ()
	{
		var widthScale = Browser.window.innerWidth / 128;
		var heightScale = Browser.window.innerHeight / 128;
		var scale = Math.min(widthScale, heightScale);

		var left = Browser.window.innerWidth / 2 - (128 * scale) / 2;
		var top = Browser.window.innerHeight / 2 - (128 * scale) / 2;

		canvas.width = cast (128 * scale, Int);
		canvas.height = cast (128 * scale, Int);

		canvas.style.left = '${left}px';
		canvas.style.top = '${top}px';
		canvas.style.width = '${128 * scale}px';
		canvas.style.height = '${128 * scale}px';
	}
}