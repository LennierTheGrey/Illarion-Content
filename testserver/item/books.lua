require("base.common");
module("item.books", package.seeall)

-- UPDATE common SET com_script='item.books' WHERE com_itemid = 2622;

function InitBook()
	--[[ -- needs a check
	if (Init == nil) then
		bookTitleDE = {}; -- The german title of the book.
		bookTitleEN = {}; -- The english title of the book.
		bookLanguage = {}; -- The ingame language skill name in which the book is written.
		bookminimumLanguage = {}; -- The minimum language skill needed to read that book.
		
		-- Book of the priests of Eldan (1)
		bookTitleDE[1] = "Das Buch der Priester Eldans";
		bookTitleEN[1] = "Book of the priests of Eldan";	
		bookLanguage[1] = Character.commonLanguage;			
		bookMinimumLanguage[1] = 0;			
		
		Init = true;
	end]]
end

function UseItem(User, SourceItem, TargetItem, Counter, Param)
	InitBook();
    -- alchemy book; just to make it accessable for testers
	if SourceItem:getData("alchemyBook")=="true" then
	    User:sendBook(101)
	end	
	-- alchemy end
	
	-- old data! 
	--[[	if (User:getSkill(bookLanguage[SourceItem.data]) >= bookMinimumLanguage) then
		User:sendBook(SourceItem.data);
	else
		base.common.InformNLS(User, Item, 
			"Das Buch ist in einer Sprache geschrieben, von der du zu wenig Kenntnisse hast.",
			"The book is written in a language in what your knowledge is not advanced enough.");
	end]]
end

function getLookAt(player,item)
    if player:getPlayerLanguage() == 0 then
	    bookName = "Allgemeine Einführng in die Grundlagen der gewöhnlichen Alchemie"
	else
      	bookName = "General introduction to the basics of common alchemy"
	end
	lookAt.name = bookName
    return lookAt
end

function LookAtItem(player, item)
    if item:getData("alchemyBook")=="true" then
	    world:itemInform(player, item, getLookAt(player,item))
	else
	    world:itemInform(player, item, base.lookat.GenerateLookAt(player, item, 0))
	end	
end
