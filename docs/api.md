# API-Design

> [!NOTE]
> **Entwurf (Phase 2), Stand 13.11.2026**, mit AI erarbeitet, vom Team noch nicht geprüft. Namen wie im [Datenmodell](datenmodell.md); unabhängig vom Stack ([ADR-0003](adr/0003-technologie-stack.md)).

## Grundregeln

- **REST mit JSON** über HTTPS, alle Pfade unter `/api`. Felder in camelCase wie im Datenmodell, Texte in UTF-8.
- **Anmeldung über ein Sitzungscookie** aus dem Anmeldebaustein des Frameworks: `HttpOnly`, `Secure`, `SameSite=Lax`, gültig 30 Minuten nach der letzten Nutzung, auch über das Schließen des Browsers hinaus (US-24 AK 4). Ändernde Anfragen schützt der CSRF-Mechanismus des Frameworks. Jausi setzt **nur technisch notwendige Cookies**: das Sitzungscookie und, falls der CSRF-Mechanismus eines braucht, dessen Cookie. Tracking oder Werbung gibt es nicht (NFR-06).
- **E-Mail-Adresse:** Registrierung und Anmeldung normalisieren sie gleich ([Datenmodell](datenmodell.md#entitäten)).
- **Ohne Anmeldung** erreichbar sind nur Registrierung und Anmeldung, dazu die Seiten Datenschutzerklärung und Impressum (US-31), die die Web-App ausliefert. Alle anderen Endpunkte antworten ohne gültige Sitzung mit `401`.
- **Nur eigene Daten:** Der Server bestimmt das Konto ausschließlich aus der Sitzung. Kein Pfad und kein Anfragekörper enthält eine `kontoId`; jede Abfrage auf Vorratseinträge und Rezepte ist auf das Konto der Sitzung eingeschränkt. Die ID eines fremden Rezepts ergibt `404`, als gäbe es es nicht, damit fremde Daten weder lesbar noch erkennbar sind (FR-16, NFR-06).
- **Sortierung:** Listen kommen alphabetisch nach Name, ohne Beachtung der Groß-/Kleinschreibung.

## Endpunkte

| Methode und Pfad | Zweck | Anfrage → Antwort | Bezug |
| --- | --- | --- | --- |
| `POST /api/konto` | Konto anlegen und anmelden | `{"email":"Lena@example.org","passwort":"geheim123"}` → `201 {"email":"lena@example.org"}` + Cookie; `409` bei vorhandener E-Mail (siehe [Fehler](#fehler)) | US-23, FR-16 |
| `DELETE /api/konto` | Konto mit allen Daten und Sitzungen löschen, nur mit Passwort ([Datenmodell](datenmodell.md#entitäten)); alte Sitzungen erhalten danach `401` | `{"passwort":"…"}` → `204`, Cookie gelöscht; `400` bei falschem Passwort | US-26, FR-16 |
| `POST /api/sitzung` | Anmelden | `{"email":"…","passwort":"…"}` → `200 {"email":"lena@example.org"}` + Cookie; `401` „E-Mail oder Passwort falsch“ | US-24 |
| `GET /api/sitzung` | Prüfen, ob angemeldet (beim Öffnen der App) | – → `200 {"email":"lena@example.org"}` oder `401` | US-24 |
| `DELETE /api/sitzung` | Abmelden | – → `204`, Cookie gelöscht | US-24 |
| `GET /api/zutaten?suche=eis` | Zutatenvorschläge: Name enthält Suchtext, ohne Groß-/Kleinschreibung. Ohne `suche` oder mit leerem bzw. nur aus Leerzeichen bestehendem Suchtext kommt der ganze Katalog. | – → `200 [{"id":7,"name":"Eis"},{"id":3,"name":"Reis"}]`; leere Liste → Hinweis „Zutat nicht im Katalog“ in der Oberfläche | US-13, FR-01 |
| `GET /api/vorrat` | Vorrat anzeigen | – → `200 [{"zutatId":3,"name":"Reis"},{"zutatId":5,"name":"Tomate"}]` | US-02, FR-02 |
| `PUT /api/vorrat/{zutatId}` | Zutat zum Vorrat hinzufügen, idempotent: zweimal hinzufügen ergibt einen Eintrag | – → `200 {"zutatId":3,"name":"Reis"}`; `404` bei unbekannter Zutat | US-01, FR-02 |
| `DELETE /api/vorrat/{zutatId}` | Zutat aus dem Vorrat entfernen, ohne Sicherheitsabfrage | – → `204`, auch wenn sie nicht im Vorrat stand | US-03, FR-02 |
| `GET /api/rezepte` | Rezeptarchiv | – → `200 [{"id":12,"name":"Eierreis"},{"id":11,"name":"Tomatenreis"}]` | US-05, FR-03 |
| `GET /api/rezepte/{id}` | Rezept mit allen Angaben und den fehlenden Zutaten aus dem Matching | – → `200 {"id":12,"name":"Eierreis","zutaten":[{"zutatId":9,"name":"Ei","menge":"2"},{"zutatId":3,"name":"Reis","menge":null}],"zubereitung":"…","fehlendeZutaten":[{"zutatId":9,"name":"Ei"}]}`; `404` | US-05, US-09, FR-03, FR-05 |
| `POST /api/rezepte` | Rezept anlegen | `{"name":"Tomatenreis","zutaten":[{"zutatId":3,"menge":"200 g"},{"zutatId":5}],"zubereitung":"…"}` → `201` mit dem Rezept wie bei `GET`; `400` bei ungültigem Rezept, `409` bei vorhandenem Namen | US-04, FR-03 |
| `PUT /api/rezepte/{id}` | Rezept bearbeiten; ersetzt Name, Zutaten und Zubereitung vollständig | wie `POST` → `200` mit dem Rezept; `400`, `404`, `409` | US-06, FR-03 |
| `DELETE /api/rezepte/{id}` | Rezept löschen; die Sicherheitsabfrage zeigt die Oberfläche vorher | – → `204`; `404` | US-19, FR-03 |
| `GET /api/matching?nurVollstaendig=true` | Matching für das ganze Archiv; ohne Parameter alle Rezepte | – → `200 [{"rezeptId":11,"name":"Tomatenreis","anzahlFehlend":0,"fehlendeZutaten":[]}]` | US-08, US-09, FR-05 |

Gültige Rezepte nach den [fachlichen Regeln](requirements.md#fachliche-regeln). Die Archivansicht kommt mit `GET /api/matching` allein aus, weil die Antwort den Namen enthält (US-09 AK 3).

## Matching

Matching bekommt seine Daten **über die Schnittstellen der Module Vorrat und Rezepte** und liest deren Tabellen nicht selbst. `GET /api/matching` holt so Vorrat und Rezepte des angemeldeten Kontos und übergibt sie an eine **reine Funktion** ohne Zugriff auf Datenbank, Netz oder Oberfläche. `GET /api/rezepte/{id}` ruft dieselbe Funktion für ein einzelnes Rezept auf und liefert `fehlendeZutaten` in den Rezeptdetails (US-09 AK 1 und 2):

```text
berechneMatching(rezepte: Liste von {rezeptId, name, zutatIds}, vorrat: Menge von zutatId)
  → Liste von {rezeptId, name, anzahlFehlend, fehlendeZutatIds}
```

Fehlend ist jede Zutat des Rezepts, die nicht im Vorrat steht; Mengen spielen keine Rolle. Die Funktion ist damit ohne Server testbar, für vollständige, teilweise und fehlende Übereinstimmung sowie leeren Vorrat (NFR-05); die Testfälle stehen in [matching-testfaelle.csv](../data/testdaten/matching-testfaelle.csv). Gespeichert wird nichts; jede Abfrage nutzt den aktuellen Vorrat.

## Fehler

Jede Fehlerantwort hat dasselbe Format. `felder` nennt bei Eingabefehlern das betroffene Feld und den Grund (NFR-04):

```json
{
  "fehler": {
    "code": "VALIDIERUNG",
    "meldung": "Das Rezept konnte nicht gespeichert werden.",
    "felder": [{ "feld": "zutaten", "grund": "Mindestens eine Zutat angeben." }]
  }
}
```

| Status | `code` | Wann |
| --- | --- | --- |
| 400 | `VALIDIERUNG` | Pflichtfeld leer, E-Mail ungültig, Passwort kürzer als 8 Zeichen, Zutat doppelt oder nicht im Katalog, falsches Passwort beim Löschen des Kontos |
| 401 | `NICHT_ANGEMELDET`, `ANMELDUNG_FEHLGESCHLAGEN` | Keine gültige Sitzung, auch die Sitzung eines gelöschten Kontos; falsche E-Mail oder falsches Passwort, ohne zu verraten, was falsch ist (US-24 AK 2) |
| 403 | `VERBOTEN` | CSRF-Prüfung fehlgeschlagen. Fremde Datensätze ergeben bewusst `404`, nicht `403`. |
| 404 | `NICHT_GEFUNDEN` | Rezept oder Zutat gibt es nicht oder gehört zu einem anderen Konto |
| 409 | `KONFLIKT` | E-Mail-Adresse schon vergeben (US-23 AK 2), Rezeptname im Konto schon vorhanden (US-04 AK 3) |

**Bewusst hingenommen:** `409` bei `POST /api/konto` verrät, dass eine E-Mail-Adresse bereits ein Konto hat. US-23 AK 2 verlangt genau diesen Hinweis; anders als bei der Anmeldung (US-24 AK 2) wird die Information daher nicht verborgen.

Der Hinweis „Keine Internetverbindung“ (NFR-04) entsteht in der Web-App, wenn der Server nicht erreichbar ist; die API liefert dafür nichts.

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
