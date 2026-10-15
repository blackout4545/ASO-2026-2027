# Fitxa 2 — Organització del servei de directori de MusicCloud

## Objectiu

En aquesta sessió hem decidit com organitzar els diferents objectes de MusicCloud dins d'un servei de directori.

Aquesta fitxa forma part de la **documentació de disseny del sistema**. Les decisions que hi indiquis s'utilitzaran posteriorment durant la implantació.

# 1. Objectes que hem de gestionar

MusicCloud necessita gestionar de manera centralitzada diferents tipus d'objectes.

Indica quins tipus d'objectes consideres que ha de contenir el servei de directori.

| Tipus d'objecte | Exemples a MusicCloud |
|---|---|
| Usuaris | Aina Ciurans, Laia Macias, Talia Costas |
| Grups | Grup_Administracio, Grup_Admins_Sistema, Grup_Campanya_Estiu |
| Equips | PC-Direccio-01, PC-Informatica-03 |
| Servidors | SRV-FITXERS, SRV-WEB, SRV-BD |
| Comptes d'aplicacions o serveis | Compte del servei de còpies de seguretat, compte de connexió a la base de dades |

Hi afegiries algun altre tipus d'objecte?

Sí, els recursos compartits (impressores i carpetes de xarxa), per poder controlar-ne l'accés des del mateix directori. Els ordinadors no els afegeixo perquè ja estan inclosos a Equips.

---

# 2. Organització mitjançant unitats organitzatives

Proposa les **unitats organitzatives (OU)** principals que utilitzaries a MusicCloud.

| OU | Què contindrà? | Per què la crees? |
|---|---|---|
| OU_Usuaris | Els comptes dels treballadors, dividits per departament | Reflecteix l'organigrama de l'empresa i permet aplicar configuracions diferents per departament. |
| OU_Equips | Els ordinadors dels treballadors | Necessiten polítiques de configuració i seguretat pròpies, diferents de les dels usuaris. |
| OU_Servidors | Els servidors de l'empresa | Necessiten polítiques molt més estrictes que un ordinador de treball. |
| OU_Grups | Els grups de seguretat | Tenir-los tots localitzats i fàcils de gestionar. |
| OU_Comptes_Servei | Els comptes que fan servir les aplicacions i els serveis (no són persones) | Separar-los dels usuaris reals, perquè tenen necessitats especials, com contrasenyes que no caduquen. |

## 2.1. Organització dels usuaris

Dibuixa l'estructura que utilitzaries per organitzar els usuaris de MusicCloud.

```text
MusicCloud
│
└── OU_Usuaris
    ├── OU_Direccio
    ├── OU_Administracio
    ├── OU_SuportTecnic
    ├── OU_ProduccioMusical
    ├── OU_Informatica
    └── OU_Externs
```

---

# 3. OU o grup?

Indica quina opció utilitzaries principalment en cada cas.

| Necessitat | OU | Grup |
|---|:-:|:-:|
| Organitzar els treballadors d'Administració | ☐ |  |
| Donar accés a la carpeta d'Administració |  | ☐ |
| Organitzar els ordinadors clients | ☐ |  |
| Identificar les persones que participen en Campanya Estiu |  | ☐ |
| Organitzar els servidors | ☐ |  |
| Donar privilegis als administradors del sistema |  | ☐ |
| Organitzar els comptes utilitzats per aplicacions | ☐ |  |

### Explica amb les teves paraules la diferència principal entre una OU i un grup.

**OU:**

És el lloc on es guarda un objecte dins del directori; cada objecte només pot estar en una. Serveix per organitzar l'estructura i aplicar polítiques de configuració.

**Grup:**

És un conjunt d'usuaris que comparteixen els mateixos permisos. Una persona pot pertànyer a molts grups alhora. Serveix per donar permisos sobre recursos.

---

# 4. Un mateix usuari: ubicació i pertinença

Considera aquest cas:

**Dídac Gassó**

- treballa a Administració;
- participa en el projecte Campanya Estiu.

Indica:

**En quina OU ubicaries el seu compte?**

A `OU_Usuaris > OU_Administracio`, perquè és el seu departament i la seva ubicació fixa dins l'empresa.

**A quins grups podria pertànyer?**

A `Grup_Administracio` (accés a les carpetes del departament) i a `Grup_Campanya_Estiu` (accés als recursos del projecte).

### Per què no és contradictori que estigui en una OU però pertanyi a diversos grups?

Perquè l'OU i els grups serveixen per coses diferents. L'OU indica on està el compte (només en un lloc) i els grups indiquen quins permisos té (en pot tenir molts). En Dídac pot entrar o sortir d'un projecte sense canviar d'OU.

---

# 5. Servei de directori

Explica breument què entens per **servei de directori**.

És una base de dades centralitzada que guarda els usuaris, grups, equips i servidors de l'empresa i permet gestionar-los tots des d'un sol lloc.

Quin problema resol a MusicCloud?

Sense servei de directori, cada ordinador i cada servei tindria la seva pròpia llista d'usuaris i contrasenyes. Amb un servei de directori, cada treballador té un únic compte per identificar-se a l'ordinador, a les carpetes i a les aplicacions. El compte només diu qui és la persona; els permisos sobre cada recurs es donen a part, amb grups. Si algú canvia de departament o marxa, es canvia el compte en un sol lloc. Amb 14 treballadors ja és la manera més apropiada de gestionar-ho.

---

# 6. LDAP

Completa les frases següents.

**LDAP és:**

Un protocol (Lightweight Directory Access Protocol) que defineix com consultar i modificar la informació d'un servei de directori.

**LDAP no és:**

Ni un programa ni un servei de directori en si mateix, i no és el mateix que Active Directory. És només el llenguatge que es fa servir per comunicar-s'hi.

Indica si les afirmacions són certes o falses.

| Afirmació | C | F |
|---|:-:|:-:|
| LDAP és sinònim d'Active Directory |  | ☐ |
| LDAP permet accedir i consultar informació d'un directori | ☐ |  |
| OpenLDAP és una implementació d'un servei de directori | ☐ |  |
| Active Directory utilitza LDAP, entre altres tecnologies | ☐ |  |

---

# 7. DIT de MusicCloud

Dibuixa la proposta final de **Directory Information Tree (DIT)** de MusicCloud.

Ha de mostrar, com a mínim:

- usuaris;
- grups;
- equips;
- servidors;
- comptes d'aplicacions o serveis;
- les subdivisions que consideris necessàries.

```text
MusicCloud
│
├── OU_Usuaris
│   ├── OU_Direccio
│   ├── OU_Administracio
│   ├── OU_SuportTecnic
│   ├── OU_ProduccioMusical
│   ├── OU_Informatica
│   └── OU_Externs
│
├── OU_Grups
│   ├── Grup_Direccio
│   ├── Grup_Administracio
│   ├── Grup_SuportTecnic
│   ├── Grup_ProduccioMusical
│   ├── Grup_Informatica
│   ├── Grup_Externs
│   ├── Grup_Caps_Departament
│   ├── Grup_Admins_Sistema
│   └── Grup_Campanya_Estiu
│
├── OU_Equips
├── OU_Servidors
└── OU_Comptes_Servei
```

---

# 8. Justificació del disseny

Escull **dues decisions** del teu DIT que consideris importants i justifica-les.

### Decisió 1

Separar els servidors dels equips dels treballadors, amb dues OU diferents: `OU_Servidors` i `OU_Equips`.

**Justificació:**

Els servidors necessiten polítiques de seguretat més estrictes que els ordinadors normals. Separats, una política pensada per a un ordinador de treball no afectarà per error un servidor important.

### Decisió 2

Gestionar el projecte Campanya Estiu amb un grup (`Grup_Campanya_Estiu`) en lloc de crear una OU per al projecte.

**Justificació:**

Un usuari només pot estar en una OU i ja és a la del seu departament, però al projecte hi participen persones de diversos departaments. Amb un grup accedeixen als recursos del projecte sense canviar d'OU, i quan acabi només cal eliminar el grup.

---

# 9. Comprovació final

Respon breument.

### a) Per què no seria una bona idea guardar tots els usuaris, grups, equips i servidors al mateix nivell sense organitzar-los?

Perquè seria molt difícil trobar i gestionar els objectes, i no es podrien aplicar polítiques diferents segons el tipus (un servidor no es configura com l'ordinador d'un treballador).

### b) Per què no hauríem d'utilitzar les OU per substituir els grups de permisos?

Perquè una OU serveix per ubicar un objecte i aplicar-li polítiques, però els permisos sobre els recursos es gestionen amb grups. A més, un usuari només pot estar en una OU i pot necessitar permisos de diverses coses alhora (departament, projecte, rol).

### c) Si MusicCloud passa de 14 a 500 treballadors, quina característica del disseny que has fet avui facilitarà més l'administració?

Que separa l'estructura dels permisos. Un treballador nou es crea a l'OU del seu departament, on rep les polítiques que li toquen, i s'afegeix al grup del departament, que ja té els permisos. No cal configurar res usuari per usuari.

---

# Documentació final del sistema

A partir de les decisions preses durant la sessió, deixa definida la proposta que utilitzarem inicialment per a MusicCloud.

## Estructura d'unitats organitzatives

```text
MusicCloud
│
├── OU_Usuaris
│   ├── OU_Direccio
│   ├── OU_Administracio
│   ├── OU_SuportTecnic
│   ├── OU_ProduccioMusical
│   ├── OU_Informatica
│   └── OU_Externs
│
├── OU_Grups
├── OU_Equips
├── OU_Servidors
└── OU_Comptes_Servei
```

## Criteri utilitzat per organitzar els objectes

Els objectes s'organitzen primer per tipus (usuaris, grups, equips, servidors i comptes de servei) i, dins dels usuaris, per departament, seguint l'organigrama real de l'empresa.

## Criteri utilitzat per diferenciar OU i grups

Les OU defineixen una estructura fixa: on es guarda cada objecte i quines polítiques rep. Els grups donen permisos sobre els recursos i poden ser permanents (departament) o temporals (projecte).
