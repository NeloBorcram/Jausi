---
status: "vorgeschlagen"
datum: "2026-11-23"
entscheidende: []
einbezogen: ["Manuel"]
informiert: []
---

# ADR-0004: Ausführbare Spring-/Vue-Basis und Azure-Dummy

## Kontext und Fragestellung

Manuel beauftragt am 23.11.2026 ausdrücklich den Beginn von Phase 3 mit Java/Spring Boot und Vue, lokal startbar und für Azure vorbereitet. Die Grundlage folgt ADR-0002/0003 und NFR-05/06; sie implementiert noch keine Must-Story und keine Anmeldung.

## Entscheidungskriterien

Ein Programm, wenig Betrieb, nachvollziehbare Builds, keine offenen Fach-APIs und keine Zugangsdaten im Repository.

## Erwogene Optionen

| Option | Vorteil | Nachteil |
| --- | --- | --- |
| Ausführbares JAR mit eingebauter Vue-Oberfläche auf App Service B1 | Ein Artefakt; einfache ZIP-Bereitstellung, eigene Domain möglich | Laufende Kosten auch ohne Zugriffe; keine Slots |
| Separate statische Oberfläche und API | Getrennte Auslieferung | Zwei Deployments und zusätzliche Cookie-/Origin-Konfiguration |
| App Service S1 mit Slots | Echter Slot-Tausch | Für das Semesterbudget zu teuer |

## Entscheidung und Begründung

Vorbereitung eines Java-21-/Spring-Boot-JARs mit Vue/TypeScript. Bicep beschreibt einen kostenlosen F1-Plan oder optional B1 mit zwei getrennten Apps für Staging und Produktion; beide teilen Ressourcen. Releases bauen einmal, testen Staging und warten vor Produktion auf Freigabe. Dies konkretisiert Manuels Wunsch ohne Slot-Tausch; die Teamentscheidung zu Hosting bleibt T6/T7.

## Folgen

PostgreSQL wird lokal in Compose vorbereitet, für die Dummy-Seite aber nicht benötigt. Framework-Security sperrt Fach-API-Pfade; nur die technische Health-Abfrage und statische Oberfläche sind öffentlich. OIDC ist für GitHub-zu-Azure vorgesehen, keine Benutzeranmeldung.

## Bestätigung

Backend-, Frontend-Prüfungen und lokaler JAR-Smoke-Test bestanden; Azure-Plan kompiliert, die Bereitstellung ist durch App-Service-Quote 0 blockiert (T7). Bereitstellungsergebnisse stehen in der Implementierungsdokumentation; keine Teamfreigabe wird angenommen.

## Erneute Prüfung und Referenzen

Bei Datenbankanbindung, Stackwechsel oder Budgetänderung prüfen. [Spring Boot](https://docs.spring.io/spring-boot/) · [Vue](https://vuejs.org/guide/quick-start.html)
