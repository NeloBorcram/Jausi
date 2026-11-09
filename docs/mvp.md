# MVP-Scope

## Ziel

Ein Nutzer erfasst vorhandene Zutaten und eigene Rezepte. Jausi zeigt, welche Rezepte zu den vorhandenen Zutaten passen und welche Zutaten fehlen. Der Umfang soll für ein vierköpfiges Team innerhalb des Semesterprojekts realistisch bleiben.

## ✅ Im MVP enthalten

- Zutatenkatalog: wächst mit den Eingaben des Nutzers; vorhandene Zutaten werden beim Tippen vorgeschlagen, fehlende neu angelegt, Duplikate verhindert.
- Vorrat: Zutaten hinzufügen und entfernen.
- Rezeptarchiv: Rezepte anlegen, anzeigen, bearbeiten und nach Bestätigung löschen.
- Matching mit dem Vorrat: Anzahl fehlender Zutaten je Rezept im Archiv, Filter für vollständig passende Rezepte, fehlende Zutaten in den Rezeptdetails.
- Dauerhafte Speicherung eines persönlichen Datenbestands.
- Eingabevalidierung und verständliche Hinweise bei leerem Vorrat oder Archiv.
- Bedienung auf dem Smartphone, auch ohne Internetverbindung.

Der MVP umfasst aus [requirements.md](requirements.md) die User Stories US-01 bis US-06, US-08, US-09, US-13 und US-17 bis US-19, die funktionalen Anforderungen FR-01 bis FR-03, FR-05 und FR-06 sowie die nichtfunktionalen Anforderungen NFR-01, NFR-03 bis NFR-06 und NFR-09. Begriffe wie Zutatenkatalog und Matching sind dort im Abschnitt „Begriffe“ definiert. Die gemeinsame Teamprüfung der Spezifikation steht noch aus.

## ❌ Außerhalb des MVP

- **Mengen:** Mengenvergleich, Umrechnung von Einheiten, automatische Verbrauchsbuchung.
- **Konten und Daten:** Nutzerkonten, gemeinsame Haushalte, Synchronisierung, Sicherung und Export.
- **Automatik:** AI-Rezeptgenerierung, Rezeptimporte, Barcode- oder Bilderkennung, Erkennung von Plural- und Schreibvarianten.
- **Weitere Themen:** Ablaufdaten, Benachrichtigungen, Ernährungs- und Allergiefilter.
- **Should/Could-Stories (nach dem MVP):** Suche (US-07), Filter „höchstens zwei fehlende Zutaten“ (US-10), Zutaten umbenennen (US-14), Favoriten (US-11), Einkaufsliste (US-12) und Abhaken beim Einkaufen (US-20), Kategorien für Zutaten und Rezepte (US-21, US-22), unbenutzte Zutaten löschen (US-15), Abschnitte in der Zubereitung (US-16).
- **Should-NFRs:** Leistungsziele NFR-02, NFR-07, NFR-08 und Lesbarkeit NFR-10 werden gemessen und dokumentiert, sind aber keine Abnahmebedingung.

## 🎬 Geplanter vollständiger Demo-Anwendungsfall

Dieser Ablauf beschreibt die spätere Produktabnahme und deckt die Anwendungsfälle AF-1 bis AF-3 aus [requirements.md](requirements.md) ab. In Phase 1 wird seine Eindeutigkeit geprüft; die Software wird noch nicht umgesetzt oder getestet.

> **Voraussetzung:** Die App läuft auf dem dokumentierten Smartphone-Testgerät im Flugmodus; Zutatenkatalog, Vorrat und Archiv sind leer.

1. Im Vorrat Reis und Tomate als neue Zutaten anlegen; sie stehen danach im Zutatenkatalog und im Vorrat.
2. Das Rezept „Tomatenreis“ mit den Zutaten Reis und Tomate speichern; beide werden beim Tippen vorgeschlagen.
3. Das Rezept „Eierreis“ speichern: „reis“ eintippen und die vorgeschlagene Zutat Reis wählen; Ei als neue Zutat anlegen. Der Zutatenkatalog enthält danach genau Reis, Tomate und Ei.
4. Das Archiv zeigt bei Tomatenreis „alles da“ und bei Eierreis „1 fehlt“. Der Filter für vollständig passende Rezepte zeigt nur Tomatenreis. In den Details von Eierreis wird Ei als fehlende Zutat angezeigt.
5. Tomate aus dem Vorrat entfernen: Das Archiv zeigt bei Tomatenreis jetzt „1 fehlt“, und in den Details steht Tomate als fehlende Zutat.
6. Die App neu starten: Zutatenkatalog, Rezepte und aktualisierter Vorrat sind weiterhin vorhanden.

## ☑️ Definition of Done für Phase 1

Abgehakt sind nur Punkte, die sich anhand der Dokumente nachprüfen lassen. Die übrigen bestätigt das Team.

- [ ] Ein anderer Entwickler versteht Produktziel, Problem und Zielgruppe ohne wesentliche Rückfragen.
- [x] Mindestens 8–10 User Stories liegen vor; jede Must-Story hat überprüfbare Akzeptanzkriterien.
- [x] Funktionale und mindestens drei relevante nichtfunktionale Anforderungen sind eindeutig und priorisiert.
- [x] MVP und spätere Erweiterungen sind klar getrennt; mindestens ein vollständiger demonstrierbarer Anwendungsfall ist beschrieben.
- [x] Zwei unterschiedliche AI-Anwendungen sind mit Eingaben, Ergebnissen und kritischer Bewertung dokumentiert: Anforderungsgenerierung und Prüfung auf Widersprüche, Lücken und Unklarheiten.
- [ ] Die fünf gepflegten Dokumente (README, Anforderungen, MVP-Scope, AI-Einsatz, Personas) sind konsistent; das Team hat die noch offenen fachlichen Punkte geprüft und seine Entscheidungen dokumentiert.

> [!IMPORTANT]
> **Status:** Dokumentationsentwurf vorhanden; gemeinsame Teamprüfung ausstehend. Phase 1 ist noch nicht als abgeschlossen bestätigt.

## Geplante spätere Produktabnahme

- [ ] Alle Must-Stories erfüllen ihre Akzeptanzkriterien.
- [ ] Die nichtfunktionalen Must-Anforderungen wurden geprüft; Ergebnisse und Testgerät werden dokumentiert.
- [ ] Matching-Tests decken vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat ab.
- [ ] Ein anderes Teammitglied hat die Umsetzung geprüft.
- [ ] Die fünf gepflegten Dokumente sind konsistent und aktuell; bekannte Einschränkungen sind dokumentiert.
- [ ] Installation, Start und Testausführung sind im README nachvollziehbar beschrieben.

## Noch in Phase 1 klären

Vom Team in der Lehrveranstaltung am 09.11.2026 zu bestätigen. Nach dem Termin wird jeder Punkt abgehakt oder mit der abweichenden Entscheidung ergänzt.

- [ ] Mitwachsender Zutatenkatalog statt festem Katalog (US-13 bis US-15, US-17, US-18).
- [ ] Personas Lena, Andrea und Jonas sowie Lena als primäre Persona.
- [ ] Nutzungskontext Smartphone und Offline-Nutzung (NFR-01, NFR-09).
- [ ] Aufteilung der Leistungsziele (NFR-02, NFR-07, NFR-08), alle Should.
- [ ] Sonderfälle: Zutat höchstens einmal je Rezept, eindeutige Rezeptnamen, Zubereitung als Freitext.
- [ ] Abschnitte in der Zubereitung (US-16, Could).
- [ ] Wichtigste Anwendungsfälle AF-1 bis AF-5 sowie die dokumentierten Risiken und Einschränkungen, inklusive Datenverlust bei Geräteverlust.
- [ ] Aufteilung von US-06 und US-13, Akzeptanzkriterien im Format Gegeben/Wenn/Dann und Lesbarkeit (NFR-10, Should).
- [ ] Gleiches Verständnis der Akzeptanzkriterien im gesamten Team.
- [ ] Developer-Review vom 09.11.2026: Mengen als Freitext, Sicherheitsabfrage nur für Rezepte und Katalog-Zutaten (nicht Vorrat), alphabetische Sortierung, Zutaten beim Bearbeiten änderbar; neue Could-Stories US-20 bis US-22.
- [ ] Zweites Developer-Review vom 09.11.2026: Zutatenvorschläge auch mitten im Wort, neue Zutaten direkt übernehmen, Vorrat speichert sofort, Abfrage beim Verlassen ungespeicherter Rezepte, Fehl-Anzahl in der Archivliste, Offline für alle Funktionen, eigene Kategorien, Einkaufsliste nur mit Katalog-Zutaten.
- [ ] Logo und Maskottchen als Idee beibehalten; Verwendung später entscheiden (nicht Teil des MVP).
