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
package robotlegs.bender.demo.weather.controller {
	import robotlegs.bender.demo.weather.model.api.IWeatherProvider;
	import robotlegs.bender.demo.weather.view.api.IWeatherUI;
	import robotlegs.bender.extensions.mediatorMap.api.IMediator;
	import robotlegs.bender.framework.api.ILogger;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class WeatherUIMediator implements IMediator {
		[Inject]
		public var ui : IWeatherUI;
		[Inject]
		public var service : IWeatherProvider;
		[Inject]
		public var logger : ILogger;

		public function initialize() : void {
			this.logger.info("Current gateway is {0}", [this.service.gateway]);
		}

		public function destroy() : void {
			this.ui.dispose();
			this.ui = null;

			this.service = null;
			this.logger = null;
		}
	}
}
