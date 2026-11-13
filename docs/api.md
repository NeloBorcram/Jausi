# API-Design

> [!NOTE]
> **Entwurf (Phase 2), Stand 13.11.2026**, mit AI erarbeitet, vom Team noch nicht geprüft. Grundregeln und Begründungen zur [Spezifikation](../api/openapi.yaml); Namen wie im [Datenmodell](datenmodell.md); unabhängig vom Stack ([ADR-0003](adr/0003-technologie-stack.md)).

## Grundregeln

- **REST mit JSON** über HTTPS, alle Pfade unter `/api`. Felder in camelCase wie im Datenmodell, Texte in UTF-8.
- **Anmeldung über ein Sitzungscookie** aus dem Anmeldebaustein des Frameworks: `HttpOnly`, `Secure`, `SameSite=Lax`, gültig 30 Minuten nach der letzten Nutzung, auch über das Schließen des Browsers hinaus (US-24 AK 4). Ändernde Anfragen schützt der CSRF-Mechanismus des Frameworks. Jausi setzt **nur technisch notwendige Cookies**: das Sitzungscookie und, falls der CSRF-Mechanismus eines braucht, dessen Cookie. Tracking oder Werbung gibt es nicht (NFR-06).
- **E-Mail-Adresse:** Registrierung und Anmeldung normalisieren sie gleich ([Datenmodell](datenmodell.md#entitäten)).
- **Ohne Anmeldung** erreichbar sind nur Registrierung und Anmeldung, dazu die Seiten Datenschutzerklärung und Impressum (US-31), die die Web-App ausliefert. Alle anderen Endpunkte antworten ohne gültige Sitzung mit `401`.
- **Nur eigene Daten:** Der Server bestimmt das Konto ausschließlich aus der Sitzung. Kein Pfad und kein Anfragekörper enthält eine `kontoId`; jede Abfrage auf Vorratseinträge und Rezepte ist auf das Konto der Sitzung eingeschränkt. Die ID eines fremden Rezepts ergibt `404`, als gäbe es es nicht, damit fremde Daten weder lesbar noch erkennbar sind (FR-16, NFR-06).
- **Sortierung:** Listen kommen alphabetisch nach Name, ohne Beachtung der Groß-/Kleinschreibung.

## Endpunkte und Datenformate

Maßgeblich ist der Vertrag [api/openapi.yaml](../api/openapi.yaml) (OpenAPI 3.1): 15 Endpunkte, alle Anfrage- und Antwortformate sowie das einheitliche Fehlerformat. Daraus lassen sich ein Mock-Server für die Oberfläche, eine Dokumentation und Code erzeugen. Gültige Rezepte nach den [fachlichen Regeln](requirements.md#fachliche-regeln). Die Archivansicht kommt mit `GET /api/matching` allein aus, weil die Antwort den Namen enthält (US-09 AK 3).

## Matching

Matching bekommt seine Daten **über die Schnittstellen der Module Vorrat und Rezepte** und liest deren Tabellen nicht selbst. `GET /api/matching` holt so Vorrat und Rezepte des angemeldeten Kontos und übergibt sie an eine **reine Funktion** ohne Zugriff auf Datenbank, Netz oder Oberfläche. `GET /api/rezepte/{id}` ruft dieselbe Funktion für ein einzelnes Rezept auf und liefert `fehlendeZutaten` in den Rezeptdetails (US-09 AK 1 und 2):

```text
berechneMatching(rezepte: Liste von {rezeptId, name, zutatIds}, vorrat: Menge von zutatId)
  → Liste von {rezeptId, name, anzahlFehlend, fehlendeZutatIds}
```

Fehlend ist jede Zutat des Rezepts, die nicht im Vorrat steht; Mengen spielen keine Rolle. Die Funktion ist damit ohne Server testbar, für vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat (NFR-05); die Testfälle stehen in [matching-testfaelle.csv](../data/testdaten/matching-testfaelle.csv). Gespeichert wird nichts; jede Abfrage nutzt den aktuellen Vorrat.

## Fehler

Format und Codes stehen in der Spezifikation. Bewusste Entscheidungen dazu:

- **Fremde Daten ergeben `404`, nicht `403`**, damit sie weder lesbar noch erkennbar sind; `403` bedeutet nur „CSRF-Prüfung fehlgeschlagen“.
- **Anmeldung verrät nichts:** `401` sagt nicht, ob E-Mail oder Passwort falsch war (US-24 AK 2).
- **Bewusst hingenommen:** `409` bei der Registrierung verrät, dass eine E-Mail-Adresse bereits ein Konto hat, weil US-23 AK 2 genau diesen Hinweis verlangt.
- Der Hinweis „Keine Internetverbindung“ (NFR-04) entsteht in der Web-App, wenn der Server nicht erreichbar ist; die API liefert dafür nichts.

## Rückverfolgbarkeit

| Story | Endpunkt | Entität |
| --- | --- | --- |
| US-01 | `PUT /api/vorrat/{zutatId}` | Vorratseintrag |
| US-02 | `GET /api/vorrat` | Vorratseintrag, Zutat |
| US-03 | `DELETE /api/vorrat/{zutatId}` | Vorratseintrag |
| US-04 | `POST /api/rezepte` | Rezept, Rezeptzutat |
| US-05 | `GET /api/rezepte`, `GET /api/rezepte/{id}` | Rezept, Rezeptzutat, Zutat |
| US-06 | `PUT /api/rezepte/{id}` | Rezept, Rezeptzutat |
| US-08 | `GET /api/matching?nurVollstaendig=true` | berechnet, nicht gespeichert |
| US-09 | `GET /api/matching` (Anzahl im Archiv, AK 3), `GET /api/rezepte/{id}` (fehlende Zutaten in den Details, AK 1 und 2) | berechnet, nicht gespeichert |
| US-13 | `GET /api/zutaten?suche=` | Zutat |
| US-19 | `DELETE /api/rezepte/{id}` | Rezept, Rezeptzutat |
| US-23 | `POST /api/konto` | Konto |
| US-24 | `POST`, `GET`, `DELETE /api/sitzung` | Konto, Sitzung des Frameworks |
| US-26 | `DELETE /api/konto` | Konto mit allen abhängigen Daten und Sitzungen |
| US-31 | kein Endpunkt: statische Seiten der Web-App | – |

## Offene Punkte

Entscheidungen für das Team stehen in [teamfragen.md](teamfragen.md) (T13, T14). Technisch offen und abhängig vom Stack ([ADR-0003](adr/0003-technologie-stack.md)): Beenden aller Sitzungen eines Kontos, Sperre nach Fehlversuchen (nur wenn Zeit bleibt), Sortierung mit Umlauten, Einspielen des Zutatenkatalogs.
