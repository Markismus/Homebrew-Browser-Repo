---------------------------------------------------------------------------
-- wield.lua
-- Selects extra items to wield.
--
-- To use this, add this line to your init.txt:
--   lua_file = lua/wield.lua
---------------------------------------------------------------------------

function make_hash(ls)
    local h = { }
    for _, i in ipairs(ls) do
        h[i] = true
    end
    return h
end

function ch_item_wieldable(it)
    -- We only need to check for unusual cases - basic matching is handled
    -- by Crawl itself.
    local spells = make_hash( you.spells() )

    if spells["Bone Shards"]
            and string.find( item.name(it, "a"), " skeleton" )
    then
        return true
    end

    if (spells["Sublimation of Blood"] or spells["Simulacrum"])
            and food.ischunk(it)
    then
        return true
    end

    if spells["Sandblast"]
            and item.class(it, true) == "missile"
            and string.find( item.name(it, "a"), " stones?" )
    then
        return true
    end

    if spells["Sticks to Snakes"]
            and item.class(it, true) == "missile"
            and string.find( item.name(it, "a"), " arrows?" )
    then
        return true
    end

    return false
end
