function onUnload()
{
   trace("Closing Sonny AS2 Bridge");
   sendWrapperMessage("Closing Sonny 1 Client Connection");
   _root.swfBridge.close();
}
var swiftBridgeAS2 = new com.gskinner.utils.SWFBridgeAS2("_sonnyConnect",this);
_root.swfBridge = swiftBridgeAS2;
trace("swf Bridge Made: " + _root.swfBridge);
sendAchievement = function(key)
{
   _root.swfBridge.send("GetAchivementFromClient",key);
   trace("Sending Achivement " + key + " using swfBridge: " + _root.swiftBridgeAS2);
};
sendWrapperMessage = function(payload)
{
   _root.swfBridge.send("MessageFromClient",payload);
};
isDebugMode = false;
