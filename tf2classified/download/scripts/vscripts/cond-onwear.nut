// Code by @theclockstealer

::ListenToGameEvent("post_inventory_application", function(hEvent)
{
	local player = GetPlayerFromUserID(hEvent.userid)
	player.ValidateScriptScope()

	local cond 
	for (local i = 0; i < 8; i++)
	{
		local held_weapon = NetProps.GetPropEntityArray(player, "m_hMyWeapons", i)
		if (held_weapon == null)
			continue
		if (cond = held_weapon.GetAttribute("add cond to wearer", 0))
		{
			local scriptscope = held_weapon.GetOrCreatePrivateScriptScope()
			scriptscope.wearercondition <- cond
			AddThinkToEnt(held_weapon, "CondReapplier")
		}
	}
}, "cond_on_wear")


function CondReapplier()
{
	if (!self || !self.IsValid())
	{
		return -1
	}
	local scriptscope = self.GetOrCreatePrivateScriptScope()
	self.GetOwner().AddCondEx(scriptscope.wearercondition, 0.2, self.GetOwner())
}
