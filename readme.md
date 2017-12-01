# Tema: Online video igra

## Opis domena

Nezavisni entiteti:
- Player
- Hero
- Map
- Item

Zavisni Entiteti:
- Skin

Agregirani entiteti:
- Shop
- Match

Trigeri:
- Nakon završene partije se ažuriraju broj pobeda/izgubljenih, iskustvo, nivo, kao i rank svakog igrača.
- Pri pravljenju novog naloga igrača, njegova lozinka se hešira. Takođe i kada je ažurira.

### Player
Svaki igrač ima svoj nalog.
- Name: nadimak igrača u igri
- Password: heširana lozinka
- Level: trenutni nivo igrača
- Experience: deo progresa ka sledećem nivou
- Wins: koliko igrač ima pobeđenih partija
- Losses: koliko ima izgubljenih partija
- Rank: broj koji predstavlja relativnu veštinu igrača, poput Elo u šahu.

### Hero
U igri postoji više različitih heroja, odnosno karaktetera kojima igrač može da upravlja.
- Name: njegovo ime
- Health: život (količina štete koju može da pretrpi)
- Defense: otpornost na napade
- Damage: jačina napada
- Mana: energija potrebna za posebne napade
- Speed: brzina kretanja.
- Passive, Spell1, Spell2, Spell3, Spell4: opisi četiri aktivna napada, i jednog pasivnog.

### Map
Postoji više mapa na kojima mogu da se igraju partije.
- Mape imaju ime
- Starting_gold: koliko zlatnika ima svaki igrač na početku
- Minimalno trajanje partije: nakon toga je moguće predati partiju
- Pamti se i očekivano trajanje partije na toj mapi.

### Item
Kupovinom stvari heroj postaje jači.
- Svaki item ima naziv
- Cost: cena stvari u zlatnicima
- Health, Defense, Damage, Mana: isto kao kod Hero
- Speed: dodatna brzina kretanja

### Skin
Pre početka partije, pored heroja igrač bira i jedan od nekoliko izgleda za svog heroja tokom partije.
Svaki heroj ima skinove, odnosno različite 3d modele. Jedan skin pripada samo jednom heroju, i svaki skin ima naziv.
- Cost: posto je igra besplatna, zarađuje prodajom skinova za prave pare.
- Is_on_sale: da li je trenutno na popustu.

### Shop
Na svakoj mapi postoji prodavnica gde se mogu kupiti stvari (oklop, oružje), ali nisu sve stvari dostupne u svakoj prodavnici.
Ako item može da se kupi, onda se pamti da li može na početku partije, ili tek posle.

### Match
Odigrana partija.
U jednoj partiji učestvuje 10 igrača. Igraju dva tima jedni protiv drugih, 5 na 5.
Pre svake partije igrač bira tačno jednog heroja koga će igrati u toj partiji.
- Length: vreme trajanja partije
- First_five_won: rezultat partije
- Sadrži id 10 igrača koji su učestvovali, id 10 heroja koje su izabrali, kao i id mape
