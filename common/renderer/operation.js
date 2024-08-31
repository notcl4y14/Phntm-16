export default class Operation {

	type;
	values;
	
	constructor (type, values = []) {
		this.type = type;
		this.values = values;
	}
	
}