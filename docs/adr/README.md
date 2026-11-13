# Architekturentscheidungen (ADRs)

Ein ADR hält eine folgenreiche Entscheidung, ihre Alternativen und ihre Begründung fest. Vor der Umsetzung einer solchen Entscheidung wird ein ADR nach der [Jausi-Vorlage](adr-template.md) angelegt. Das gilt insbesondere für Plattform, Datenspeicherung, externe Abhängigkeiten, Infrastruktur und Deployment.

1. Die Vorlage nach `docs/adr/NNNN-kurztitel.md` kopieren und die nächste freie Nummer wählen. Pro ADR eine Entscheidung oder eine eng zusammengehörige Gruppe von Entscheidungen dokumentieren.
2. Als `vorgeschlagen` einreichen. Betroffene Anforderungen, Alternativen, Risiken und überprüfbare Bestätigung nennen. Die Umsetzung wartet auf die Teamentscheidung.
3. Nach der Prüfung Status, Datum und tatsächliche Entscheidende eintragen. Bei einer späteren Änderung einen neuen ADR anlegen und den alten als `ersetzt` kennzeichnen; beide miteinander verlinken.

| ADR | Entscheidung | Status |
| --- | --- | --- |
| [0001](0001-infrastruktur-und-release.md) | Infrastruktur als Code und kontrollierte Releases | Vorgeschlagen |
| [0002](0002-architekturstil-client-server.md) | Client-Server-Web-App mit Konten statt rein lokaler App | Vorgeschlagen, gilt ohne Einwand ab 15.11.2026 |
