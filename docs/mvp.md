# MVP-Scope

## Ziel

Ein Nutzer erfasst vorhandene Zutaten und eigene Rezepte. Jausi zeigt, welche Rezepte zu den vorhandenen Zutaten passen und welche Zutaten fehlen. Der Umfang soll für ein vierköpfiges Team innerhalb des Semesterprojekts realistisch bleiben.

## ✅ Im MVP enthalten

- Konto: mit E-Mail-Adresse und Passwort anlegen, an- und abmelden und löschen; die Daten sind auf jedem Gerät verfügbar.
- Datenschutzerklärung und Impressum (im MVP als Platzhalter), ohne Anmeldung erreichbar.
- Zutatenkatalog: fest vorgegeben, vom Team von Hand gepflegt und für alle Konten gleich; passende Zutaten werden beim Tippen vorgeschlagen.
- Vorrat: Zutaten aus dem Katalog hinzufügen und entfernen.
- Rezeptarchiv: Rezepte anlegen, anzeigen, bearbeiten und nach Bestätigung löschen.
- Matching mit dem Vorrat: Anzahl fehlender Zutaten je Rezept im Archiv, Filter für vollständig passende Rezepte, fehlende Zutaten in den Rezeptdetails.
- Dauerhafte Speicherung je Konto auf dem Server.
- Eingabevalidierung und verständliche Hinweise bei leerem Vorrat oder Archiv und ohne Internetverbindung.
- Bedienung im Browser des Smartphones, auf Android und iPhone; eine Internetverbindung ist nötig.

Der MVP umfasst aus [requirements.md](requirements.md) die User Stories US-01 bis US-06, US-08, US-09, US-13, US-19, US-23, US-24, US-26 und US-31, die funktionalen Anforderungen FR-01 bis FR-03, FR-05, FR-06, FR-16 und FR-22 sowie die nichtfunktionalen Anforderungen NFR-01 und NFR-03 bis NFR-06. Begriffe wie Zutatenkatalog und Matching sind dort im Abschnitt „Begriffe“ definiert. Das Team hat die Spezifikation am 13.11.2026 geprüft und bestätigt. Danach wurde ebenfalls am 13.11.2026 eine Scope-Änderung zu Konten und Server vorgeschlagen ([ADR-0002](adr/0002-architekturstil-client-server.md)); dieser Umfang enthält sie bereits. Ohne Einwand des Teams gilt sie ab 15.11.2026.

## ❌ Außerhalb des MVP

- **Mengen:** Mengenvergleich, Umrechnung von Einheiten, automatische Verbrauchsbuchung.
- **Eigene Zutaten verwalten:** anlegen mit Duplikatprüfung (US-17, US-18, Should), umbenennen (US-14, Should), unbenutzte löschen (US-15, Could). Zutaten außerhalb des Katalogs können im MVP nur in der Zubereitung stehen.
- **Konten:** Passwort zurücksetzen (US-25, Should); Sperre nach fehlgeschlagenen Anmeldungen nur, wenn Zeit bleibt.
- **Bedienkomfort:** Abfrage beim Verlassen ungespeicherter Rezepte (US-32, Should).
- **Automatik:** AI-Rezeptgenerierung, Rezeptimporte, Barcode- oder Bilderkennung, Erkennung von Plural- und Schreibvarianten.
- **Weitere Themen:** Ablaufdaten, Benachrichtigungen, Ernährungs- und Allergiefilter.
- **Weitere Should/Could-Stories (nach dem MVP):** Suche (US-07), Filter „höchstens zwei fehlende Zutaten“ (US-10), Favoriten (US-11), Einkaufsliste (US-12) und Abhaken beim Einkaufen (US-20), Kategorien für Zutaten und Rezepte (US-21, US-22), Abschnitte in der Zubereitung (US-16).
- **Später (nach dem Kurs):** siehe Abschnitt „Für später vorgemerkt“.
- **Should-NFRs:** Leistungsziele NFR-02, NFR-07, NFR-08 und Lesbarkeit NFR-10 werden gemessen und dokumentiert, wenn im Kurs Zeit bleibt; sie sind keine Abnahmebedingung.

## 🗂️ Für später vorgemerkt

Legitime Funktionen für Jausi, die bewusst nicht im Rahmen des Kurses umgesetzt werden. Sie sind dokumentiert, damit sie nicht jedes Mal neu diskutiert werden; aufgenommen werden sie nur durch eine ausdrückliche Entscheidung des Teams.

| Funktion | Bezug | Warum später |
| --- | --- | --- |
| Eigene App für Android und iPhone | [architecture.md](architecture.md) | Die Web-App deckt beide Plattformen ab; eine App nutzt später dieselbe Server-API. |
| Daten ohne Verbindung lesen, auch bei Serverausfall | US-30, NFR-09 | Braucht eine lokale Kopie im Browser oder in einer App. |
| Daten exportieren | US-29 | Recht auf Datenübertragbarkeit; bis dahin erfüllt das Team Anfragen von Hand. |
| Einkaufsliste ohne Internet | US-28 | Setzt die Einkaufsliste (US-12, Could) und Offline-Fähigkeit voraus. |
| Verbrauchsstatistik | US-27 | Braucht über längere Zeit gesammelte Daten. |
| Zutatenkatalog aus einer externen Quelle | [requirements.md](requirements.md#bekannte-einschränkungen-und-risiken) | Lizenz, Umfang und deutsche Bezeichnungen müssten erst geprüft werden. |
| Synchronisierung, gemeinsame Haushalte | – | Mehrere Personen an denselben Daten bringen Rechte und Konflikte mit sich. |

## 🎬 Geplanter vollständiger Demo-Anwendungsfall

Dieser Ablauf beschreibt die spätere Produktabnahme und deckt die Anwendungsfälle AF-6 und AF-1 bis AF-3 aus [requirements.md](requirements.md) ab. In Phase 1 wird seine Eindeutigkeit geprüft; die Software wird noch nicht umgesetzt oder getestet.

> **Voraussetzung:** Jausi läuft im Browser eines dokumentierten Smartphone-Testgeräts; ein zweites Gerät mit Browser, etwa ein Laptop, steht bereit. Es gibt noch kein Konto. Der Zutatenkatalog enthält unter anderem Reis, Tomate und Ei.

1. Auf dem Smartphone ein Konto mit E-Mail-Adresse und Passwort anlegen; Vorrat und Archiv sind leer.
2. Im Vorrat „tom“ eintippen und die vorgeschlagene Zutat Tomate wählen, ebenso Reis; beide stehen danach im Vorrat. Die Eingabe „Xyz“ zeigt den Hinweis „Zutat nicht im Katalog“.
3. Das Rezept „Tomatenreis“ mit den Zutaten Reis und Tomate speichern; beide werden beim Tippen vorgeschlagen.
4. Das Rezept „Eierreis“ speichern: „reis“ eintippen und die vorgeschlagene Zutat Reis wählen, dann Ei aus den Vorschlägen wählen. Ei steht danach im Rezept, aber nicht im Vorrat.
5. Das Archiv zeigt bei Tomatenreis „alles da“ und bei Eierreis „1 fehlt“. Der Filter für vollständig passende Rezepte zeigt nur Tomatenreis. In den Details von Eierreis wird Ei als fehlende Zutat angezeigt.
6. Tomate aus dem Vorrat entfernen: Das Archiv zeigt bei Tomatenreis jetzt „1 fehlt“, und in den Details steht Tomate als fehlende Zutat.
7. Abmelden und auf dem zweiten Gerät mit demselben Konto anmelden: Rezepte und aktualisierter Vorrat sind dort vorhanden.

## ☑️ Definition of Done für Phase 1

Abgehakt sind nur Punkte, die sich anhand der Dokumente nachprüfen lassen. Die übrigen bestätigt das Team.

- [x] Ein anderer Entwickler versteht Produktziel, Problem und Zielgruppe ohne wesentliche Rückfragen.
- [x] Mindestens 8–10 User Stories liegen vor; jede Must-Story hat überprüfbare Akzeptanzkriterien.
- [x] Funktionale und mindestens drei relevante nichtfunktionale Anforderungen sind eindeutig und priorisiert.
- [x] MVP und spätere Erweiterungen sind klar getrennt; mindestens ein vollständiger demonstrierbarer Anwendungsfall ist beschrieben.
- [x] Zwei unterschiedliche AI-Anwendungen sind mit Eingaben, Ergebnissen und kritischer Bewertung dokumentiert: Anforderungsgenerierung und Prüfung auf Widersprüche, Lücken und Unklarheiten.
- [x] Die fünf gepflegten Dokumente (README, Anforderungen, MVP-Scope, AI-Einsatz, Personas) sind konsistent; das Team hat die noch offenen fachlichen Punkte geprüft und seine Entscheidungen dokumentiert.

> [!IMPORTANT]
> **Status:** Phase 1 ist abgeschlossen; das Team hat die Dokumentation am 13.11.2026 geprüft und bestätigt. Phase 2 ist seit 13.11.2026 freigegeben. Die danach vorgeschlagene Scope-Änderung (ADR-0002) gilt ohne Einwand ab 15.11.2026; ADR-0001 und ADR-0002 bleiben bis zur Annahme vorgeschlagen.

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
| Zutatenkatalog | Fest vorgegeben, im Kurs vom Team von Hand gepflegt. Eigene Zutaten (US-17, US-18) sind Should; eine externe Quelle ist eine spätere Erweiterung (siehe unten). |
| Personas | Lena, Andrea und Jonas; Lena ist die primäre Persona. |
| Nutzungskontext | Am 13.11.2026 bestätigt: Smartphone, Daten nur auf dem Gerät, Offline-Nutzung als Must, keine Konten. **Danach geändert, vorgeschlagen mit stillschweigender Zustimmung (Einwand bis 15.11.2026):** Web-App im Browser des Smartphones mit Konto und Daten auf dem Server; nach dem MVP eine lokale Kopie zum Lesen (US-30, später), die Einkaufsliste ohne Internet (US-28, später) und eine eigene App; Daten exportieren (US-29, später). Siehe [ADR-0002](adr/0002-architekturstil-client-server.md). |
| Leistungsziele | NFR-02, NFR-07 und NFR-08 sind Should; der Referenzdatensatz enthält den vollständigen Zutatenkatalog. |
| Sonderfälle | Jede Zutat höchstens einmal je Rezept, eindeutige Rezeptnamen, Zubereitung als Freitext. |
| Abschnitte in der Zubereitung | US-16 bleibt Could; Zutaten je Abschnitt sowie Umbenennen und Umsortieren werden erst bei einer Umsetzung ergänzt. |
| Anwendungsfälle und Risiken | AF-1 bis AF-5 und die dokumentierten Risiken, darunter Datenverlust bei Geräteverlust oder durch den Browser und mögliche Hosting-Kosten. |
| Akzeptanzkriterien | US-06 und US-13 aufgeteilt, alle Kriterien im Format Gegeben/Wenn/Dann, Lesbarkeit als NFR-10 (Should); das Team versteht die Kriterien gleich. |
| Developer-Reviews | Mengen als Freitext; Sicherheitsabfrage nur beim Löschen von Rezepten und Katalog-Zutaten und beim Verlassen ungespeicherter Rezepte (seit 13.11.2026 Should, US-32); alphabetische Sortierung; Zutaten beim Bearbeiten änderbar; Vorschläge auch mitten im Wort; Vorrat speichert sofort; Fehl-Anzahl in der Archivliste; Offline für alle Funktionen; neue Could-Stories US-20 bis US-22 mit eigenen Kategorien und einer Einkaufsliste nur aus Katalog-Zutaten. Neue Zutaten direkt übernehmen gehört zu US-17 (Should). |
| Verbrauchsstatistik | Neu (US-27), für später vorgemerkt; vorgeschlagen am 13.11.2026 zusammen mit ADR-0002. |
| Logo und Maskottchen | Bleiben als Idee; die Verwendung wird später entschieden, nicht Teil des MVP. |
