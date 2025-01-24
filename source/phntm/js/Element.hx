package phntm.js;

import js.Browser;

abstract class Element
{
	public var element : js.html.Element;
	public abstract function build () : Void;
}