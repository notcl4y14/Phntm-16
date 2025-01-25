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
		display.fill([255, 255, 255, 255]);

		var displayDim = display.getSize();
		
		for (x in 0...displayDim[0])
		{
			for (y in 0...displayDim[1])
			{
				if ((x + y) % 2 == 0)
				{
					continue;
				}

				display.setColor(x, y, [25, 25, 25, 255]);
			}
		}

		fitCanvasToWindow();
		applyDisplay();
	}

	private static function applyDisplay ()
	{
		var displayDim = display.getSize();
		var index = -1;

		var scaleX : Int = Std.int(canvas.width / displayDim[0]);
		var scaleY : Int = Std.int(canvas.height / displayDim[1]);

		while (++index < display.getArea())
		{
			var x : Int = index % displayDim[0];
			var y : Int = Std.int(index / displayDim[0]);
			var color : Array<Int> = display.getColor(x, y);

			context.fillStyle = 'rgba(${color[0]}, ${color[1]}, ${color[2]}, ${color[3]})';
			context.fillRect(x * scaleX, y * scaleY, scaleX, scaleY);
		}
	}

	private static function fitCanvasToWindow ()
	{
		var widthScale = Browser.window.innerWidth / 128;
		var heightScale = Browser.window.innerHeight / 128;
		var scale = Math.min(widthScale, heightScale);

		var left = Browser.window.innerWidth / 2 - (128 * scale) / 2;
		var top = Browser.window.innerHeight / 2 - (128 * scale) / 2;

		var width : Int = Std.int(128 * scale);
		var height : Int = Std.int(128 * scale);

		// Subtract by 1 if the width/height value is odd.
		width = width - width % 2;
		height = height - height % 2;

		canvas.width = width;
		canvas.height = height;

		canvas.style.left = '${left}px';
		canvas.style.top = '${top}px';
		canvas.style.width = '${width}px';
		canvas.style.height = '${height}px';
	}
}