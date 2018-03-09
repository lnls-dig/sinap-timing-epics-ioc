from org.csstudio.opibuilder.scriptUtil import PVUtil
from org.csstudio.opibuilder.scriptUtil import ColorFontUtil

num=int(display.getWidget("EvtNum").getPropertyValue("text"))

callname = widget.getPropertyValue("name")

if ((callname == 'EvtUp') & (num < 63)):
  num = num + 1

elif ((callname == 'EvtDown') & (num > 1)):
  num = num - 1

if (num > 63):
  num = 63
elif (num < 1):
  num = 1

display.getWidget("EvtNum").setPropertyValue("text", str(num))

if (num < 10):
  code = '0'+str(num)
else:
  code = str(num)

display.getWidget("EvtLabel").setPropertyValue("text", "Event "+code)
display.getWidget("EvtCode").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Code-Mon")
display.getWidget("EvtTime").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Delay-SP")
display.getWidget("EvtTimeRB").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Delay-RB")
display.getWidget("EvtDesc").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Desc-SP")
display.getWidget("EvtDescRB").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Desc-RB")
display.getWidget("EvtMode").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"DelayType-Sel")
display.getWidget("EvtModeSts").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"DelayType-Sts")
display.getWidget("EvtTrans").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Mode-Sel")
display.getWidget("EvtTransSts").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"Mode-Sts")
display.getWidget("EvtTrig").setPropertyValue("pv_name", "$(P)$(R)Evt"+code+"ExtTrig-Cmd")
