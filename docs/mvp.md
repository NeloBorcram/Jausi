# MVP-Scope

## Ziel

Ein Nutzer erfasst vorhandene Zutaten und eigene Rezepte. Jausi zeigt, welche Rezepte anhand der vorhandenen Zutaten passen und welche Zutaten fehlen. Der Umfang soll für ein vierköpfiges Team innerhalb des Semesterprojekts realistisch bleiben.

## Im MVP enthalten

- Vorgegebene gemeinsame Zutatenliste mit eindeutig unterscheidbaren Einträgen.
- Vorratsliste mit Hinzufügen und Entfernen von Zutaten.
- Rezeptarchiv mit Anlegen, Details, Bearbeiten und bestätigtem Löschen.
- Vollständig passende Rezepte filtern; fehlende Zutaten je Rezept anzeigen.
- Dauerhafte Speicherung eines persönlichen Datenbestands.
- Eingabevalidierung und verständliche Leerzustände.

Der MVP umfasst US-01 bis US-06 sowie US-08 und US-09, FR-01 bis FR-03 sowie FR-05 und FR-06 und NFR-01 bis NFR-06 aus [requirements.md](requirements.md). Die gemeinsame Teamprüfung der Spezifikation steht noch aus.

## Außerhalb des MVP

- Mengenvergleich, Umrechnung von Einheiten und automatische Verbrauchsbuchung.
- Nutzerkonten, gemeinsame Haushalte und Synchronisierung.
- Pflege oder freie Erweiterung des Zutatenkatalogs durch Nutzer.
- AI-Rezeptgenerierung, externe Rezeptimporte, Barcode- oder Bilderkennung.
- Ablaufdaten, Benachrichtigungen und Ernährungs-/Allergiefilter.
- Favoriten und Einkaufsliste (Could).
- Suche nach Rezeptnamen (Should).
- Filter für höchstens zwei fehlende Zutaten (Should; erst nach Abschluss des MVP).

## Geplanter vollständiger Demo-Anwendungsfall

Dieser Ablauf beschreibt die spätere Produktabnahme. In Phase 1 wird seine Eindeutigkeit geprüft; die Software wird noch nicht umgesetzt oder getestet.

1. Reis und Tomate zum Vorrat hinzufügen.
2. „Tomatenreis“ mit Reis und Tomate als Zutaten speichern.
3. „Eierreis“ mit Reis und Ei als Zutaten speichern.
4. Der Filter für vollständig passende Rezepte zeigt nur Tomatenreis. Eierreis zeigt Ei als fehlende Zutat.
5. Tomate aus dem Vorrat entfernen: Tomatenreis passt nicht mehr vollständig und zeigt Tomate als fehlend.
6. Die App neu starten: Rezepte und aktualisierter Vorrat sind weiterhin vorhanden.

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

Fachlicher Startumfang des Zutatenkatalogs, Angemessenheit der Priorisierung und Leistungsgrenze sowie gemeinsame Verständlichkeit der Akzeptanzkriterien. Architektur und Technologieauswahl gehören in Phase 2; Implementierung in Phase 3; Qualitätssicherung und Testausführung in Phase 4; abschließende Evaluation und Reflexion in Phase 5.
