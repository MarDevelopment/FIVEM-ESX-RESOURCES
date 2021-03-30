Citizen.CreateThread(function()
    while (true) do
					  --  (X, Y, Z, radius, Nix pille) 
		ClearAreaOfPeds(440.84, -983.14, 30.69, 400.0, 1) --PD
		--ClearAreaOfPeds(440.84, -983.14, 30.69, 400.0, 1) ---husk , efter den første linje hvis du tilføjer flere
        Citizen.Wait(0)
    end
end)