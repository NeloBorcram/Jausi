---
name: adr-anlegen
description: Legt einen neuen Architecture Decision Record nach der Jausi-Vorlage an, mit nächster freier Nummer, Status „vorgeschlagen“ und Eintrag in der ADR-Übersicht. Verwenden, wenn eine folgenreiche Architektur-, Plattform-, Daten-, Infrastruktur- oder Deploymententscheidung dokumentiert werden soll.
---

# ADR anlegen

**Status:** Vorschlag vom 13.11.2026. Das Team kann den Skill anpassen. Ablauf nach `docs/adr/README.md`.

## Voraussetzung

Die aktuelle Phase erlaubt Architekturarbeit (siehe `AGENTS.md`), oder der Nutzer hat ausdrücklich einen ADR beauftragt.

## Vorgehen

1. Lies `docs/adr/README.md`, `docs/adr/adr-template.md`, die bestehenden ADRs und die betroffenen Anforderungen in `docs/requirements.md`.
2. Bestimme die nächste freie Nummer `NNNN` und einen kurzen Titel in Kleinbuchstaben mit Bindestrichen.
3. Kopiere die Vorlage nach `docs/adr/NNNN-kurztitel.md` und fülle sie aus:
   - Kontext mit Bezug auf konkrete Story-, FR- und NFR-IDs.
   - Mindestens zwei echte Alternativen mit Vor- und Nachteilen, nicht nur pro forma.
   - Entscheidung, Folgen, Risiken und eine überprüfbare Bestätigung.
   - Status **vorgeschlagen**. Entscheidende erst nach tatsächlicher Teamfreigabe eintragen.
4. Ergänze die Tabelle in `docs/adr/README.md`.
5. Widerspricht der ADR einem bestehenden ADR oder einer Anforderung, das ausdrücklich nennen statt still zu überschreiben.
6. Eine Zeile im Protokoll von `docs/ai-usage.md` ergänzen; dabei festhalten, welche AI-Empfehlungen kritisch hinterfragt wurden (Vorgabe aus Phase 2).

## Regeln

- Nie als „angenommen“ markieren ohne Teamfreigabe.
- Keine Ressourcen anlegen oder Code schreiben; der ADR dokumentiert nur.
