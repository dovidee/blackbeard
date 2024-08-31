fun nok-til-euro(nok :: Number) -> Number:
  doc: "Tar en argument i kroner for å konvertere krone til euro"
  euro = 0.085 # 31 august valuta
  convert = nok * euro
  convert
where:
  nok-til-euro(10) is 0.85 
  nok-til-euro(100) is 8.5
  nok-til-euro(1000) is 85
end

fun nok-til-usd(nok :: Number) -> Number:
  doc: "Tar en argument i kroner for å konvertere krone til USD"
  usd = 0.095 # 31 august valuta
  convert = nok * usd
  convert
where:
  nok-til-usd(10) is 0.95
  nok-til-usd(100) is 9.5
  nok-til-usd(1000) is 95
end

fun nok-til-joker(nok :: Number, valg :: String) -> Number:
  doc: "Tar en argument i kroner, og en argument i valg for valuta for å konvertere krone til euro eller USD basert på user input"
  euro = 0.085 # 31 august valuta
  usd = 0.095 # 31 august valuta
  if valg == "euro":
    convert = nok * euro
    convert
  else if valg == "usd":
    convert = nok * usd
    convert
  else:
    raise("Ikke gyldig valuta") # raise error hvis valg argument er ikke euro eller usd
  end
where:
  nok-til-joker(10, "euro") is 0.85
  nok-til-joker(10, "usd") is 0.95
  nok-til-joker(10, "yen") is 137.75 # raise error test
end
