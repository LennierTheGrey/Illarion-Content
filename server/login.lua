-- called after every player login
require("base.common")
require("content.dailymessage")

module("server.login", package.seeall);

function onLogin( player )

    world:gfx(31,player.pos); --A nice GFX that announces clearly: A player logged in.

	--General welcome message
    players=world:getPlayersOnline(); --Reading all players online so we can count them
	base.common.TempInformNLS(player,"[Login] Willkommen auf Illarion! Es sind "..table.getn(players).." Spieler online.","[Login] Welcome to Illarion! There are "..table.getn(players).." players online."); --sending a message

	--Messages of the day
    messageG={};
    messageG[1]="[Tipp] Leichte R�stungen wie Leder sch�tzen sehr gut gegen stumpfe Waffen aber schlecht gegen Hiebwaffen.";
    messageG[2]="[Tipp] Mittlere R�stungen wie Kettenhemden sch�tzen sehr gut gegen Hiebwaffen aber schlecht gegen Stichwaffen.";
    messageG[3]="[Tipp] Schwere R�stungen wie Plattenpanzer sch�tzen sehr gut gegen Stichwaffen aber schlecht gegen stumpfe Waffen.";
	messageG[4]="[Tipp] Wir spielen miteinander, nicht gegeneinander. Viel Spa� beim Spielen!";	
	messageG[5]="[Tipp] Bitte besuche uns im IRC-Chat: #illarion auf Quakenet.";
	messageG[6]="[Tipp] Im Forum sind viele interessante Diskussion und Informationen zu finden. Meld dich gleich an!";
	messageG[7]="[Tipp] Wenn du einen Gamemaster erreichen m�chtest, schreibe !gm <Deine Nachricht> im Chatfenster.";
	messageG[8]="[Tipp] Br�gon ist der Gott des Feuers.";
	messageG[9]="[Tipp] Eldan ist der Gott des Geistes.";
	messageG[10]="[Tipp] Findari ist die G�ttin der Luft.";
	messageG[11]="[Tipp] Tanora/Zelphia ist die G�ttin des Wassers.";
	messageG[12]="[Tipp] Ushara ist die G�ttin der Erde .";
	messageG[13]="[Tipp] Adron ist der Gott des Weines und der Feste.";
	messageG[14]="[Tipp] Cherga ist die G�ttin der Geister und der Unterwelt.";
	messageG[15]="[Tipp] Elara ist die G�ttin des Wissens und der Weisheit.";
	messageG[16]="[Tipp] Irmorom ist der Gott des Handels und des Handwerks.";
	messageG[17]="[Tipp] Malach�n ist der Gott der Jagd und der Schlachten.";
	messageG[18]="[Tipp] Moshran ist der Gott des Blutes und der Gebeine.";
	messageG[19]="[Tipp] Narg�n ist der Gott des Chaos.";
	messageG[20]="[Tipp] Oldra ist die G�ttin der Fruchtbarkeit und des Lebens.";
	messageG[21]="[Tipp] Ronagan ist der Gott der Diebe und der Schatten.";
	messageG[22]="[Tipp] Sirani ist die G�ttin der Liebe und der Freude.";
	messageG[23]="[Tipp] Zhambra ist der Gott der Freundschaft und Treue.";
	messageG[24]="[Tipp] Cadomyr ist das Reich der Ehre.";
	messageG[25]="[Tipp] Runewick ist das Reich der Weisheit.";		
	messageG[26]="[Tipp] Galmair ist das Reich des Reichtums.";
	messageG[27]="[Tipp] Manchen Monstern sollte man lieber nicht alleine begegnen.";
	messageG[28]="[Tipp] Gegenst�nde von geringer Haltbarkeit drohen zu zerbrechen. Ein Fachmann kann sie ausbessern.";
	messageG[29]="[Tipp] Fernwaffen werden nicht umsonst so genannt: stark auf Distanz; nutzlos im Nahkampf.";
	messageG[30]="[Tipp] Hiebwaffen sind gut gegen leichte R�stungen.";
	messageG[31]="[Tipp] Stichwaffen sind gut gegen mittlere R�stungen.";
	messageG[32]="[Tipp] Stumpfe Waffen sind gute gegen schwere R�stungen.";
	
    messageE={};
    messageE[1]="[Tip] Light armour like leather armour protects good against blunt weapons but bad against slashing weapons.";
    messageE[2]="[Tip] Medium armour like chain mail protects good against slashing weapons but bad against puncture weapons.";
    messageE[3]="[Tip] Heavy armour like plate armour protects good against puncture weapons but bad against blunt weapons.";
    messageE[4]="[Tip] We play with, not against each other. Have fun playing!";
	messageE[5]="[Tip] Please join our IRC chat: #illarion on Quakenet.";
	messageE[6]="[Tip] The forum contains many interesting discussions and information. Register today!";	
	messageE[7]="[Tip] If you want to contact a gamemaster, type !gm <Your message> in the chat box.";
	messageE[8]="[Tip] Br�gon is the God of fire.";
	messageE[9]="[Tip] Eldan is the God of spirit.";
	messageE[10]="[Tip] Findari is the Goddess of air.";
	messageE[11]="[Tip] Tanora/Zelphia is the Goddess of water.";
	messageE[12]="[Tip] Ushara is the Goddess of earth.";
	messageE[13]="[Tip] Adron is the God of festivities and wine.";
	messageE[14]="[Tip] Cherga is the Goddess of spirits and the underworld.";
	messageE[15]="[Tip] Elara is the Goddess of wisdom and knowledge.";
	messageE[16]="[Tip] Irmorom is the God of trade and craftsmanship.";
	messageE[17]="[Tip] Malach�n is the God of battle and hunting.";
	messageE[18]="[Tip] Moshran is the God of blood and bones.";
	messageE[19]="[Tip] Narg�n is the God of chaos.";
	messageE[20]="[Tip] Oldra is the Goddess of life and fertility.";
	messageE[21]="[Tip] Ronagan is the God of thieves and shadows.";
	messageE[22]="[Tip] Sirani is the Goddess of love and pleasure.";
	messageE[23]="[Tip] Zhambra is the God of friendship and loyalty.";
	messageE[24]="[Tip] Cadomyr is the realm of honour.";
	messageE[25]="[Tip] Runewick is the realm of wisdom.";
	messageE[26]="[Tip] Galmair is the realm of wealth.";
	messageE[27]="[Tip] Some monsters you should avoid all alone.";
	messageE[28]="[Tip] Items of low durability might break any time. A specialist can repair them.";
	messageE[29]="[Tip] Distance weapons have their name for a reason; useful for distant targets, useless in melee.";
	messageE[30]="[Tip] Slashing weapons are good against light armour.";
	messageE[31]="[Tip] Puncture weapons are good against medium armour.";
	messageE[32]="[Tip] Blunt weapons are good against heavy armour.";
	
	dailyMessageID=math.random(1,table.getn(messageG)); --chosing a message at random
	base.common.TempInformNLS( player,messageG[dailyMessageID],messageE[dailyMessageID]); --sending the message

		--TEMPORARY SOLUTION TO CATCH NEW PLAYERS
	if player:getMentalCapacity() < 1999 or player:getQuestProgress(122) == 0 then --Mental Capacity CANNOT drop below 1999 -> New player or cheater. However, new players should start with a higher value
	    player:increaseMentalCapacity(2000000); --Maybe reduce to 200000 for brand new players. This is for existing players.
		base.common.TempInformNLS(player,"[Skillsystem] Mental Capacity zwangsangepasst!","[Skill system] Adjustment of mental capacity enforced."); --Debuggin'
		player:setQuestProgress(122,1);
	end
	--TEMPORARY SOLUTION END
	
	player:increaseAttrib("foodlevel",-1);
	-- Abhandlung von Transporttieren
	local cowStatus = player:getQuestProgress(8);
	if (player:getQuestProgress(8) ~= 0) then
	    if (cowStatus == 1) then
		    newPos = createCow( player );
		else
		    newPos = base.common.DataToPosition( cowStatus );

			npcRace=50;
			if (player.pos.z == 50) then
				npcRace=30;
			end

		    if not world:createDynamicNPC("Lasttier",npcRace,newPos,0,"npc_lasttier.lua") then
		        newPos = false;
		    end
		end
		if not newPos then
			player:inform("Fehler beim Erstellen des Lasttieres.");
		else
			Transporter = world:getCharacterOnField(newPos);
			transport_effect = LongTimeEffect( 10, 500000 );
			transport_effect:addValue("owner",player.id);
			Transporter.effects:addEffect(transport_effect);
		end
	end
	-- Abhandlung von Transporttieren fertig

	-- �berpr�fung f�r korrekt initiertes Regenerationsskript
	find, reg_effect = player.effects:find(2);
	if not find then
		player.effects:addEffect( LongTimeEffect(2,10) );
	end
	
	--Checking longterm cooldown
	find, reg_effect = player.effects:find(33);
	if not find then
		player.effects:addEffect( LongTimeEffect(33,10) );
	end

	-- Smell effect removed for the time being (annoying!!!)
	find, stinkEffekt = player.effects:find(18);
	if find then
		player.effects:removeEffect(18);
	end
	
	-- Cold effect removed for the time being (annoying!!!)
	find, coldEffekt = player.effects:find(3);
	if find then
		player.effects:removeEffect(3);
	end

	--Good/Bad days removed for the time being (confusing!!!)
	--[[if not( player.pos.z == 100 or player.pos.z == 101 ) then
		HowAreYouToday( player );
	end]]

	-- Langzeitefekt f�r Runenlehren
    year=world:getTime("year");
    year=(year-1)*31536000;						-- (year-1)*((15*24) + 5)*24*60*60;
    month=world:getTime("month");
    month=(month-1)*2073600;					-- (month-1)*24*24*60*60;
    day=world:getTime("day");
    day=(day-1)*86400;							-- (day-1)*24*60*60;
    hour=world:getTime("hour");
    hour=hour*3600;								-- hour*60*60;
    minute=world:getTime("minute");
    minute=minute*60;
    second=world:getTime("second");
    second=second;

	timestamp=year+month+day+hour+minute+second;

	find, teachEffect = player.effects:find(22);
	if find then
	    --player:inform("moep->Effekt gefunden");
		found, Rune1Index = teachEffect:findValue("Rune1Index");
		if found then
    		if ( (timestamp>=Rune1Index) or (Rune1Index==1) ) then
    		    --player:inform("moep->Rune 1 ist frei");
    			teachEffect:addValue("Rune1Index",1);
				Rune1=1;
			else
			    --player:inform("moep->Rune 1 ist gesperrt");
			    Rune1=2;
			end
		end
		found, Rune2Index = teachEffect:findValue("Rune2Index");
		if found then
    		if ( (timestamp>=Rune2Index) or (Rune2Index==1) ) then
    		    --player:inform("moep->Rune 2 ist frei");
				teachEffect:addValue("Rune2Index",1);
				Rune2=1;
			else
			    --player:inform("moep->Rune 2 ist gesperrt");
			    Rune2=2;
			end
		end
		if ( (Rune1==1) and (Rune2==1) ) then
		    --player:inform("moep->Effekt wird entfernt");
			player.effects:removeEffect(22);
		end
	else
	    --player:inform("moep->Effekt NICHT gefunden");
    end

    --player:inform("moep->Fertig!");

--[[
	-- Langzeiteffekt f�r magie
	--
	if ( ( player:getMagicType( ) == 0 ) and ( player:getMagicFlags( 0 ) > 0 ) ) then -- Charakter ist Magier
		player:inform("Magie start");
	    find, magicEffect = player.effects:find(600);
	    player:inform("Effekt gesucht");
            if not find then
	    player:inform("Effekt nicht gefunden");
		player.effects:addEffect( LongTimeEffect(600,10) );
	    player:inform("Effekt gesetzt");
	    end
	    player:inform("Effekt gefunden.");
	end
]]
	-- �berpr�fung auf Newbie-Status
	NewbieState = player:getQuestProgress(2);
	if NewbieState == 2 then
		-- player logged out before moving the first time, let's offer another chance
		NewbieState=0;
	end
	if NewbieState == 0 and player.pos.z == 100 then
		-- first login
		local atNewbieSpawn = true;
		-- commented out, useless?
		--[[ for x=31,32 do
			for y=19,24 do
				if player.pos.x == x and player.pos.y == y then
					atNewbieSpawn = true;
				end
			end
		end ]]
		if atNewbieSpawn then
			player:setQuestProgress(2,1); -- player seems to be a newbie, so start "Quest"
			outText=base.common.GetNLS(player,"#w Du verl��t das Schiff, welches dich in das geheimnisvolle Land Illarion gebracht hat. Endlich wieder festen Boden unter den F��en!","#w You leave the ship that brought you to the mysterious land Illarion. Finally standing again on firm ground again!");
			player:inform(outText);
			outText2=base.common.GetNLS(player,"#w Hilfe erh�ltst du jederzeit im Illarion-Chat oder auf dem Illarion-Forum, welche auf der Homepage verlinkt sind.","#w You can get help of any kind in the Illarion chat or the Illarion forum. You can find a link to both on the homepage.");
			player:inform(outText2);

			foundEffect,newbieEffect = player.effects:find(13);
			if not foundEffect then
				newbieEffect=LongTimeEffect(13,1);
				player.effects:addEffect(newbieEffect);
			else
				newbieEffect.nextCalled=100;
				setNewbiePos(newbieEffect, player);
			end
		end
	elseif (NewbieState == 36 or NewbieState == 322) then  --player logged out on Noobia during fighting,lets warp him back to the npc
		player:warp(position(63,41,100));
		if (world:isCharacterOnField(position(41,50,100))==true) then
			if (world:isCharacterOnField(position(43,50,100))==true) then
				player:warp(position(41,48,100));
				player:talk(Character.say, "Arghh!");
			else
				player:warp(position(43,50,100));
				player:talk(Character.say, "Arghh!");
			end
		else
			player:warp(position(41,50,100));
			player:talk(Character.say, "Arghh!"); --needed phrase for the Npc(npc_nargon_hammerfaust.lua) to react
		end
	end
	-- �berpr�fung von Newbie-Status fertig

	return true;
end

function createCow( player )
	posList = { 0, 1, -1, 2, -2 };
	for i, XPos in pairs(posList) do
		for k, YPos in pairs(posList) do
			SettingPos = position(player.pos.x+XPos,player.pos.y+YPos,player.pos.z);
			if not world:isCharacterOnField( SettingPos ) and not world:isItemOnField( SettingPos ) then
				if world:createDynamicNPC("Lasttier",50,SettingPos,0,"npc_lasttier.lua") then
					return SettingPos;
				else
					return false;
				end
			end
		end
	end
	return false;
end

function setNewbiePos(newbieEffect,Character)

	newbieEffect:addValue("newbiePosX",Character.pos.x);
	newbieEffect:addValue("newbiePosY",Character.pos.y);
	newbieEffect:addValue("newbiePosZ",Character.pos.z);
end

--Good/Bad days removed for the time being (confusing!!!)
--[[function HowAreYouToday( Char )
    if not listOfAttribs then
        listOfAttribs = {"strength","dexterity","constitution","agility","willpower","perception","essence","intelligence"};
    end
    math.randomseed( Char.id + world:getTime("day") + world:getTime("month") + world:getTime("year") );

    local firstAttrib = listOfAttribs[ math.random(1,8) ];
    local secondAttrib = "";
    repeat
        secondAttrib = listOfAttribs[ math.random(1,8) ];
    until( firstAttrib ~= secondAttrib );

    local randomTry = math.random(0,10);
    if( randomTry >= 0 ) and ( randomTry < 1 ) then
        AttribMessage( Char, firstAttrib, 2 );
    elseif( randomTry >= 1 ) and ( randomTry < 3 ) then
        AttribMessage( Char, firstAttrib, 1 );
    elseif( randomTry >= 3 ) and ( randomTry < 5 ) then
        AttribMessage( Char, firstAttrib, -1 );
    end

    local randomTry = math.random(0,10);
    if( randomTry >= 0 ) and ( randomTry < 1 ) then
        AttribMessage( Char, secondAttrib, 2 );
    elseif( randomTry >= 1 ) and ( randomTry < 3 ) then
        AttribMessage( Char, secondAttrib, 1 );
    elseif( randomTry >= 3 ) and ( randomTry < 5 ) then
        AttribMessage( Char, secondAttrib, -1 );
    end
end

function AttribMessage( Char, attrib, value )
    Char:increaseAttrib( attrib, value );
    local Race = Char:getRace();
    local msg = content.dailymessage.GetMessage( Char:getPlayerLanguage(), attrib, Race, value );
    if msg then
		Char:inform( base.common.GetNLS( Char, "#w Deine heutige Verfassung: ", "#w Your condition today: " )..msg );
    end
end]]
