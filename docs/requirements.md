# Anforderungen und User Stories

> [!NOTE]
> Stand Phase 1, am 13.11.2026 vom Team bestätigt. Die offenen Punkte vom 09.11.2026 sind geklärt; Entscheidungen und Abweichungen stehen in [mvp.md](mvp.md#entscheidungen-der-teamprüfung).
>
> **Scope-Änderung vorgeschlagen am 13.11.2026:** Web-App mit Konto und Daten auf dem Server, Offline-Nutzung erst nach dem MVP ([ADR-0002](adr/0002-architekturstil-client-server.md)). Ohne Einwand des Teams gilt sie ab 15.11.2026; dieses Dokument enthält sie bereits.

**Inhalt:** [Kontext](#kontext) · [Anwendungsfälle](#wichtigste-anwendungsfälle) · [Begriffe](#begriffe) · [Fachliche Regeln](#fachliche-regeln) · [User Stories](#user-stories-mit-akzeptanzkriterien) · [Funktionale Anforderungen](#funktionale-anforderungen) · [Nichtfunktionale Anforderungen](#nichtfunktionale-anforderungen) · [Einschränkungen und Risiken](#bekannte-einschränkungen-und-risiken)

## Kontext

- **Produkt:** Jausi verbindet Lebensmittelvorrat und persönliches Rezeptarchiv und zeigt, was mit vorhandenen Zutaten kochbar ist. Problem und Zahlen stehen im [README](../README.md).
- **Zielgruppe:** Menschen, die mit vorhandenen Zutaten kochen möchten, primär Studierende. Die Personas Lena (primär), Andrea und Jonas stehen in [personas.md](personas.md). „Nutzer“ in den Stories meint alle Personas.
- **Nutzung:** hauptsächlich auf dem Smartphone, in der Küche (Was kann ich kochen? Rezept lesen) und beim Einkaufen (Was fehlt? Vorrat ergänzen). Im MVP ist Jausi eine Web-App für den Browser des Smartphones; sie braucht eine Internetverbindung. Mit einem Konto sind die Daten auf jedem Gerät verfügbar. Eine eigene App und Offline-Funktionen folgen nach dem MVP.
- **Rahmen:** Semesterprojekt eines vierköpfigen Teams mit kleinem MVP. Architekturstil: Web-App mit Server und Konten ([ADR-0002](adr/0002-architekturstil-client-server.md), vorgeschlagen).

## Wichtigste Anwendungsfälle

Jeder Anwendungsfall beschreibt, wer wann warum handelt und was danach gilt. Jede User Story gehört zu mindestens einem Anwendungsfall.

| ID | Anwendungsfall | Persona | Auslöser | Ergebnis | User Stories | Im MVP |
| --- | --- | --- | --- | --- | --- | --- |
| AF-1 | Vorrat pflegen | alle | nach dem Einkauf oder Kochen | Der Vorrat stimmt mit den Zutaten daheim überein. | US-01–03, US-13–15, US-17, US-18, US-21 | Teilweise (nur Must-Stories) |
| AF-2 | Rezepte sammeln | Jonas | ein neues Gericht gekocht oder entdeckt | Das Rezept ist im Archiv und wiederauffindbar. | US-04–07, US-11, US-13, US-17–19, US-22, US-32 | Teilweise (nur Must-Stories) |
| AF-3 | Was kann ich kochen? | Lena | Hunger, Blick in den Kühlschrank | Ein Rezept ist gewählt, dessen Zutaten alle vorhanden sind. | US-08, US-09 | Ja, vollständig (Hauptanwendungsfall) |
| AF-4 | Einkauf planen | Andrea | vor dem Wocheneinkauf | Sie weiß, welche Zutaten sie für welche Rezepte nachkaufen muss. | US-09, US-10, US-12, US-20, US-28 | Teilweise (nur Must-Story US-09) |
| AF-5 | Nach Rezept kochen | alle | am Herd, Smartphone in der Hand | Das Gericht ist zubereitet, ohne lange im Rezept zu suchen. | US-05, US-16 | Teilweise (nur Must-Story US-05) |
| AF-6 | Konto nutzen | alle | erster Start, neues Gerät oder keine Verbindung | Die Person kommt an ihre eigenen Daten und kann sie mitnehmen. | US-23–26, US-29–31 | Teilweise (nur Must-Stories) |
| AF-7 | Verbrauch nachvollziehen | Andrea | Rückblick auf die letzten Wochen | Sie weiß, welche Zutaten sie oft kauft und verbraucht. | US-27 | Nein |

AF-6 (Konto) ist die Voraussetzung für alle anderen; AF-1 und AF-2 sind die Voraussetzung für den Hauptanwendungsfall AF-3:

```mermaid
flowchart LR
    AF6["AF-6<br/>Konto nutzen"] --> AF1
    AF6 --> AF2
    AF1["AF-1<br/>Vorrat pflegen"] --> AF3{{"AF-3<br/>Was kann ich kochen?"}}
    AF2["AF-2<br/>Rezepte sammeln"] --> AF3
    AF3 -->|"alles da"| AF5["AF-5<br/>Nach Rezept kochen"]
    AF3 -->|"etwas fehlt"| AF4["AF-4<br/>Einkauf planen"]
    AF4 -.->|"nach dem Einkauf"| AF1
    AF1 -.->|"über die Zeit"| AF7["AF-7<br/>Verbrauch nachvollziehen"]
```

## Begriffe

Die Begriffe gelten verbindlich für alle Projektdokumente; wörtliche Zitate in [ai-usage.md](ai-usage.md) bleiben unverändert.

| Begriff | Bedeutung | Nicht verwenden |
| --- | --- | --- |
| **Zutatenkatalog** | Fest vorgegebene Liste aller Zutaten mit genau einer Schreibweise je Zutat. Das Team pflegt sie von Hand; sie ist für alle Konten gleich. Vorrat und Rezepte verwenden nur Zutaten daraus. Eigene Zutaten anzulegen ist eine spätere Erweiterung (US-17, Should). | Zutatenliste |
| **Vorrat** | Zutaten aus dem Katalog, die gerade daheim sind, ohne Mengen. | Bestand, Vorratsliste, Inventur, Inventurliste |
| **Rezept** | Name, mindestens eine Zutat und eine Zubereitung als Freitext; Mengen sind optional und Freitext. | – |
| **Rezeptarchiv** (kurz: Archiv) | Alle gespeicherten Rezepte. | Rezeptliste, Rezeptsammlung |
| **Zutatenvorschlag** | Zutat aus dem Katalog, die beim Eintippen angezeigt wird (US-13). Nicht dasselbe wie Matching. | – |
| **Matching** | Abgleich eines Rezepts mit dem Vorrat: Welche Zutaten sind da, welche fehlen? Mengen zählen nicht. | Rezeptvorschlag |
| **Vollständig passendes Rezept** | Alle Zutaten des Rezepts stehen im Vorrat. | – |
| **Fehlende Zutat** | Zutat eines Rezepts, die nicht im Vorrat steht. | – |
| **Favorit** | Vom Nutzer markiertes Rezept (Could). | Lieblingsrezept |
| **Einkaufsliste** | Zutaten aus dem Katalog, die der Nutzer kaufen will (Could). Abgehakte Zutaten wandern in den Vorrat. | Shoppingliste |
| **Konto** | Zugang einer Person mit E-Mail-Adresse und Passwort. Vorrat, Rezeptarchiv und Einkaufsliste gehören zu genau einem Konto; der Zutatenkatalog ist für alle gleich. | Account, Profil |
| **Kategorie** | Vom Nutzer selbst angelegte Gruppe für Zutaten oder Rezepte, etwa „Gemüse“ oder „Frühstück“ (Could). | Tag, Label |

```mermaid
erDiagram
    ZUTATENKATALOG ||--o{ ZUTAT : "enthält (fest vorgegeben)"
    VORRAT }o--o{ ZUTAT : "enthält (ohne Menge)"
    REZEPTARCHIV ||--o{ REZEPT : "enthält"
    REZEPT }o--|{ ZUTAT : "verwendet (Menge optional)"
    KONTO ||--|| VORRAT : "besitzt"
    KONTO ||--|| REZEPTARCHIV : "besitzt"
```

## Fachliche Regeln

**Zutaten**
- Vorrat und Rezepte verwenden nur Zutaten aus dem Zutatenkatalog. Im MVP ist der Katalog fest: Nutzer können keine Zutaten anlegen, umbenennen oder löschen.
- Beim Tippen werden alle Zutaten vorgeschlagen, deren Name die Eingabe enthält, ohne Beachtung der Groß-/Kleinschreibung und alphabetisch sortiert.
- Enthält keine Zutat des Katalogs die Eingabe, erscheint ein Hinweis, und es wird nichts übernommen.

**Eigene Zutaten (Should, nach dem MVP)**
- Fehlt eine Zutat, wird sie neu angelegt, direkt dort übernommen, wo sie eingegeben wurde (Vorrat oder Rezept), und steht danach überall zur Auswahl (US-17).
- Namen, die sich nur in Groß-/Kleinschreibung oder in Leerzeichen am Rand unterscheiden, gelten als gleich. Dann wird die vorhandene Zutat verwendet; die zuerst eingegebene Schreibweise bleibt (US-18).
- Ein Zutatenname darf nicht leer sein und nicht nur aus Leerzeichen bestehen.

**Vorrat**
- Jede Zutat steht höchstens einmal im Vorrat; was nicht darin steht, gilt als nicht vorhanden. Mengen werden nicht erfasst.
- Salz, Öl und andere Grundzutaten werden wie alle Zutaten behandelt und nicht automatisch als vorhanden angenommen.

**Rezepte**
- Ein Rezept ist gültig mit Name, mindestens einer Zutat und einer nicht leeren Zubereitung (Freitext).
- Jede Zutat steht höchstens einmal in einem Rezept; erneutes Hinzufügen zeigt einen Hinweis.
- Rezeptnamen sind eindeutig; Namen, die sich nur in Groß-/Kleinschreibung oder in Leerzeichen am Rand unterscheiden, gelten als gleich.
- Mengen sind optional und werden je Zutat als Freitext erfasst, etwa „500 g“ oder „1 Prise“.
- Zutaten, die nicht im Zutatenkatalog stehen, können im MVP nur in der Zubereitung erwähnt werden; sie zählen nicht fürs Matching.

**Anzeige und Speichern**
- Vorrat und Archiv sind alphabetisch sortiert, ohne Beachtung der Groß-/Kleinschreibung.
- Das Archiv zeigt bei jedem Rezept, ob alle Zutaten vorhanden sind oder wie viele fehlen.
- Änderungen am Vorrat werden sofort gespeichert. Rezepte werden mit „Speichern“ gesichert. Wer ein Rezept mit ungespeicherten Änderungen verlässt, bekommt eine Sicherheitsabfrage (US-32, Should).

**Matching**
- Ein Rezept passt vollständig, wenn alle seine Zutaten im Vorrat stehen. Mengen werden nicht geprüft.
- Änderungen am Vorrat ändern keine Rezepte; das Matching verwendet immer den aktuellen Vorrat.

**Konto**
- Das Konto dient nur der Anmeldung und der Zuordnung der Daten. Profilfunktionen wie Name, Bild oder Einstellungen sind nicht vorgesehen.
- Die E-Mail-Adresse ist eindeutig, ohne Beachtung der Groß-/Kleinschreibung.
- Ein Passwort hat mindestens 8 Zeichen.
- Jede Person sieht und ändert nur Vorrat, Rezepte und Einkaufsliste ihres eigenen Kontos.

**Einkaufsliste (Could)**
- Die Einkaufsliste enthält nur Zutaten aus dem Zutatenkatalog.
- Abgehakte Zutaten werden in den Vorrat übernommen und von der Liste entfernt.

## User Stories mit Akzeptanzkriterien

Die Stories sind nach Anwendungsfall gruppiert. Ein Klick klappt eine Story mit ihren Akzeptanzkriterien (AK) im Format Gegeben / Wenn / Dann auf. Hinweistexte dürfen im Design (Phase 2) umformuliert werden; ihre Aussage bleibt gleich. Alle Stories außer denen zu AF-6 setzen voraus, dass die Person angemeldet ist.

### Story Map

**Must** ist nötig für den Kernablauf: anmelden, Zutaten erfassen, Rezepte verwalten, passende Rezepte und fehlende Zutaten sehen, alles dauerhaft im Konto gespeichert und im Browser des Smartphones bedienbar. Die Must-Zeile ist der MVP. **Should** verbessert die Nutzung, **Could** ist Komfort; beide sind im Kurs möglich, wenn Zeit bleibt. **Später** sind legitime Funktionen, die bewusst erst nach dem Kurs in Frage kommen.

| | 🥕 AF-1<br>Vorrat pflegen | 📖 AF-2<br>Rezepte sammeln | 🍳 AF-3<br>Was kann ich kochen? | 🛒 AF-4<br>Einkauf planen | 👩‍🍳 AF-5<br>Nach Rezept kochen | 🔐 AF-6<br>Konto nutzen | 📊 AF-7<br>Verbrauch nachvollziehen |
| --- | --- | --- | --- | --- | --- | --- | --- |
| **Must** | [US-01](#us-01)<br>[US-02](#us-02)<br>[US-03](#us-03)<br>[US-13](#us-13) | [US-04](#us-04)<br>[US-05](#us-05)<br>[US-06](#us-06)<br>[US-19](#us-19) | [US-08](#us-08)<br>[US-09](#us-09) | – | – | [US-23](#us-23)<br>[US-24](#us-24)<br>[US-26](#us-26)<br>[US-31](#us-31) | – |
| **Should** | [US-17](#us-17)<br>[US-18](#us-18)<br>[US-14](#us-14) | [US-07](#us-07)<br>[US-32](#us-32) | – | [US-10](#us-10) | – | [US-25](#us-25) | – |
| **Could** | [US-15](#us-15)<br>[US-21](#us-21) | [US-11](#us-11)<br>[US-22](#us-22) | – | [US-12](#us-12)<br>[US-20](#us-20) | [US-16](#us-16) | – | – |
| **Später** | – | – | – | [US-28](#us-28) | – | [US-29](#us-29)<br>[US-30](#us-30) | [US-27](#us-27) |

### 🥕 AF-1 · Vorrat pflegen

<a id="us-01"></a>
<details>
<summary><strong>US-01 · Zutat zum Vorrat hinzufügen</strong> · Must</summary>

> Als Nutzer möchte ich eine Zutat aus dem Zutatenkatalog zum Vorrat hinzufügen, damit Jausi weiß, welche Rezepte ich kochen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Reis“ steht im Zutatenkatalog, aber nicht im Vorrat
- **Wenn** die Person „Reis“ zum Vorrat hinzufügt
- **Dann** steht „Reis“ im Vorrat.

**AK 2**
- **Gegeben** „Reis“ steht bereits im Vorrat
- **Wenn** die Person „Reis“ erneut hinzufügt
- **Dann** steht „Reis“ weiterhin genau einmal im Vorrat.

**AK 3**
- **Gegeben** die Person hat „Reis“ zum Vorrat hinzugefügt
- **Wenn** sie die App sofort danach schließt und neu startet
- **Dann** steht „Reis“ im Vorrat, ohne dass sie etwas speichern musste.

</details>

<a id="us-02"></a>
<details>
<summary><strong>US-02 · Vorrat anzeigen</strong> · Must</summary>

> Als Nutzer möchte ich meinen Vorrat sehen, damit ich vorhandene Lebensmittel überblicken kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** der Vorrat enthält Tomate und Reis
- **Wenn** die Person den Vorrat öffnet
- **Dann** werden genau Reis und Tomate angezeigt, in dieser Reihenfolge (alphabetisch).

**AK 2**
- **Gegeben** der Vorrat ist leer
- **Wenn** die Person den Vorrat öffnet
- **Dann** erscheint der Hinweis „Noch keine Zutaten im Vorrat“, und das Hinzufügen einer Zutat ist mit einem Tipp erreichbar.

</details>

<a id="us-03"></a>
<details>
<summary><strong>US-03 · Zutat aus dem Vorrat entfernen</strong> · Must</summary>

> Als Nutzer möchte ich verbrauchte Zutaten entfernen, damit mein Vorrat aktuell bleibt.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** Tomate steht im Vorrat und im Rezept „Tomatenreis“
- **Wenn** die Person Tomate aus dem Vorrat entfernt
- **Dann** steht Tomate nicht mehr im Vorrat, das Rezept „Tomatenreis“ bleibt unverändert und zeigt Tomate als fehlende Zutat.

**AK 2**
- **Gegeben** Tomate steht im Vorrat
- **Wenn** die Person Tomate entfernt
- **Dann** geschieht das sofort, ohne Sicherheitsabfrage.

</details>

<a id="us-13"></a>
<details>
<summary><strong>US-13 · Zutatenvorschläge beim Tippen</strong> · Must</summary>

> Als Nutzer möchte ich beim Eintippen einer Zutat passende Zutaten aus dem Zutatenkatalog vorgeschlagen bekommen, damit ich schnell auswähle, statt den ganzen Namen zu tippen.

*Gehört auch zu AF-2.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Reis“ und „Paprika“ stehen im Zutatenkatalog
- **Wenn** die Person „RE“ eintippt
- **Dann** wird „Reis“ vorgeschlagen und „Paprika“ nicht.

**AK 2**
- **Gegeben** „Reis“ wird vorgeschlagen
- **Wenn** die Person den Vorschlag wählt
- **Dann** wird „Reis“ übernommen, ohne dass eine neue Zutat entsteht.

**AK 3**
- **Gegeben** „Reis“ und „Eis“ stehen im Zutatenkatalog
- **Wenn** die Person „eis“ eintippt
- **Dann** werden „Eis“ und „Reis“ in dieser Reihenfolge vorgeschlagen, weil beide „eis“ enthalten.

**AK 4**
- **Gegeben** keine Zutat im Zutatenkatalog enthält „Xyz“
- **Wenn** die Person „Xyz“ eintippt
- **Dann** erscheint der Hinweis „Zutat nicht im Katalog“, und es wird keine Zutat übernommen.

</details>

<a id="us-17"></a>
<details>
<summary><strong>US-17 · Neue Zutat anlegen</strong> · Should</summary>

> Als Nutzer möchte ich eine Zutat neu anlegen, wenn sie nicht im Zutatenkatalog steht, damit ich auch Zutaten verwenden kann, die der feste Katalog nicht enthält.

*Gehört auch zu AF-2.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Ei“ steht nicht im Zutatenkatalog
- **Wenn** die Person im Vorrat „Ei“ eintippt und neu anlegt
- **Dann** steht „Ei“ im Zutatenkatalog und im Vorrat und ist auch in Rezepten auswählbar.

**AK 2**
- **Gegeben** „Ei“ steht nicht im Zutatenkatalog
- **Wenn** die Person beim Anlegen eines Rezepts „Ei“ eintippt und neu anlegt
- **Dann** steht „Ei“ im Zutatenkatalog und im Rezept, aber nicht im Vorrat.

**AK 3**
- **Gegeben** die Eingabe ist leer oder besteht nur aus Leerzeichen
- **Wenn** die Person eine Zutat anlegen will
- **Dann** wird keine Zutat angelegt, und ein Hinweis erscheint.

</details>

<a id="us-18"></a>
<details>
<summary><strong>US-18 · Doppelte Zutaten verhindern</strong> · Should</summary>

> Als Nutzer möchte ich, dass Jausi beim Anlegen eigener Zutaten Duplikate verhindert, damit das Matching nicht an unterschiedlichen Schreibweisen scheitert.

*Gehört auch zu AF-2.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Reis“ steht im Zutatenkatalog
- **Wenn** die Person „ reis “ neu anlegen will
- **Dann** wird keine neue Zutat angelegt, sondern „Reis“ verwendet.

**AK 2**
- **Gegeben** „Tomate“ steht im Zutatenkatalog
- **Wenn** die Person „Tomaten“ anlegt
- **Dann** entsteht eine zweite Zutat. Das ist die dokumentierte Einschränkung bei Pluralformen.

</details>

<a id="us-14"></a>
<details>
<summary><strong>US-14 · Zutaten umbenennen oder zusammenführen</strong> · Should</summary>

> Als Nutzer möchte ich Zutaten umbenennen oder zusammenführen, damit ich Tippfehler und Duplikate korrigieren kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Tomatte“ steht im Vorrat und im Rezept „Tomatenreis“
- **Wenn** die Person sie in „Tomate“ umbenennt
- **Dann** erscheint „Tomate“ in Vorrat und Rezept.

**AK 2**
- **Gegeben** „Tomate“ und „Tomaten“ existieren
- **Wenn** die Person „Tomaten“ mit „Tomate“ zusammenführt
- **Dann** verweisen Vorrat und alle Rezepte nur noch auf „Tomate“, und „Tomaten“ ist nicht mehr im Zutatenkatalog.

**AK 3**
- **Gegeben** ein Rezept enthält sowohl „Tomate“ als auch „Tomaten“
- **Wenn** die Person „Tomaten“ mit „Tomate“ zusammenführt
- **Dann** steht „Tomate“ genau einmal im Rezept.

</details>

<a id="us-15"></a>
<details>
<summary><strong>US-15 · Unbenutzte Zutaten löschen</strong> · Could</summary>

> Als Nutzer möchte ich unbenutzte Zutaten löschen, damit der Zutatenkatalog übersichtlich bleibt.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Zimt“ kommt weder im Vorrat noch in einem Rezept vor
- **Wenn** die Person „Zimt“ löscht und die Sicherheitsabfrage bestätigt
- **Dann** ist „Zimt“ nicht mehr im Zutatenkatalog.

**AK 2**
- **Gegeben** „Reis“ kommt in einem Rezept vor
- **Wenn** die Person „Reis“ löschen will
- **Dann** ist das nicht möglich, und ein Hinweis nennt den Grund.

</details>

<a id="us-21"></a>
<details>
<summary><strong>US-21 · Zutaten kategorisieren</strong> · Could</summary>

> Als Nutzer möchte ich Zutaten einer Kategorie wie „Gemüse“ oder „Milchprodukte“ zuordnen und den Vorrat danach filtern, damit ich bei vielen Zutaten den Überblick behalte.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** Tomate gehört zur Kategorie „Gemüse“, Milch zu „Milchprodukte“, beide stehen im Vorrat
- **Wenn** die Person den Vorrat nach „Gemüse“ filtert
- **Dann** wird nur Tomate angezeigt.

**AK 2**
- **Gegeben** eine Zutat ohne Kategorie
- **Wenn** die Person sie zum Vorrat hinzufügt
- **Dann** ist das möglich; die Kategorie ist optional.

**AK 3**
- **Gegeben** es gibt noch keine Kategorie „Gewürze“
- **Wenn** die Person bei Zimt „Gewürze“ eingibt
- **Dann** wird die Kategorie angelegt und steht danach für weitere Zutaten zur Auswahl.

</details>

### 📖 AF-2 · Rezepte sammeln

<a id="us-04"></a>
<details>
<summary><strong>US-04 · Rezept anlegen</strong> · Must</summary>

> Als Nutzer möchte ich ein Rezept anlegen, damit ich es später wieder verwenden kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** es gibt kein Rezept „Tomatenreis“
- **Wenn** die Person ein Rezept mit dem Namen „Tomatenreis“, den Zutaten Reis und Tomate und einer Zubereitung speichert
- **Dann** erscheint es im Archiv.

**AK 2**
- **Gegeben** Name, Zutaten oder Zubereitung fehlen
- **Wenn** die Person speichert
- **Dann** wird nicht gespeichert, und eine Fehlermeldung nennt das fehlende Feld.

**AK 3**
- **Gegeben** es gibt bereits „Tomatenreis“
- **Wenn** die Person ein neues Rezept „tomatenreis“ speichert
- **Dann** wird nicht gespeichert, und eine Fehlermeldung weist auf den vorhandenen Namen hin.

**AK 4**
- **Gegeben** Reis steht bereits im Rezept
- **Wenn** die Person Reis erneut hinzufügt
- **Dann** erscheint ein Hinweis, und Reis steht weiterhin genau einmal im Rezept.

</details>

<a id="us-05"></a>
<details>
<summary><strong>US-05 · Archiv und Rezept öffnen</strong> · Must</summary>

> Als Nutzer möchte ich das Rezeptarchiv und einzelne Rezepte öffnen, damit ich Zutaten und Zubereitung lesen kann.

*Gehört auch zu AF-5.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** das Archiv enthält „Tomatenreis“ und „Eierreis“
- **Wenn** die Person das Archiv öffnet
- **Dann** werden beide Rezepte mit Namen angezeigt, alphabetisch sortiert („Eierreis“ vor „Tomatenreis“).

**AK 2**
- **Gegeben** ein Rezept mit Zutaten, Mengenangaben und Zubereitung
- **Wenn** die Person es öffnet
- **Dann** werden alle erfassten Angaben angezeigt.

**AK 3**
- **Gegeben** das Archiv ist leer
- **Wenn** die Person es öffnet
- **Dann** erscheint der Hinweis „Noch keine Rezepte“, und das Anlegen eines Rezepts ist mit einem Tipp erreichbar.

</details>

<a id="us-06"></a>
<details>
<summary><strong>US-06 · Rezept bearbeiten</strong> · Must</summary>

> Als Nutzer möchte ich ein Rezept bearbeiten, damit ich Korrekturen und Änderungen festhalten kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** ein gespeichertes Rezept
- **Wenn** die Person die Zubereitung ändert und speichert
- **Dann** ist die Änderung nach erneutem Öffnen sichtbar.

**AK 2**
- **Gegeben** „Tomatenreis“ enthält Reis und Tomate
- **Wenn** die Person Tomate entfernt, Zwiebel hinzufügt, bei Reis die Menge „200 g“ einträgt und speichert
- **Dann** enthält das Rezept nach erneutem Öffnen Reis (200 g) und Zwiebel.

**AK 3**
- **Gegeben** die Änderung verletzt eine Regel aus US-04, etwa ein leerer Name
- **Wenn** die Person speichert
- **Dann** wird nicht gespeichert, und eine Fehlermeldung erscheint.

</details>

<a id="us-32"></a>
<details>
<summary><strong>US-32 · Ungespeicherte Änderungen nicht verlieren</strong> · Should</summary>

> Als Nutzer möchte ich gewarnt werden, wenn ich ein Rezept mit ungespeicherten Änderungen verlasse, damit ich keine Eingaben versehentlich verliere.

*Bis 13.11.2026 als AK 4 Teil von US-06 (Must); für den Kurs auf Should gesetzt, weil der Kernablauf ohne die Abfrage funktioniert.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person hat die Zubereitung geändert, aber nicht gespeichert
- **Wenn** sie das Rezept verlässt
- **Dann** erscheint eine Sicherheitsabfrage; bestätigt sie, wird die Änderung verworfen, bricht sie ab, bleibt sie im Rezept.

</details>

<a id="us-19"></a>
<details>
<summary><strong>US-19 · Rezept löschen</strong> · Must</summary>

> Als Nutzer möchte ich ein Rezept löschen, damit mein Archiv nur Rezepte enthält, die ich noch nutze.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** ein gespeichertes Rezept
- **Wenn** die Person „Löschen“ wählt
- **Dann** erscheint eine Sicherheitsabfrage.

**AK 2**
- **Gegeben** die Sicherheitsabfrage
- **Wenn** die Person bestätigt
- **Dann** ist das Rezept nicht mehr im Archiv, und seine Zutaten bleiben im Zutatenkatalog.

**AK 3**
- **Gegeben** die Sicherheitsabfrage
- **Wenn** die Person abbricht
- **Dann** bleibt das Rezept unverändert im Archiv.

</details>

<a id="us-07"></a>
<details>
<summary><strong>US-07 · Rezepte suchen</strong> · Should</summary>

> Als Nutzer möchte ich Rezepte nach Namen suchen, damit ich ein bestimmtes Gericht finde.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** das Archiv enthält „Tomatenreis“ und „Eierreis“
- **Wenn** die Person „REIS“ sucht
- **Dann** werden beide Rezepte angezeigt.

**AK 2**
- **Gegeben** kein Rezeptname enthält den Suchbegriff
- **Wenn** die Person sucht
- **Dann** erscheint der Hinweis „Keine Rezepte gefunden“.

</details>

<a id="us-11"></a>
<details>
<summary><strong>US-11 · Favoriten</strong> · Could</summary>

> Als Nutzer möchte ich Rezepte als Favoriten markieren, damit ich sie schnell wiederfinde.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** ein Rezept ist kein Favorit
- **Wenn** die Person es als Favorit markiert
- **Dann** erscheint es im Favoritenfilter.

**AK 2**
- **Gegeben** ein Rezept ist Favorit
- **Wenn** die Person die Markierung entfernt
- **Dann** erscheint es nicht mehr im Favoritenfilter.

</details>

<a id="us-22"></a>
<details>
<summary><strong>US-22 · Rezepte kategorisieren</strong> · Could</summary>

> Als Nutzer möchte ich Rezepte einer Kategorie wie „Frühstück“ oder „Hauptspeise“ zuordnen und das Archiv danach filtern, damit ich passende Gerichte schneller finde.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** „Eierreis“ gehört zu „Hauptspeise“, „Porridge“ zu „Frühstück“
- **Wenn** die Person das Archiv nach „Frühstück“ filtert
- **Dann** wird nur „Porridge“ angezeigt.

**AK 2**
- **Gegeben** ein Rezept ohne Kategorie
- **Wenn** die Person es speichert
- **Dann** ist es gültig; die Kategorie ist optional.

**AK 3**
- **Gegeben** es gibt noch keine Kategorie „Dessert“
- **Wenn** die Person bei einem Rezept „Dessert“ eingibt
- **Dann** wird die Kategorie angelegt und steht danach für weitere Rezepte zur Auswahl.

</details>

### 🍳 AF-3 · Was kann ich kochen?

<a id="us-08"></a>
<details>
<summary><strong>US-08 · Vollständig passende Rezepte anzeigen</strong> · Must</summary>

> Als Nutzerin wie Lena möchte ich vollständig passende Rezepte anzeigen, damit ich ohne Einkauf schnell etwas kochen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** der Vorrat enthält Reis und Tomate, das Archiv „Tomatenreis“ (Reis, Tomate) und „Eierreis“ (Reis, Ei)
- **Wenn** die Person den Filter für vollständig passende Rezepte wählt
- **Dann** wird nur „Tomatenreis“ angezeigt.

**AK 2**
- **Gegeben** ein Rezept verlangt „500 g Reis“ und Reis steht im Vorrat
- **Wenn** das Matching läuft
- **Dann** gilt Reis als vorhanden; Mengen werden nicht geprüft.

**AK 3**
- **Gegeben** kein Rezept passt vollständig
- **Wenn** die Person den Filter wählt
- **Dann** erscheint der Hinweis „Keine Rezepte mit allen Zutaten vorhanden“.

</details>

<a id="us-09"></a>
<details>
<summary><strong>US-09 · Fehlende Zutaten anzeigen</strong> · Must</summary>

> Als Nutzer möchte ich fehlende Zutaten sehen, damit ich meinen Einkauf planen kann.

*Gehört auch zu AF-4.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** der Vorrat enthält Reis, das Rezept „Eierreis“ verlangt Reis und Ei
- **Wenn** die Person „Eierreis“ öffnet
- **Dann** wird genau Ei als fehlende Zutat angezeigt.

**AK 2**
- **Gegeben** alle Zutaten von „Tomatenreis“ stehen im Vorrat
- **Wenn** die Person es öffnet
- **Dann** erscheint „Alle Zutaten vorhanden – Mengen nicht geprüft“.

**AK 3**
- **Gegeben** der Vorrat enthält Reis und Tomate, das Archiv „Tomatenreis“ (Reis, Tomate) und „Eierreis“ (Reis, Ei)
- **Wenn** die Person das Archiv öffnet
- **Dann** steht bei „Tomatenreis“ „alles da“ und bei „Eierreis“ „1 fehlt“, ohne dass sie ein Rezept öffnen muss.

</details>

### 🛒 AF-4 · Einkauf planen

<a id="us-10"></a>
<details>
<summary><strong>US-10 · Höchstens zwei fehlende Zutaten</strong> · Should</summary>

> Als Nutzerin wie Andrea möchte ich Rezepte mit höchstens zwei fehlenden Zutaten finden, damit ich vorhandene Lebensmittel aufbrauche, statt viel neu einzukaufen.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** drei Rezepte, denen null, zwei und drei Zutaten fehlen
- **Wenn** die Person den Filter „höchstens zwei fehlende Zutaten“ wählt
- **Dann** werden die Rezepte mit null und zwei fehlenden Zutaten samt Anzahl angezeigt, das mit drei nicht.

</details>

<a id="us-12"></a>
<details>
<summary><strong>US-12 · Einkaufsliste</strong> · Could</summary>

> Als Nutzer möchte ich fehlende Zutaten auf eine Einkaufsliste übernehmen, damit ich sie gesammelt sehe.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** Ei fehlt für „Eierreis“ und steht bereits auf der Einkaufsliste
- **Wenn** die Person die fehlenden Zutaten von „Eierreis“ übernimmt
- **Dann** steht Ei genau einmal auf der Einkaufsliste.

**AK 2**
- **Gegeben** Milch steht im Zutatenkatalog, aber in keinem Rezept
- **Wenn** die Person Milch über die Zutatenvorschläge direkt zur Einkaufsliste hinzufügt
- **Dann** steht Milch auf der Einkaufsliste.

</details>

<a id="us-20"></a>
<details>
<summary><strong>US-20 · Einkaufsliste abhaken</strong> · Could</summary>

> Als Nutzerin wie Andrea möchte ich beim Einkaufen gefundene Zutaten auf der Einkaufsliste abhaken, damit sie ohne erneutes Eintippen in meinem Vorrat stehen.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** Ei steht auf der Einkaufsliste, aber nicht im Vorrat
- **Wenn** die Person Ei abhakt
- **Dann** steht Ei im Vorrat und nicht mehr auf der Einkaufsliste.

**AK 2**
- **Gegeben** Ei und Milch stehen auf der Einkaufsliste
- **Wenn** die Person nur Ei abhakt
- **Dann** bleibt Milch auf der Einkaufsliste und steht nicht im Vorrat.

</details>

<a id="us-28"></a>
<details>
<summary><strong>US-28 · Einkaufsliste ohne Internet</strong> · Später</summary>

> Als Nutzerin wie Andrea möchte ich die Einkaufsliste auch ohne Internetverbindung lesen und abhaken, damit ich im Supermarkt ohne Netz einkaufen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person hat die Einkaufsliste mit Ei und Milch zuletzt mit Internetverbindung geöffnet
- **Wenn** sie ohne Internetverbindung Ei abhakt
- **Dann** ist Ei auf dem Gerät abgehakt.

**AK 2**
- **Gegeben** Ei wurde ohne Internetverbindung abgehakt
- **Wenn** wieder eine Verbindung besteht
- **Dann** steht Ei im Vorrat und nicht mehr auf der Einkaufsliste, auch auf anderen Geräten.

**AK 3**
- **Gegeben** keine Internetverbindung
- **Wenn** die Person eine andere Funktion als die Einkaufsliste öffnet
- **Dann** erscheint der Hinweis „Keine Internetverbindung“.

</details>

### 👩‍🍳 AF-5 · Nach Rezept kochen

<a id="us-16"></a>
<details>
<summary><strong>US-16 · Abschnitte in der Zubereitung</strong> · Could</summary>

> Als Nutzer möchte ich die Zubereitung eines Rezepts in Abschnitte gliedern, damit ich beim Kochen nur den aktuellen Teil sehe, etwa „Boden“, „Füllung“ oder „Glasur“.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** ein Rezept mit den Abschnitten „Boden“ und „Füllung“
- **Wenn** die Person nur „Füllung“ aufklappt
- **Dann** ist nur deren Text sichtbar, und die Zutaten stehen weiterhin in einer gemeinsamen Liste.

**AK 2**
- **Gegeben** ein Rezept ohne Abschnitte
- **Wenn** die Person es speichert
- **Dann** ist es gültig.

</details>

### 🔐 AF-6 · Konto nutzen

<a id="us-23"></a>
<details>
<summary><strong>US-23 · Konto anlegen</strong> · Must</summary>

> Als Nutzer möchte ich mit E-Mail-Adresse und Passwort ein Konto anlegen, damit meine Daten gesichert und auf jedem Gerät verfügbar sind.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** es gibt kein Konto mit der E-Mail-Adresse lena@example.org
- **Wenn** die Person mit dieser Adresse und einem gültigen Passwort ein Konto anlegt
- **Dann** ist sie angemeldet, und Vorrat und Archiv sind leer.

**AK 2**
- **Gegeben** es gibt bereits ein Konto mit lena@example.org
- **Wenn** jemand ein Konto mit LENA@example.org anlegen will
- **Dann** entsteht kein zweites Konto, und ein Hinweis erscheint.

**AK 3**
- **Gegeben** die E-Mail-Adresse ist ungültig oder das Passwort kürzer als 8 Zeichen
- **Wenn** die Person das Konto anlegen will
- **Dann** entsteht kein Konto, und eine Fehlermeldung nennt das betroffene Feld.

</details>

<a id="us-24"></a>
<details>
<summary><strong>US-24 · Anmelden und abmelden</strong> · Must</summary>

> Als Nutzer möchte ich mich an- und abmelden, damit ich meine Daten auf jedem Gerät sehe und niemand sonst sie sieht.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person hat auf Gerät A das Rezept „Tomatenreis“ gespeichert und Reis zum Vorrat hinzugefügt
- **Wenn** sie sich auf Gerät B mit demselben Konto anmeldet
- **Dann** sieht sie dort „Tomatenreis“ im Archiv und Reis im Vorrat.

**AK 2**
- **Gegeben** E-Mail-Adresse oder Passwort sind falsch
- **Wenn** die Person sich anmelden will
- **Dann** wird sie nicht angemeldet, und der Hinweis „E-Mail oder Passwort falsch“ erscheint, ohne zu verraten, welche Angabe falsch ist.

**AK 3**
- **Gegeben** die Person ist angemeldet
- **Wenn** sie sich abmeldet
- **Dann** sind Vorrat und Rezepte auf diesem Gerät erst nach erneuter Anmeldung wieder sichtbar.

**AK 4**
- **Gegeben** die Person ist angemeldet und schließt den Browser
- **Wenn** sie Jausi innerhalb von 30 Minuten nach der letzten Nutzung wieder öffnet
- **Dann** ist sie weiterhin angemeldet; danach muss sie sich neu anmelden.

</details>

<a id="us-25"></a>
<details>
<summary><strong>US-25 · Passwort zurücksetzen</strong> · Should</summary>

> Als Nutzer möchte ich ein vergessenes Passwort zurücksetzen, damit ich wieder an meine Daten komme.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** es gibt ein Konto mit lena@example.org
- **Wenn** die Person „Passwort vergessen“ wählt und diese Adresse eingibt
- **Dann** bekommt sie eine E-Mail, mit der sie ein neues Passwort festlegen kann.

**AK 2**
- **Gegeben** es gibt kein Konto mit der eingegebenen Adresse
- **Wenn** die Person „Passwort vergessen“ wählt
- **Dann** erscheint derselbe Hinweis wie bei AK 1, damit nicht erkennbar ist, ob ein Konto existiert.

</details>

<a id="us-26"></a>
<details>
<summary><strong>US-26 · Konto löschen</strong> · Must</summary>

> Als Nutzer möchte ich mein Konto löschen, damit keine Daten von mir gespeichert bleiben.

*Must, weil die DSGVO (Art. 17) ein Recht auf Löschung vorsieht und Löschwünsche sonst von Hand bearbeitet werden müssten.*

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person ist angemeldet
- **Wenn** sie „Konto löschen“ wählt, ihr Passwort eingibt und die Sicherheitsabfrage bestätigt
- **Dann** sind Konto, Vorrat, Rezepte, Einkaufsliste und Statistik gelöscht, und eine Anmeldung mit diesen Daten ist nicht mehr möglich.

**AK 2**
- **Gegeben** die Sicherheitsabfrage
- **Wenn** die Person abbricht
- **Dann** bleibt das Konto unverändert.

**AK 3**
- **Gegeben** die Person gibt ein falsches Passwort ein
- **Wenn** sie das Löschen bestätigt
- **Dann** bleibt das Konto unverändert, und der Hinweis „Passwort falsch“ erscheint.

</details>

<a id="us-29"></a>
<details>
<summary><strong>US-29 · Daten exportieren</strong> · Später</summary>

> Als Nutzer möchte ich alle meine Daten herunterladen, damit ich eine eigene Kopie habe und Jausi jederzeit mit meinen Daten verlassen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** das Konto enthält Reis und Tomate im Vorrat und das Rezept „Tomatenreis“
- **Wenn** die Person „Daten exportieren“ wählt
- **Dann** erhält sie eine Datei in einem gängigen, maschinenlesbaren Format mit Vorrat, Einkaufsliste und allen Rezepten samt Zutaten, Mengen und Zubereitung.

**AK 2**
- **Gegeben** die exportierte Datei
- **Wenn** die Person sie mit einem Texteditor öffnet
- **Dann** sind Rezeptnamen, Zutaten und Zubereitung lesbar.

</details>

<a id="us-30"></a>
<details>
<summary><strong>US-30 · Daten ohne Verbindung lesen</strong> · Später</summary>

> Als Nutzer möchte ich Vorrat und Rezepte auch lesen können, wenn ich keine Internetverbindung habe oder der Server ausfällt, damit ich trotzdem nach meinen Rezepten kochen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person hat Jausi auf diesem Gerät zuletzt mit Verbindung genutzt
- **Wenn** keine Verbindung besteht oder der Server nicht erreichbar ist
- **Dann** kann sie Vorrat, Archiv und Rezeptdetails mit dem Stand der letzten Verbindung lesen, und der Hinweis „Offline – Stand vom …“ erscheint.

**AK 2**
- **Gegeben** keine Verbindung
- **Wenn** die Person ein Rezept oder den Vorrat ändern will
- **Dann** ist das nicht möglich, und ein Hinweis erklärt den Grund.

**AK 3**
- **Gegeben** auf dem Gerät liegt eine lokale Kopie
- **Wenn** die Person sich abmeldet
- **Dann** wird die lokale Kopie auf diesem Gerät gelöscht.

</details>

<a id="us-31"></a>
<details>
<summary><strong>US-31 · Datenschutzerklärung und Impressum</strong> · Must</summary>

> Als Nutzer möchte ich nachlesen, welche Daten Jausi speichert und wer Jausi betreibt, damit ich weiß, wem ich meine Daten anvertraue.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person legt ein Konto an
- **Wenn** sie das Formular sieht
- **Dann** ist die Datenschutzerklärung dort verlinkt, bevor sie das Konto anlegt.

**AK 2**
- **Gegeben** die Person ist nicht angemeldet
- **Wenn** sie Jausi öffnet
- **Dann** erreicht sie Datenschutzerklärung und Impressum mit einem Tipp.

**AK 3**
- **Gegeben** die Datenschutzerklärung
- **Wenn** die Person sie liest
- **Dann** nennt sie Zweck, gespeicherte Daten, Speicherort, Speicherdauer, die Rechte der Person (Auskunft, Berichtigung, Löschung, Datenübertragbarkeit, Beschwerde) und eine Kontaktadresse.

</details>

### 📊 AF-7 · Verbrauch nachvollziehen

<a id="us-27"></a>
<details>
<summary><strong>US-27 · Verbrauchsstatistik</strong> · Später</summary>

> Als Nutzerin wie Andrea möchte ich sehen, welche Zutaten ich in letzter Zeit wie oft zum Vorrat hinzugefügt und wieder entfernt habe, damit ich mein Konsumverhalten nachvollziehen kann.

**Akzeptanzkriterien**

**AK 1**
- **Gegeben** die Person hat Tomate in den letzten 30 Tagen dreimal zum Vorrat hinzugefügt
- **Wenn** sie die Statistik für die letzten 30 Tage öffnet
- **Dann** steht Tomate mit „3-mal hinzugefügt“.

**AK 2**
- **Gegeben** ein Rezept verlangt „500 g Reis“
- **Wenn** die Person die Statistik öffnet
- **Dann** zeigt sie Anzahlen, keine Mengen; Mengen werden weiterhin nicht erfasst.

</details>

## Funktionale Anforderungen

| ID | Anforderung | Priorität | Bezug |
| --- | --- | --- | --- |
| FR-01 | Das System stellt einen fest vorgegebenen Zutatenkatalog bereit und schlägt beim Eintippen passende Zutaten daraus vor. | Must | US-01, US-04, US-13 |
| FR-02 | Das System zeigt den Vorrat an und erlaubt, Zutaten aus dem Zutatenkatalog hinzuzufügen und zu entfernen; jede Zutat steht höchstens einmal im Vorrat. | Must | US-01–03 |
| FR-03 | Das System erlaubt, Rezepte anzulegen, anzuzeigen, zu bearbeiten und nach einer Sicherheitsabfrage zu löschen, und prüft dabei die Regeln für gültige Rezepte. | Must | US-04–06, US-19 |
| FR-04 | Das System findet Rezepte, deren Name den Suchbegriff enthält, ohne Beachtung der Groß-/Kleinschreibung. | Should | US-07 |
| FR-05 | Das System berechnet für jedes Rezept die fehlenden Zutaten aus dem aktuellen Vorrat, zeigt deren Anzahl im Archiv und bietet einen Filter für vollständig passende Rezepte. | Must | US-08, US-09 |
| FR-06 | Das System speichert Vorrat und Rezepte dauerhaft auf dem Server, dem Konto zugeordnet, sodass sie nach einem Neustart und nach der Anmeldung auf jedem Gerät unverändert vorhanden sind. | Must | US-01–06, US-08, US-09, US-19, US-24 |
| FR-07 | Das System filtert Rezepte mit höchstens zwei fehlenden Zutaten und zeigt deren Anzahl. | Should | US-10 |
| FR-08 | Das System erlaubt, Rezepte als Favoriten zu markieren und nach Favoriten zu filtern. | Could | US-11 |
| FR-09 | Das System übernimmt die fehlenden Zutaten eines Rezepts ohne Duplikate auf eine Einkaufsliste. | Could | US-12 |
| FR-10 | Das System erlaubt, Zutaten umzubenennen und zusammenzuführen, und aktualisiert dabei Vorrat und alle Rezepte. | Should | US-14 |
| FR-11 | Das System erlaubt, Zutaten nach einer Sicherheitsabfrage zu löschen, wenn sie weder im Vorrat noch in einem Rezept vorkommen. | Could | US-15 |
| FR-12 | Das System erlaubt, die Zubereitung in benannte, einklappbare Abschnitte zu gliedern. | Could | US-16 |
| FR-13 | Das System übernimmt abgehakte Zutaten der Einkaufsliste in den Vorrat und entfernt sie von der Liste. | Could | US-20 |
| FR-14 | Das System erlaubt, Zutaten und Rezepten optional eine selbst angelegte Kategorie zuzuordnen und Vorrat und Archiv danach zu filtern. | Could | US-21, US-22 |
| FR-15 | Das System erlaubt, eigene Zutaten anzulegen, speichert sie dauerhaft im Zutatenkatalog und verhindert Duplikate gemäß den fachlichen Regeln. | Should | US-17, US-18 |
| FR-16 | Das System erlaubt, ein Konto mit E-Mail-Adresse und Passwort anzulegen, sich an- und abzumelden und das Konto mit allen Daten zu löschen, und zeigt jeder Person nur die Daten ihres Kontos. | Must | US-23, US-24, US-26 |
| FR-17 | Das System erlaubt, ein vergessenes Passwort per E-Mail zurückzusetzen. | Should | US-25 |
| FR-18 | Das System zählt, wie oft Zutaten zum Vorrat hinzugefügt und entfernt wurden, und zeigt das für einen gewählten Zeitraum an. Gespeichert werden nur Zählungen je Zutat und Woche (Datensparsamkeit). | Später | US-27 |
| FR-19 | Das System hält die Einkaufsliste ohne Internetverbindung lesbar und abhakbar und überträgt die Änderungen, sobald wieder eine Verbindung besteht. | Später | US-28 |
| FR-20 | Das System erlaubt, alle Daten des eigenen Kontos als Datei in einem gängigen, maschinenlesbaren Format herunterzuladen. | Später | US-29 |
| FR-21 | Das System hält eine lokale Kopie von Vorrat und Rezepten auf dem Gerät, die ohne Verbindung lesbar ist und beim Abmelden gelöscht wird. | Später | US-30 |
| FR-22 | Das System zeigt eine Datenschutzerklärung und ein Impressum, die ohne Anmeldung erreichbar sind; die Datenschutzerklärung ist bei der Registrierung verlinkt. | Must | US-31 |

## Nichtfunktionale Anforderungen

| ID | Anforderung und Prüfung | Priorität |
| --- | --- | --- |
| NFR-01 | Deutschsprachige Oberfläche, die im Browser eines Smartphones mit 360 Pixel Breite ohne horizontales Scrollen bedienbar ist; Vorrat und Archiv sind von der Hauptnavigation mit einem Tipp erreichbar. Prüfung durch manuellen Durchlauf aller Must-Stories auf je einem dokumentierten Android- und iPhone-Testgerät. | Must |
| NFR-02 | Matching (US-08, US-09): Mit dem Referenzdatensatz erscheinen die vollständig passenden Rezepte und die fehlenden Zutaten je Rezept innerhalb einer Sekunde auf dem dokumentierten Testgerät. | Should |
| NFR-03 | Nach Speichern, Neustart und erneuter Anmeldung, auch auf einem anderen Gerät, sind Zutatenkatalog, Vorrat und Rezepte unverändert vorhanden. Prüfung mit einem gespeicherten Beispieldatensatz. | Must |
| NFR-04 | Fehlermeldungen nennen das betroffene Feld und den Grund; bereits eingegebene Daten bleiben nach einer Fehlermeldung erhalten. Das Löschen von Rezepten und Zutaten aus dem Zutatenkatalog erfordert eine Sicherheitsabfrage; das Entfernen einer Zutat aus dem Vorrat nicht. Ohne Internetverbindung erscheint der Hinweis „Keine Internetverbindung“. Prüfung mit ungültigen Eingaben, Abbruch einer Löschaktion und getrennter Verbindung. | Must |
| NFR-05 | Das Matching ist unabhängig von der Oberfläche testbar; automatisierte Tests prüfen vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat. | Must |
| NFR-06 | Als personenbezogene Daten werden nur E-Mail-Adresse und Passwort erfasst. Passwörter werden nie im Klartext gespeichert, alle Daten werden verschlüsselt übertragen, und eine Person kann nur die Daten ihres eigenen Kontos lesen und ändern. Server und Datenbank stehen in der EU. Jausi setzt nur technisch notwendige Cookies (Anmeldung) und verwendet kein Tracking und keine Werbung; ein Cookie-Banner ist damit nicht nötig. Vorrats- und Rezeptdaten gehen an keinen AI-Dienst. Prüfung der Eingabefelder, der Datenflüsse, der gesetzten Cookies und eines Zugriffsversuchs auf ein fremdes Konto. | Must |
| NFR-07 | Zutatenvorschläge (US-13): Mit dem Referenzdatensatz erscheinen die Zutatenvorschläge innerhalb einer Sekunde nach jeder Eingabe auf dem dokumentierten Testgerät. | Should |
| NFR-08 | Suche (US-07): Mit dem Referenzdatensatz erscheinen die Suchergebnisse innerhalb einer Sekunde auf dem dokumentierten Testgerät. Gilt nur, wenn die Suche umgesetzt wird. | Should |
| NFR-09 | Ohne Internetverbindung oder bei Serverausfall sind Vorrat und Rezepte lesbar (US-30); die Einkaufsliste ist zusätzlich abhakbar, und Haken werden übertragen, sobald wieder eine Verbindung besteht (US-28). Gilt jeweils, sobald die Story umgesetzt ist. Prüfung im Flugmodus und bei abgeschaltetem Server. Bis 13.11.2026 galt Offline-Nutzung aller Funktionen als Must; geändert mit ADR-0002. | Später |
| NFR-10 | Rezepte sind beim Kochen gut lesbar: Fließtext in der Rezeptansicht mindestens 16 Pixel groß, Kontrast zwischen Text und Hintergrund mindestens 4,5:1 (WCAG 2.1, Stufe AA). Prüfung auf dem dokumentierten Testgerät mit einem Kontrast-Prüfwerkzeug. | Should |

**Referenzdatensatz für NFR-02, NFR-07 und NFR-08:** der vollständige Zutatenkatalog, 200 Zutaten im Vorrat und 100 Rezepte mit je bis zu 20 Zutaten. Die Datenmengen sind ein Referenzwert für die Messung, keine Obergrenze. Testgerät und Messmethode werden nach Festlegung der Plattform dokumentiert. Gemessen wird nur, wenn im Kurs Zeit bleibt; dann genügen die Demo-Daten, falls der Referenzdatensatz zu aufwendig ist.

## Bekannte Einschränkungen und Risiken

- **Mengen:** „Zutat vorhanden“ heißt nicht „genug davon“. Rezeptmengen werden angezeigt, aber nicht mit dem Vorrat verglichen; die Oberfläche macht das sichtbar.
- **Fester Zutatenkatalog (MVP):** Zutaten, die nicht im Katalog stehen, können nicht erfasst werden. Sie lassen sich nur in der Zubereitung erwähnen und zählen nicht fürs Matching. Eigene Zutaten (US-17, US-18) heben das nach dem MVP auf.
- **Zutatenkatalog von Hand:** Im Kurs pflegt das Team den Katalog von Hand und beginnt klein; fehlt eine Zutat, wird sie ergänzt. Eine externe Quelle für einen großen Datensatz ist eine spätere Erweiterung. Die folgenden Quellen aus der Recherche des Teams dienen Developern nur als Orientierung, wie Zutaten-Datensätze aufgebaut sein können (Lizenz, Umfang und deutsche Bezeichnungen nicht geprüft):
  - FoodEx2 (EFSA): europäische Klassifikation von Lebensmitteln und Zutaten
  - FoodOn: offene Ontologie für Lebensmittel
  - LanguaL: Thesaurus zur Beschreibung von Lebensmitteln
  - FooDB: Datenbank der chemischen Inhaltsstoffe von Lebensmitteln
- **Pluralformen:** Ab US-17 gelten „Tomate“ und „Tomaten“ als verschiedene Zutaten. Die Zutatenvorschläge sollen solche Duplikate vermeiden.
- **Leeres Archiv (AF-3):** Jausi nützt erst, wenn Rezepte erfasst sind; beim ersten Start findet das Matching nichts.
- **Einzelerfassung (AF-1, Risiko):** Nach einem großen Einkauf müssen Zutaten einzeln eingetragen werden. Ist das zu mühsam, veraltet der Vorrat. Das Abhaken auf der Einkaufsliste (US-20, Could) mildert das nach dem MVP; mehrere Zutaten auf einmal hinzuzufügen wäre eine weitere mögliche Erweiterung.
- **Ohne Internet (AF-4, Risiko):** Im MVP ist Jausi ohne Internetverbindung nicht nutzbar, auch nicht beim Einkaufen; fehlende Zutaten lassen sich im Supermarkt ohne Netz nicht nachsehen. Die lokale Kopie zum Lesen (US-30, später) und die Einkaufsliste ohne Internet (US-28, später) mildern das nach dem MVP.
- **Datenverlust:** Die Daten liegen auf dem Server und sind an das Konto gebunden; ein verlorenes Gerät kostet keine Daten mehr. Ein Ausfall oder Datenverlust des Servers trifft dagegen alle Konten. Wie der Server gesichert wird, klärt Phase 2. Nach dem MVP mildern der Export (US-29) und die lokale Kopie (US-30) das Risiko und verhindern, dass Daten nur bei uns liegen.
- **Konten und Sicherheit:** Mit Konten speichert Jausi personenbezogene Daten (E-Mail-Adresse) und muss Zugriffe auf fremde Konten verhindern (NFR-06). Ein vergessenes Passwort lässt sich im MVP nicht zurücksetzen; das kommt mit US-25 (Should). Rechtlicher Rahmen in der EU und in Österreich: DSGVO (Datensparsamkeit, Sicherheit, Auskunft, Löschung, Datenübertragbarkeit), Impressumspflicht (§ 5 ECG, § 25 MedienG) und Cookie-Regeln (§ 165 TKG 2021). Mit dem Hosting-Anbieter ist ein Vertrag zur Auftragsverarbeitung nötig (DSGVO Art. 28). Diese Einordnung hat AI erstellt; sie ist keine Rechtsberatung.
- **Externe Dienste:** Der MVP braucht einen Server mit Datenbank; das Hosting kann laut [ADR-0001](adr/0001-infrastruktur-und-release.md) kostenpflichtig sein. Für das Zurücksetzen von Passwörtern (US-25, Should) wäre zusätzlich ein E-Mail-Dienst nötig. Eine externe Quelle für den Zutatenkatalog würde nur einmalig als Datengrundlage verwendet. Werden später welche gewählt, sind Verfügbarkeit, Kosten und Abhängigkeiten zu dokumentieren.
- **Offen für Phase 2:** Technologien für Client und Server, Datenbank, Art der Anmeldung und Hosting. Architekturstil: [ADR-0002](adr/0002-architekturstil-client-server.md) (vorgeschlagen); Hosting und Releases: [ADR-0001](adr/0001-infrastruktur-und-release.md) (vorgeschlagen).

Die Befunde der AI-Prüfungen, die zu diesem Stand geführt haben, stehen in [ai-usage.md](ai-usage.md#befunde-der-ai-prüfungen).
