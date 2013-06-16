package robotlegs.bender.demo.hello {
	import robotlegs.bender.bundles.mvcs.MVCSBundle;
	import robotlegs.bender.demo.hello.model.appconfig.HelloWorldAppLaunch;
	import robotlegs.bender.demo.hello.model.appconfig.HelloWorldAppPrepare;
	import robotlegs.bender.extensions.contextView.ContextView;
	import robotlegs.bender.framework.api.IContext;
	import robotlegs.bender.framework.impl.Context;

	import flash.display.Sprite;

	public class HelloWorld extends Sprite {
		/**
		 * @private
		 */
		private var context : IContext;
		/**
		 * @private
		 */
		private var appHolder : Sprite;

		public function HelloWorld() {
			this.appHolder = new Sprite();
			this.context = new	Context().
				install(MVCSBundle).
				configure(new ContextView(this.appHolder), HelloWorldAppPrepare).
				afterInitializing(this.onContextInitedHandler);
			this.context.initialized && this.onContextInitedHandler();
			this.addChild(this.appHolder);
		}

		/**
		 * @private <code>IContext</code> inited. Lets launch this app
		 */
		private function onContextInitedHandler() : void {
			this.context.configure(HelloWorldAppLaunch);
		}
	}
}