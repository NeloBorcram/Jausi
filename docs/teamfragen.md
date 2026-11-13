# Offene Teamfragen

Alle Fragen, die das Team gemeinsam entscheiden muss, stehen nur hier; die anderen Dokumente verlinken auf die Nummer. Nach der Teamsitzung die Entscheidung eintragen, das betroffene Dokument anpassen und die Zeile nach unten zu „Entschieden“ verschieben. Stand: 13.11.2026.

## Bis 15.11.2026

| # | Frage | Wer | Hintergrund |
| --- | --- | --- | --- |
| T1 | Gibt es einen Einwand gegen Client-Server mit Konten und die damit verbundene Scope-Änderung? Ohne Einwand gilt ADR-0002 ab 15.11.2026. | alle | [ADR-0002](adr/0002-architekturstil-client-server.md) |

## Vor dem Start der Umsetzung (23.11.2026)

| # | Frage | Wer | Hintergrund |
| --- | --- | --- | --- |
| T2 | ADR-0001 und ADR-0002 konkurrieren: ADR-0001 setzt noch Daten auf dem Gerät und Offline-Nutzung voraus. Mit welchem gehen wir? | Team | [ADR-0001](adr/0001-infrastruktur-und-release.md) |
| T3 | Kenntnisse in Java/Spring Boot, TypeScript/Node, Vue, React und C# (jede Person schätzt sich selbst ein) | Manuela, Alex, Manuel | [ADR-0003](adr/0003-technologie-stack.md#kenntnisse-im-team) |
| T4 | Technologie-Stack entscheiden (Vorschlag Spring Boot mit Vue). Reicht eine Person mit Spring-Boot-Kenntnissen für das Backend? | Team | [ADR-0003](adr/0003-technologie-stack.md) |
| T6 | Hosting-Vorschlag (Azure mit Studierenden-Guthaben) bestätigen. Genügt die Freigabe durch eine Person ohne Slot-Tausch? | Team, Manuel | [hosting.md](hosting.md) |
| T7 | Im Azure-Portal prüfen: PostgreSQL B1ms 12 Monate gratis? App Service in den erlaubten Regionen? Reicht der Gratistarif für den gewählten Stack? | offen | [hosting.md](hosting.md) |
| T8 | Verantwortliche für die Risiken festlegen | Team | [architecture.md](architecture.md#risiken-und-schwachstellen-ai-review) |
| T9 | Merksatz „Die Entwicklung der App wartet nicht auf die Infrastruktur“ gemeinsam bestätigen | Team | [architecture.md](architecture.md#leitlinie-bewusst-einfach) |

## Zu Beginn der Umsetzung

| # | Frage | Wer | Hintergrund |
| --- | --- | --- | --- |
| T13 | Inhalt der Datenschutzerklärung: Kontaktadresse, Verantwortliche, Aufbewahrungsfrist der Sicherungen (US-31) | Team | [datenmodell.md](datenmodell.md#entitäten) |
| T14 | Reihenfolge der Zutaten im Rezept und Längengrenzen für Name, Zubereitung und Menge | Team | [datenmodell.md](datenmodell.md#entitäten) |
| T15 | Umfang des Zutatenkatalogs (mindestens 200 für den Referenzdatensatz) und wer ihn pflegt | Team | [architecture.md](architecture.md#risiken-und-schwachstellen-ai-review) |

## Entschieden

| # | Entscheidung | Von, Datum |
| --- | --- | --- |
| T5 | Node 22 auf `develop` war keine Vorentscheidung für den Stack. | Roger, 13.11.2026 |
| T10 | Eine Anmeldung bleibt 30 Minuten nach der letzten Nutzung gültig, auch wenn der Browser geschlossen wird (US-24 AK 4 angepasst). | Roger, 13.11.2026 |
| T11 | Sperre nach fehlgeschlagenen Anmeldungen nur, wenn im Kurs Zeit bleibt. | Roger, 13.11.2026 |
| T12 | Ein Konto lässt sich nur mit dem Passwort löschen (US-26 AK 1 und AK 3). | Roger, 13.11.2026 |
| T13a | Das Impressum ist im MVP ein Platzhalter. | Roger, 13.11.2026 |
