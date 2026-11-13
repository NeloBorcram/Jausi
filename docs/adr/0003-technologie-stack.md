---
status: "vorgeschlagen"
datum: "2026-11-13"
entscheidende: []
einbezogen: ["Roger"]
informiert: []
---

# ADR-0003: Technologie-Stack für Oberfläche, Backend, Datenbank und Anmeldung

> [!IMPORTANT]
> **Vorschlag, mit AI (Claude, Opus 5.5) erarbeitet, keine Teamfreigabe.** Bekannt ist bisher nur Rogers Selbsteinschätzung; die Empfehlung gilt erst, wenn Manuela, Alex und Manuel ihre Kenntnisse angegeben haben. Entscheidung vor dem 23.11.2026.

## Kontext und Fragestellung

[ADR-0002](0002-architekturstil-client-server.md) legt eine Client-Server-Web-App mit Konten fest. Zu entscheiden ist **ein** zusammenhängender Stack: Oberfläche, Backend, Datenbank und Anmeldebaustein. Er muss [api.md](../api.md) und [datenmodell.md](../datenmodell.md) umsetzen und der Leitlinie „bewusst einfach“ folgen ([architecture.md](../architecture.md#leitlinie-bewusst-einfach)). Bis zum Start der Umsetzung am 23.11.2026 bleiben 10 Tage, die Umsetzung dauert etwa 16 Tage. Hosting ([hosting.md](../hosting.md)) und Release-Ablauf ([ADR-0001](0001-infrastruktur-und-release.md)) sind nicht Teil dieser Entscheidung.

## Kenntnisse im Team

Selbsteinschätzungen; die AI trägt nichts ein.

| Person | Angegebene Kenntnisse |
| --- | --- |
| Roger | Python, Clojure, Vue, Electron, Spring Boot, TypeScript, Gleam, Java (13.11.2026) |
| Manuela, Alex, Manuel | offen |

## Entscheidungskriterien

- **NFR-01:** Smartphone-Browser auf Android und iPhone; Zutatenvorschläge beim Tippen (US-13).
- **NFR-05:** Matching als reine Logik mit automatisierten Tests.
- **NFR-06:** Passwort-Hashing, Sitzung und CSRF-Schutz vom Framework statt selbst zusammengesetzt.
- **Kenntnisse und Lernaufwand:** Der Kurs verlangt Technologien, die das Team versteht.
- **Ein Programm** liefert Oberfläche und API aus; läuft auf Azure App Service laut Hosting-Vorschlag.

## Erwogene Optionen

Allen gemeinsam: **PostgreSQL** (im Hosting-Vorschlag in der EU verfügbar, lokal einfach zu starten) und eine Oberfläche, die Vite zu statischen Dateien baut und das Backend mit ausliefert.

| Option | Spricht dafür | Spricht dagegen |
| --- | --- | --- |
| **A · C# / ASP.NET Core** mit Identity | Anmeldung, Hashing, CSRF und Sperre nach Fehlversuchen fertig im Framework | Niemand hat C# angegeben. Die Variante mit Razor Pages wäre noch einfacher, hätte aber keine eigenständige API nach [api.md](../api.md). |
| **B · Java / Spring Boot** mit Spring Security und Spring Data JPA | Roger nennt Java und Spring Boot; Hashing, Sitzung und CSRF vom Framework; Konto bleibt eine eigene Tabelle | Für eine JSON-API braucht Spring Security eigene Konfiguration; JVM braucht mehr Speicher; zwei Toolchains (Java und npm) |
| **C · TypeScript / Node** mit einer Anmeldebibliothek | Eine Sprache für alles; Roger nennt TypeScript | Kein Anmeldebaustein im Framework: Bibliothek selbst wählen und zusammensetzen, größtes NFR-06-Risiko, widerspricht der Leitlinie |

**Oberfläche:** **Vue mit TypeScript** (Roger nennt Vue, gilt als leichter zu lernen) oder **React** (verbreiteter, aber von niemandem genannt; Verbreitung allein ist laut Kurs kein Grund).

## Entscheidung und Begründung

**Empfehlung: B mit Vue**, unter Vorbehalt der fehlenden Kenntnisse. Spring Boot als ein Programm mit JSON-API, Vue-Oberfläche aus demselben Artefakt, Spring Security mit Sitzungscookie, PostgreSQL, Schema und Zutatenkatalog als versionierte Migrationen, Matching als eigenes Modul ohne Abhängigkeit zu Spring.

- **Kenntnisse:** Einzige Option, deren Backend, Anmeldung und Oberfläche alle in der bekannten Einschätzung vorkommen.
- **NFR-06:** Sicherheitsbausteine kommen aus einem Framework; das erfüllt die Leitlinie, C nicht.
- **NFR-05:** Ein eigenes Build-Modul für das Matching erzwingt die Trennung.

**Wann die Empfehlung kippt:** Kann außer Roger niemand Java, aber mehrere TypeScript → **C mit Vue**. Können mehrere C# → **A mit Vue** neu bewerten. Kennen die anderen React statt Vue → **React**.

## Folgen

- **Einfacher:** ein Repository, ein Artefakt, ein Deployment.
- **Aufwand vor den ersten Stories:** Spring Security für die JSON-API einrichten (Anmeldung per JSON, `401` statt Weiterleitung, CSRF-Cookie, Anmeldung über Neustarts hinaus nach US-24 AK 4). Die Details gehören in Phase 3.
- **Infrastruktur:** Node 22 auf `develop` war keine Vorentscheidung; die Laufzeit folgt dem gewählten Stack.
- **Hosting:** Ob der Gratistarif für die JVM reicht, ist offen ([hosting.md](../hosting.md)).
- **Risiko:** Wer Java oder Vue neu lernt, ist anfangs langsamer. Gegenmaßnahme: erste Stories in Paaren mit Roger.

## Bestätigung

- Das Matching-Modul hat keine Abhängigkeit zu Spring oder Datenbank; seine Tests laufen ohne Datenbank (NFR-05).
- Ein Test mit zwei Konten zeigt, dass keines die Daten des anderen sieht (NFR-06).
- Nach einem Neustart bleibt eine Person angemeldet (US-24 AK 4).
- Ein Artefakt liefert Oberfläche und API aus.

## Kritische Prüfung der AI-Empfehlung

- Der erste AI-Entwurf empfahl ASP.NET Core, obwohl niemand C# angegeben hatte; erst Rogers Angaben korrigierten das.
- Die neue Empfehlung stützt sich auf eine von vier Personen, und zwar auf die, die mit der AI arbeitet. Können die anderen kein Java, trägt Roger das Backend allein.
- Für C spricht mit TypeScript ernsthaft viel; dass eine selbst gewählte Anmeldebibliothek riskanter ist, kann die AI nicht belegen.

## Offene Fragen

Offen sind T3 und T4 in [teamfragen.md](../teamfragen.md). Neu bewerten, sobald die Kenntnisse vorliegen oder das Hosting nicht Azure App Service wird.

## Referenzen

- [Spring Security: CSRF](https://docs.spring.io/spring-security/reference/servlet/exploits/csrf.html) · [Spring Session](https://docs.spring.io/spring-session/reference/) · [Vue.js](https://vuejs.org/guide/introduction.html) · [ASP.NET Core Identity](https://learn.microsoft.com/en-us/aspnet/core/security/authentication/identity)
