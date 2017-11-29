# Tema: Online video igra

## Opis domena
U jednoj partiji učestvuje 10 igrača. Igraju dva tima jedni protiv drugih, 5 na 5.

Svaki igrač ima svoj nalog.

U igri postoji više različitih heroja, odnosno karaktetera kojima igrač može da upravlja.

Pre svake partije igrač bira tačno jednog heroja koga će igrati u toj partiji.

Takođe, igrač bira i jedan od nekoliko izgleda za svog heroja tokom partije.

Postoji više mapa na kojima mogu da se igraju partije.

Na svakoj mapi postoji prodavnica gde se mogu kupiti stvari (oklop, oružje), ali nisu sve stvari dostupne u svakoj prodavnici.

### Player (nalog igrača)
- Level, trenutni nivo igrača
- Experience, deo progresa ka sledećem nivou
- Wins, koliko igrač ima pobeđenih partija
- Losses, koliko ima izgubljenih partija
- Rank, broj koji predstavlja relativnu veštinu igrača, poput Elo u šahu.

### Map
- Starting_gold, koliko zlatnika ima svaki igrač na početku
- Minimalno trajanje partije: nakon toga je moguće predati partiju
- Can always buy: da li uvek može da se kupuje u prodavnici, ili samo na početku

### Item
- Kupovinom stvari heroj postaje jači
- Cost: cena stvari u zlatnicima
- Health: život (količina štete koju može da pretrpi)
- Defense: otpornost na napade
- Damage: jačina napada
- Mana: energija potrebna za posebne napade
- Speed: dodatna brzina kretanja

### Hero
- Health, Defense, Damage, Mana: isto kao kod Item
- Speed: brzina kretanja.
- Passive, Spell1, Spell2, Spell3, Spell4: opisi četiri aktivna napada, i jednog pasivnog.

### Skin
Svaki heroj ima skinove, odnosno različite 3d modele. Jedan skin pripada samo jednom heroju.
- Cost: posto je igra besplatna, zarađuje prodajom skinova za prave pare.
- Is_on_sale: da li je trenutno na popustu.

### Shop
Koje stvari se mogu kupiti na kojoj mapi.

### Match
Odigrana partija.
- Length: vreme trajanja partije
- First_five_won: rezultat partije
- Sadrži id 10 igrača koji su učestvovali, id 10 heroja koje su izabrali, kao i id mape
