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
end
fun yngste_eldste(valg :: String):
  full_navn_og_epost = select first_name, last_name, email from dummy-table end
  kodifisert = dummy-table.length() - 1 
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
end
