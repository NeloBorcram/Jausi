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

Damit sind zwei unterschiedliche AI-Anwendungen dokumentiert: **Generierung und Strukturierung von Anforderungen** sowie **kritische Validierung der Spezifikation**. Dafür wurde dasselbe Werkzeug verwendet; die Vorgabe verlangt unterschiedliche Anwendungen, nicht ausdrücklich unterschiedliche AI-Tools.

## Verwendete Eingaben

- „Wir wollen eine Jausi app machen. Diese soll ein einfaches SemesterProjekt sein.“
- Vorgaben: Rezeptarchiv und Inventurliste als Must-haves; Wunsch nach kombinierten Use Cases.
- Anschlussauftrag: Konzept übernehmen, vier Pflichtdokumente dauerhaft anlegen und aktualisieren; Teamgröße vier.

- Weitere Nutzereingabe: vollständige Phase-1-Aufgabenbeschreibung und Phasenplan sowie „Wir sind noch in der Phase 1!!!“ und „Also noch nicht vorarbeiten!!!“.
- Arbeitsauftrag für die AI-Prüfung, aus dieser Eingabe abgeleitet: Bestehende Dokumente mit den vollständigen Phase-1-Vorgaben abgleichen; Widersprüche, Lücken und überflüssige Musts identifizieren; die Spezifikation korrigieren und spätere Phasen klar abgrenzen.

Die vollständigen Phase-1-Vorgaben und Phasentermine wurden vom Nutzer im Chat bereitgestellt. Die verlinkte Moodle-Seite wurde nicht separat geprüft.

## Kritische Bewertung

- **Nützlich:** AI hat die grobe Idee in überprüfbare Anforderungen übersetzt und Vorrat und Rezepte durch ein einfaches Matching verbunden.
- **Scope begrenzt:** Einkaufsliste, Favoriten und Ablaufdaten erweitern den Aufwand. Sie wurden nicht in den MVP aufgenommen.
- **Unklarheit aufgelöst:** „Vorhanden“ prüft ausschließlich die Existenz einer Zutat. Mengen werden nicht verrechnet; die Oberfläche muss das kenntlich machen.
- **Datenkonsistenz:** Eine gemeinsame Zutatenliste verhindert, dass unterschiedliche Schreibweisen den Vergleich verfälschen. Ihr konkreter Umfang ist noch offen.
- **Grenzen:** AI kennt weder den verfügbaren Zeitrahmen noch die technische Erfahrung des Teams. Machbarkeit und vorgeschlagene Leistungsgrenze müssen vom Team geprüft werden.
- **Validierung offen:** Es wurden noch keine Nutzerinterviews, Implementierung oder App-Tests durchgeführt. Die Akzeptanz des Konzepts durch den Nutzer ersetzt keine gemeinsame Abnahme der gesamten Spezifikation.
- **AI-Empfehlung korrigiert:** Die frühere Empfehlung, Technik und ein Grundgerüst vorzubereiten, ging über die aktuelle Phase hinaus. Sie wurde nach der Nutzerklarstellung zurückgenommen und die Phasengrenze in den Projektanweisungen festgehalten.
- **Priorisierung korrigiert:** Suche nach Namen ist für den vollständigen Kernablauf nicht unverzichtbar und wurde von Must auf Should verschoben. Die acht verbleibenden Must-Stories beschreiben Vorrat, Rezeptverwaltung und Zutatenvergleich.
- **Nachvollziehbare Prüfung:** Einzelbefunde und Korrekturen stehen in [requirements.md](requirements.md). Eine AI-Prüfung ersetzt keine unabhängige Bewertung durch die Studierenden.

## Fortlaufende Pflege

Bei weiterem AI-Einsatz werden Datum, Werkzeug, Aufgabe, Ergebnis und menschliche Prüfung ergänzt. Vorschläge werden anhand von Produktziel, Aufwand und Akzeptanzkriterien bewertet. Nicht übernommene Vorschläge und wesentliche Korrekturen werden mit ihrer Begründung festgehalten. Personenbezogene Daten und Zugangsdaten gehören nicht in AI-Eingaben.
