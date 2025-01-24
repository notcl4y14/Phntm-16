package phntm.js;

import js.Browser;

abstract class ElementBuilder
{
	public var element : js.html.Element;
	public abstract function build () : Void;
}