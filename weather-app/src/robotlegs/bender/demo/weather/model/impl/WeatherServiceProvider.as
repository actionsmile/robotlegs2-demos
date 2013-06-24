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
package robotlegs.bender.demo.weather.model.impl {
	import robotlegs.bender.demo.weather.model.api.IWeatherProvider;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class WeatherServiceProvider implements IWeatherProvider {
		/**
		 * @private url dividers
		 */
		private var dividers : Vector.<String> = new <String>["://", ":", "@", ":", "/"];
		/**
		 * @private
		 */
		private var _config : Object;
		/**
		 * @private
		 */
		private var _gateway : String;
		/**
		 * @private
		 */
		private var _commands : Vector.<String>;
		/**
		 * @private
		 */
		private var _cities : Vector.<String>;

		public function init(config : Object) : void {
			this._config = config;
			this._commands = new <String>[this.forecast, this.weather, this.search];
			this._gateway = this.parseURI(config["gateway"]);
			this.extractArray(config["cities"], String, this.cities);
		}

		public function get gateway() : String {
			return this._gateway;
		}

		public function get commands() : Vector.<String> {
			return this._commands;
		}

		public function get forecast() : String {
			return this._config["forecast"] ||= "forecast";
		}

		public function get weather() : String {
			return this._config["weather"] ||= "weather";
		}

		public function get search() : String {
			return this._config["search"] ||= "search";
		}

		public function get query() : String {
			return this._config["query"] ||= "query";
		}

		public function get cities() : Vector.<String> {
			return this._cities ||= new Vector.<String>();
		}

		private function parseURI(source : Object) : String {
			var result : String;
			if (source) {
				result = source["protocol"] || "http";
				result += this.dividers[0];
				if (source["login"]) {
					result += source["login"];
					result += source["password"] ? (this.dividers[1] + source["password"]) : "";
					result += this.dividers[2];
				}
				result += source["host"] || "localhost";
				result += source["port"] > 0 ? (this.dividers[3] + source["port"]) : "";
				result += this.dividers[4];
				result += source["address"] || "";
			}
			return result;
		}

		private function extractArray(array : Array, type : Class, vector : *) : void {
			if (array)
				while (array.length > 0)
					vector["push"](new type(array.shift()));
			array = null;
		}
	}
}
