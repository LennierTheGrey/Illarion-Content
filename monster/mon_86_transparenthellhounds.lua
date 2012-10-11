require("monster.base.drop")
require("monster.base.lookat")
require("monster.base.quests")
require("base.messages");
module("monster.mon_86_transparenthellhounds", package.seeall)


function ini(Monster)

init=true;
monster.base.quests.iniQuests();
killer={}; --A list that keeps track of who attacked the monster last

--Random Messages

end

function enemyNear(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    if math.random(1,10) == 1 then
        monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while
    end
	
    return false
end

function enemyOnSight(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end

    monster.base.drop.MonsterRandomTalk(Monster,msgs); --a random message is spoken once in a while

    if monster.base.drop.DefaultSlowdown( Monster ) then
        return true
    else
        return false
    end
end

function onAttacked(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end
    monster.base.kills.setLastAttacker(Monster,Enemy)
    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onCasted(Monster,Enemy)

    if init==nil then
        ini(Monster);
    end
    monster.base.kills.setLastAttacker(Monster,Enemy)
    killer[Monster.id]=Enemy.id; --Keeps track who attacked the monster last
end

function onDeath(Monster)

	local NoDrop=Monster:getSkill("no drop pls")
	if NoDrop >= 10 then
	return;
	end
	
    if killer and killer[Monster.id] ~= nil then

        murderer=getCharForId(killer[Monster.id]);
    
        if murderer then --Checking for quests

            monster.base.quests.checkQuest(murderer,Monster);
            killer[Monster.id]=nil;
            murderer=nil;

        end
    end
    
    monster.base.drop.ClearDropping();
    local MonID=Monster:getMonsterType();

if (MonID==861) then --Crippled Ghostbeast, Level: 5, Armourtype: light, Weapontype: concussion

        --Category 1: Special Loot

        local done=monster.base.drop.AddDropItem(63,1,20,(100*math.random(4,5)+math.random(44,55)),0,1); --entrails 
        if not done then done=monster.base.drop.AddDropItem(257,1,10,(100*math.random(4,5)+math.random(44,55)),0,1); end --raw topaz
        if not done then done=monster.base.drop.AddDropItem(83,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --topas amulet
        if not done then done=monster.base.drop.AddDropItem(283,1,1,(100*math.random(4,5)+math.random(44,55)),0,1); end --blackstone
        if not done then done=monster.base.drop.AddDropItem(359,1,1,(100*math.random(1,1)+math.random(11,11)),0,1); end --flame 

        --Category 2: Special Loot

        local done=monster.base.drop.AddDropItem(197,1,20,(100*math.random(4,5)+math.random(44,55)),0,2); --amethyst
        if not done then done=monster.base.drop.AddDropItem(285,1,10,(100*math.random(4,5)+math.random(44,55)),0,2); end --diamond
        if not done then done=monster.base.drop.AddDropItem(79,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --amethyst amulet
        if not done then done=monster.base.drop.AddDropItem(62,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --emerald amulet
        if not done then done=monster.base.drop.AddDropItem(45,1,1,(100*math.random(4,5)+math.random(44,55)),0,2); end --emerald

        --Category 3: More Special Loot

        local done=monster.base.drop.AddDropItem(284,1,20,(100*math.random(4,5)+math.random(44,55)),0,3); --bluestone
        if not done then done=monster.base.drop.AddDropItem(46,1,10,(100*math.random(4,5)+math.random(44,55)),0,3); end --ruby
        if not done then done=monster.base.drop.AddDropItem(45,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --emerald
        if not done then done=monster.base.drop.AddDropItem(79,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --amethyst amulet
        if not done then done=monster.base.drop.AddDropItem(198,1,1,(100*math.random(4,5)+math.random(44,55)),0,3); end --topaz

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(2586,math.random(1,1),100,773,0,4); --fur


    elseif (MonID==862) then --Ghostbeast, Level: 6, Armourtype: medium, Weapontype: puncture

        --Category 1: Speical Loot

        local done=monster.base.drop.AddDropItem(63,1,20,(100*math.random(6,7)+math.random(55,66)),0,1); --entrails
        if not done then done=monster.base.drop.AddDropItem(253,1,10,(100*math.random(5,6)+math.random(55,66)),0,1); end --raw bluestone
        if not done then done=monster.base.drop.AddDropItem(46,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --ruby
        if not done then done=monster.base.drop.AddDropItem(198,1,1,(100*math.random(5,6)+math.random(55,66)),0,1); end --topaz
        if not done then done=monster.base.drop.AddDropItem(359,1,1,(100*math.random(1,1)+math.random(11,11)),0,1); end --flame

        --Category 2: Special Loot

        local done=monster.base.drop.AddDropItem(198,1,20,(100*math.random(5,6)+math.random(55,66)),0,2); --topaz
        if not done then done=monster.base.drop.AddDropItem(45,1,10,(100*math.random(5,6)+math.random(55,66)),0,2); end --emerald 
        if not done then done=monster.base.drop.AddDropItem(83,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --topaz amulet
        if not done then done=monster.base.drop.AddDropItem(71,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --bluestone amulet
        if not done then done=monster.base.drop.AddDropItem(45,1,1,(100*math.random(5,6)+math.random(55,66)),0,2); end --emerald

        --Category 3: More Special Loot

        local done=monster.base.drop.AddDropItem(46,1,20,(100*math.random(5,6)+math.random(55,66)),0,3); --ruby
        if not done then done=monster.base.drop.AddDropItem(283,1,10,(100*math.random(5,6)+math.random(55,66)),0,3); end --blackstone
        if not done then done=monster.base.drop.AddDropItem(284,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --bluestone
        if not done then done=monster.base.drop.AddDropItem(67,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --rubin amulet
        if not done then done=monster.base.drop.AddDropItem(83,1,1,(100*math.random(5,6)+math.random(55,66)),0,3); end --topaz amulet

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(2586,math.random(1,1),100,773,0,4); --fur


    elseif (MonID==863) then --Giant Ghostbeast, Level: 7, Armourtype: heavy, Weapontype: slashing

        --Category 1: Special Loot

        local done=monster.base.drop.AddDropItem(63,1,20,(100*math.random(6,7)+math.random(66,77)),0,1); --entrails
        if not done then done=monster.base.drop.AddDropItem(254,1,10,(100*math.random(6,7)+math.random(66,77)),0,1); end --raw diamond
        if not done then done=monster.base.drop.AddDropItem(198,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --topaz
        if not done then done=monster.base.drop.AddDropItem(83,1,1,(100*math.random(6,7)+math.random(66,77)),0,1); end --topaz amulet
        if not done then done=monster.base.drop.AddDropItem(359,1,1,(100*math.random(1,1)+math.random(11,11)),0,1); end --flame

        --Category 2: Special Loot

        local done=monster.base.drop.AddDropItem(284,1,20,(100*math.random(6,7)+math.random(66,77)),0,2); --bluestone
        if not done then done=monster.base.drop.AddDropItem(197,1,10,(100*math.random(6,7)+math.random(66,77)),0,2); end --amethyst
        if not done then done=monster.base.drop.AddDropItem(222,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --amulet
        if not done then done=monster.base.drop.AddDropItem(82,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --blackstone amulet 
        if not done then done=monster.base.drop.AddDropItem(284,1,1,(100*math.random(6,7)+math.random(66,77)),0,2); end --bluestone

        --Category 3: More Special Loot

        local done=monster.base.drop.AddDropItem(46,1,20,(100*math.random(6,7)+math.random(66,77)),0,3); --ruby
        if not done then done=monster.base.drop.AddDropItem(45,1,10,(100*math.random(6,7)+math.random(66,77)),0,3); end --emerald
        if not done then done=monster.base.drop.AddDropItem(283,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --blackstone
        if not done then done=monster.base.drop.AddDropItem(62,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --emerald amulet
        if not done then done=monster.base.drop.AddDropItem(2553,1,1,(100*math.random(6,7)+math.random(66,77)),0,3); end --pure fire

        --Category 4: Perma Loot
        monster.base.drop.AddDropItem(2586,math.random(1,1),100,773,0,4); --fur

    end
    monster.base.drop.Dropping(Monster);
end
