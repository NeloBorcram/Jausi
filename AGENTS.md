# Projektanweisungen für Jausi

- Erstelle oder ändere Git-Commits nur auf ausdrücklichen Auftrag des Nutzers. Ein Auftrag gilt für die konkret angeforderte Aktion und ist keine dauerhafte Commit-Erlaubnis. Änderungen bleiben ansonsten uncommitted.
- Halte `README.md`, `docs/requirements.md`, `docs/mvp.md`, `docs/ai-usage.md` und `docs/personas.md` dauerhaft vorhanden und aktuell.
- Prüfe bei jeder Aufgabe alle fünf Dokumente. Aktualisiere betroffene Inhalte im selben Änderungssatz; vermeide inhaltslose Änderungen an unveränderten Dokumenten.
- Lege zusätzliche Projektdokumentation immer in `docs/` ab. `README.md` und diese Projektanweisungen bleiben im Repository-Stamm.
- Schreibe Projektdokumentation auf Deutsch.
- Das Team besteht aus vier Personen. Plane einen kleinen, realistischen Semesterprojekt-MVP.
- Team: Manuela, Alex, Manuel und Roger. Verwende ausschließlich Vornamen. Die zugehörigen E-Mail-Adressen stehen im README.
- Die Aufgabenstellungen des Kurses stehen zusammengefasst in `docs/kursvorgaben.md`. Richte Inhalte und Deliverables einer Phase danach aus und ergänze die Datei, sobald weitere Phasen veröffentlicht sind; maßgeblich bleibt Moodle.
- Phase 1 (Projektdefinition und Requirements) ist abgeschlossen und vom Team bestätigt. Phase 2 (Architecture & Design) ist seit 13.11.2026 freigegeben: Architekturvarianten, Technologieauswahl, Architekturdiagramm, Datenmodell, API-Design, ADRs und Hosting gemäß `docs/kursvorgaben.md`. Die Architektur muss die Anforderungen aus Phase 1 unterstützen. Arbeite nicht an Implementierung oder Testausführung vor. Beginne Phase 3 erst nach ausdrücklichem Auftrag des Nutzers; ein Kalenderdatum oder ein in Moodle freigeschalteter Abschnitt allein ist keine Freigabe.
- Git-Ablauf: Solange nur Dokumentation entsteht, wird direkt auf `main` gearbeitet. Sobald App-Code entsteht, gilt der Ablauf mit Branch, Pull Request und Review aus `docs/github-workflow.md`.
- Feste Prompts für wiederkehrende Aufgaben liegen als Skills unter `.agents/skills/` (offener Standard „Agent Skills“). Passt eine Aufgabe zu einem Skill, lies dessen `SKILL.md` und folge ihm. Die Skills sind Vorschläge; das Team kann sie anpassen.
- Behalte Mengenvergleich, automatische Verbrauchsbuchung und AI-Rezeptgenerierung außerhalb des MVP, solange das Team keine dokumentierte Scope-Änderung beschließt.
- Dokumentiere tatsächlichen AI-Einsatz und offene Entscheidungen ehrlich. Erfinde keine Teamfreigaben, Tests oder implementierten Funktionen.
- Dokumentiere folgenreiche Architektur-, Infrastruktur- und Deploymententscheidungen vor ihrer Umsetzung mit der Vorlage unter `docs/adr/adr-template.md`. Führe vorgeschlagene Entscheidungen in `docs/adr/README.md`; markiere sie erst nach tatsächlicher Teamfreigabe als angenommen.
