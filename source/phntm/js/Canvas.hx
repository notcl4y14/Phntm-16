package phntm.js;

import js.Browser;

class Canvas extends Element
{
	public function new () {}
	public function build () : Void
	{
		element = Browser.document.createElement("canvas");
		Browser.document.body.appendChild(element);
	}
}