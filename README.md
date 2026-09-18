# blackbeard

Pyret tasks from IS-114 at the University of Agder, autumn 2024. Three standalone files, each
covering its own topic: functions with unit tests, image building, and table processing against a
Google spreadsheet.

Every function is documented with `doc:` and tested in `where:` blocks in the file itself.

![image](images/olympisk-flagg.svg)

## Running the Code

The files are run on [code.pyret.org](https://code.pyret.org). Open an `.arr` file there and press
**Run**. That also runs all the `where:` blocks as tests.

`struktur.arr` additionally requires you to be logged in with a Google account that has read access
to the spreadsheet the functions pull their data from. The first run asks for access to Google
Drive.

## Structure

| File | Topic |
|------|-------|
| `konvert.arr` | Currency conversion: functions, conditionals and `raise` |
| `olympisk-flagg.arr` | The Olympic flag built from circles with the image library |
| `struktur.arr` | Tables from Google Sheets: filtering, sorting, statistics and a chart |
| `dummydata.xlsx` | The dataset `struktur.arr` reads, ready to upload to Google Sheets |
| `images/` | Diagrams belonging to this README |

## konvert.arr

Converts Norwegian kroner to euros and dollars. The rates are hardcoded as they stood on
31 August 2024 (`0.085` for the euro, `0.095` for USD).

| Function | Description |
|----------|-------------|
| `nok-til-euro(nok)` | Kroner to euros |
| `nok-til-usd(nok)` | Kroner to dollars |
| `nok-til-joker(nok, valg)` | Kroner to euros or dollars, depending on `valg` |

`nok-til-joker` takes the currency as a string, `"euro"` or `"usd"`. Anything else gives
`raise("Valuta må vær 'euro' eller 'usd'")`.

## olympisk-flagg.arr

Builds the Olympic flag out of five rings with `circle` and `overlay-xy`. The diagram at the top of
this file shows the steps.

| Function | Description |
|----------|-------------|
| `konvert-flagg(ring1, ring2, ring3, ring4, ring5)` | Takes five colors and assembles the rings into one image |
| `olympisk-flagg(valg)` | Calls `konvert-flagg` with a ready made color set |

The rings are assembled in pairs: `ring1` and `ring2` are offset 30 pixels in both directions so
that they overlap diagonally, the same is done with `ring3` and `ring4`, and the two pairs are
placed next to each other with a 70 pixel offset before the fifth ring is added at 140.

`olympisk-flagg` takes `"farget"` for the five official colors (blue, yellow, black, green, red) or
`"monokrom"` for five black rings. Anything else gives a `raise`.

## struktur.arr

Loads a Google spreadsheet with `load-spreadsheet` and the `o1-oppg3` sheet into a table with the
columns `id`, `first_name`, `last_name`, `email`, `gender`, `ip_address` and `age`. The dataset
lives in `dummydata.xlsx`: 10 rows, with the tab and the columns named exactly as the code expects.

| Function | Description |
|----------|-------------|
| `filtrer_alder()` | Pulls out name and age, filters on age and swaps the age column for a year of birth |
| `yngste_eldste(valg)` | Gives the full name and email of the youngest or the oldest in the table |
| `gsnitt()` | The mean age for the whole table |
| `navn_alder_chart()` | Bar chart with names on the X axis and age on the Y axis |

`filtrer_alder` uses `select` to pull out `first_name` and `age`, `sieve` to filter on age, and
`extend` to convert age into a year of birth (`2024 - age`). The age column is removed at the end
with `drop`, since the year of birth replaces it.

`yngste_eldste` sorts the table on age, descending for `"yngste"` and ascending for `"eldste"`, and
picks the last row. Anything other than `"yngste"` and `"eldste"` gives a `raise`.

`gsnitt` uses `T.running-mean` from `tables` to add a column with a running mean, and reads off the
last row. `navn_alder_chart` merges first name and last name into one column with `extend` and
draws a bar chart with `from-list.bar-chart`.

### Setting Up the Spreadsheet

The file does not read `dummydata.xlsx` from disk. `load-spreadsheet` takes the ID of a spreadsheet
that lives in Google Sheets, so the dataset has to be uploaded first:

1. **Upload the file.** Go to [drive.google.com](https://drive.google.com), choose **New**, then
   **File upload**, and select `dummydata.xlsx`.
2. **Convert to Google Sheets.** Open the file in Drive and choose **File**, then **Save as Google
   Sheets**. `load-spreadsheet` only reads Google's own format, not the xlsx file itself. Drive
   does this automatically if you have turned on conversion on upload.
3. **Check the sheet tab.** The code looks the tab up with
   `dummy-sheet.sheet-by-name("o1-oppg3", true)`, so the tab has to be named `o1-oppg3`. It is
   already named that in `dummydata.xlsx`, so here it is just a matter of confirming that the name
   survived the upload. If the tab is renamed during conversion, right click it at the bottom and
   choose **Rename**. The `true` argument means that the first row is headers.
4. **Copy the ID from the address bar.** The URL of an open spreadsheet looks like this:

   ```
   https://docs.google.com/spreadsheets/d/1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g/edit#gid=0
   ```

   The ID is the string between `/d/` and the next slash, that is
   `1RYN0i4Zx_UETVuYacgaGfnFcv4l9zd9toQTTdkQkj7g`. You will find the same ID under **File**, then
   **Share**, then **Copy link**.
5. **Paste the ID into the code.** The first line of `struktur.arr` then becomes:

   ```
   dummy-sheet = load-spreadsheet("your-id-here")
   ```

6. **Run the file.** The first run opens a Google window asking for access to Drive. Approve with
   the account that owns the spreadsheet. If the sheet sits on a different account, it has to be
   shared with the account you are logged in with on code.pyret.org.

The declaration in `load-table` mirrors the sheet: every column in the sheet has to be listed there,
in the same order and with the right type, including the ones no function uses. Otherwise Pyret
stops with an error about column names or the number of columns. `dummydata.xlsx` is set up so that
this holds from the first run, without changing a line in `struktur.arr`.

## Notes

- Of the seven columns in `load-table`, only `first_name`, `last_name`, `email` and `age` are
  actually read. `id`, `gender` and `ip_address` are there only because the original sheet had them,
  and appear nowhere else in the file.
- The contents of `dummydata.xlsx` are laid out to match the `where:` blocks in `struktur.arr`. The
  ages produce the years of birth the tests expect, the mean comes to 55.9, and `Delila Tackes` and
  `Aretha Marconi` are the youngest and the oldest. `ip_address` is stored as a number, not as
  `12.34.56.78`, because `load-table` declares the column as `Number`.
- `York Sarjeant` and `Aretha Marconi` are both 86, since both are meant to give the year of birth
  1938. The test for `"eldste"` expects `Aretha Marconi`, and that assumes the sort preserves the
  row order when ages are equal. Aretha therefore has to sit after York in the sheet.
- The test `nok-til-joker(10, "yen") is 137.75` in `konvert.arr` is meant to test that the function
  throws an error, but is written as an ordinary equality test. Pyret tests this with `raises`
  instead: `nok-til-joker(10, "yen") raises "Valuta"`.
- The filter in `filtrer_alder` is `(age <= 80) or (age >= 30)`, which lets every row through. `and`
  would have filtered on the 30 to 80 age range, which was probably the intention, but the `where:`
  block expects all 10 names. Change the operator and the test breaks.
