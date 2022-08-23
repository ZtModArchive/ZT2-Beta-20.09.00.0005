-- animalcompanions.lua
-- animal companions
include "scenario/scripts/ui.lua";




-- there is string replacement for $ amounts and animal type needed

function evalanimalcompanions(comp)

-- an new animal, of opposite sex, is chosen randomly from all animals that the player has . 
-- player must breed the animal with their original animal within 2 months. Repeatable 
-- player has to pay for the animal (half the animals price)




end




function completeanimalcompanions(comp)
-- loaned animal removed, player keeps young animal and gets back the 
-- money paid (e.g. half price of loaned animal)


end


function failanimalcompanions(comp)
-- there are 2 failure states... if the player failed to breed, or if they killed or 
	-- otherwise can't return the animal
	
-- failure to breed just ends the challenge...nothing else happens.

--  if player kills the loaned animal or releases it to wild, they pay a penalty
-- penalty is 1.5 x the full price of the animal


end




