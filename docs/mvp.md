# MVP-Scope

## Ziel

Ein Nutzer erfasst vorhandene Zutaten und eigene Rezepte. Jausi zeigt, welche Rezepte zu den vorhandenen Zutaten passen und welche Zutaten fehlen. Der Umfang soll für ein vierköpfiges Team innerhalb des Semesterprojekts realistisch bleiben.

## ✅ Im MVP enthalten

- Zutatenkatalog: fest vorgegeben, vom Team zusammengestellt (gegebenenfalls aus einer externen Quelle) und mit der App ausgeliefert; passende Zutaten werden beim Tippen vorgeschlagen.
- Vorrat: Zutaten aus dem Katalog hinzufügen und entfernen.
- Rezeptarchiv: Rezepte anlegen, anzeigen, bearbeiten und nach Bestätigung löschen.
- Matching mit dem Vorrat: Anzahl fehlender Zutaten je Rezept im Archiv, Filter für vollständig passende Rezepte, fehlende Zutaten in den Rezeptdetails.
- Dauerhafte Speicherung eines persönlichen Datenbestands.
- Eingabevalidierung und verständliche Hinweise bei leerem Vorrat oder Archiv.
- Bedienung auf dem Smartphone, auch ohne Internetverbindung.

Der MVP umfasst aus [requirements.md](requirements.md) die User Stories US-01 bis US-06, US-08, US-09, US-13 und US-19, die funktionalen Anforderungen FR-01 bis FR-03, FR-05 und FR-06 sowie die nichtfunktionalen Anforderungen NFR-01, NFR-03 bis NFR-06 und NFR-09. Begriffe wie Zutatenkatalog und Matching sind dort im Abschnitt „Begriffe“ definiert. Das Team hat die Spezifikation am 13.11.2026 geprüft und bestätigt.

## ❌ Außerhalb des MVP

- **Mengen:** Mengenvergleich, Umrechnung von Einheiten, automatische Verbrauchsbuchung.
- **Eigene Zutaten verwalten:** anlegen mit Duplikatprüfung (US-17, US-18, Should), umbenennen (US-14, Should), unbenutzte löschen (US-15, Could). Zutaten außerhalb des Katalogs können im MVP nur in der Zubereitung stehen.
- **Konten und Daten:** Nutzerkonten, gemeinsame Haushalte, Synchronisierung, Sicherung und Export.
- **Automatik:** AI-Rezeptgenerierung, Rezeptimporte, Barcode- oder Bilderkennung, Erkennung von Plural- und Schreibvarianten.
- **Weitere Themen:** Ablaufdaten, Benachrichtigungen, Ernährungs- und Allergiefilter.
- **Weitere Should/Could-Stories (nach dem MVP):** Suche (US-07), Filter „höchstens zwei fehlende Zutaten“ (US-10), Favoriten (US-11), Einkaufsliste (US-12) und Abhaken beim Einkaufen (US-20), Kategorien für Zutaten und Rezepte (US-21, US-22), Abschnitte in der Zubereitung (US-16).
- **Should-NFRs:** Leistungsziele NFR-02, NFR-07, NFR-08 und Lesbarkeit NFR-10 werden gemessen und dokumentiert, sind aber keine Abnahmebedingung.

## 🎬 Geplanter vollständiger Demo-Anwendungsfall

Dieser Ablauf beschreibt die spätere Produktabnahme und deckt die Anwendungsfälle AF-1 bis AF-3 aus [requirements.md](requirements.md) ab. In Phase 1 wird seine Eindeutigkeit geprüft; die Software wird noch nicht umgesetzt oder getestet.

> **Voraussetzung:** Die App läuft auf dem dokumentierten Smartphone-Testgerät im Flugmodus; Vorrat und Archiv sind leer. Der ausgelieferte Zutatenkatalog enthält unter anderem Reis, Tomate und Ei.

1. Im Vorrat „tom“ eintippen und die vorgeschlagene Zutat Tomate wählen, ebenso Reis; beide stehen danach im Vorrat. Die Eingabe „Xyz“ zeigt den Hinweis „Zutat nicht im Katalog“.
2. Das Rezept „Tomatenreis“ mit den Zutaten Reis und Tomate speichern; beide werden beim Tippen vorgeschlagen.
3. Das Rezept „Eierreis“ speichern: „reis“ eintippen und die vorgeschlagene Zutat Reis wählen, dann Ei aus den Vorschlägen wählen. Ei steht danach im Rezept, aber nicht im Vorrat.
4. Das Archiv zeigt bei Tomatenreis „alles da“ und bei Eierreis „1 fehlt“. Der Filter für vollständig passende Rezepte zeigt nur Tomatenreis. In den Details von Eierreis wird Ei als fehlende Zutat angezeigt.
5. Tomate aus dem Vorrat entfernen: Das Archiv zeigt bei Tomatenreis jetzt „1 fehlt“, und in den Details steht Tomate als fehlende Zutat.
6. Die App neu starten: Rezepte und aktualisierter Vorrat sind weiterhin vorhanden.

## ☑️ Definition of Done für Phase 1

Abgehakt sind nur Punkte, die sich anhand der Dokumente nachprüfen lassen. Die übrigen bestätigt das Team.

- [x] Ein anderer Entwickler versteht Produktziel, Problem und Zielgruppe ohne wesentliche Rückfragen.
- [x] Mindestens 8–10 User Stories liegen vor; jede Must-Story hat überprüfbare Akzeptanzkriterien.
- [x] Funktionale und mindestens drei relevante nichtfunktionale Anforderungen sind eindeutig und priorisiert.
- [x] MVP und spätere Erweiterungen sind klar getrennt; mindestens ein vollständiger demonstrierbarer Anwendungsfall ist beschrieben.
- [x] Zwei unterschiedliche AI-Anwendungen sind mit Eingaben, Ergebnissen und kritischer Bewertung dokumentiert: Anforderungsgenerierung und Prüfung auf Widersprüche, Lücken und Unklarheiten.
- [x] Die fünf gepflegten Dokumente (README, Anforderungen, MVP-Scope, AI-Einsatz, Personas) sind konsistent; das Team hat die noch offenen fachlichen Punkte geprüft und seine Entscheidungen dokumentiert.

> [!IMPORTANT]
> **Status:** Phase 1 ist abgeschlossen; das Team hat die Dokumentation am 13.11.2026 geprüft und bestätigt. Phase 2 ist seit 13.11.2026 freigegeben; ADR-0001 bleibt vorgeschlagen, bis das Team ihn annimmt.

## Geplante spätere Produktabnahme

- [ ] Alle Must-Stories erfüllen ihre Akzeptanzkriterien.
- [ ] Die nichtfunktionalen Must-Anforderungen wurden geprüft; Ergebnisse und Testgerät werden dokumentiert.
- [ ] Matching-Tests decken vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat ab.
- [ ] Ein anderes Teammitglied hat die Umsetzung geprüft.
- [ ] Die fünf gepflegten Dokumente sind konsistent und aktuell; bekannte Einschränkungen sind dokumentiert.
- [ ] Installation, Start und Testausführung sind im README nachvollziehbar beschrieben.

## Entscheidungen der Teamprüfung

Das Team hat die offenen Punkte vom 09.11.2026 geprüft und am 13.11.2026 bestätigt. Zwischenstände und Begründungen stehen im [AI-Protokoll](ai-usage.md#protokoll) und in der Git-Historie.

| Thema | Entscheidung |
| --- | --- |
| Zutatenkatalog | Fest vorgegeben, vom Team zusammengestellt, gegebenenfalls aus einer externen Quelle. Eigene Zutaten (US-17, US-18) sind Should. Quelle und Umfang des Datensatzes sind noch offen, siehe [requirements.md](requirements.md#bekannte-einschränkungen-und-risiken). |
| Personas | Lena, Andrea und Jonas; Lena ist die primäre Persona. |
| Nutzungskontext | Smartphone, Daten nur auf dem Gerät, Offline-Nutzung ist Must (NFR-01, NFR-09), keine Konten im MVP. Passt zum vorgeschlagenen [ADR-0001](adr/0001-infrastruktur-und-release.md), der noch nicht angenommen ist. |
| Leistungsziele | NFR-02, NFR-07 und NFR-08 sind Should; der Referenzdatensatz enthält den vollständigen Zutatenkatalog. |
| Sonderfälle | Jede Zutat höchstens einmal je Rezept, eindeutige Rezeptnamen, Zubereitung als Freitext. |
| Abschnitte in der Zubereitung | US-16 bleibt Could; Zutaten je Abschnitt sowie Umbenennen und Umsortieren werden erst bei einer Umsetzung ergänzt. |
| Anwendungsfälle und Risiken | AF-1 bis AF-5 und die dokumentierten Risiken, darunter Datenverlust bei Geräteverlust oder durch den Browser und mögliche Hosting-Kosten. |
| Akzeptanzkriterien | US-06 und US-13 aufgeteilt, alle Kriterien im Format Gegeben/Wenn/Dann, Lesbarkeit als NFR-10 (Should); das Team versteht die Kriterien gleich. |
| Developer-Reviews | Mengen als Freitext; Sicherheitsabfrage nur beim Löschen von Rezepten und Katalog-Zutaten und beim Verlassen ungespeicherter Rezepte; alphabetische Sortierung; Zutaten beim Bearbeiten änderbar; Vorschläge auch mitten im Wort; Vorrat speichert sofort; Fehl-Anzahl in der Archivliste; Offline für alle Funktionen; neue Could-Stories US-20 bis US-22 mit eigenen Kategorien und einer Einkaufsliste nur aus Katalog-Zutaten. Neue Zutaten direkt übernehmen gehört zu US-17 (Should). |
| Logo und Maskottchen | Bleiben als Idee; die Verwendung wird später entschieden, nicht Teil des MVP. |
