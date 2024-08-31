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
fun yngste_eldste(valg :: String) -> Table:
  full_navn_og_epost = select first_name, last_name, email, age from dummy-table end
  end
with-min-max = extend dummy-table using age:
  max: T.running-max of age,
  min: T.running-min of age
end
  if valg == "yngste":
  kodifisere = dummy-table.length() - 1
  funnet = with-min-max.row-n(kodifisere)["min"]
  funnet
  else if valg == "eldste":
  kodifisere = dummy-table.length() - 1
  funnet = with-min-max.row-n(kodifisere)["max"]
  funnet
  else:
    raise("Du må velge 'yngste' eller 'eldste' fra tabellen")
  end
end
