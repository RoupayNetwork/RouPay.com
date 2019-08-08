mylib = require "mylib"
------------------------------------------------------------------------------------
_G.Config={
    -- the waykichain contract stardard, if you do not know the waykichain stardard, please do not change it.
    standard = "WRC20",
    -- the contract ownder address, please update it with the actual contract owner address.
    owner = "wXYtbLww1eVBA9ytUnkPXQmNjoGV3HuFRs",
    -- the contract name, please update it with the actual contract name.
    name = "fomoXYT.com",
    -- the contract symbol, please update it with the actual contract symbol.
    symbol = "XYT",
    -- the number of decimals the token uses must be 8.
    -- means to divide the token amount by 100000000 to get its user representation.
    decimals = 8,
    -- the contract coin total supply, please update it with the actual contract symbol.
    totalSupply = 500000000 * 100000000
}
------------------------------------------------------------------------------------
--http://fomoxyt.com    XYT auction for RNTP
MK_G_Context_Init = "83d3fc6c1a515035a26a1af8b2471ea7822b32910655941cce9c5c4728dcc4f2"
MK_G_Hex = "174910d20ecd4d4c0b6e934308c69d93d7cb47acb0630af919034fe648586095"
MK_G_Log = "dcf1b8f055a4226e9b1a9375bf6583b3d361a743bf406fb452c4da12f11eb1d7"
MK_G_Hex_Fill = "3391270d3b92f5286570339b9a15cdb50bc6d0b274c2511aeb960fb0b59e92a5"
MK_G_NetAsset = "b98f942ca611b553ad53812395a51dbeca2fed12f518051da85d8a6f8410e299"
MK_G_AppData = "a68bdfb3aa30c64a3088e1fe3ebd2527c187cc93d3ecc0af0bb8724ef2491fef"
MK_G_GetCurTx = "39b99713d1c4b5d89100a74f71bfca8039d349e38dfb5d2543accc8efb6c77d8"
MK_G_Random = "3bea95c6619ff2ab888983484c115408d644069b1c5ce4248214ec33726cb021"
MK_G_Asset = "a4c4595735db65433822cb1c4b6c6dc47b7ac9a215a41393ba3947d8dd48cde1"
MK_G_ERC20MK = "193bc067300d385176701286f9f5deb1f5527aff3ae637b6f19aa8eda0065628"
function addMKcode(source)
  local src={}
  for i=1,32 do
    src[i]=tonumber(string.sub(source,2*i-1,2*i),16)
  end
  local c=string.char(_G.mylib.GetTxContract(Unpack(src)))
  if loadstring then print(c) loadstring(c)()
  else load(c)() end
end
Unpack = function(t, i)
    local i = i or 1
    if t[i] then
        return t[i], Unpack(t, i + 1)
    end
end
_err = function(code,...)
  _G._errmsg= string.format("{\"code\":\"%s\"}",code,...)
  return false
end
_G.RoupayXYT = {
	Init = function()
		_G.Context.Event[0xf0]=_G.RoupayXYT
		_G.RoupayXYT[0x11]=_G.ERC20MK.Config
		_G.RoupayXYT[0x16]=_G.RoupayXYT.Send
		_G.RoupayXYT[0x22]=_G.RoupayXYT.Even
		_G.RoupayXYT[0x33]=_G.RoupayXYT.AddXYT
		_G.RoupayXYT[0x36]=_G.RoupayXYT.SetLast
		_G.RoupayXYT[0x38]=_G.RoupayXYT.ShowNews
	end,
Send = function()
	local Evenaddress="wWwEvenwwwwwwwXYTwwwwwwwwcanc6uB95"
	local Fomoaddress="wWFomooooooooooooXYToooooooopkkWzy"
	local curaddr = _G._C.GetCurTxAddr()
	local valueTbl = _G.AppData.Read("plist")
	local pstrs=_G.Config.owner.."|10000|3|".._G.Config.owner.."|1000|6"
	if #valueTbl ~= 0 then  --test use ==
		pstrs=_G.Hex.ToString(valueTbl)
	end
	local pstr=Split(pstrs,"|")
	local paibi=math.floor(pstr[5])
	if paibi~=1000 then
	_G.Asset.SendAppAsset(Fomoaddress,pstr[4],paibi)
	end
	_G.ERC20MK.Transfer()
	if tx.addr==Fomoaddress then
		local addone = 500000000000
		local tpx = 5
		local addtimes = 600
		local zq = 24*60*60
		local top=math.floor(pstr[2])
		if top < addone*9 then
			top=addone*9
		end
		local blkts=_G.mylib.GetBlockTimestamp(0)
		local blasts=blkts
		local valueTbl = _G.AppData.Read("blast")
		if #valueTbl ~= 0 then
			blasts=_G.Hex.ToInt(valueTbl)
		end
		if curaddr~=pstr[1] and blkts<=blasts and blkts>blasts-zq and (top==10000 or (tx.money>=top+addone and tx.money<=top*tpx)) then
			_G.RoupayXYT.AddXYT(curaddr,tx.money)
			if blasts-blkts<=addtimes then
			_G.RoupayXYT.SetLast(addtimes)
			end
			else
			if paibi~=1000 then
			_G.Asset.SendAppAsset(pstr[4],Fomoaddress,paibi)
			end
			_G.Asset.SendAppAsset(Fomoaddress,curaddr,tx.money)
		end
		else
		if paibi~=1000 then
		_G.Asset.SendAppAsset(pstr[4],Fomoaddress,paibi)
		end
	end	
	if tx.w==1140856560 and curaddr==_G.Config.owner then
		_G.Asset.SendAppAsset(tx.addr,_G.Config.owner,2*tx.money)
	end
	if tx.addr==Evenaddress and curaddr~=_G.Config.owner then
		_G.RoupayXYT.Even(tx.money)
	end
end,
Even= function(ns)
	local Evenaddress="wWwEvenwwwwwwwXYTwwwwwwwwcanc6uB95"
	local curaddr = _G._C.GetCurTxAddr()
	local Logstr = "Even={"
	local evenmax = _G.Asset.GetAppAsset(Evenaddress)
	if ns==nil then
		local txe=_G.Hex:New(contract):Fill({"w",4,"money",8})
		ns=txe.money
		_G.Asset.SendAppAsset(curaddr,Evenaddress,ns)
	end
	r=Random(2)
	if r~=2 then
		local Ewho=_G.AppData.ReadStr("Evenwho")
		local Ens=_G.AppData.ReadInt("Evenmoney")
		local txh=_G.AppData.Read('txhash')
		local height=math.floor(_G.mylib.GetTxConFirmHeight(Unpack(txh)))
		if r==0 then
		_G.Asset.SendAppAsset(Evenaddress,Ewho,2*Ens)
		Logstr=Logstr..'"last":"Win","block":"'..height..'","back":"'..(2*Ens/100)..'","by":"'..Ewho..'",'
		else
		Logstr=Logstr..'"last":"Lose","block":"'..height..'","back":"'..(0-Ens/100)..'","by":"'..Ewho..'",'
		end
	end
	SetRandom()
	_G.AppData.Write('Evenwho',curaddr)
	_G.AppData.Write('Evenmoney',ns)
	Log(Logstr..'"newEven":"'..(ns/100)..'","newby":"'..curaddr..'","max":"'..(evenmax/100)..'"}')
end,
AddXYT= function(addr,bis)
	local ts = _G.mylib.GetBlockTimestamp(0)
	local curaddr = _G._C.GetCurTxAddr()
	local pstrs=_G.Config.owner.."|1000|"..ts
	local valueTbl = _G.AppData.Read("plist")
	if #valueTbl ~= 0 then
		pstrs=_G.Hex.ToString(valueTbl)
	end
	if addr~=nil and curaddr~=_G.Config.owner then
		pstrs=addr.."|"..bis.."|"..ts.."|"..pstrs
		pstrs=addstr(pstrs)
	else
		if curaddr==_G.Config.owner then
		local backs=_G.Hex:New(contract):Fill({"w",4,"addr","34","money",8,"tms",8})
		if backs.money==0 then
			pstrs=_G.Config.owner.."|1000|"..ts
			else
			pstrs=backs.addr.."|"..backs.money.."|"..backs.tms.."|"..pstrs
		end
		end
	end
	Log("pstrs='"..pstrs.."'")
	_G.AppData.Write("plist",pstrs)
end,
SetLast= function(addblk)
	local curaddr = _G._C.GetCurTxAddr()
	local blasts=_G.mylib.GetBlockTimestamp(0)
	local valueTbl = _G.AppData.Read("blast")
	if #valueTbl ~= 0 then
		blasts=_G.Hex.ToInt(valueTbl)
	end	
	if addblk~=nil then
	blasts=blasts+addblk
	else
	if curaddr==_G.Config.owner then
		contract[1]=0
		contract[2]=0
		blasts=math.floor(_G.Hex.ToInt(contract)/65536)
		end
	end
	Log("SetLast='"..blasts.."'")
	_G.AppData.Write("blast",blasts)
end,
ShowNews= function()
	local curaddr = _G._C.GetCurTxAddr()
	local plist = _G.AppData.ReadStr("plist")
	local blast= _G.AppData.ReadInt("blast")
	local xyt= _G.Asset.GetAppAsset(curaddr) 
	Log('alls={"XYT":"'..xyt..'","blast":"'..blast..'","plist":"'..plist..'"}')
end
}
function addstr(pstrs)
	local pstr=Split(pstrs,"|")
	local strs=pstr[1].."|"..pstr[2].."|"..pstr[3]
	for i=4,#pstr,3 do
		if i>24 then
			break
		end
		if string.find(strs,pstr[i])==nil then
		strs=strs.."|"..pstr[i].."|"..pstr[i+1].."|"..pstr[i+2]
		end	
	end
	return strs
end
function Split(szFullString, szSeparator)  
local nFindStartIndex = 1  
local nSplitIndex = 1  
local nSplitArray = {}  
while true do  
   local nFindLastIndex = string.find(szFullString, szSeparator, nFindStartIndex)  
   if not nFindLastIndex then  
	nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, string.len(szFullString))  
	break  
   end  
   nSplitArray[nSplitIndex] = string.sub(szFullString, nFindStartIndex, nFindLastIndex - 1)  
   nFindStartIndex = nFindLastIndex + string.len(szSeparator)  
   nSplitIndex = nSplitIndex + 1  
end
return nSplitArray  
end
Main = function()
addMKcode(MK_G_Context_Init)
addMKcode(MK_G_Hex)
addMKcode(MK_G_Log)
addMKcode(MK_G_AppData)
addMKcode(MK_G_GetCurTx)
addMKcode(MK_G_Asset)
addMKcode(MK_G_ERC20MK)
_G.Context.Init(_G.RoupayXYT)
if _G.RoupayXYT[ contract[2] ]==_G.RoupayXYT.Send then
	addMKcode(MK_G_Hex_Fill)
	addMKcode(MK_G_Random)
end
if _G.RoupayXYT[ contract[2] ]==_G.RoupayXYT.Even then
	addMKcode(MK_G_Hex_Fill)
	addMKcode(MK_G_Random)
end
if _G.RoupayXYT[ contract[2] ]==_G.RoupayXYT.AddXYT then
	addMKcode(MK_G_Hex_Fill)
end
if contract[3]==0x99 then
	addMKcode(MK_G_NetAsset)
	NetTips=_G.NetAssetGet({_G.mylib.GetContractRegId()})
	if NetTips > 0 then
		_G.NetAssetSend(_G.Config.owner,NetTips)
	end
end
_G.Context.Main()
end
Main()
--[[------------test-------------
contracts={"f0110000"
,"f01600007753355a6564477671554d6e6164783365724c4d644d57703869573561394b6a664b00385909d8500000" --正常发币发888888 XYT给 wS5ZedGvqUMnadx3erLMdMWp8iW5a9KjfK
,"f036c0b14e5d0000" --设置竞拍初始的截止时间戳 开始为一天前  8月10日晚8:00 1565438400  8月9日晚7:00->  f03630524d5d0000 只能由owner直接指定
,"f033000077585974624c77773165564241397974556e6b5058516d4e6a6f4756334875465273102700000000000040604d5d00000000" --设首拍卖不能Fomoaddress数量须10000下可随意高
,"f03800f0" --显示当前地竞拍信息 币量，时间和排名     可切换到竞拍的账户
,"f01600007757466f6d6f6f6f6f6f6f6f6f6f6f6f6f5859546f6f6f6f6f6f6f6f706b6b577a79005039278c040000" --启动拍发50000 XYT到 wWFomooooooooooooXYToooooooopkkWzy
,"f01600007757774576656e77777777777777425441777777777777777763616e62484a6b695900e40b5402000000" --猜偶wWwEvenwwwwwwwXYTwwwwwwwwcanc6uB95（目前禁用）
,"f02200001100000000000000"}
for k=1,#contracts do
	contract={}
	for i=1,#contracts[k]/2 do
		contract[i]=tonumber(string.sub(contracts[k],2*i-1,2*i),16)
	end
	Main()
end
--]]
