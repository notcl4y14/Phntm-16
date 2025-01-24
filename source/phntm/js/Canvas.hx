package phntm.js;

import js.Browser;

class Canvas extends ElementBuilder
{
	public function new () {}
	public function build () : Void
	{
		element = Browser.document.createElement("canvas");
		Browser.document.body.appendChild(element);
	}
}