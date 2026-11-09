# MVP-Scope

## Ziel

Ein Nutzer erfasst vorhandene Zutaten und eigene Rezepte. Jausi zeigt, welche Rezepte zu den vorhandenen Zutaten passen und welche Zutaten fehlen. Der Umfang soll für ein vierköpfiges Team innerhalb des Semesterprojekts realistisch bleiben.

## Im MVP enthalten

- Zutatenkatalog: wächst mit den Eingaben des Nutzers; vorhandene Zutaten werden beim Tippen vorgeschlagen, fehlende neu angelegt, Duplikate verhindert.
- Vorrat: Zutaten hinzufügen und entfernen.
- Rezeptarchiv: Rezepte anlegen, anzeigen, bearbeiten und nach Bestätigung löschen.
- Matching mit dem Vorrat: Filter für vollständig passende Rezepte; fehlende Zutaten je Rezept anzeigen.
- Dauerhafte Speicherung eines persönlichen Datenbestands.
- Eingabevalidierung und verständliche Hinweise bei leerem Vorrat oder Archiv.

Der MVP umfasst aus [requirements.md](https://github.com/NeloBorcram/Jausi/blob/main/docs/requirements.md) die User Stories US-01 bis US-06, US-08, US-09 und US-13, die funktionalen Anforderungen FR-01 bis FR-03, FR-05 und FR-06 sowie die nichtfunktionalen Anforderungen NFR-01, NFR-03 bis NFR-06 und NFR-09. Begriffe wie Zutatenkatalog und Matching sind dort im Abschnitt „Begriffe“ definiert. Die gemeinsame Teamprüfung der Spezifikation steht noch aus.

## Außerhalb des MVP

- Mengenvergleich, Umrechnung von Einheiten und automatische Verbrauchsbuchung.
- Nutzerkonten, gemeinsame Haushalte und Synchronisierung.
- Zutaten umbenennen und zusammenführen (Should) sowie unbenutzte Zutaten löschen (Could).
- Erkennung von Plural- und Schreibvarianten wie „Tomate“ und „Tomaten“.
- AI-Rezeptgenerierung, externe Rezeptimporte, Barcode- oder Bilderkennung.
- Ablaufdaten, Benachrichtigungen sowie Ernährungs- und Allergiefilter.
- Favoriten, Einkaufsliste und Abschnitte in der Zubereitung (Could).
- Suche nach Rezeptnamen (Should).
- Filter für höchstens zwei fehlende Zutaten (Should; erst nach Abschluss des MVP).
- Leistungsziele NFR-02, NFR-07 und NFR-08 (Should): werden gemessen und dokumentiert, sind aber keine Abnahmebedingung des MVP.

## Geplanter vollständiger Demo-Anwendungsfall

Dieser Ablauf beschreibt die spätere Produktabnahme. In Phase 1 wird seine Eindeutigkeit geprüft; die Software wird noch nicht umgesetzt oder getestet.

Voraussetzung: Zutatenkatalog, Vorrat und Archiv sind leer.

1. Reis und Tomate als neue Zutaten anlegen und zum Vorrat hinzufügen.
2. Das Rezept „Tomatenreis“ mit den Zutaten Reis und Tomate speichern; beide werden beim Tippen vorgeschlagen.
3. Das Rezept „Eierreis“ speichern: „reis“ eintippen und die vorgeschlagene Zutat Reis wählen; Ei als neue Zutat anlegen. Der Zutatenkatalog enthält danach genau Reis, Tomate und Ei.
4. Der Filter für vollständig passende Rezepte zeigt nur Tomatenreis. In den Details von Eierreis wird Ei als fehlende Zutat angezeigt.
5. Tomate aus dem Vorrat entfernen: Tomatenreis passt nicht mehr vollständig und zeigt Tomate als fehlende Zutat.
6. Die App neu starten: Zutatenkatalog, Rezepte und aktualisierter Vorrat sind weiterhin vorhanden.

## Definition of Done für Phase 1

- Ein anderer Entwickler versteht Produktziel, Problem und Zielgruppe ohne wesentliche Rückfragen.
- Mindestens 8–10 User Stories liegen vor; jede Must-Story hat überprüfbare Akzeptanzkriterien.
- Funktionale und mindestens drei relevante nichtfunktionale Anforderungen sind eindeutig und priorisiert.
- MVP und spätere Erweiterungen sind klar getrennt; mindestens ein vollständiger demonstrierbarer Anwendungsfall ist beschrieben.
- Zwei unterschiedliche AI-Anwendungen sind mit Eingaben, Ergebnissen und kritischer Bewertung dokumentiert: Anforderungsgenerierung und Prüfung auf Widersprüche, Lücken und Unklarheiten.
- Die vier Dokumente sind konsistent; das Team hat die noch offenen fachlichen Punkte geprüft und seine Entscheidungen dokumentiert.

Status: Dokumentationsentwurf vorhanden; gemeinsame Teamprüfung ausstehend. Phase 1 ist noch nicht als abgeschlossen bestätigt.

## Geplante spätere Produktabnahme

- Alle Must-Stories erfüllen ihre Akzeptanzkriterien.
- Die nichtfunktionalen Must-Anforderungen wurden geprüft; Ergebnisse und Testgerät werden dokumentiert.
- Matching-Tests decken vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat ab.
- Ein anderes Teammitglied hat die Umsetzung geprüft.
- Die vier Pflichtdokumente sind konsistent und aktuell; bekannte Einschränkungen sind dokumentiert.
- Installation, Start und Testausführung sind im README nachvollziehbar beschrieben.

## Noch in Phase 1 klären

- Zustimmung zum mitwachsenden Zutatenkatalog (Scope-Änderung, siehe US-13 bis US-15).
- Angemessenheit der Priorisierung und der Leistungsgrenze.
- Gleiches Verständnis der Akzeptanzkriterien im gesamten Team.

Architektur und Technologieauswahl gehören in Phase 2, die Implementierung in Phase 3, Qualitätssicherung und Testausführung in Phase 4 sowie abschließende Evaluation und Reflexion in Phase 5.