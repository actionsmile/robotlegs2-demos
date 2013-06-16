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
package robotlegs.bender.demo.weather {
	import robotlegs.bender.demo.weather.model.appconfig.WeatherAppMediatorMapping;
	import robotlegs.bender.demo.weather.model.appconfig.WeatherAppCommandMapping;
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.demo.weather.model.appconfig.WeatherAppInjections;
	import robotlegs.bender.demo.weather.model.appconfig.WeatherAppLaunch;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import flash.display.Sprite;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class WeatherApp extends Sprite {
		/**
		 * @private appication container Sprite
		 */
		private var _appContainer : Sprite;
		/**
		 * @private app context
		 */
		private var _context : IContext;
		
		/**
		 * This is main application class.
		 * All we need is just instantiate application context,
		 * application container and add container to display list.
		 */
		public function WeatherApp() {
			this._appContainer = new Sprite();
			this._context = new Context().
				install(MVCSBundle).configure(new ContextView(this._appContainer)).
				configure(WeatherAppInjections, WeatherAppCommandMapping, WeatherAppMediatorMapping).
				afterInitializing(this.onContextInitializedHandler);
			/**
			 * when <code>this._appContainer</code> added to stage,
			 * StageSyncExtension initiates context initialization.
			 * If your container already in stage display list and
			 * you need to handle <code>afterInitialization</code>,
			 * use <code>this._context.initialized ? this.onContextInitializedHandler() : this._context.initialize();</code>
			 */
			this.addChild(this._appContainer);
		}

		// Handlers
		/**
		 * @private This method invokes after context initialization
		 * @return void
		 */
		private function onContextInitializedHandler() : void {
			this._context.configure(WeatherAppLaunch);
		}
	}
}
