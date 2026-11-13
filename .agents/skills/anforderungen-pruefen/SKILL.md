---
name: anforderungen-pruefen
description: Prüft docs/requirements.md und docs/mvp.md auf Widersprüche, Lücken, Unklarheiten, nicht überprüfbare Akzeptanzkriterien und zu viele Must-Anforderungen – aus Sicht eines Senior Product Owners und eines Developers. Verwenden, wenn Anforderungen neu geschrieben oder geändert wurden oder vor einer Abgabe.
---

# Anforderungen prüfen

**Status:** Vorschlag vom 13.11.2026. Das Team kann den Skill anpassen. Entstanden aus den Prüfungen vom 07.11. und 09.11.2026 (siehe `docs/ai-usage.md`).

## Ziel

Befunde liefern, keine Änderungen. Die Entscheidung über jeden Befund trifft das Team.

## Vorgehen

1. Lies `docs/requirements.md`, `docs/mvp.md`, `docs/personas.md` und die Vorgaben der aktuellen Phase in `docs/kursvorgaben.md`.
2. Prüfe aus Sicht eines **Senior Product Owners**:
   - Ist jede Story einem Anwendungsfall und einer Persona zugeordnet?
   - Ist Must wirklich unverzichtbar für den demonstrierbaren Kernablauf? Passt der MVP zu vier Personen und einem Semester?
   - Werden die Begriffe aus dem Abschnitt „Begriffe“ einheitlich verwendet?
   - Sind die NFRs messbar, mit Prüfmethode?
3. Prüfe aus Sicht eines **Developers**, der morgen beginnen soll:
   - Wo würde ich nachfragen? Fehlende Sonderfälle, Sortierung, Speicherzeitpunkt, Leerzustände, Fehlermeldungen.
   - Ist jedes Akzeptanzkriterium im Format Gegeben/Wenn/Dann eindeutig und als Test formulierbar?
   - Widersprechen sich Story, fachliche Regel, FR und NFR?
4. Prüfe die Konsistenz: MVP-Liste in `mvp.md` gegen Must-Stories, Must-FRs und Must-NFRs in `requirements.md`.

## Ausgabe

Eine Tabelle, nach Schwere sortiert:

| # | Stelle | Befund | Warum es ein Problem ist | Vorschlag |
| --- | --- | --- | --- | --- |

Danach kurz: was gut ist und nicht geändert werden sollte.

## Regeln

- Ändere keine Dateien, solange der Nutzer nicht zustimmt.
- Erfinde keine Teamfreigaben. Markiere Annahmen als Annahmen.
- Schlage keine Technologie- oder Architekturentscheidungen vor, solange die Phase das nicht vorsieht (siehe `AGENTS.md`).
- Nach der Prüfung eine Zeile im Protokoll von `docs/ai-usage.md` ergänzen.
