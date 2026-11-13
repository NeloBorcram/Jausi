<p align="center">
  <img src="docs/assets/maskottchen/logo-moehrchen.png" alt="Jausi-Logo: Möhrchen mit zwei Einkaufstaschen" width="220">
</p>

<h1 align="center">Jausi</h1>

<p align="center">
  <strong>Rezepte mit dem, was du daheim hast.</strong>
</p>

> [!NOTE]
> **Auf einen Blick**
> - **Was:** App, die einen persönlichen Lebensmittelvorrat mit einem Rezeptarchiv verbindet und zeigt, welche Gerichte mit vorhandenen Zutaten möglich sind.
> - **Für wen:** Menschen, die unkompliziert mit dem kochen möchten, was sie daheim haben, allen voran Studierende.
> - **Wo:** im Browser des Smartphones, in der Küche und beim Einkaufen; mit Konto auf jedem Gerät. Eine eigene App ist für die Zeit nach dem Kurs vorgemerkt.
> - **Stand:** Phase 1 (Anforderungen) ist abgeschlossen und am 13.11.2026 vom Team bestätigt; Phase 2 (Architektur und Design) läuft. Es gibt noch keinen Code.

## Problem

Menschen, die unkompliziert kochen möchten, allen voran Studierende, verlieren leicht den Überblick über ihre Lebensmittel. Jausi beantwortet die Frage **„Was kann ich heute mit meinem Vorrat kochen?“** und unterstützt dabei, vorhandene Zutaten zu nutzen und unnötige Einkäufe zu vermeiden.

**Warum das relevant ist:**

- In österreichischen Haushalten werden pro Person und Jahr rund **69 kg Lebensmittel** weggeworfen, davon etwa **37 kg vermeidbar** ([BMLUK, Daten 2024](https://www.bmluk.gv.at/themen/abfall-und-kreislaufwirtschaft/abfallvermeidung/lebensmittel/oesterreich/haushalte.html)).
- In einer Umfrage der Verbraucherzentrale NRW wünschte sich rund **ein Drittel** der Befragten Rezepte zur Resteverwertung ([Verbraucherzentrale NRW](https://www.verbraucherzentrale.nrw/pressemitteilungen/neue-umfrage-fortschritte-bei-vermeidung-von-lebensmittelabfaellen-111819)).
- Laut einer Studie der ZHAW verschwenden **jüngere Menschen** mehr Lebensmittel als ältere ([ZHAW](https://www.zhaw.ch/de/medien/medienmitteilungen/detailansicht-medienmitteilung/event-news/frauen-ernaehren-sich-nachhaltiger-aeltere-verschwenden-weniger-nahrungsmittel/)).

Eine Erhebung speziell zu Studierenden liegt dem Team nicht vor.

## Zielgruppe

Alle Nutzer wollen drei Dinge wissen: **Was habe ich da? Was kann ich damit kochen? Was muss ich nachkaufen?** Drei fiktive [Personas](docs/personas.md) zeigen unterschiedliche Motivationen:

| Persona | Motivation |
| --- | --- |
| 🎓 **Lena, 22, Studentin** (primär) | will schnell entscheiden, was es heute gibt, und nur das Nötigste kaufen |
| 🌱 **Andrea, 38, berufstätig** | will vorhandene Lebensmittel aufbrauchen statt sie wegzuwerfen |
| 🍳 **Jonas, 19, Lehrling** | kocht erst seit Kurzem und will sein kleines Repertoire nutzen |

## So funktioniert Jausi

```mermaid
flowchart LR
    K["🧺 Zutatenkatalog<br/>vom Team gepflegt"] --> V["🥕 Vorrat<br/>was ich daheim habe"]
    K --> R["📖 Rezeptarchiv<br/>meine eigenen Rezepte"]
    U["👤 Konto<br/>Daten auf dem Server"] --> V
    U --> R
    V --> M{"Matching"}
    R --> M
    M --> P["✅ Vollständig passend<br/>sofort kochbar"]
    M --> F["🛒 Fehlende Zutaten<br/>je Rezept"]
```

Zutaten werden beim Tippen aus einem fest vorgegebenen Zutatenkatalog vorgeschlagen. Das Team pflegt ihn von Hand; eigene Zutaten anzulegen ist eine spätere Erweiterung. Das Matching prüft nur, **ob** eine Zutat vorhanden ist, nicht die Menge.

## Geplanter Funktionsumfang (MVP)

- Konto mit E-Mail-Adresse und Passwort, jederzeit löschbar; Vorrat und Rezepte sind auf jedem Gerät verfügbar. Datenschutz nach DSGVO, Server in der EU.
- Zutaten aus dem festen Zutatenkatalog im Vorrat erfassen und entfernen; passende Zutaten werden beim Tippen vorgeschlagen.
- Eigene Rezepte mit Zutaten, optionalen Mengenangaben und Zubereitung verwalten.
- Passende Rezepte finden und fehlende Zutaten anzeigen.
- Im Browser des Smartphones nutzbar, auf Android und iPhone; eine Internetverbindung ist nötig.

**Bewusst nicht im MVP:** Mengenvergleich, eigene Zutaten anlegen und Suche nach Rezeptnamen (Should), Favoriten, Einkaufsliste und Kategorien (Could). Für die Zeit nach dem Kurs vorgemerkt: eigene App, Offline-Nutzung, Export und Verbrauchsstatistik. AI unterstützt die Projektarbeit; eine AI-Funktion in der App ist nicht vorgesehen. Details stehen im [MVP-Scope](docs/mvp.md).

## Projektdokumentation

| Dokument | Inhalt |
| --- | --- |
| [Anforderungen](docs/requirements.md) | Anwendungsfälle, Begriffe, User Stories, funktionale und nichtfunktionale Anforderungen |
| [MVP-Scope](docs/mvp.md) | Was im MVP ist und was nicht, Demo-Ablauf, Definition of Done, Entscheidungen der Teamprüfung |
| [Personas](docs/personas.md) | Lena, Andrea und Jonas im Detail |
| [AI-Einsatz](docs/ai-usage.md) | Wo und wie AI eingesetzt wurde, Prompts und kritische Bewertung |
| [Branding](docs/branding.md) | Logo- und Maskottchen-Ideen (nicht Teil des MVP) |
| [Architektur](docs/architecture.md) | Entwurf Phase 2: Architekturüberblick, Vergleich der Architekturvarianten, vorgeschlagener Architekturstil |
| [Hosting](docs/hosting.md) | Entwurf Phase 2: Kostenvergleich, Vorschlag Azure-Guthaben für das Projekt, Eigenhosting als spätere Option |
| [Architekturentscheidungen](docs/adr/README.md) | Verbindliche ADR-Vorlage und erste Entscheidungsvorschläge |
| [Kursvorgaben](docs/kursvorgaben.md) | Aufgabenstellungen der fünf Phasen aus Moodle, zusammengefasst, mit Abgleich zum Projektstand |
| [Feste Prompts (Skills)](.agents/skills/) | Vorschläge für wiederkehrende AI-Aufgaben: Anforderungen prüfen, Dokumentation auf Konsistenz prüfen, ADR anlegen |
| [Zusammenarbeit auf GitHub](docs/github-workflow.md) | Pull Requests, CI-Prüfung, Schutz für main und Hosting-Optionen |

## Team

| Teammitglied | E-Mail |
| --- | --- |
| Manuela | se26m005@technikum-wien.at |
| Alex | se26m018@technikum-wien.at |
| Manuel | se26m026@technikum-wien.at |
| Roger | se26m063@technikum-wien.at |

In der Projektdokumentation verwenden wir ausschließlich Vornamen. Die Verantwortung für die Anforderungen liegt beim Team; AI liefert Vorschläge und unterstützt deren Prüfung.

## Projektstand

Phase 1 ist am 13.11.2026 vom Team bestätigt; Phase 2 ist seit 13.11.2026 freigegeben. Ebenfalls am 13.11.2026 wurde eine Scope-Änderung zu Konten und Server vorgeschlagen (ADR-0002, gilt ohne Einwand ab 15.11.2026). Zwei Architekturvorschläge liegen als ADR vor; daraus folgt keine Freigabe zur Umsetzung. Es gibt noch keinen App-Code. Die Termine stammen aus dem Kursplan und sind keine bestätigten Abgabefristen.

| Phase laut Kursplan | Datum | Stand |
| --- | --- | --- |
| 1 – Project Definition & Requirements | 14.10.2026 | ✅ abgeschlossen, vom Team bestätigt am 13.11.2026 |
| 2 – Architecture & Design | 09.11.2026 | ⏳ in Arbeit, freigegeben am 13.11.2026 |
| 3 – AI-assisted/driven Implementation | 23.11.2026 | – |
| 4 – Quality Assurance & Testing | 09.12.2026 | – |
| 5 – Evaluation & Reflection | 21.12.2026 | – |
