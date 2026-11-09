# AI-Einsatz und Reflexion

## Zweck

AI wird zur Strukturierung der Idee, Anforderungsanalyse und Prüfung auf Unklarheiten eingesetzt. Eine AI-Funktion im Produkt ist für den MVP nicht vorgesehen. Das vierköpfige Team bleibt für Scope, fachliche Entscheidungen und Qualität verantwortlich.

## Tatsächlicher Einsatz

| Datum | Werkzeug | Aufgabe | Ergebnis / menschliche Entscheidung |
| --- | --- | --- | --- |
| 14.10.2026 | Codex im Chat | Vom Nutzer bereitgestellte Teamangaben dokumentieren und die Namenskonvention anwenden. | Manuela, Alex, Manuel und Roger im README ergänzt; ausschließlich Vornamen gemäß Nutzerwunsch. Anforderungen und MVP bleiben unverändert. |
| 14.10.2026 | Codex im Chat | Aus Vorratsliste und Rezeptarchiv eine einfache App-Idee und Use Cases entwickeln. | Vorschlag „Rezepte mit dem, was du daheim hast“; der Nutzer hat das Konzept angenommen. |
| 14.10.2026 | Codex im Chat | Die vier Phase-1-Dokumente erstellen und fortlaufende Dokumentationspflege als Projektregel festhalten. | Projektüberblick, priorisierte Stories mit Akzeptanzkriterien, Anforderungen, MVP und Reflexion erstellt. Gemeinsame Teamprüfung steht aus. |
| 14.10.2026 | Codex im Chat | Bestehende Spezifikation anhand der vollständigen Kursvorgaben auf Widersprüche, Lücken, unnötige Musts und Vorarbeit prüfen. | Suche zu Should verschoben, Phase-1- und Produktabnahme getrennt, fachliche Kataloglücke und unbestätigtes Leistungsziel ausgewiesen sowie externe Abhängigkeiten berücksichtigt. Nutzer begrenzt die Arbeit ausdrücklich auf Phase 1; Teamprüfung der Korrekturen bleibt offen. |
| 07.11.2026 | Claude (Sonnet 5.5) im Chat | `requirements.md` und `mvp.md` auf sprachliche Fehler, inkonsistente Begriffe, Widersprüche und Lücken prüfen | Befunde u. a.: unklare Formulierungen (z. B. „Daten erhalten“, „Inventur“), uneinheitliche Begriffe (Zutatenkatalog/Zutatenliste, Vorrat/Vorratsliste/Bestand), „Matching“ ohne Definition, widersprüchlicher Demo-Schritt in `mvp.md`. Vorschläge geprüft und überwiegend übernommen |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Phase-1-Dokumente mit der Moodle-Aufgabe abgleichen; Glossar im Abschnitt „Begriffe“ erweitern | Befunde: Teamprüfung, Startumfang des Zutatenkatalogs und Leistungsziel offen; Restinkonsistenzen (FR-01 „Zutatenliste“, US-01 „Bestand“, „Daten erhalten“); Tippfehler; viele Must-NFRs. Glossar um Rezept, Rezeptarchiv, Fehlende Zutat, Favorit und Prioritätsstufen sowie ausgeschlossene Synonyme ergänzt. Restinkonsistenzen (Rezeptliste, Bestand, Lieblingsrezepte, Zutatenliste) auf Nutzerwunsch durch die definierten Begriffe ersetzt; „Bestandsführung“ als bewusste Abgrenzung belassen. Anschließend „Daten erhalten“ präzisiert, Tippfehler und zwei fehlerhafte Tabellenzeilen korrigiert. Teamprüfung steht aus. |
| 09.11.2026 | Claude (Opus 5.5) im Chat | Offenen Punkt „Startumfang des Zutatenkatalogs“ klären | AI empfahl zunächst einen festen Katalog mit ca. 50 Zutaten in sechs Kategorien. Der Nutzer schlug stattdessen einen mitwachsenden Katalog mit Vorschlägen aus bisherigen Eingaben vor und begründete die Priorität Must mit unterschiedlichen Vorlieben der Nutzer. AI ergänzte Duplikatprüfung, die bekannte Einschränkung bei Pluralformen und die Aufteilung in Must (US-13), Should (US-14) und Could (US-15). Als Vorschlag eingetragen; Teamentscheidung ausstehend. |

Damit sind zwei unterschiedliche AI-Anwendungen dokumentiert: **Generierung und Strukturierung von Anforderungen** sowie **kritische Validierung der Spezifikation**. Die Generierung und die erste Prüfung erfolgten mit Codex; die sprachliche und inhaltliche Nachprüfung am 07.11.2026 erfolgte mit einem zweiten Werkzeug (Claude) und diente zugleich als unabhängige zweite Meinung.

## Verwendete Eingaben

- „Wir wollen eine Jausi app machen. Diese soll ein einfaches SemesterProjekt sein.“
- Vorgaben: Rezeptarchiv und Inventurliste als Must-haves; Wunsch nach kombinierten Use Cases.
- Anschlussauftrag: Konzept übernehmen, vier Pflichtdokumente dauerhaft anlegen und aktualisieren; Teamgröße vier.
- Weitere Nutzereingabe: vollständige Phase-1-Aufgabenbeschreibung und Phasenplan sowie „Wir sind noch in der Phase 1!!!“ und „Also noch nicht vorarbeiten!!!“.
- Arbeitsauftrag für die AI-Prüfung, aus dieser Eingabe abgeleitet: Bestehende Dokumente mit den vollständigen Phase-1-Vorgaben abgleichen; Widersprüche, Lücken und überflüssige Musts identifizieren; die Spezifikation korrigieren und spätere Phasen klar abgrenzen.
- Prüfe `requirements.md` und `mvp.md`.
- „Was fehlt uns?“ zusammen mit der vollständigen Phase-1-Aufgabenbeschreibung (09.11.2026).
- „Haben wir bereits irgendwo eine Art Glossar? Um die einheitlichen Begriffe irgendwo zu dokumentieren?“
- „Kann man es nicht so festsetzen, dass immer Zutaten vorgeschlagen werden, die der Nutzer dokumentiert hat?“

Die vollständigen Phase-1-Vorgaben und Phasentermine wurden vom Nutzer im Chat bereitgestellt. Die verlinkte Moodle-Seite wurde nicht separat geprüft.

## Kritische Bewertung

- **Nützlich:** AI hat die grobe Idee in überprüfbare Anforderungen übersetzt und Vorrat und Rezepte durch ein einfaches Matching verbunden.
- **Scope begrenzt:** Einkaufsliste, Favoriten und Ablaufdaten erweitern den Aufwand. Sie wurden nicht in den MVP aufgenommen.
- **Unklarheit aufgelöst:** „Vorhanden“ prüft ausschließlich die Existenz einer Zutat. Mengen werden nicht verrechnet; die Oberfläche muss das kenntlich machen.
- **Datenkonsistenz:** Ein Zutatenkatalog mit genau einer Schreibweise je Zutat verhindert, dass unterschiedliche Schreibweisen den Vergleich verfälschen. Statt eines festen Katalogs schlägt das Team einen mitwachsenden Katalog mit Vorschlägen und Duplikatprüfung vor; Pluralformen bleiben eine dokumentierte Einschränkung.
- **Nutzeridee statt AI-Vorschlag:** Die AI hatte einen festen Katalog mit vorgegebenem Umfang empfohlen. Der mitwachsende Katalog kam vom Nutzer und passt besser zu einem persönlichen Rezeptarchiv. Die AI hat die Idee nicht selbst vorgeschlagen, aber ihre Risiken (Duplikate, Pluralformen) und eine sinnvolle Priorisierung ergänzt.
- **Grenzen:** AI kennt weder den verfügbaren Zeitrahmen noch die technische Erfahrung des Teams. Machbarkeit und vorgeschlagene Leistungsgrenze müssen vom Team geprüft werden.
- **Validierung offen:** Es wurden noch keine Nutzerinterviews, Implementierung oder App-Tests durchgeführt. Die Akzeptanz des Konzepts durch den Nutzer ersetzt keine gemeinsame Abnahme der gesamten Spezifikation.
- **AI-Empfehlung korrigiert:** Die frühere Empfehlung, Technik und ein Grundgerüst vorzubereiten, ging über die aktuelle Phase hinaus. Sie wurde nach der Nutzerklarstellung zurückgenommen und die Phasengrenze in den Projektanweisungen festgehalten.
- **Priorisierung korrigiert:** Suche nach Namen ist für den vollständigen Kernablauf nicht unverzichtbar und wurde von Must auf Should verschoben. Die acht verbleibenden Must-Stories beschreiben Vorrat, Rezeptverwaltung und Zutatenvergleich; mit dem vorgeschlagenen mitwachsenden Zutatenkatalog kommt US-13 als neunte hinzu.
- **Fachbegriff falsch gedeutet:** Die AI hat „Zutatenkatalog“ zunächst als Synonym für „Zutatenliste“ behandelt. Fachliche Begriffe müssen daher vom Team und nicht von der AI festgelegt werden.
- **Sprachliche Prüfung:** AI hat unklare und fehlerhafte Formulierungen sowie inkonsistente Begriffe zuverlässig gefunden. Das Kursvokabular und die Dozentenvorgaben kennt sie nicht; deren Einhaltung bleibt Aufgabe des Teams.
- **Nachvollziehbare Prüfung:** Einzelbefunde und Korrekturen stehen in [requirements.md](https://github.com/NeloBorcram/Jausi/blob/main/docs/requirements.md). Eine AI-Prüfung ersetzt keine unabhängige Bewertung durch die Studierenden.

## Fortlaufende Pflege

Bei weiterem AI-Einsatz werden Datum, Werkzeug, Aufgabe, Ergebnis und menschliche Prüfung ergänzt. Vorschläge werden anhand von Produktziel, Aufwand und Akzeptanzkriterien bewertet. Nicht übernommene Vorschläge und wesentliche Korrekturen werden mit ihrer Begründung festgehalten. Personenbezogene Daten und Zugangsdaten gehören nicht in AI-Eingaben.