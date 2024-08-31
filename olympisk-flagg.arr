fun konvert-flag(ring1 :: String, ring2 :: String, ring3 :: String, ring4 :: String, ring5 :: String) -> Image:
  doc: "Hver ring tar en farge som et argument. Den lager ring1_2 og ring3_4 for å sette sammen til 4 ringer totalt. Til slutt, setter den sammen den siste ringen og gir output av hele ringen"
  ring1_2 = overlay-xy(circle(30, "outline", ring1),
      30, 30, 
    circle(30, "outline", ring2))
  
  ring3_4 = overlay-xy(circle(30, "outline", ring3),
      30, 30, 
    circle(30, "outline", ring4))

  ring1_2_3_4 = overlay-xy(ring1_2,
      70, 0,
    ring3_4)
  
  ring1_2_3_4_5 = overlay-xy(ring1_2_3_4,
      140, 0,
    circle(30, "outline", ring5))
  
  ring1_2_3_4_5 # Legg til alle ringene
end

fun olympisk-flagg(valg :: String) -> Image:
  doc: "Tar et valg som et argument enten monokrom eller farget. Nested funksjon for å lage et flagg i disse fargene"
  if valg == "monokrom":
    konvert-flag("black", "black", "black", "black", "black")
  else if valg == "farget":
    konvert-flag("blue", "yellow", "black", "green", "red")
  else:
    raise("Du må velge enten 'monokrom' eller 'farget' flagg")
  end
end
