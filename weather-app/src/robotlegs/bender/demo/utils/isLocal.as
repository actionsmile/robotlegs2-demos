package robotlegs.bender.demo.utils {
	import flash.net.LocalConnection;
	import flash.system.Capabilities;
	/**
	 * @playerversion			Adobe Flashplayer 11.1 or higher
	 * @langversion				Actionscript 3.0
	 * @author					Aziz Zaynutdinov (aziz.zaynutdinoff at gmail.com)
	 * 
	 * Checks, if <code>swf</code>-application lunched on local device or from net
	 * @return <code>true</code>, if application lunched localy
	 */
	public function isLocal() : Boolean {
		var connection : LocalConnection = new LocalConnection();
		var result : Boolean = Capabilities.playerType == "Desktop" || connection.domain == "localhost";
		connection = null;
		return result;
	}
}
