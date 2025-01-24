package phntm.js;

import js.Browser;

class Main
{
	private static var canvas : js.html.CanvasElement;

	public static function main () : Void
	{
		canvas = Browser.document.createCanvasElement();
		Browser.document.body.appendChild(canvas);

		Browser.window.onresize = () -> fitCanvasToWindow();

		fitCanvasToWindow();
	}

	private static function fitCanvasToWindow ()
	{
		var widthScale = Browser.window.innerWidth / 256;
		var heightScale = Browser.window.innerHeight / 256;
		var scale = Math.min(widthScale, heightScale);

		var left = Browser.window.innerWidth / 2 - (256 * scale) / 2;
		var top = Browser.window.innerHeight / 2 - (256 * scale) / 2;

		canvas.width = cast (256 * scale, Int);
		canvas.height = cast (256 * scale, Int);

		canvas.style.left = '${left}px';
		canvas.style.top = '${top}px';
		canvas.style.width = '${256 * scale}px';
		canvas.style.height = '${256 * scale}px';
	}
}