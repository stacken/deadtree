# deadtree

Du behöver docker och GNU make.

För de fysiska utskicken skapa en pdf enligt instruktioner här under. Skriv ut, lägg i
fönsterkuvert, frankera och posta.

## Skapa en mall

Skapa en ny mall i `mallar/`, t.ex. `mallar/2015-varmate_2.tex`.

## Bygg PDF

Skriv `MALL=2015-varmate_2 make pdf` och vänta, du bör ha din PDF i `out/` efter ett tag.
Du behöver ha OpenAFS installerat, samt utcheckade principaler så att du kan läsa finger.txt.

## Bygg webbsida

Skriv `MALL=2015-varmate_2 make html`, du bör ha en html och css fil i `out/` efter ett tag.

## Bygg ren text

Skriv `MALL=2015-varmate_2 make plain`, du bör hitta en txt-fil i `out/` efter ett tag.

## Skicka e-post

Skriv `MALL=2015-varmate_2 make plain`, för att generera ett mail i ren text. Använd sedan
`./send.py` samt txt-filen i `out/` för att skicka mail. Det ingår en `send-list.lst` som du
kan modifera och använda tillsammans med `--addressfile` för att skicka ett testmail först.
När du är klar så använder du `--finger` i stället för `--addressfile`.
