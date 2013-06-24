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
package robotlegs.bender.demo.weather.controller.commands.hooks {
	import robotlegs.bender.demo.model.api.IApplicationModel;
	import robotlegs.bender.demo.namespaces.offline;
	import robotlegs.bender.demo.namespaces.online;
	import robotlegs.bender.demo.utils.isLocal;
	import robotlegs.bender.demo.weather.model.WeatherAppVariables;
	import robotlegs.bender.framework.api.IHook;

	import flash.display.Stage;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class GetConfigURL implements IHook {
		[Inject(name="applicationStage")]
		public var stage : Stage;
		[Inject]
		public var model : IApplicationModel;
		
		// configURL values, according launch mode
		offline var configURL : String = "./../config/app.settings";
		online var configURL : String = "";

		public function hook() : void {
			var mode : Namespace = isLocal() ? offline : online;
			online::configURL = this.stage.root.loaderInfo.parameters["config"];
			this.model.setVariable(WeatherAppVariables.CONFIG_URL, mode::configURL);
			
			this.dispose();
		}

		private function dispose() : void {
			this.model = null;
			this.stage = null;
		}
	}
}
