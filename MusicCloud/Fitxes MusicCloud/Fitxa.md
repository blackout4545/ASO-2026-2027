# Fitxa 1 — Anàlisi inicial de MusicCloud

## Objectiu

MusicCloud necessita reorganitzar la seva infraestructura informàtica. Abans d'instal·lar o configurar cap servei, cal entendre:

- qui treballa a l'empresa;
- quines funcions té cada persona;
- quins recursos existeixen;
- qui necessita accedir a cada recurs;
- com podem gestionar aquests accessos de manera eficient.

---

# 1. Conèixer MusicCloud

Consulta la informació disponible sobre els departaments, treballadors i perfils d'usuari de MusicCloud.

Completa la taula següent.

| Persona | Departament | Funció / responsabilitat | Necessita privilegis especials? Per què? |
|---|---|---|---|
| Aina Ciurans, Rut Tornil | Direcció | Gestió general de l'empresa | **Sí.** Han de poder consultar (només lectura) les carpetes de tots els departaments i tenen carpetes confidencials pròpies. |
| Dídac Gassó | Administració | Factures, contractes i documentació interna | **No.** Usuari estàndard: només necessita els recursos del seu departament i els comuns. |
| Laia Macias | Administració | Cap del departament | **Sí.** Com a responsable ha d'accedir a la carpeta de gestió del departament, que els seus companys no veuen. |
| Estel Birosta, Aina Zuriguel | Suport tècnic | Manteniment de sistemes i incidències | **No de forma permanent.** Només tenen accessos temporals i registrats quan han de resoldre una incidència. |
| Lluïsa Richart | Suport tècnic | Cap del departament | **Sí.** Gestiona la carpeta de gestió del departament i la dels scripts. |
| Roser Alberch, Guillem Adella, Alícia Monclús, Carles Molins, Eulàlia Galcera | Producció musical | Gestió de continguts musicals | **No.** Usuaris estàndard, treballen amb les carpetes d'artistes i catàleg. |
| Meritxell Reglat | Producció musical | Cap del departament | **Sí.** Necessita la carpeta de gestió del departament, amb permisos que la resta de l'equip no té. |
| Talia Costas, Alex Soriano | Informàtica | Suport sistema informàtic (Talia també és cap del departament) | **Sí.** Han d'administrar els sistemes: crear usuaris, gestionar permisos, fer còpies de seguretat i revisar logs. |
| Pere Espinalt, Neus Bages | Externs | Usuaris temporals o externs | **No, al contrari:** necessiten encara menys accés que ningú. Només poden fer servir la carpeta d'intercanvi. |

### 1.1. Reflexió

Quines diferències observes entre un **treballador**, un **departament** i una **funció o responsabilitat**?

Un treballador és la persona (Laia Macias). Un departament és el grup on treballa (Administració). Una funció és el paper que hi fa (cap de departament): dos companys del mateix departament poden tenir funcions diferents, i és la funció la que decideix quins accessos necessita.

Hi ha persones que, pel seu càrrec o funció, necessiten accessos diferents dels altres membres del seu departament?

☑ Sí  
☐ No

Posa'n algun exemple:

Laia Macias, cap d'Administració, pot entrar a la carpeta de gestió del departament i en Dídac, del mateix departament, no. Talia Costas i Alex Soriano, d'Informàtica, administren els backups i els logs.

# 2. Recursos de l'empresa

Analitza l'estructura d'informació de MusicCloud.

Classifica alguns dels recursos següents segons la seva finalitat.

| Recurs | Qui creus que l'hauria d'utilitzar? | Per a què? |
|---|---|---|
| `/empresa/comu/intercanvi` | Tothom, també els usuaris externs | Intercanviar documents de manera temporal amb persones de fora de l'empresa. |
| `/empresa/comu/comunicats` | Direcció hi publica; la resta de treballadors només el llegeix (els externs no hi accedeixen) | Avisos i comunicats interns de l'empresa. |
| `/empresa/departaments/administracio/compartida` | Els treballadors d'Administració (Direcció només en lectura) | Documents de treball que comparteix tot el departament. |
| `/empresa/departaments/administracio/gestio_departament` | Només la cap d'Administració (Direcció només en lectura) | Documents de gestió i validació del responsable, amb informació restringida. |
| `/empresa/projectes/campanya_estiu` | Només les persones assignades al projecte, vinguin del departament que vinguin | Treballar conjuntament en la campanya d'estiu. |
| `/empresa/administracio_sistema/backups` | Només els administradors del sistema (Informàtica) | Guardar les còpies de seguretat de l'empresa, que són molt sensibles. |

---

# 3. Qui ha de poder fer què?

Per a cada situació, indica quin nivell d'accés consideres adequat.

Utilitza:

- **NA** → sense accés
- **L** → lectura
- **L/E** → lectura i escriptura
- **ADM** → administració

No busquis encara una solució tècnica. Pensa només en les necessitats de l'empresa.

| Situació | Accés proposat | Justificació |
|---|---|---|
| Dídac accedeix a la carpeta compartida d'Administració | L/E | Treballa al departament i ha de poder crear i modificar documents. |
| Laia accedeix a la gestió del departament d'Administració | L/E | És la responsable del departament i és l'única que hi treballa. |
| Pere, treballador extern, accedeix als comunicats interns | NA | És una persona externa i no ha de veure informació interna. |
| Talia accedeix als backups del sistema | ADM | És administradora del sistema i ha de poder gestionar-los. |
| Un membre de Producció musical accedeix a la carpeta d'Administració | NA | No és del departament i no la necessita per fer la seva feina. |
| Un participant de `campanya_estiu` accedeix als fitxers del projecte | L/E | Ha de poder treballar amb els fitxers del projecte mentre hi participi. |

---

# 4. Primer problema: com assignem els permisos?

Imagina que MusicCloud té només quatre treballadors:

- Anna
- Biel
- Carla
- David

Tots quatre treballen al mateix departament i necessiten accedir a la mateixa carpeta.

Una possible solució seria configurar:

```text
Anna  → lectura/escriptura
Biel  → lectura/escriptura
Carla → lectura/escriptura
David → lectura/escriptura
```

### 4.1.

Què passaria si l'empresa tingués **100 treballadors** amb el mateix tipus d'accés?

Hauríem de configurar 100 permisos un per un. Seria molt lent, i és fàcil equivocar-se o deixar-se algú.

### 4.2.

Què passaria cada vegada que s'incorporés una persona nova?

Caldria afegir-la manualment a cada carpeta a la qual ha d'accedir, i podria quedar-se sense algun permís o tenir-ne un de més per error.

### 4.3.

Què passaria quan una persona canviés de departament?

Hauríem de treure-li un per un els permisos antics i afegir-li els nous. Si ens oblidem d'algun, conservaria accessos que ja no li corresponen.

### 4.4.

Proposa una manera de gestionar aquestes persones conjuntament.

No cal que coneguis encara el nom tècnic de la solució.

Ajuntar-les en un conjunt (per exemple, "Administració") i donar els permisos al conjunt en lloc de donar-los a cada persona. Afegir o treure algú del conjunt seria suficient per canviar-li tots els accessos.

# 5. Canvis a MusicCloud

Ara es produeixen aquests tres canvis:

### Cas A

Dídac deixa Administració i passa a Producció musical.

Quins accessos hauria de perdre?

Els de les carpetes d'Administració (la compartida i la de documentació interna).

Quins accessos hauria d'obtenir?

Els de les carpetes de Producció musical (la compartida, artistes i catàleg). Els recursos comuns de l'empresa els conserva.

### Cas B

S'incorpora una nova treballadora al departament d'Administració.

Quins accessos caldria configurar?

La seva carpeta personal, els recursos comuns de l'empresa i les carpetes d'Administració (compartida i documentació interna). No la carpeta de gestió del departament, que és només de la cap.

### Cas C

Pere Espinalt deixa de col·laborar amb MusicCloud.

Què hauríem de fer amb els seus accessos?

Desactivar-los o eliminar-los immediatament, perquè una persona que ja no col·labora amb l'empresa no ha de poder entrar a res. També convé revisar què ha deixat a la carpeta d'intercanvi.

# 6. Busquem una solució millor

Suposa ara que podem crear conjunts de persones que comparteixen unes mateixes necessitats d'accés.

Per exemple:

```text
Administració
    ├── Dídac
    ├── Laia
    └── Roser
```

I podem donar permisos directament al conjunt:

```text
Administració → carpeta_administracio → L/E
```

### 6.1.

Quin avantatge té aquesta solució respecte a donar permisos persona per persona?

El permís es dona una sola vegada al conjunt i s'aplica a tothom qui en forma part. Hi ha menys feina, menys errors i és més fàcil de revisar.

### 6.2.

Si Dídac passa d'Administració a Producció musical, què caldria modificar?

Només caldria treure'l del conjunt d'Administració i afegir-lo al de Producció musical. Els permisos de les carpetes no es toquen.

### 6.3.

Com anomenaries aquests conjunts de persones?

Grups.

# 7. Primera proposta per a MusicCloud

A partir de l'organització de l'empresa, proposa els primers conjunts de persones que crearies.

**No cal trobar encara la solució definitiva.**

| Nom proposat | Qui hi pertanyeria? | Per què existeix aquest conjunt? |
|---|---|---|
| Direccio | Aina Ciurans, Rut Tornil | Donar accés a les carpetes de Direcció i lectura a les dels altres departaments. |
| Administracio | Dídac Gassó, Laia Macias | Donar accés a les carpetes d'Administració. |
| SuportTecnic | Estel Birosta, Aina Zuriguel, Lluïsa Richart | Donar accés a les carpetes de Suport tècnic. |
| ProduccioMusical | Roser Alberch, Guillem Adella, Meritxell Reglat, Alícia Monclús, Carles Molins, Eulàlia Galcera | Donar accés a les carpetes de Producció musical. |
| Informatica | Talia Costas, Alex Soriano | Donar accés a les carpetes d'Informàtica. |
| Externs | Pere Espinalt, Neus Bages | Donar-los només accés a la carpeta d'intercanvi. |
| Caps_Departament | Laia Macias, Lluïsa Richart, Meritxell Reglat, Talia Costas | Donar els permisos de responsable de departament. |
| Admins_Sistema | Talia Costas, Alex Soriano | Donar privilegis d'administració (backups, logs, configuracions). |
| Campanya_Estiu | Persones de diversos departaments assignades al projecte | Donar accés a les carpetes del projecte només mentre dura. |

---

# 8. Cas que complica el model

Laia treballa al departament d'Administració, però també és la responsable del departament.

És suficient que pertanyi només al conjunt `Administració`?

☐ Sí  
☑ No

Per què?

Perquè amb el conjunt `Administració` només tindria els accessos d'un treballador normal, i com a responsable també necessita la carpeta de gestió del departament i poder consultar determinats informes de Direcció.

Quina possible solució proposes?

Que pertanyi a dos conjunts alhora: `Administració` (per als accessos del departament) i `Caps_Departament` (per als permisos de responsable).

---

# 9. Un altre cas

Diverses persones de departaments diferents participen temporalment en el projecte:

```text
Campanya Estiu
```

Creus que hauríem de canviar-les de departament?

☐ Sí  
☑ No

Si no, com podríem donar-los accés als recursos del projecte?

Creant un conjunt per al projecte (`Campanya_Estiu`), afegint-hi les persones que hi participen i donant-li accés a la carpeta del projecte. Cadascuna es queda al seu departament i, quan s'acabi la campanya, n'hi ha prou amb desfer el conjunt.

---

# 10. Conclusions

Completa les frases amb les teves paraules.

### Usuari

Un usuari representa:

La identitat d'una persona (o d'un servei) dins del sistema, amb el seu compte i la seva contrasenya. Serveix per saber qui és.

### Recurs

Un recurs és:

Qualsevol cosa a la qual es pot accedir: una carpeta compartida, un servidor, una impressora o una aplicació.

### Permís

Un permís determina:

Què pot fer un usuari amb un recurs concret: no accedir-hi, llegir, llegir i escriure o administrar-lo.

### Grup

Un grup serveix per:

Ajuntar usuaris que tenen les mateixes necessitats d'accés i donar els permisos de cop, en lloc de fer-ho un per un.

---

# 11. Regla de mínim privilegi

Analitza aquesta afirmació:

> Un usuari només hauria de tenir els permisos estrictament necessaris per realitzar la seva feina.

Explica amb les teves paraules què significa.

Significa donar a cada persona només l'accés que necessita per treballar. Així es redueixen els errors i el dany si li roben el compte.

Posa un exemple relacionat amb MusicCloud.

Un membre de Producció musical no ha de poder entrar a les carpetes d'Administració (factures i contractes), perquè no les necessita per fer la seva feina.

---

# 12. Pregunta final

Imagina que demà MusicCloud passa de 14 treballadors a 500.

Quina de les dues estratègies consideres més adequada?

☐ Assignar permisos individualment a cada usuari.

☑ Organitzar els usuaris segons les seves necessitats i assignar permisos a aquests conjunts.

Justifica la resposta.

Amb 500 treballadors, donar permisos un per un seria inabastable i s'hi cometrien molts errors. Amb conjunts, una persona nova només s'afegeix al seu grup, i si canvia de departament només cal canviar-la de grup.
