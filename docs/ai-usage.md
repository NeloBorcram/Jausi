# AI-Einsatz und Reflexion

AI hat uns geholfen, die Idee zu strukturieren, Anforderungen zu formulieren und sie auf Widersprüche, Lücken und Unklarheiten zu prüfen (Phase 1) sowie Architektur, Datenmodell, API, Stack und Hosting zu entwerfen und auf Risiken zu prüfen (Phase 2). Eine AI-Funktion in der App ist nicht vorgesehen. Für Scope, fachliche Entscheidungen und Qualität bleibt das Team verantwortlich.

**Werkzeuge:** Codex (14.10.2026), Claude Sonnet 5.5 (07.11.2026) und Claude Opus 5.5 (09.11.2026), jeweils im Chat; dazu Google Gemini für Logo-Entwürfe.

## 1 · Anforderungen generieren und strukturieren

**Ausgewählte Prompts**
- „Wir wollen eine Jausi app machen. Diese soll ein einfaches SemesterProjekt sein.“ Dazu Rezeptarchiv und Inventurliste als Must-haves.
- „Kann man es nicht so festsetzen, dass immer Zutaten vorgeschlagen werden, die der Nutzer dokumentiert hat?“

**Ergebnis:** Produktidee „Rezepte mit dem, was du daheim hast“, User Stories mit Akzeptanzkriterien, funktionale und nichtfunktionale Anforderungen, MVP-Abgrenzung, später Personas und Anwendungsfälle.

**Was wir geändert haben**
- Die AI empfahl einen **festen Zutatenkatalog** mit rund 50 Zutaten. Der Nutzer schlug stattdessen einen **mitwachsenden Katalog** vor, weil jeder andere Zutaten verwendet. Die AI ergänzte Duplikatprüfung, Pluralformen als Einschränkung und die Aufteilung in Must, Should und Could. Später am selben Tag kehrte der Nutzer für den MVP zum **festen Katalog** zurück: Das Team stellt einen großen Zutaten-Datensatz zusammen, gegebenenfalls aus einer externen Quelle; eigene Zutaten werden Should.
- Die ersten AI-Personas („Studierende“, „Person ohne Verschwendung“) waren dem Nutzer zu vage. Daraus wurden drei ausführliche Personas.
- Der erste Vorschlag mit drei Anwendungsfällen ließ sieben Stories ohne Zuordnung; nach genauerer Prüfung wurden es fünf.

## 2 · Anforderungen prüfen

**Ausgewählte Prompts**
- „Prüfe `requirements.md` und `mvp.md`.“ (07.11.2026, zweites Werkzeug als unabhängige Meinung)
- „Kannst du die Requirements dir nochmal anschauen und nach professionellem Standard bewerten, als wärst du ein Senior Product Owner?“
- „Alle Requirements sind nach dem besten Stand geschrieben?“

**Ergebnis:** uneinheitliche Begriffe (daraus entstand das Glossar), zu viele Musts, zu große Stories, subjektive und nicht messbare Kriterien, fehlender Nutzungskontext, ungeklärte Sonderfälle. Alle Befunde und ihre Umsetzung stehen unten in [Befunde der AI-Prüfungen](#befunde-der-ai-prüfungen).

**Was wir geändert haben**
- Suche von Must auf Should, Leistungsziele je Story aufgeteilt und als Should eingestuft.
- Große Stories aufgeteilt, alle Akzeptanzkriterien im Format Gegeben/Wenn/Dann.
- In zwei Durchgängen aus Sicht eines Developers geprüft: Lücken bei Mengenformat, Sortierung, Speichern, Zutatenvorschlägen und Matching-Anzeige sowie ein Widerspruch zur Sicherheitsabfrage geschlossen.
- Nicht übernommen: Gespräche mit echten Nutzern. Das bleibt eine bekannte Lücke.

## 3 · Architektur und Design (Phase 2)

**Ausgewählte Prompts**
- „Schau dir vor allem die Kursvorgaben an – und was noch für Phase 2 aussteht“, dazu mehrere Agents, die sich nicht in die Quere kommen.
- „Gerne in den verschachtelten Chats einen AUDIT starten oder an sich irgendwie eine Überprüfung.“

**Einsatz:** Alternativen vorschlagen (Architekturvarianten V1 bis V3, drei Stacks, neun Hosting-Optionen), Entwürfe erstellen (Komponenten, [Datenmodell](datenmodell.md), [API](api.md)) und Schwachstellen suchen (Risiko-Review, Audit auf Over-Engineering, Gegen-Audit über Kreuz zwischen drei parallelen Sitzungen).

**Kritisch hinterfragte AI-Empfehlungen** (Details in der verlinkten Datei)

| AI-Empfehlung | Was daraus wurde | Wo |
| --- | --- | --- |
| PWA ohne Server, bevor die Kenntnisse des Teams bekannt waren; Server-Variante fehlte | Zurückgewiesen; Vergleich neu in drei Ebenen, Client-Server mit Konten vom Nutzer gewählt | [architecture.md](architecture.md#kritische-bewertung-der-ai-beiträge), [ADR-0002](adr/0002-architekturstil-client-server.md) |
| ASP.NET Core, obwohl niemand C# angegeben hatte | Nach Rogers Kenntnissen Spring Boot mit Vue; gilt erst mit den Kenntnissen der anderen (T3, T4) | [ADR-0003](adr/0003-technologie-stack.md#kritische-prüfung-der-ai-empfehlung) |
| Preise und Angebote beim Hosting | Sechs Aussagen widerlegt oder korrigiert | [hosting.md](hosting.md#kritische-prüfung-der-ai-empfehlungen) |
| Mehrere Technik-ADRs, Infrastruktur nach ADR-0001 | Ein ADR-0003; Leitlinie „bewusst einfach“ | [architecture.md](architecture.md#leitlinie-bewusst-einfach) |
| Modulregel „kein Modul liest Tabellen eines anderen“ | Im Gegen-Audit als zu streng befunden, gelockert | [architecture.md](architecture.md#komponenten-und-verantwortlichkeiten) |
| Angemeldet bleiben bis zur Abmeldung (US-24 AK 4) | Von Roger auf 30 Minuten nach der letzten Nutzung festgelegt (T10) | [teamfragen.md](teamfragen.md) |

**Lehre:** AI schlägt Architektur und Technik bereitwillig vor, kennt aber weder die Kenntnisse des Teams noch verlässliche Preise. Brauchbar wurden die Ergebnisse erst durch Prüfung gegen Kursvorgaben, Anforderungen und Anbieterseiten und durch eine zweite Sitzung, die gegenprüfte. Entscheiden muss das Team; offen ist, was in [teamfragen.md](teamfragen.md) steht.

## Kritische Bewertung (Phase 1)

- **Nützlich:** AI übersetzt eine grobe Idee schnell in überprüfbare Anforderungen und findet Begriffsfehler und Widersprüche zuverlässig.
- **Entscheidende Ideen kamen vom Team:** Den mitwachsenden Katalog (später für den MVP zurückgenommen) und zusammengesetzte Rezepte (daraus US-16) brachte der Nutzer ein. Die AI fragte nach dem Nutzungskontext; Smartphone und Offline-Nutzung hat der Nutzer entschieden. Statt der AI-Idee, fehlende Zutaten einzeln in den Vorrat zu übernehmen, schlug der Nutzer eine Einkaufsliste zum Abhaken während des Einkaufs vor (US-20).
- **AI geht zu weit:** Sie empfahl früh Technik und ein Grundgerüst, also Arbeit aus späteren Phasen. Das wurde zurückgenommen und als Projektregel festgehalten.
- **AI geht unsauber mit Begriffen um:** Sie behandelte „Zutatenkatalog“ als Synonym für „Zutatenliste“ und nannte die Akzeptanzkriterien „Szenario“ (Begriff aus BDD), obwohl die Aufgabe „Akzeptanzkriterien“ verlangt. Beides bemerkte der Nutzer. Fachbegriffe legt das Team fest.
- **AI-Ergebnisse brauchen Kontrolle:** Die Zahlen im README stammen aus einer AI-Websuche, ohne dass die AI die Seiten geöffnet hat; der Nutzer hat alle drei Quellen am 09.11.2026 geprüft. Das erste Developer-Review übersah bei US-11 denselben Formfehler, den es bei US-19 fand. Ein einzelner AI-Durchgang reicht nicht als Prüfung.
- **Grenzen:** AI kennt weder Zeitrahmen noch Erfahrung des Teams und keine Kursvorgaben. Es gab keine Nutzerinterviews, Implementierung oder Tests; die gemeinsame Teamprüfung stand zu diesem Zeitpunkt aus (erfolgt am 13.11.2026).

## Befunde der AI-Prüfungen

Befunde aus den AI-Prüfungen vom 14.10., 07.11. und 09.11.2026 und wie das Team sie umgesetzt hat. Überholte Befunde bleiben zur Nachvollziehbarkeit stehen.

| Befund | Bewertung und Korrektur |
| --- | --- |
| Suche war Must, obwohl der Kernablauf über das Rezeptarchiv möglich ist. | US-07 und FR-04 auf Should gesetzt; MVP entsprechend angepasst. |
| Produktabnahme und Phase-1-Abschluss waren vermischt. | Separate Definition of Done für die Spezifikation ergänzt; App-Tests sind erst später auszuführen. |
| Technische Vorbereitung wurde zu früh empfohlen. | Technologieauswahl und Architektur auf Phase 2 verschoben; keine Implementierungsarbeiten in Phase 1. |
| Ein Zutatenkatalog begrenzt die erfassbaren Lebensmittel. | **Wieder aktuell (09.11.2026):** Nach einem Zwischenstand mit mitwachsendem Katalog (letzte Zeile dieser Tabelle) gilt im MVP wieder ein fester Katalog. Dafür wird gegebenenfalls eine externe Quelle für einen großen Zutaten-Datensatz benötigt; die Begrenzung ist als Einschränkung dokumentiert, eigene Zutaten sind Should (US-17, US-18). Quelle und Umfang sind offen. |
| Die Leistungsgrenze war ein AI-Vorschlag ohne Teamvalidierung. | **Aktualisiert (09.11.2026):** Aufgeteilt in NFR-02, NFR-07 und NFR-08 mit gemeinsamem Referenzdatensatz; alle drei sind Should. Vom Team am 13.11.2026 bestätigt. |
| Externe Abhängigkeiten und Kosten waren nicht explizit behandelt. | Der MVP verlangt keine externen APIs oder kostenpflichtigen Dienste. Falls später welche gewählt werden, sind Verfügbarkeit, Kosten und Abhängigkeiten zu dokumentieren. |
| Manche Texte waren unklar, Begriffe waren inkonsistent. | Review durch AI und manuelles Review; verständlichere, konsistente Formulierungen und Abschnitt „Begriffe“ ergänzt. |
| Ein vorgegebener Zutatenkatalog verhindert eigene Rezepte mit Zutaten, die nicht im Katalog stehen; damit scheitert der Kernablauf für diese Nutzer. | **Überholt (09.11.2026):** Rückkehr zum festen Katalog, siehe oben. Ursprünglicher Vorschlag aus dem Team: Der Zutatenkatalog wächst mit den Eingaben des Nutzers (US-13, Must). Komfortfunktionen sind Should bzw. Could (US-14, US-15). Der feste Katalog entfällt, die Anzahl der Must-Anforderungen bleibt bei den funktionalen Anforderungen gleich. Teamentscheidung ausstehend. |

## Protokoll

Jeder AI-Einsatz mit Datum, Werkzeug, Aufgabe und menschlicher Entscheidung.

<details>
<summary><strong>Protokoll anzeigen (33 Einträge)</strong></summary>

| Datum | Werkzeug | Aufgabe | Ergebnis / menschliche Entscheidung |
| --- | --- | --- | --- |
| 14.10.2026 | Codex im Chat | Teamangaben und Projektidee | Teamnamen im README, nur Vornamen. Idee „Rezepte mit dem, was du daheim hast“ vom Nutzer angenommen. |
| 14.10.2026 | Codex im Chat | Phase-1-Dokumente erstellen | README, Anforderungen, MVP und Reflexion erstellt; laufende Pflege als Projektregel. |
| 14.10.2026 | Codex im Chat | Spezifikation gegen die Kursvorgaben prüfen | Suche auf Should gesetzt, Phase-1- und Produktabnahme getrennt, Kataloglücke und unbestätigtes Leistungsziel ausgewiesen. |
| 07.11.2026 | Claude (Sonnet 5.5) im Chat | `requirements.md` und `mvp.md` prüfen (zweites Werkzeug) | Uneinheitliche Begriffe, „Matching“ ohne Definition, widersprüchlicher Demo-Schritt; überwiegend übernommen. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Abgleich mit Moodle, Glossar erweitern | Glossar ergänzt, Restinkonsistenzen und Tippfehler behoben. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Zutatenkatalog und Leistungsziele | AI empfahl einen festen Katalog mit rund 50 Zutaten; der Nutzer wählte einen mitwachsenden (US-13 bis US-15). NFR-02 je Story aufgeteilt (NFR-02, -07, -08), auf AI-Rat Should. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Review als Senior Product Owner | Nutzer entschied Smartphone als Hauptgerät, Offline und Sonderfälle; AI-Personas waren zu vage, daraus drei Personas. US-16 kam vom Nutzer. |
| 09.11.2026 | Google Gemini; Claude (Opus 5.5) im Chat | Logo und Maskottchen | Drei Entwürfe in `branding.md`; AI markierte Namenskonflikte. Nicht im MVP. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Gesamtreview und Anwendungsfälle | Formatfehler und veraltete Listen behoben; die Quellen prüfte der Nutzer selbst. Fünf statt drei Anwendungsfälle, damit jede Story zugeordnet ist. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Darstellung und Kompaktheit (mehrere Durchgänge) | Story Map, aufklappbare Stories, Protokoll zugeklappt; der Nutzer lehnte mehrere Stilvorschläge ab. Keine Anforderung geändert. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Selbstkritik der Anforderungen | Stories aufgeteilt, alle AK als Gegeben/Wenn/Dann, NFR-10 ergänzt. Nicht übernommen: Gespräche mit echten Nutzern. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Teamfreigabe eintragen; „Szenario“ korrigieren | Die Freigabe wurde zurückgenommen, weil die Prüfung erst in der Lehrveranstaltung stattfand. **AI-Fehler:** AK als „Szenario“ bezeichnet, alle 38 umbenannt. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Zwei Developer-Reviews | Drei Lücken, danach zehn offene Fragen; einen Formfehler (US-11) hatte die AI beim ersten Mal übersehen. Der Nutzer ergänzte US-20 bis US-22 (Could). |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Audit des Projekts | Kein inhaltlicher Befund, fünf Kleinigkeiten behoben. |
| 09.11.2026 | Codex im Chat | ADR-Vorlage und ADR-0001 | Manuel gab Infrastruktur als Code und manuelle Freigabe vor; Codex verglich Optionen. Bedingter Vorschlag. |
| 09.11.2026 | Codex im Chat | CI und Ruleset | Prüfung der Pflichtdokumente in GitHub Actions; Ruleset als Vorlage. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Offene Punkte: Katalog, Offline, Leistungsziele | Der Nutzer kehrte zum festen Katalog zurück (Quellen von der AI nicht geprüft) und schlug Konten vor, am 12.11. zurückgenommen. Referenzdatensatz angepasst. |
| 12.11.2026 | Claude (Opus 5.5) im Chat | Abgleich nach parallelem Push; Sonderfälle und Risiken | Verlorene Änderungen neu eingespielt; wegen des Widerspruchs zu ADR-0001 blieb Offline Must, ohne Konten. Zwei Risiken ergänzt. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Offene Punkte abschließen; Phase 1 bestätigt | AI trennte, was nur das Team klären kann; die Bestätigung des Teams meldete der Nutzer. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Kursvorgaben dokumentieren | Phase 1 und 2 in `kursvorgaben.md`; fehlende Phase-2-Deliverables benannt. |
| 13.11.2026 | Claude (Opus 5.5) mit Websuche | Aufräumen, AGENTS.md, Best Practices | Direkt auf `main` bis App-Code, `CLAUDE.md` importiert `AGENTS.md`, drei Skills als Vorschlag. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Konsistenzprüfung, Phase 2 freigeben | Skill „doku-konsistenz“ ohne Befund; der Nutzer gab Phase 2 frei. |
| 13.11.2026 | Claude (Opus 5.5) mit Websuche | Architekturvarianten | Den ersten Entwurf (nur Plattformen, ohne Server, PWA empfohlen) wies der Nutzer zurück; Neuaufbau in drei Ebenen. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Scope-Änderung zu Client-Server mit Konten | Entscheidung des Nutzers; AI lehnte ab, sie als Teamfreigabe einzutragen. Daraus ADR-0002 mit Einwandfrist bis 15.11. und US-23 bis US-28. |
| 13.11.2026 | Claude (Opus 5.5) mit Websuche | Hosting vergleichen | Zehn Optionen; sechs AI-Aussagen widerlegt, darunter Preise und eine erfundene Behauptung. Vorschlag Azure-Guthaben, Teambestätigung offen. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Export, lokale Kopie, EU-Recht | US-29 und US-30 für später; nach der EU-Prüfung US-26 Must und US-31 neu. Keine Rechtsberatung. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | `architecture.md` kürzen, Diagramme | Von 134 auf 70 Zeilen; Diagramme gerendert und korrigiert. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Umfang und Over-Engineering prüfen | Der Nutzer entschied: Katalog von Hand, Leitlinie „bewusst einfach“, Priorität „Später“. Ein ADR-0003 statt mehrerer; ADR-0001 unberührt. |
| 13.11.2026 | Claude (Opus 5.5), drei parallele Sitzungen | Datenmodell, API, ADR-0003, Komponenten, Risiken | ADR-0003 empfahl zuerst C#, obwohl niemand im Team C# angegeben hatte. Das Gegen-Audit fand fünf mittlere Befunde, darunter Sitzungen nach der Kontolöschung; alle korrigiert. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Doku kürzen, Teamfragen sammeln | Regel „jedes Thema an einer Stelle“; `teamfragen.md` mit 15 Fragen, Rogers Antworten eingearbeitet. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Kursvorgaben-Check, AI-Einsatz der Phase 2 | Abschnitt 3 ergänzt; offen bleiben die Teamentscheidungen. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Projektablauf, GitHub-Issues | 14 Story-Issues und ein Issue für Teamentscheidungen; ein Board unter Rogers Konto ließ sich nicht verknüpfen und wurde gelöscht. |
| 13.11.2026 | Claude (Opus 5.5) im Chat | Protokoll kürzen | Von 55 Zeilen mit rund 4.700 Wörtern auf 33 kurze Zeilen; Regel für kompakte Einträge. |
</details>

Bewährte Prompts für wiederkehrende Aufgaben liegen als Skills unter [`.agents/skills/`](../.agents/skills/): [Anforderungen prüfen](../.agents/skills/anforderungen-pruefen/SKILL.md), [Dokumentation auf Konsistenz prüfen](../.agents/skills/doku-konsistenz/SKILL.md) und [ADR anlegen](../.agents/skills/adr-anlegen/SKILL.md). Sie sind Vorschläge und werden wie Code über Änderungen im Repository verbessert.

Bei weiterem AI-Einsatz ergänzen wir eine Zeile pro Aufgabe oder Sitzung, nicht pro Arbeitsschritt, mit höchstens zwei Sätzen: AI-Beitrag und menschliche Entscheidung. Details stehen in den Dateien und in der Git-History. Nicht übernommene Vorschläge halten wir mit Begründung fest. Personenbezogene Daten und Zugangsdaten gehören nicht in AI-Eingaben.
