--[[
Illarion Server

This program is free software: you can redistribute it and/or modify it under
the terms of the GNU Affero General Public License as published by the Free
Software Foundation, either version 3 of the License, or (at your option) any
later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE.  See the GNU Affero General Public License for more
details.

You should have received a copy of the GNU Affero General Public License along
with this program.  If not, see <http://www.gnu.org/licenses/>.
]]
-- UPDATE common SET com_script='gm.items.id_93_medal' WHERE com_itemid=93;
local lookat = require("base.lookat")
local common = require("base.common")
local globalvar = require("base.globalvar")
local M = {}

local gfxSubMenu = {"Fire","Ice and wind","Clouds","Light","Sparkles","Misc","Heavy attack","Attack","Friendly"}
local gfxMenu = {}
gfxMenu[1]={globalvar.gfxBLITZ,""}
gfxMenu[2]={globalvar.gfxICE,""}
gfxMenu[3]={globalvar.gfxELFFIRE,""}
gfxMenu[4]={globalvar.gfxDEMFIRE,""}
gfxMenu[5]={globalvar.gfxBLITZ,"Light"}
gfxMenu[6]={globalvar.gfxICE,"Ice and wind"}
gfxMenu[7]={globalvar.gfxELFFIRE,"Ice and wind"}
gfxMenu[8]={globalvar.gfxDEMFIRE,"Clouds"}
gfxMenu[9]={globalvar.gfxSPELL,"Ice and wind"}
gfxMenu[10]={globalvar.gfxWIND,"Ice and wind"}
gfxMenu[11]={globalvar.gfxGIFTWOLKE,"Clouds"}
gfxMenu[12]={globalvar.gfxFIREBALL,"Fire"}
gfxMenu[13]={globalvar.gfxPLATSCH,"Misc"}
gfxMenu[14]={globalvar.gfxFIZZLE,"Clouds"}
gfxMenu[15]={globalvar.gfxBLOOD,"Misc"}
gfxMenu[16]={globalvar.gfxBOW,"Fight"}
gfxMenu[17]={globalvar.gfxRAIN,"Sparkles"}
gfxMenu[18]={globalvar.gfxSWORD,"Fight"}
gfxMenu[19]={globalvar.gfxSHIELD,"Fight"}
gfxMenu[20]={globalvar.gfxMACE,"Fight"}
gfxMenu[21]={globalvar.gfxDAGGER,"Fight"}
gfxMenu[22]={globalvar.gfxCLAW,"Misc"}
gfxMenu[23]={globalvar.gfxBOXING,"Fight"}
gfxMenu[24]={globalvar.gfxGLOWING,"Light"}
gfxMenu[25]={globalvar.gfxFALL,"Clouds"}
gfxMenu[26]={globalvar.gfxFLAMESTRIKE,"Fire"}
gfxMenu[27]={globalvar.gfxLIGHT,"Light"}
gfxMenu[28]={globalvar.gfxFIREFIELD,"Fire"}
gfxMenu[29]={globalvar.gfxSTARS,"Misc"}
gfxMenu[30]={globalvar.gfxEXPLO,"Fire"}
gfxMenu[31]={globalvar.gfxSPLASH,"Sparkles"}
gfxMenu[32]={globalvar.gfxSUN,"Light"}
gfxMenu[33]={globalvar.gfxVIOLETT,"Fire"}
gfxMenu[34]={globalvar.gfxSPRINKLE,"Sparkles"}
gfxMenu[35]={globalvar.gfxSCOTTY,"Sparkles"}
gfxMenu[36]={globalvar.gfxBLITZ,"Heavy attack"}
gfxMenu[37]={globalvar.gfxICE,"Heavy attack"}
gfxMenu[38]={globalvar.gfxELFFIRE,"Attack"}
gfxMenu[39]={globalvar.gfxDEMFIRE,"Attack"}
gfxMenu[40]={globalvar.gfxSPELL,"Attack"}
gfxMenu[41]={globalvar.gfxWIND,"Attack"}
gfxMenu[42]={globalvar.gfxGIFTWOLKE,"Attack"}
gfxMenu[43]={globalvar.gfxFIREBALL,"Attack"}
gfxMenu[44]={globalvar.gfxRAIN,"Friendly"}
gfxMenu[45]={globalvar.gfxFALL,"Attack"}
gfxMenu[46]={globalvar.gfxFLAMESTRIKE,"Attack"}
gfxMenu[47]={globalvar.gfxLIGHT,"Attack"}
gfxMenu[48]={globalvar.gfxFIREFIELD,"Heavy attack"}
gfxMenu[49]={globalvar.gfxSTARS,"Friendly"}
gfxMenu[50]={globalvar.gfxEXPLO,"Attack"}
gfxMenu[51]={globalvar.gfxSPLASH,"Friendly"}
gfxMenu[52]={globalvar.gfxSUN,"Friendly"}
gfxMenu[53]={globalvar.gfxVIOLETT,"Heavy attack"}
gfxMenu[54]={globalvar.gfxSPRINKLE,"Friendly"}
gfxMenu[55]={globalvar.gfxSCOTTY,"Friendly"}

local monsterCreation
local gfx
local gfxSelector
local sfx
local animation
local changeAvatar


local function UseItemWithField(User, TargetPos)

    -- First check for mode change
    local modes = {"Monster", "GFX", "GFX Selector", "SFX", "Avatar changes"}
    local cbSetMode = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end

        local index = dialog:getSelectedIndex() + 1
        if index == 1 then
            monsterCreation(User, TargetPos)
        elseif index == 2 then
            gfx(User, TargetPos)
        elseif index == 3 then
            gfxSelector(User, TargetPos)
        elseif index == 4 then
            sfx(User, TargetPos)
        elseif index == 5 then
            changeAvatar(User)
        else
            User:inform("no valid function")
        end
    end
    local sd = SelectionDialog("Pick a function of the medal.", "Which do you want to use?", cbSetMode)
    for _, m in ipairs(modes) do
        sd:addOption(0, m)
    end
    User:requestSelectionDialog(sd)
end

function monsterCreation(User, TargetPos)

    local cbInputDialog = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end

        local number, amount, radius, gfxId, sfxId
        local inputNumber = dialog:getInput()
        if (string.find(inputNumber,"(%d+) (%d+) (%d+) (%d+) (%d+)") ~= nil) then
            local _
            _, _, number, amount, radius, gfxId, sfxId = string.find(inputNumber,"(%d+) (%d+) (%d+) (%d+) (%d+)")
            number = tonumber(number)
            amount = tonumber(amount)
            radius = tonumber(radius)
            gfxId = tonumber(gfxId)
            sfxId = tonumber(sfxId)
        elseif (string.find(inputNumber,"(%d+) (%d+) (%d+) (%d+)") ~= nil) then
            local _
            _, _, number, amount, radius, gfxId = string.find(inputNumber,"(%d+) (%d+) (%d+) (%d+)")
            number = tonumber(number)
            amount = tonumber(amount)
            radius = tonumber(radius)
            gfxId = tonumber(gfxId)
            sfxId = 0
        elseif (string.find(inputNumber,"(%d+) (%d+) (%d+)") ~= nil) then
            local _
            _, _, number, amount, radius = string.find(inputNumber,"(%d+) (%d+) (%d+)")
            number = tonumber(number)
            amount = tonumber(amount)
            radius = tonumber(radius)
            gfxId = 0
            sfxId = 0
        elseif (string.find(inputNumber,"(%d+) (%d+)") ~= nil) then
            local _
            _, _, number, amount = string.find(inputNumber,"(%d+) (%d+)")
            number = tonumber(number)
            amount = tonumber(amount)
            radius = 0
            gfxId = 0
            sfxId = 0
        elseif (string.find(inputNumber,"(%d+)") ~= nil) then
            local _
            _, _, number = string.find(inputNumber,"(%d+)")
            number = tonumber(number)
            amount = 1
            radius = 0
            gfxId = 0
            sfxId = 0
        else
            User:inform("No number")
        end

        if amount > 100 then
            amount = 100
        end

        for _ = 1, amount do
            local monPos = common.getFreePos( TargetPos, radius )
            world:createMonster(number, monPos, 20)
            if gfxId ~= 0 then
                world:gfx(gfxId, monPos)
            end
        end

        User:inform("Creating "..amount.. " monsters with ID "..number.." (radius = "..radius..")")
        User:logAdmin("creates "..amount.. " monsters with ID "..number.." at "..tostring(TargetPos).." (radius = "..radius..")")

        if sfxId ~= 0 then
            world:makeSound(sfxId,TargetPos)
        end
    end
    User:requestInputDialog(InputDialog("Spawn a monster.", "Usage enter: MonsterID [amount] [radius] [GFX] [SFX]" ,false, 255, cbInputDialog))
end

function gfxSelector(User,TargetPos)
    local validIndex = {}
    local validIndexSub = {}

    local cbTopMenu = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local indexTop = dialog:getSelectedIndex() + 1
        if validIndex[indexTop][2] == 0 then
            world:gfx(gfxMenu[validIndex[indexTop][1]][1],TargetPos)
        else
            local cbSubMenu = function (dialog)
                if (not dialog:getSuccess()) then
                    return
                end
                local indexSub = dialog:getSelectedIndex() + 1
                world:gfx(gfxMenu[validIndexSub[indexSub][1]][1],TargetPos)
            end
            local sdSubMenu = SelectionDialog("GFX Effects", "Graphic effect is played in front of char.", cbSubMenu)
            local optionSubId = 1
            for i = 1, #(gfxMenu) do
                if gfxMenu[i][2] ==  gfxSubMenu[validIndex[indexTop][2]]then
                    sdSubMenu:addOption(0, globalvar.gfxText[gfxMenu[i][1]])
                    validIndexSub[optionSubId] = {i,0}
                    optionSubId = optionSubId+1
                end
            end
            User:requestSelectionDialog(sdSubMenu)
        end
    end
    local sdTopMenu = SelectionDialog("GFX Effects", "Graphic effect is played in front of char.", cbTopMenu)
    local optionId = 1
    for i = 1, #(gfxMenu) do
        if common.IsNilOrEmpty(gfxMenu[i][2]) then
            sdTopMenu:addOption(0, globalvar.gfxText[gfxMenu[i][1]])
            validIndex[optionId] = {i,0}
            optionId = optionId+1
        end
    end
    for i = 1, #(gfxSubMenu) do
        sdTopMenu:addOption(0, "Group: "..gfxSubMenu[i])
        validIndex[optionId] = {0,i}
        optionId = optionId+1
    end
    User:requestSelectionDialog(sdTopMenu)
end

function gfx(User, TargetPos)

    local cbInputDialog = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local inputNumber = dialog:getInput()
        if (string.find(inputNumber,"(%d+)") ~= nil) then
            local _, _, number = string.find(inputNumber,"(%d+)")
            number = tonumber(number)
            world:gfx(number,TargetPos)
        else
            User:inform("No number")
        end
    end
    User:requestInputDialog(InputDialog("Play a graphics effect.", "Usage: Type in graphic effects id. Will be played in front of character." ,false, 255, cbInputDialog))
end

function sfx(User, TargetPos)

    local cbInputDialog = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local inputNumber = dialog:getInput()
        if (string.find(inputNumber,"(%d+)") ~= nil) then
            local _, _, number = string.find(inputNumber,"(%d+)")
            number = tonumber(number)
            world:makeSound(number,TargetPos)
        else
            User:inform("No number")
        end
    end
    User:requestInputDialog(InputDialog("Play a sound effect.", "Usage: Type in sound effects id." ,false, 255, cbInputDialog))
end

function animation(User)

    local cbInputDialog = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local inputNumber = dialog:getInput()
        if (string.find(inputNumber,"(%d+)") ~= nil) then
            local _, _, number = string.find(inputNumber,"(%d+)")
            number = tonumber(number)
            User:performAnimation(number)
        else
            User:inform("No number")
        end
    end
    User:requestInputDialog(InputDialog("Play a animation effect.", "Usage: Type in animation effects id." ,false, 255, cbInputDialog))
end

function changeAvatar(User)

    local playersTmp = world:getPlayersInRangeOf(User.pos, 4)
    local players = {User}
    for _, player in pairs(playersTmp) do
        if (player.id ~= User.id) then
            table.insert(players, player)
        end
    end

    local cbChoosePlayer = function (dialog)
        if (not dialog:getSuccess()) then
            return
        end
        local chosenPlayer = players[dialog:getSelectedIndex()+1]
        local cbInputDialog = function (dialog)
            if (not dialog:getSuccess()) then
                return
            end
            local inputString = dialog:getInput()
            if (string.find(inputString,"(%a+) (%d+) (%d+) (%d+)") ~= nil) then
                local _, _, modifier, red, green, blue = string.find(inputString,"(%a+) (%d+) (%d+) (%d+)")
                red = tonumber(red)
                green = tonumber(green)
                blue = tonumber(blue)
                if modifier == "haircolor" or modifier == "haircolour" then
                    chosenPlayer:setHairColour(colour(red, green, blue))
                elseif modifier == "skincolor" or modifier == "skincolour" then
                    chosenPlayer:setSkinColour(colour(red, green, blue))
                else
                    User:inform("Sorry, I didn't understand you.")
                    return
                end
                User:logAdmin("changes avatar of "..chosenPlayer.name..": Set " ..modifier.." to RGB ("..red..", "..green..", "..blue..")")
            elseif (string.find(inputString,"(%a+) (%d+)") ~= nil) then
                local _, _, modifier, id = string.find(inputString,"(%a+) (%d+)")
                id = tonumber(id)
                if modifier == "race" then
                    chosenPlayer:setRace(id)
                elseif modifier == "gender" then
                    chosenPlayer:setAttrib("sex", id)
                    chosenPlayer:setRace(chosenPlayer:getRace()) --to update avatar properly
                elseif modifier == "beard" then
                    chosenPlayer:setBeard(id)
                elseif modifier == "hair" then
                    chosenPlayer:setHair(id)
                else
                    User:inform("Sorry, I didn't understand you.")
                    return
                end
                User:logAdmin("changes avatar of "..chosenPlayer.name..": Set " ..modifier.." to ID "..id)
            else
                User:inform("Sorry, I didn't understand you.")
                User:requestInputDialog(InputDialog("Change the appearance for the selected character.", "Usage: race <id>, gender <0|1>,, beard <id>, hair <id>, haircolor <red> <green> <blue>, skincolor <red> <green> <blue>" ,false, 255, cbInputDialog))
            end
        end
        User:requestInputDialog(InputDialog("Change the appearance for the selected character.", "Usage: race <id>, gender <0|1>, beard <id>, hair <id>, haircolor <red> <green> <blue>, skincolor <red> <green> <blue>" ,false, 255, cbInputDialog))
    end
    --Dialog to choose the player
    local sdPlayer = SelectionDialog("Change the avatar of ...", "First choose a victim:", cbChoosePlayer)
    local raceNames = {"Human", "Dwarf", "Halfling", "Elf", "Orc", "Lizardman", "Other"}
        for _, player in ipairs(players) do
        local race = math.min(player:getRace()+1, #raceNames)
        sdPlayer:addOption(0,player.name .. " (" .. raceNames[race] .. ") " .. player.id)
        end
    User:requestSelectionDialog(sdPlayer)
end

function M.UseItem(User, SourceItem)
    UseItemWithField(User, common.GetFrontPosition(User))
end

function M.LookAtItem(User, Item)
    lookat.SetSpecialDescription(Item, "Verwende die Medallie zum aufrufen der Funktionen.", "Use the medal to pick a function.")
    lookat.SetSpecialName(Item, "Medaille", "Medal")
    return lookat.GenerateLookAt(User, Item, lookat.METAL)
end

return M

