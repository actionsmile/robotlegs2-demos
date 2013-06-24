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
package robotlegs.bender.demo.weather.model.appconfig {
	import robotlegs.bender.demo.commands.InitStageOptions;
	import robotlegs.bender.demo.commands.NullCommand;
	import robotlegs.bender.demo.events.ApplicationEvent;
	import robotlegs.bender.demo.weather.controller.commands.AddUIElements;
	import robotlegs.bender.demo.weather.controller.commands.LoadConfig;
	import robotlegs.bender.demo.weather.controller.commands.guards.OnlyIfDataContainsGateway;
	import robotlegs.bender.demo.weather.controller.commands.hooks.GetConfigURL;
	import robotlegs.bender.demo.weather.controller.commands.hooks.InitWeatherService;
	import robotlegs.bender.extensions.eventCommandMap.api.IEventCommandMap;

	import flash.events.DataEvent;
	import flash.events.Event;

	/**
	 * @author Aziz Zaynutdinov (actionsmile at icloud.com)
	 * @langversion Actionscript 3.0
	 */
	public class WeatherAppCommandMapping {
		// App configuration file, which contains command mapping section
		[Inject]
		public var commandMap : IEventCommandMap;

		[PostConstruct]
		public function init() : void {
			// after stage initialization, command map will automatically unmap this event
			this.commandMap.map(Event.INIT).toCommand(InitStageOptions).once();
			this.commandMap.map(ApplicationEvent.LAUNCH).toCommand(LoadConfig).withHooks(GetConfigURL).once();
			this.commandMap.map(DataEvent.DATA, DataEvent).toCommand(NullCommand).withHooks(InitWeatherService).withGuards(OnlyIfDataContainsGateway).once();
			this.commandMap.map(ApplicationEvent.READY).toCommand(AddUIElements).once();
		}
	}
}
