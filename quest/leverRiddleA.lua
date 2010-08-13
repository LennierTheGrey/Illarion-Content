require("base.class")

-- For Fal-Fal's lever Riddle

module("quest.leverRiddleA", package.seeall)

addToLeverRiddleAString = base.class.class(function(LeverRiddleAString, char)
    LeverRiddleAString.toAdd = char;        -- the character to add
    LeverRiddleAString.theString="";        -- initialize string
end);

function addToLeverRiddleAString:execute()
    if string.find( self.theString, self.toAdd ) == nil then    -- if the lever was not pulled already
        self.theString = self.theString .. self.toAdd;          -- append new character
       
       ------------------DEBUG INFORMATION---------------------
	    plyList=world:getPlayerInRangeOf(position(221,739,0), 20);
	    for i, player in pairs(plyList) do
	        player:inform("theString: "..self.theString.." and self.toAdd : "..self.toAdd);
	    end
	   -------------------------------------------------------------- 
	    
		if string.len( self.theString ) == 5 then               -- 5 levers were pulled already
                                                        -- check whether the sequence was right in here!
        end   
    end
end