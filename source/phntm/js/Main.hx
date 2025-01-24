package phntm.js;

import js.Browser;

class Main
{
	public static function main () : Void
	{
		var widthScale = Browser.window.innerWidth / 256;
		var heightScale = Browser.window.innerWidth / 256;
		var scale = Math.min(widthScale, heightScale);

		var left = Browser.window.innerWidth / 2 - (256 * scale) / 2;
		var top = Browser.window.innerHeight / 2 - (256 * scale) / 2;

		var canvas = Browser.document.createCanvasElement();

		canvas.width = cast (256 * scale, Int);
		canvas.height = cast (256 * scale, Int);

		canvas.style.left = '${left}';
		canvas.style.top = '${top}';
		canvas.style.width = '${256 * scale}';
		canvas.style.height = '${256 * scale}';

		Browser.document.body.appendChild(canvas);
	}
}