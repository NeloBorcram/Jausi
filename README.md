# Jausi

**Rezepte mit dem, was du daheim hast.**

Jausi ist ein Semesterprojekt eines vierköpfigen Teams. Die App verbindet einen persönlichen Lebensmittelvorrat mit einem Rezeptarchiv und zeigt, welche Gerichte mit vorhandenen Zutaten zubereitet werden können.

## Problem und Zielgruppe

Menschen, die unkompliziert kochen möchten, allen voran Studierende, verlieren leicht den Überblick über ihre Lebensmittel. Jausi beantwortet die Frage: „Was kann ich heute mit meinem Vorrat kochen?“ und unterstützt dabei, vorhandene Zutaten zu nutzen und unnötige Einkäufe zu vermeiden.

Das Problem ist relevant: In österreichischen Haushalten werden pro Person und Jahr rund 69 kg Lebensmittel weggeworfen, davon etwa 37 kg vermeidbar ([BMLUK, Daten 2024](https://www.bmluk.gv.at/themen/abfall-und-kreislaufwirtschaft/abfallvermeidung/lebensmittel/oesterreich/haushalte.html)). In einer Umfrage der Verbraucherzentrale NRW wünschte sich rund ein Drittel der Befragten Rezepte zur Resteverwertung ([Verbraucherzentrale NRW](https://www.verbraucherzentrale.nrw/pressemitteilungen/neue-umfrage-fortschritte-bei-vermeidung-von-lebensmittelabfaellen-111819)). Laut einer Studie der ZHAW verschwenden jüngere Menschen mehr Lebensmittel als ältere ([ZHAW](https://www.zhaw.ch/de/medien/medienmitteilungen/detailansicht-medienmitteilung/event-news/frauen-ernaehren-sich-nachhaltiger-aeltere-verschwenden-weniger-nahrungsmittel/)). Eine Erhebung speziell zu Studierenden liegt dem Team nicht vor.

Alle Nutzer wollen wissen: Was habe ich da, was kann ich damit kochen, was muss ich nachkaufen? Drei fiktive [Personas](docs/personas.md) zeigen unterschiedliche Motivationen:

- **Lena, 22, Studentin (primär):** will schnell entscheiden, was es heute gibt, und nur das Nötigste kaufen.
- **Andrea, 38, berufstätig:** will vorhandene Lebensmittel aufbrauchen statt sie wegzuwerfen.
- **Jonas, 19, Lehrling:** kocht erst seit Kurzem und will sein kleines Repertoire nutzen.

Jausi wird hauptsächlich auf dem Smartphone genutzt: in der Küche und beim Einkaufen.

## Geplanter Funktionsumfang

- Zutaten im Vorrat erfassen und entfernen; vorhandene Zutaten werden beim Tippen vorgeschlagen, neue angelegt.
- Eigene Rezepte mit Zutaten, optionalen Mengenangaben und Zubereitung verwalten.
- Passende Rezepte finden und fehlende Zutaten anzeigen.
- Auf dem Smartphone nutzbar, auch ohne Internet.

Die Suche nach Rezeptnamen gehört nicht zum MVP (Should).

Der MVP prüft ausschließlich, ob Zutaten vorhanden sind. Mengen werden im Rezept dokumentiert, aber nicht mit Vorratsmengen verglichen. Ein persönlicher Zutatenkatalog wächst mit den Eingaben des Nutzers; Vorschläge beim Tippen und eine Duplikatprüfung verhindern unterschiedliche Schreibweisen beim Vergleich (Vorschlag, Teamentscheidung ausstehend). AI unterstützt die Projektarbeit; eine AI-Funktion in der App ist nicht vorgesehen.

## Projektdokumentation

- [Anforderungen und User Stories](docs/requirements.md)
- [MVP-Scope](docs/mvp.md)
- [AI-Einsatz und Reflexion](docs/ai-usage.md)
- [Personas](docs/personas.md)
- [Branding und Maskottchen (Entwurf)](docs/branding.md)

README, Anforderungen, MVP-Scope, AI-Einsatz und Personas werden bei jeder Projektänderung auf Aktualität geprüft und bei betroffenen Inhalten gemeinsam mit der Änderung aktualisiert. Weitere Dokumentation liegt ausschließlich in `docs/`.

## Zusammenarbeit

| Teammitglied | E-Mail |
| --- | --- |
| Manuela | se26m005@technikum-wien.at |
| Alex | se26m018@technikum-wien.at |
| Manuel | se26m026@technikum-wien.at |
| Roger | se26m063@technikum-wien.at |

In der Projektdokumentation verwenden wir ausschließlich Vornamen.

Wir arbeiten zu viert. In Phase 1 prüfen wir gemeinsam Problemdefinition, Anforderungen, Priorisierung und MVP. Die Verantwortung für die Anforderungen liegt beim Team; AI liefert Vorschläge und unterstützt deren Prüfung.

## Projektstand und offene Entscheidungen

Phase 1: Projektdefinition und Anforderungen. Es gibt noch keine App-Implementierung und keine ausführbaren Tests.

Aktuell bearbeiten wir ausschließlich Phase 1. Technologieauswahl, Architektur, Implementierung und Testausführung folgen in den vorgesehenen späteren Phasen.

| Phase laut bereitgestelltem Kursplan | Datum |
| --- | --- |
| 1 – Project Definition & Requirements | 14.10.2026 |
| 2 – Architecture & Design | 09.11.2026 |
| 3 – AI-assisted/driven Implementation | 23.11.2026 |
| 4 – Quality Assurance & Testing | 09.12.2026 |
| 5 – Evaluation & Reflection | 21.12.2026 |

Die Daten sind die angegebenen Phasentermine; sie werden nicht als bestätigte Abgabefristen interpretiert. Die Phase-1-Abnahmekriterien stehen in [docs/mvp.md](docs/mvp.md).
