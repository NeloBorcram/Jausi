---
name: doku-konsistenz
description: Prüft die gepflegten Projektdokumente (README, requirements, mvp, ai-usage, personas) und weitere Dateien in docs/ gegeneinander auf Widersprüche, veraltete Stände, kaputte Links und Anker sowie einen falschen Zähler im AI-Protokoll. Verwenden nach jeder größeren Dokumentationsänderung und vor einem Commit.
---

# Dokumentation auf Konsistenz prüfen

**Status:** Vorschlag vom 13.11.2026. Das Team kann den Skill anpassen. Fasst die Prüfungen zusammen, die bei den Änderungen im November 2026 jeweils von Hand gemacht wurden.

## Prüfungen

1. **MVP-Umfang:** Die Story-, FR- und NFR-IDs im Absatz „Der MVP umfasst …“ in `docs/mvp.md` stimmen genau mit den Must-Einträgen in `docs/requirements.md` überein. README („Geplanter Funktionsumfang“, „Bewusst nicht im MVP“) widerspricht dem nicht.
2. **Story Map:** Jede Story aus `requirements.md` steht genau einmal in der Story Map, mit gleicher Priorität wie in ihrer Überschrift, und gehört zu mindestens einem Anwendungsfall.
3. **Begriffe:** Die Wörter aus der Spalte „Nicht verwenden“ im Abschnitt „Begriffe“ kommen in den Dokumenten nicht vor (wörtliche Zitate in `ai-usage.md` ausgenommen).
4. **Personas:** Die „wichtigsten User Stories“ in `docs/personas.md` existieren und passen zur Priorität.
5. **Status und Phasen:** README-Projektstand, Status in `mvp.md`, Hinweis oben in `requirements.md` und `docs/kursvorgaben.md` nennen denselben Stand. ADRs stehen in `docs/adr/README.md` mit demselben Status wie im ADR selbst.
6. **Links und Anker:** Alle relativen Links zeigen auf existierende Dateien; Anker (`#…`) passen zu einer Überschrift oder einem `<a id>`.
7. **AI-Protokoll:** Die Zahl in „Protokoll anzeigen (N Einträge)“ stimmt mit der Anzahl der Tabellenzeilen überein.
8. **Format:** `git diff --check` meldet nichts.

## Ausgabe

Liste der Befunde mit Datei und Zeile. Wenn alles passt, ausdrücklich „Keine Befunde“ melden, mit der Liste der geprüften Punkte.

## Regeln

- Nur melden, nicht ändern, außer der Nutzer bittet darum.
- Prüfungen, die nicht ausgeführt werden konnten, als solche nennen.
