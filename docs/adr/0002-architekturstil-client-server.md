---
status: "vorgeschlagen"
datum: "2026-11-13"
entscheidende: []
einbezogen: ["Roger"]
informiert: ["Manuela", "Alex", "Manuel"]
---

# ADR-0002: Client-Server-Web-App mit Konten statt rein lokaler App

<!-- Stillschweigende Zustimmung: Vorschlag von Roger am 13.11.2026, das Team ist informiert.
Ohne Einwand bis 15.11.2026 gilt der ADR als angenommen; dann Status, Datum und Entscheidende aktualisieren. -->

> [!IMPORTANT]
> **Vorschlag mit stillschweigender Zustimmung:** Roger hat diese Entscheidung am 13.11.2026 vorgeschlagen und das Team informiert. Kommt bis **15.11.2026** kein Einwand, gilt sie als angenommen.

## Kontext und Fragestellung

Wo liegen Daten und Logik von Jausi, auf dem Gerät oder auf einem Server? Der Variantenvergleich steht in [architecture.md](../architecture.md). Phase 1 ging von einer rein lokalen App ohne Konten und mit Offline-Nutzung als Must aus (NFR-09). Langfristig soll Jausi auf mehreren Geräten mit denselben Daten nutzbar sein, zuerst im Browser des Smartphones, später als eigene App. Diese Entscheidung legt den Architekturstil fest. Sie entscheidet nicht über konkrete Technologien, Hosting-Anbieter oder die Art der Anmeldung.

## Entscheidungskriterien

- Bedienung auf Android und iPhone mit einer Codebasis (NFR-01).
- Daten bleiben erhalten und sind auf mehreren Geräten verfügbar (FR-06, NFR-03).
- Langfristige Erweiterbarkeit: eigene App, Synchronisierung, Statistik.
- Umsetzbar für vier Personen in einem Semester; Kenntnisse im Team: Web sowie Java oder C#.
- Echtes API-Design und Hosting als Lernziel der Phase 2.

## Erwogene Optionen

| Option | Vorteile | Nachteile / Risiken |
| --- | --- | --- |
| V1 · Rein lokal | Erfüllt Offline ohne Umweg, kein Serverbetrieb, keine personenbezogenen Daten. | Daten nur auf einem Gerät; Datenverlust bei Geräteverlust oder durch den Browser; kaum API-Design; ein späterer Wechsel zu Konten erfordert eine Datenübernahme. |
| V2 · Local-first mit Backend | Offline bleibt möglich; Katalog über eine API; Sicherung später möglich. | Zwei Datenhaltungen; Synchronisierung später aufwendig; für einen MVP mehr Komplexität als nötig. |
| V3 · Client-Server mit Konten | Daten auf dem Server, auf jedem Gerät verfügbar; ein Ort für Logik und Daten; vollständiges API-Design; passt zu ADR-0001 und zu den Kenntnissen des Teams. | Ohne Internet keine Nutzung im MVP; Konten bringen personenbezogene Daten und Sicherheitsanforderungen; Serverbetrieb und Kosten. |

## Entscheidung und Begründung

**Vorschlag: V3 · Client-Server mit Konten.** Jausi wird im MVP eine Web-App, die im Browser des Smartphones gut bedienbar ist. Daten und Matching liegen auf dem Server und sind einem Konto zugeordnet. Eine eigene App für Android und iPhone sowie Offline-Funktionen folgen nach dem MVP: eine lokale Kopie zum Lesen, auch bei Serverausfall (US-30, später), ein Export aller Daten (US-29, später) und die Einkaufsliste ohne Internet (US-28, später).

Begründung: V3 erfüllt das langfristige Ziel mit dem geringsten Umbau, nutzt die vorhandenen Kenntnisse und liefert das API-Design, das Phase 2 verlangt. Offline-Nutzung ist dafür im MVP kein Must mehr; das ist eine bewusste Scope-Änderung gegenüber dem Stand vom 13.11.2026.

Offen und gemeinsam in ADR-0003 „Technologie-Stack“ zu entscheiden: Technologien für Client und Server, Datenbank, Art der Anmeldung (Baustein des Frameworks oder externer Anbieter). Hosting (siehe [ADR-0001](0001-infrastruktur-und-release.md)).

## Folgen

- Anforderungen geändert: Konto-Stories US-23 bis US-26 (Konto löschen als Must wegen DSGVO), Datenschutzerklärung und Impressum US-31, Verbrauchsstatistik US-27, Offline-Einkaufsliste US-28, Export US-29 und lokale Kopie zum Lesen US-30; NFR-06 um Datenschutz und Zugriffsschutz erweitert; NFR-09 von Must zu Should, beschränkt auf Lesen und die Einkaufsliste. Details in [requirements.md](../requirements.md) und [mvp.md](../mvp.md).
- Neue Risiken: Ohne Internet keine Nutzung, auch beim Einkaufen (AF-4); Verfügbarkeit und Kosten des Servers; Sicherheit der Konten.
- Kleineres Risiko: Datenverlust bei Geräteverlust entfällt weitgehend.
- ADR-0001 setzt eine Web-App voraus und passt zu dieser Entscheidung; er bleibt ein eigener Vorschlag.

## Bestätigung

Geplante Nachweise für die spätere Umsetzung, noch nicht durchgeführt:

- Demo-Ablauf aus [mvp.md](../mvp.md) im Browser, inklusive Abmelden und erneutem Anmelden auf einem zweiten Gerät; Must-Stories zusätzlich auf Android und iPhone (NFR-01).
- Test, dass eine angemeldete Person keine Daten einer anderen Person lesen oder ändern kann.

## Erneute Prüfung und Referenzen

Neu bewerten, wenn Offline-Nutzung für den MVP wieder zwingend wird, der Serverbetrieb das Budget übersteigt oder das Team eine native App vor der Web-App braucht.

- [architecture.md: Variantenvergleich](../architecture.md)
- [ADR-0001: Infrastruktur als Code und kontrollierte Releases](0001-infrastruktur-und-release.md)
