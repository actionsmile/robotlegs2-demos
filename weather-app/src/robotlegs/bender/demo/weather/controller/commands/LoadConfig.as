/**
 * Copyright (c) 2009-2013 the original author or authors
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */
package robotlegs.bender.demo.weather.controller.commands {
	import robotlegs.bender.demo.events.ApplicationEvent;
	import flash.events.DataEvent;
	import robotlegs.bender.demo.model.api.IApplicationModel;
	import robotlegs.bender.demo.weather.model.WeatherAppVariables;
	import robotlegs.bender.extensions.commandCenter.api.ICommand;
	import robotlegs.bender.framework.api.ILogger;

	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class LoadConfig implements ICommand {
		[Inject]
		public var model : IApplicationModel;
		[Inject]
		public var logger : ILogger;
		[Inject]
		public var dispacther : IEventDispatcher;
		/**
		 * @private
		 */
		private var configLoader : URLLoader;

		public function execute() : void {
			this.createConfigLoader();
			this.configLoader.load(new URLRequest(this.model.getVariable(WeatherAppVariables.CONFIG_URL)));
		}

		private function dispose() : void {
			this.disposeConfigLoader();
			this.model = null;
			this.dispacther = null;
			this.logger = null;
		}

		private function createConfigLoader() : void {
			if (!this.configLoader) {
				this.configLoader = new URLLoader();
				this.configLoader.addEventListener(Event.OPEN, this.onConfigStartLoadingHandler);
				this.configLoader.addEventListener(ProgressEvent.PROGRESS, this.onConfigLoadingHandler);
				this.configLoader.addEventListener(Event.COMPLETE, this.onConfigLoadedHandler);
				this.configLoader.addEventListener(IOErrorEvent.IO_ERROR, this.onConfigLoadingErrorHandler);
				this.configLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onConfigLoadingErrorHandler);
			}
		}

		private function disposeConfigLoader() : void {
			if (this.configLoader) {
				this.configLoader.removeEventListener(Event.OPEN, this.onConfigStartLoadingHandler);
				this.configLoader.removeEventListener(ProgressEvent.PROGRESS, this.onConfigLoadingHandler);
				this.configLoader.removeEventListener(Event.COMPLETE, this.onConfigLoadedHandler);
				this.configLoader.removeEventListener(IOErrorEvent.IO_ERROR, this.onConfigLoadingErrorHandler);
				this.configLoader.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, this.onConfigLoadingErrorHandler);
				this.configLoader = null;
			}
		}

		// Handlers
		private function onConfigLoadedHandler(event : Event) : void {
			this.logger.debug("Config file successfully loaded.");
			this.dispacther.dispatchEvent(new DataEvent(DataEvent.DATA, false, false, this.configLoader.data));
			this.dispacther.dispatchEvent(new ApplicationEvent(ApplicationEvent.READY));
			this.dispose();
		}

		private function onConfigStartLoadingHandler(event : Event) : void {
			// create preloader
		}

		private function onConfigLoadingHandler(event : ProgressEvent) : void {
			// show progress
		}

		private function onConfigLoadingErrorHandler(event : SecurityErrorEvent) : void {
			// handle error
			this.logger.error(event.text);
			this.dispose();
		}
	}
}
