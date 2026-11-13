# Hosting

> [!NOTE]
> **Entwurf (Phase 2), Stand 13.11.2026.** Mit AI und Websuche erarbeitet. Die Wahl für das Projekt ist ein Vorschlag von Roger, das Team hat sie noch nicht bestätigt. Preise ändern sich und sind vor einer Bestellung zu prüfen. Kursvorgabe: Hosting-Möglichkeiten vergleichen, unter anderem nach Kosten ([kursvorgaben.md](kursvorgaben.md#phase-2--architecture--design)).

**Kurz:** Für das Projekt hosten wir Jausi bei Azure und zahlen mit dem Studierenden-Guthaben eines Teammitglieds; das Team zahlt nichts und wartet keinen Server. Für einen Betrieb nach dem Semester ist ein eigener Server ab etwa 6 € pro Monat möglich, wenn jemand die Wartung übernimmt.

## Anforderungen

Laut [ADR-0002](adr/0002-architekturstil-client-server.md) wird Jausi eine Web-App mit Konten. Zu hosten sind die App (Backend, liefert auch die Oberfläche aus), eine Datenbank (z. B. PostgreSQL) und die Domain `jausi.at`. Das Hosting soll:

- **wenig kosten**, möglichst ohne Kreditkarte,
- **wenig Betrieb** verursachen; der Kurs warnt vor komplexer Infrastruktur,
- **in der EU** stehen, weil Konten personenbezogene Daten enthalten (NFR-06),
- **nicht einschlafen**, damit die erste Antwort in der Demo schnell kommt (NFR-02),
- **Test vor dem Live-Gang und Freigabe durch eine Person** erlauben ([ADR-0001](adr/0001-infrastruktur-und-release.md)).

## Vergleich

| Option | Art | Kosten pro Monat | Bezahlung | Betrieb durch | Einschätzung |
| --- | --- | --- | --- | --- | --- |
| **Azure App Service** | Cloud-Plattform | 0 € in der Entwicklung, ca. 12 € live | Guthaben | Anbieter | ✅ Vorschlag |
| Azure Container Apps | Cloud-Plattform | ca. 0 € im Gratiskontingent | Guthaben | Anbieter | ⚠️ schläft ein, Region ungeprüft |
| Render | Cloud-Plattform | ca. 13 USD (eine Person), ca. 38 USD (Team) | Kreditkarte | Anbieter | ⚠️ für ein Team teuer |
| Railway | Cloud-Plattform | ab 5 USD, nach Verbrauch | Kreditkarte | Anbieter | ⚠️ Kosten schwer planbar |
| Fly.io | Cloud-Plattform | ab ca. 2–5 USD | Kreditkarte | teilweise wir | ⚠️ wenig Arbeitsspeicher |
| Webhosting (z. B. easyname) | Webhosting | ca. 3–8 € | Zahlung nötig | Anbieter | ❌ nur PHP |
| Netcup VPS Lite 1 | eigener Server | 5,90 €, mind. 6 Monate | Lastschrift oder Rechnung | wir | ⚠️ günstig, Wartung bei uns |
| Hetzner Cloud | eigener Server | ca. 6 € | Zahlung nötig | wir | ❌ derzeit nicht bestellbar |
| Server zu Hause | eigener Server | ca. 2–7 € Strom | – | wir | ❌ Ausfälle, Daten im Heimnetz |

Stand 13.11.2026. Azure-Preise aus der [Azure-Preis-API](https://prices.azure.com/api/retail/prices) (West Europe, ohne USt.), Netcup und Webhosting inkl. USt., übrige von Anbieter- oder Vergleichsseiten. **Ausgeschieden** sind Gratis-Angebote von Render, Koyeb, Oracle und Google Cloud Run: Die Datenbanken laufen ab, sind nur stundenweise aktiv oder für Europa ungeklärt.

## Vorschlag: Azure App Service mit Studierenden-Guthaben

Azure for Students gibt 100 USD Guthaben pro Jahr, ohne Kreditkarte. Wir nutzen das Abonnement eines Teammitglieds.

- **Zwei Apps** im selben App-Service-Plan: Staging zum Testen, Produktion für den echten Betrieb. Während der Entwicklung im Gratistarif **F1**, ab dem Live-Gang mit `jausi.at` im Tarif **B1** (ca. 12 € pro Monat aus dem Guthaben). Der Wechsel ist eine Einstellung.
- **PostgreSQL B1ms** mit je einer Datenbank für Staging und Produktion; laut Azure for Students 12 Monate gratis.
- **Entwicklung lokal**, z. B. mit Docker Compose. Neue Versionen gehen erst nach Staging und nach Freigabe durch eine Person in die Produktion.

**Warum:** Das Team zahlt nichts, Microsoft wartet die Server, App Service unterstützt Java, .NET und Node.js, und die Terraform-Vorarbeit auf `develop` bleibt nutzbar.

**Grenzen:** F1 hat keine eigene Domain, nur 60 Minuten Rechenzeit pro Tag und schläft ein; vor der Abschlusspräsentation auf B1 wechseln. Ist PostgreSQL nicht gratis, kostet der Live-Betrieb ca. 29 € pro Monat und das Guthaben reicht etwa drei Monate. Ausweichlösung, falls App Service in den erlaubten Regionen fehlt: Azure Container Apps.

**Abweichung von ADR-0001:** ADR-0001 sieht für Produktion den Tarif S1 (ca. 62 € pro Monat) mit Slot-Tausch vor, also Staging und Produktion per Knopfdruck tauschen. Das würde das Guthaben in gut einem Monat verbrauchen. Der Vorschlag verzichtet nur darauf und behält den Rest von ADR-0001 bei; ob das genügt, entscheidet Manuel als Autor von ADR-0001 mit dem Team.

## Später: eigener Server

Für einen Betrieb nach dem Semester ist **Netcup VPS Lite 1** die günstigste Lösung: 2 Kerne, 4 GB Arbeitsspeicher, 80 GB Speicher für 5,90 € pro Monat, deutscher Anbieter, Server in Nürnberg, Wien oder Amsterdam. Mit der freien Software **Coolify** lässt sich dort eine Oberfläche ähnlich einer Cloud-Plattform einrichten.

Voraussetzung ist eine Person im Team, die Updates einspielt, den Zugang absichert, die Datenbank täglich extern sichert, Ausfälle behebt und den Datenschutz der Konten verantwortet. Ohne sie ist ein eigener Server für eine App mit Konten nicht zu empfehlen.

## Kritische Prüfung der AI-Empfehlungen

Der Vergleich entstand im Dialog mit Claude (Opus 5.5). Sechs AI-Aussagen hielten Rogers Prüfung nicht stand:

| AI-Aussage | Ergebnis der Prüfung |
| --- | --- |
| Azure B1 für ca. 12 € | Das Guthaben trägt die Kosten, und der Gratistarif F1 reicht für die Entwicklung. |
| „Nicht alle im Team haben eine Kreditkarte“ | Erfunden, gestrichen. |
| Render für ca. 13 USD | Der günstige Plan erlaubt nur eine Person; ein Team zahlt ca. 38 USD. |
| Render gratis nutzbar | Gratis-Apps schlafen ein, die Gratis-Datenbank wird nach 30 Tagen gelöscht. |
| Hetzner-Server für ca. 6 € | Nicht bestellbar; im Preisrechner gab es nur 1 GB Arbeitsspeicher. |
| Netcup „Lite“ heißt weniger Rechenleistung | Laut Netcup betrifft es die Netzwerkanbindung; der Standort wird zugeteilt. |

**Lehre:** Preise aus Vergleichsseiten waren mehrfach veraltet. Verlässlich waren erst die Anbieterseiten und der eigene Blick in die Preisrechner.

## Offene Punkte

Siehe [teamfragen.md](teamfragen.md), T6 und T7.

## Quellen

- **Azure:** [Preis-API](https://learn.microsoft.com/en-us/rest/api/cost-management/retail-prices/azure-retail-prices) · [Azure for Students](https://azure.microsoft.com/en-us/free/students) · [Regionen (Microsoft Q&A)](https://learn.microsoft.com/en-us/answers/questions/5765973/i-m-unable-to-pick-any-region-when-creating-a-new) · [App-Service-Tarife](https://azure.microsoft.com/en-ca/pricing/details/app-service/plans/) · [Domain erst ab B1 (Microsoft Q&A)](https://learn.microsoft.com/en-us/answers/questions/5658353/upgrade-to-allow-custom-domains) · [PostgreSQL](https://azure.microsoft.com/en-gb/pricing/details/postgresql/flexible-server/) · [Container Apps](https://azure.microsoft.com/pricing/details/container-apps/)
- **Plattformen:** [Render: Preise](https://render.com/pricing) · [Render: Gratis](https://render.com/docs/free) · [Railway (Drittanbieter)](https://www.activepieces.com/blog/railway-pricing-2026-plans-usage-rates-and-costs) · [Fly.io](https://fly.io/pricing-update/) · [Koyeb](https://www.koyeb.com/docs/faqs/pricing) · [Oracle](https://docs.oracle.com/en-us/iaas/Content/FreeTier/resourceref.htm) · [Cloud Run](https://cloud.google.com/run/pricing)
- **Server:** [Netcup: vServer Lite](https://www.netcup.com/de/server/vps-lite) · [Netcup: AGB](https://www.netcup.com/de/agb) · [Hetzner: Cloud](https://www.hetzner.com/de/cloud/) · [Coolify](https://coolify.io/) · [easyname](https://www.easyname.com/hosting)
