// Code by @jugheadbomb

function WeaponCond_OnEntitySpawned(entity)
{
	entity.SetContextThink("WeaponCond_EntitySpawnPost", WeaponCond_EntitySpawnPost, 0.01)
}

function WeaponCond_EntitySpawnPost(entity)
{
	if (!entity)
		return;

	local classname = entity.GetClassname();

	if (classname.find("tf_weapon") != null || classname.find("tf2c_weapon") != null)
	{
		local cond = entity.GetAttribute("add cond while active", 0.0).tointeger();
		if (cond == 0)
			return;

		local owner = entity.GetOwner();

		entity.ValidateScriptScope();
		entity.GetScriptScope().WeaponThink <- function()
		{
			if (self == null || !self.IsValid())
				return;

			if (owner.GetActiveWeapon() == self)
			{
				owner.AddCondEx(cond, 0.15, null);
			}

		}

		AddThinkToEnt(entity, "WeaponThink");
	}
}

local weapon = null;
while (weapon = Entities.FindByClassname(weapon, "tf_weapon*"))
{
	WeaponCond_OnEntitySpawned(weapon);
}

weapon = null;
while (weapon = Entities.FindByClassname(weapon, "tf2c_weapon*"))
{
	WeaponCond_OnEntitySpawned(weapon);
}

Entities.EnableEntityListening()
Hooks.Add(this, "OnEntitySpawned", WeaponCond_OnEntitySpawned, "WeaponCond")