const { app, BrowserWindow } = require('electron/main')
const path = require('node:path')

function createWindow() {
	const config = {
		width: 800,
		height: 600
	};
	const win = new BrowserWindow(config);

	win.loadFile('html/index.html');
}

app.whenReady().then(() => {
	createWindow()

	app.on('activate', () => {
		if (BrowserWindow.getAllWindows().length === 0) {
			createWindow()
		}
	})
})

app.on('window-all-closed', () => {
	if (process.platform !== 'darwin') {
		app.quit()
	}
})