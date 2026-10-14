# Anforderungen und User Stories

## Produktziel

Jausi verbindet Lebensmittelvorrat und persönliches Rezeptarchiv für Studierende und Personen, die unkompliziert mit vorhandenen Zutaten kochen möchten. Das vierköpfige Team entwickelt einen überschaubaren Semesterprojekt-MVP.

## Priorisierungsmaßstab

Must umfasst den vollständigen Kernanwendungsfall: Vorrat erfassen, Rezepte verwalten, passende Rezepte und fehlende Zutaten erkennen sowie Daten erhalten. Should verbessert die Nutzung, ohne diesen Ablauf zu ermöglichen. Could bietet zusätzlichen Komfort. Suche nach Namen ist deshalb Should; die Rezeptliste bleibt auch ohne Suche nutzbar.

## Fachliche Regeln

- Vorrat und Rezeptzutaten verwenden dieselben eindeutig unterscheidbaren Einträge einer gemeinsamen Zutatenliste. Unterschiedliche Schreibweisen dürfen nicht zu falschen Vergleichen führen; die technische Umsetzung folgt in Phase 2.
- Jede Zutat steht höchstens einmal im Vorrat. Ihr Status lautet vorhanden oder nicht vorhanden.
- Ein gültiges Rezept hat einen nicht leeren Namen, mindestens eine Zutat und nicht leere Zubereitungsschritte.
- Mengen und Einheiten sind optionale Rezeptangaben und beeinflussen das Matching nicht.
- Ein Rezept passt vollständig, wenn alle seine Zutaten im Vorrat vorhanden sind. Es erfolgt keine Aussage über ausreichende Mengen.
- Salz, Öl und andere Grundzutaten werden wie alle anderen Zutaten behandelt und nicht automatisch als vorhanden angenommen.
- Vorratsänderungen verändern weder Rezepte noch deren Zutaten. Nach einer Änderung wird das Matching mit dem aktuellen Vorrat berechnet.

## User Stories mit Akzeptanzkriterien

| ID | User Story | Priorität | Akzeptanzkriterien |
| --- | --- | --- | --- |
| US-01 | Als Nutzer möchte ich eine Zutat aus der gemeinsamen Liste zum Vorrat hinzufügen, damit mein Bestand erfasst ist. | Must | Die gewählte Zutat erscheint im Vorrat; erneutes Hinzufügen erzeugt keinen zweiten Eintrag. |
| US-02 | Als Nutzer möchte ich meinen Vorrat sehen, damit ich vorhandene Lebensmittel überblicken kann. | Must | Alle vorhandenen Zutaten werden angezeigt; ein leerer Vorrat zeigt einen verständlichen Hinweis. |
| US-03 | Als Nutzer möchte ich verbrauchte Zutaten entfernen, damit mein Vorrat aktuell bleibt. | Must | Die entfernte Zutat wird nicht mehr als vorhanden gewertet; gespeicherte Rezepte bleiben erhalten. |
| US-04 | Als Nutzer möchte ich ein Rezept anlegen, damit ich es später wieder verwenden kann. | Must | Name, mindestens eine ausgewählte Zutat und Zubereitung sind erforderlich; ungültige Eingaben zeigen eine Fehlermeldung. |
| US-05 | Als Nutzer möchte ich Archiv und Rezeptdetails öffnen, damit ich Zutaten und Zubereitung lesen kann. | Must | Das Archiv zeigt gespeicherte Rezepte; Details zeigen alle erfassten Angaben; ein leeres Archiv zeigt einen Hinweis. |
| US-06 | Als Nutzer möchte ich Rezepte bearbeiten und löschen, damit mein Archiv aktuell bleibt. | Must | Änderungen sind nach erneutem Öffnen sichtbar; Löschen erfordert Bestätigung und entfernt das Rezept aus dem Archiv. |
| US-07 | Als Nutzer möchte ich Rezepte nach Namen suchen, damit ich ein bestimmtes Gericht finde. | Should | Teilbegriffe werden ohne Beachtung der Groß-/Kleinschreibung gefunden; keine Treffer werden klar angezeigt. |
| US-08 | Als Nutzer möchte ich vollständig passende Rezepte anzeigen, damit ich mit vorhandenen Zutaten kochen kann. | Must | Der Filter zeigt genau Rezepte, deren Zutaten vollständig vorhanden sind; Mengen spielen keine Rolle. |
| US-09 | Als Nutzer möchte ich fehlende Zutaten sehen, damit ich meinen Einkauf planen kann. | Must | Je Rezept werden genau die nicht vorhandenen Zutaten angezeigt; bei vollständiger Übereinstimmung erscheint „Alle Zutaten vorhanden – Mengen nicht geprüft“. |
| US-10 | Als Nutzer möchte ich Rezepte mit höchstens zwei fehlenden Zutaten finden, damit ich mit wenig Einkauf kochen kann. | Should | Ein eigener Filter zeigt Rezepte mit null bis zwei fehlenden Zutaten und deren Anzahl. |
| US-11 | Als Nutzer möchte ich Lieblingsrezepte markieren, damit ich sie schnell wiederfinde. | Could | Eine Markierung kann gesetzt und entfernt werden; ein Filter zeigt die markierten Rezepte. |
| US-12 | Als Nutzer möchte ich fehlende Zutaten auf eine Einkaufsliste übernehmen, damit ich sie gesammelt sehe. | Could | Fehlende Zutaten eines gewählten Rezepts werden ohne doppelte Einträge übernommen. |

## Funktionale Anforderungen

| ID | Anforderung | Priorität | Bezug |
| --- | --- | --- | --- |
| FR-01 | Gemeinsame, vorgegebene Zutatenliste zur Auswahl in Vorrat und Rezepten bereitstellen. | Must | US-01, US-04 |
| FR-02 | Vorrat anzeigen, Zutaten hinzufügen und entfernen. | Must | US-01–03 |
| FR-03 | Rezepte anlegen, anzeigen, bearbeiten und nach Bestätigung löschen. | Must | US-04–06 |
| FR-04 | Rezeptnamen durch Teiltextsuche durchsuchen. | Should | US-07 |
| FR-05 | Vollständig passende Rezepte filtern und fehlende Zutaten je Rezept anzeigen. | Must | US-08–09 |
| FR-06 | Vorrat und Rezepte über einen Neustart hinweg speichern. | Must | US-01–09 |
| FR-07 | Nach höchstens zwei fehlenden Zutaten filtern. | Should | US-10 |
| FR-08 | Favoriten verwalten. | Could | US-11 |
| FR-09 | Einkaufsliste aus fehlenden Zutaten erstellen. | Could | US-12 |

## Nichtfunktionale Anforderungen

| ID | Anforderung und Prüfung | Priorität |
| --- | --- | --- |
| NFR-01 | Deutsche, konsistente Oberfläche; Vorrat und Archiv sind von der Hauptnavigation erreichbar. Prüfung durch manuellen Durchlauf aller Must-Stories. | Must |
| NFR-02 | Bei 100 Rezepten mit je bis zu 20 Zutaten und 200 Vorratszutaten erscheinen Such- und Matching-Ergebnisse innerhalb einer Sekunde auf dem dokumentierten Testgerät. Messung nach Festlegung der Plattform. | Must |
| NFR-03 | Nach Speichern und Neustart sind Vorrat und Rezepte unverändert vorhanden. Prüfung mit einem gespeicherten Beispieldatensatz. | Must |
| NFR-04 | Ungültige Pflichtfelder werden verständlich gemeldet und nicht gespeichert; Löschen eines Rezepts erfordert Bestätigung. Prüfung mit ungültigen Eingaben und Abbruch der Löschaktion. | Must |
| NFR-05 | Das Matching ist unabhängig von der Oberfläche testbar; automatisierte Tests prüfen vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat. | Must |
| NFR-06 | Der MVP erfordert keine personenbezogenen Angaben und übermittelt Vorrats- oder Rezeptdaten an keinen AI-Dienst. Prüfung der Eingabefelder und Datenflüsse. | Must |

## Prüfung auf Widersprüche und Unklarheiten

AI-Prüfung vom 14.10.2026 anhand der vollständig bereitgestellten Phase-1-Vorgaben:

| Befund | Bewertung und Korrektur |
| --- | --- |
| Suche war Must, obwohl der Kernablauf über die Rezeptliste möglich ist. | US-07 und FR-04 auf Should gesetzt; MVP entsprechend angepasst. |
| Produktabnahme und Phase-1-Abschluss waren vermischt. | Separate Definition of Done für die Spezifikation ergänzt; App-Tests sind erst später auszuführen. |
| Technische Vorbereitung wurde zu früh empfohlen. | Technologieauswahl und Architektur auf Phase 2 verschoben; keine Implementierungsarbeiten in Phase 1. |
| Ein Zutatenkatalog begrenzt die erfassbaren Lebensmittel. | Vor Phase-1-Abschluss muss das Team dessen fachlichen Startumfang prüfen und bestätigen. |
| Die Leistungsgrenze war ein AI-Vorschlag ohne Teamvalidierung. | Eine Sekunde bei den genannten Datenmengen bleibt ein überprüfbarer Zielvorschlag; gemeinsame Bestätigung steht aus. |
| Externe Abhängigkeiten und Kosten waren nicht explizit behandelt. | Der MVP verlangt keine externen APIs oder kostenpflichtigen Services. Falls später welche gewählt werden, sind Verfügbarkeit, Kosten und Abhängigkeiten zu dokumentieren. |

- „Zutat vorhanden“ bedeutet keine ausreichende Menge. Die Oberfläche muss diese Einschränkung sichtbar machen.
- Inventur bedeutet im MVP eine Liste vorhandener Zutaten, keine Mengenbuchhaltung.
- Mengenangaben im Rezept und mengenunabhängiges Matching sind bewusst getrennt.
- Einträge fehlen gegebenenfalls im vorgegebenen Zutatenkatalog. Dessen Startumfang muss das Team vor der Umsetzung festlegen; freie Katalogpflege gehört nicht zum MVP.
- Dauerhafte Speicherung ist verbindlich; Plattform und Speichermethode sind noch offen.
- Der MVP verwendet einen persönlichen Datenbestand ohne Anmeldung, geteilten Haushalt oder Synchronisierung.
- Ein Ablaufdatum ist eine spätere Idee, keine Anforderung für die aktuelle Umsetzung.

Die Spezifikation ist ein Arbeitsentwurf auf Basis des angenommenen Konzepts. Vor Abschluss von Phase 1 prüfen die vier Teammitglieder Akzeptanzkriterien, Prioritäten, fachlichen Zutatenumfang und Leistungsziel. Technische Entscheidungen bleiben Phase 2 vorbehalten.
