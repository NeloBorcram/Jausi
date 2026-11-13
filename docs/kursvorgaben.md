# Kursvorgaben

Zusammenfassung der Aufgabenstellungen aus dem Moodle-Kurs, damit Team und AI-Werkzeuge darauf verweisen können. Die Texte sind gekürzt und in eigenen Worten wiedergegeben; maßgeblich bleibt die Aufgabenstellung in Moodle (Abschnitt der jeweiligen Phase). Die Termine stammen aus dem Kursplan und sind keine bestätigten Abgabefristen.

| Phase | Termin laut Kursplan | Vorgaben hier erfasst | Stand im Projekt |
| --- | --- | --- | --- |
| [1 – Project Definition & Requirements](#phase-1--project-definition--requirements) | 14.10.2026 | ✅ am 13.11.2026 | abgeschlossen, vom Team bestätigt |
| [2 – Architecture & Design](#phase-2--architecture--design) | 09.11.2026 | ✅ am 13.11.2026 | freigegeben am 13.11.2026, in Arbeit; zwei ADRs liegen als Vorschlag vor |
| [3 – AI-assisted/driven Implementation](#phase-3--ai-assisteddriven-implementation) | 23.11.2026 | ⏳ noch nicht veröffentlicht | – |
| [4 – Quality Assurance & Testing](#phase-4--quality-assurance--testing) | 09.12.2026 | ⏳ noch nicht veröffentlicht | – |
| [5 – Evaluation & Reflection](#phase-5--evaluation--reflection) | 21.12.2026 | ⏳ noch nicht veröffentlicht | – |

**Rahmen aus dem Kurs:** Projektthemen gibt es als Vorschlagsliste; eigene Themen wie Jausi sind nach Absprache möglich. Jede Phase wird in Moodle eigens abgegeben.

## Phase 1 – Project Definition & Requirements

**Ziel:** Aus einer groben Idee eine klare, realistische und umsetzbare Produktspezifikation entwickeln, gezielt mit AI-Unterstützung.

**Aufgaben**
- Projektidee, Problem und Mehrwert definieren; zuerst das Problem verstehen, dann Lösungen entwickeln.
- Zielgruppe mit ihren Bedürfnissen und die wichtigsten Anwendungsfälle bestimmen.
- Mindestens 8–10 konkrete, verständliche und überprüfbare User Stories.
- Funktionale und nichtfunktionale Anforderungen: eindeutig, widerspruchsfrei, möglichst messbar.
- Priorisieren nach Must/Should/Could; Must heißt wirklich unverzichtbar.
- MVP-Scope festlegen: lieber klein und funktionierend als unrealistisch groß.
- Anforderungen auf Widersprüche und Unklarheiten prüfen.

**Rahmenbedingungen**
- Realistisches Softwareprojekt für ein Semester; in späteren Phasen muss tatsächlich Software entstehen.
- Das MVP deckt mindestens einen vollständigen, demonstrierbaren Anwendungsfall ab.
- Externe APIs und Services sind erlaubt; Abhängigkeiten und Kosten sind zu berücksichtigen.
- AI wird aktiv im Requirements Engineering eingesetzt, mindestens zweimal unterschiedlich (zum Beispiel Stories generieren und Anforderungen prüfen). Ergebnisse werden kritisch bewertet und korrigiert; die Verantwortung liegt bei den Studierenden.
- Qualität: überprüfbare Akzeptanzkriterien für jede Must-Story, mindestens drei relevante NFRs, klare Trennung von MVP und Erweiterungen.

**Deliverables**

| Datei | Inhalt laut Kurs | Umsetzung |
| --- | --- | --- |
| `README.md` | Idee, Problem, Zielgruppe, Projektziel | [README](../README.md) |
| `docs/requirements.md` | User Stories, FR und NFR, Priorisierung, Akzeptanzkriterien | [requirements.md](requirements.md) |
| `docs/mvp.md` | MVP-Scope, enthaltene und ausgeschlossene Funktionen | [mvp.md](mvp.md) |
| `docs/ai-usage.md` | AI-Einsatz, ausgewählte Prompts, Ergebnisse, kritische Bewertung | [ai-usage.md](ai-usage.md) |

Zusätzlich vom Team, nicht vom Kurs verlangt: [personas.md](personas.md). Die Personas helfen Developern, Anforderungen aus verschiedenen Sichten zu prüfen.

**Typische Fehler:** zu großes Projekt, Technologiewahl vor dem Verständnis der Anforderungen, unklare oder nicht prüfbare Stories, AI-Ergebnisse ungeprüft übernehmen, zu viele Musts, nicht testbare Anforderungen.

**Bewertung:** Problemdefinition, Anforderungsqualität, MVP-Abgrenzung, AI-Kompetenz, Nachvollziehbarkeit.

**Definition of Done:** Ein anderer Entwickler versteht ohne wesentliche Rückfragen, was für wen entwickelt wird, welches Problem gelöst wird, was zum MVP gehört und welche Anforderungen überprüfbar erfüllt sein müssen. Die Umsetzung im Projekt steht in [mvp.md](mvp.md) im Abschnitt „Definition of Done für Phase 1“.

**Kernaussage des Kurses:** AI kann Anforderungen erzeugen, aber nicht entscheiden, was das Produkt sein soll. Es zählt die Qualität und kritische Bewertung, nicht die Menge.

## Phase 2 – Architecture & Design

**Ziel:** Eine nachvollziehbare, technisch sinnvolle und umsetzbare Architektur mit AI-Unterstützung entwickeln; Entscheidungen begründen und kritisch hinterfragen.

**Aufgaben**
- Mindestens zwei Architekturvarianten untersuchen, vergleichen, eine auswählen und die Wahl begründen.
- Technologien (Sprachen, Frameworks, Datenbanken, weitere Komponenten) anhand konkreter Anforderungen auswählen, nicht nach Beliebtheit.
- Architekturdiagramm der Systemstruktur und wesentlichen Komponenten (zum Beispiel C4); Komponenten mit ihren Verantwortlichkeiten beschreiben.
- Datenmodell: zentrale Entitäten, Beziehungen und Datenstrukturen.
- Schnittstellen- und API-Design: wesentliche Schnittstellen, Endpunkte und Datenformate.
- Mindestens zwei Architecture Decision Records.
- Hosting-Möglichkeiten vergleichen, unter anderem nach Kosten.

**Worauf achten**
- Requirements first: Die Architektur muss die Anforderungen aus Phase 1 unterstützen.
- Keep it simple: Ein modularer Monolith passt oft besser als Microservices.
- Trade-offs jeder Entscheidung verstehen und benennen.
- Diagramm, Datenmodell und API-Design müssen zusammenpassen.
- Sinnvolle Erweiterungen bedenken, aber nicht für hypothetische Anforderungen bauen.
- Wichtige NFRs berücksichtigen: Security, Performance, Maintainability.
- Die Architektur muss zum MVP und zur verfügbaren Zeit passen; keine unnötigen Technologien oder Infrastruktur. Das Team muss sie erklären und verteidigen können.

**AI-Einsatz**
- AI für alternative Architekturvorschläge sowie zum Finden von Schwachstellen und Risiken einsetzen.
- Mindestens eine AI-Empfehlung kritisch hinterfragen und bewerten.
- Wesentliche AI-Beiträge und die daraus folgenden Entscheidungen dokumentieren (in [ai-usage.md](ai-usage.md)).

**Deliverables**

| Datei | Inhalt laut Kurs | Stand |
| --- | --- | --- |
| `docs/architecture.md` | Überblick, Variantenvergleich, Technologieentscheidungen | Entwurf: Variantenvergleich in [architecture.md](architecture.md), Architekturstil vorgeschlagen (ADR-0002) |
| `docs/hosting.md` | Hosting-Möglichkeiten und Kostenvergleich | fehlt; erste Optionen in [github-workflow.md](github-workflow.md) |
| `docs/adr/` | mindestens zwei ADRs | zwei Vorschläge: [ADR-0001](adr/0001-infrastruktur-und-release.md), [ADR-0002](adr/0002-architekturstil-client-server.md) |
| Architekturdiagramm | wesentliche Komponenten und Beziehungen | erster Überblick in [architecture.md](architecture.md), Technologien noch offen |
| Datenmodell | zentrale Entitäten und Beziehungen | fachliches Modell in [requirements.md](requirements.md#begriffe), technisches fehlt |
| API-Design | wesentliche Schnittstellen und Datenformate | fehlt |

**Typische Fehler:** Overengineering (Microservices, Message Queues, komplexe Infrastruktur), AI-Architektur ungeprüft übernehmen, Technologien, die niemand im Team versteht, Entscheidungen ohne Bezug zu den Anforderungen, Diagramme, die nicht zur Implementierung passen, oberflächliche Vergleiche nur für die Form.

**Bewertung:** Architekturqualität, Entscheidungsqualität, Alternativen, AI-Kompetenz, Konsistenz von Requirements, Architektur, Datenmodell und Schnittstellen.

**Definition of Done:** Architektur dokumentiert und visualisiert, wesentliche Technologieentscheidungen begründet, mindestens zwei Varianten verglichen, mindestens zwei ADRs, Datenmodell und API-Design konkret genug für den Start der Implementierung, und das Team kann seine Entscheidungen erklären.

**Kernaussage des Kurses:** AI kann Architekturen vorschlagen, aber Engineers müssen sie verstehen und begründen. Gut ist die einfachste Architektur, die die Anforderungen zuverlässig erfüllt.

## Phase 3 – AI-assisted/driven Implementation

Aufgabenstellung noch nicht veröffentlicht. Wird ergänzt, sobald sie in Moodle verfügbar ist.

## Phase 4 – Quality Assurance & Testing

Aufgabenstellung noch nicht veröffentlicht. Wird ergänzt, sobald sie in Moodle verfügbar ist.

## Phase 5 – Evaluation & Reflection

Aufgabenstellung noch nicht veröffentlicht. Wird ergänzt, sobald sie in Moodle verfügbar ist.
