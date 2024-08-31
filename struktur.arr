include gdrive-sheets
include tables
include math
import tables as T

dummy-sheet = load-spreadsheet("1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g")
dummy-table = load-table: id :: Number, first_name :: String, last_name :: String, email :: String, gender :: String, ip_address :: Number, age :: Number source: dummy-sheet.sheet-by-name("o1-oppg3", true)
end

fun filtrer_alder():
  doc: "Hent navn og alder fra tabell, og filtrer den nye tabellen til å vær yngre enn 80 eller 80 år, og eldre enn 30 eller 30 år."
  name_og_age = select first_name, age from dummy-table end
  filtrer_nog = sieve name_og_age using age:
    (age <= 80) or (age >= 30)
  end
  filtrer_nog
where:
  filtrer_alder().row-n(0)["age"] is 25
  filtrer_alder().row-n(1)["first_name"] is "Veda"
  filtrer_alder().row-n(9)["first_name"] is "Aretha"
end

fun yngste_eldste(valg :: String):
  doc: "Finn den eldste eller yngste fra tabellen, og vis fullnavn plus email"
  full_navn_og_epost = select first_name, last_name, email from dummy-table end # Ta full navn og epost og lag ny tabell
  kodifisert = dummy-table.length() - 1 # Kode teller fra 0 
  if valg == "yngste":
    filtrer_fnoe_yngst = order dummy-table: age descending end
    finn_yngst = filtrer_fnoe_yngst.row-n(kodifisert)
    fulldata = finn_yngst["first_name"] + " " + finn_yngst["last_name"] + ": " + finn_yngst["email"]
    fulldata
  else if valg == "eldste":
    filtrer_fnoe_eldst = order dummy-table: age ascending end
    finn_eldst = filtrer_fnoe_eldst.row-n(kodifisert)
    fulldata = finn_eldst["first_name"] + " " + finn_eldst["last_name"] + ": " + finn_eldst["email"]
    fulldata
  else:
    raise("Du må velge 'yngste' eller 'eldste' fra tabellen")
  end
where:
  yngste_eldste("yngste") is "Delila Tackes: dtackes5@newsvine.com"
  yngste_eldste("eldste") is "Aretha Marconi: amarconi9@gov.uk"
  yngste_eldste("eldst") is "Aretha Marconi: amarconi9@gov.uk" # Error
end

fun gsnitt():
  doc: "Finn gjennomsnittet av alle alderne"
  avg-alder = extend dummy-table 
    using age:
    mean: T.running-mean of age
  end
  kodifisert = dummy-table.length() - 1
  funnet = avg-alder.row-n(kodifisert)["mean"]
  funnet
where:
  gsnitt() is 55.9
  gsnitt() * 2 is 111.8 # Fins ikke mer relevant testing for gjennomsnitt; trenger flere dataset
  gsnitt() / 2 is 27.95 # Fins ikke mer relevant testing for gjennomsnitt; trenger flere dataset
end
