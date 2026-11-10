---
status: "vorgeschlagen"
datum: "2026-11-09"
entscheidende: []
einbezogen: ["Manuel"]
informiert: []
---

# ADR-0001: Infrastruktur als Code und kontrollierte Releases

## Kontext und Fragestellung

Jausi liegt auf GitHub. Manuel hat `jausi.at` registriert und vorgegeben, die Infrastruktur von Beginn an als Code zu verwalten. Gewünscht sind Dev/Test, Staging und Produktion sowie eine manuelle Freigabe für den Wechsel von Staging nach Produktion. Wie setzen wir das für vier Personen mit möglichst wenig zusätzlichem Betriebsaufwand um?

Der Vorschlag für Azure App Service gilt **unter der Voraussetzung einer Web-App**. Dieser ADR entscheidet weder die App-Plattform noch die lokale Datenspeicherung. Die Bereitstellung muss den [MVP](../mvp.md) und die [Anforderungen](../requirements.md) respektieren: Smartphone-Nutzung (NFR-01), dauerhafte lokale Daten (FR-06/NFR-03) und Offline-Nutzung (NFR-09). Eine veröffentlichte Web-App muss diese Anforderungen unabhängig vom Hosting erfüllen; Azure ist hier für die Auslieferung vorgesehen, nicht als Laufzeitabhängigkeit der fachlichen Funktionen.

## Entscheidungskriterien

- Infrastruktur und Release-Regeln sind versioniert und reproduzierbar; keine Zugangsdaten oder Terraform-State-Dateien im öffentlichen Repository.
- Das Team behält GitHub für Code und Pull Requests. Für Produktion muss eine Person den getesteten Release ausdrücklich freigeben.
- Dasselbe Artefakt durchläuft Dev/Test und Staging bis zur Produktion. Die Freigabe bezieht sich auf genau diese Version.
- Betriebsaufwand und laufende Kosten bleiben für das Semesterprojekt tragbar.

## Erwogene Optionen

| Option | Vorteile | Nachteile / Risiken |
| --- | --- | --- |
| GitHub Actions, Terraform und Azure App Service mit Staging-Slot | Ein Ort für PR-Checks und Releases; manuelle Freigabe mit protokolliertem Slot-Tausch; Azure- und GitHub-Konfiguration können als Code gepflegt werden. | Kostenpflichtiger App-Service-Tarif ab Standard für Slots; Terraform-State und Identitäten brauchen eine Ersteinrichtung. |
| Azure Pipelines mit GitHub, Terraform und App Service | Vergleichbarer Release-Ablauf; sinnvoll, falls Azure DevOps für CI/CD vorgegeben wird. | Zusätzliche Projekt- und Berechtigungsverwaltung; das Team verfolgt Releases in einem zweiten System. |
| GitHub Actions und versionierte Releases auf statischem Hosting | Kann für eine rein statische Web-App günstiger und einfacher sein. | Ein App-Service-Slot-Tausch entfällt. Promotion und Rückkehr zur vorherigen Version müssten beim gewählten Hosting gesondert nachgewiesen werden. |

## Entscheidung und Begründung

**Vorschlag:** GitHub Actions für CI/CD und Terraform für die Infrastruktur. Falls das Team eine Web-App wählt und Azure-Kosten sowie Berechtigungen bestätigt, wird Dev/Test als separate App eingerichtet; Staging ist ein Slot der Produktions-App. Der Produktionsjob wartet auf eine manuelle Freigabe und tauscht erst dann den Staging-Slot mit Produktion. `jausi.at` bleibt an Produktion gebunden. Auto-Swap bleibt aus.

Die Infrastruktur wird getrennt vom App-Release bereitgestellt. Eine versionierte Ersteinrichtung soll den Remote-State, die erforderlichen Rollen und die OIDC-Verbindung zwischen GitHub und Azure schaffen. Die erste Anmeldung und die dafür nötigen Berechtigungen sind Voraussetzungen. DNS wird als Code verwaltet, soweit der DNS-Anbieter das unterstützt; andernfalls werden die manuellen Schritte festgehalten. Ein neuer Release darf Staging während einer offenen Freigabe nicht überschreiben.

**Offen für die Teamentscheidung:** App-Plattform, Azure-Abonnement und Budget, Zugriff für die Ersteinrichtung, DNS-Anbieter und freigabeberechtigte Personen. Azure Boards ist eine separate Entscheidung und keine Voraussetzung für diesen Ablauf.

## Folgen

- Das Repository enthält später die Terraform-Definitionen und Workflow-Dateien. Infrastrukturänderungen können im PR geprüft werden.
- Die Produktionsfreigabe ist eine menschliche Entscheidung. Die Regel dafür wird versioniert. Rollen und föderierte Identitäten begrenzen, welcher Workflow auf welche Umgebung zugreifen darf.
- Ein erneuter Slot-Tausch kann zur vorherigen App-Version zurückführen, solange diese noch im Staging-Slot liegt. Er macht keine Änderungen an lokal gespeicherten Nutzerdaten rückgängig.

## Bestätigung

Geplante Nachweise für die spätere Umsetzung:

- Terraform-Plan gegen die vorgesehenen Umgebungen prüfen und nach dem Apply auf unerwartete Abweichungen kontrollieren.
- Anhand des Artefakt-Hashs nachweisen, dass Dev/Test, Staging und Produktion dieselbe Version erhalten. Prüfen, dass ohne Freigabe kein Swap erfolgt und eine parallele Ausführung Staging nicht überschreibt.
- Auf einem Smartphone den Offline-Durchlauf prüfen und vorhandene lokale Daten nach einem Release erneut öffnen. Slot-Rücktausch separat demonstrieren.

Auf ausdrücklichen Auftrag ist eine [versionierte Hosting-Vorbereitung](../azure-hosting.md) mit einer Willkommensseite vorhanden. Solange `main` unverändert bleibt, dient `develop` als vorläufige Release-Quelle; Produktion ist eine geschützte Deployment-Umgebung. Die geplanten Nachweise in Azure stehen aus; es wurden keine Ressourcen erstellt oder Releases in Azure ausgeführt. Der ADR bleibt vorgeschlagen.

## Erneute Prüfung und Referenzen

Neu bewerten, wenn eine native App gewählt wird, das Azure-Budget nicht ausreicht oder die Hosting-Anforderungen sich ändern.

- [Azure App Service: Deployment-Slots](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
- [GitHub Actions: Deployment-Umgebungen](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments)
- [Microsoft-Beispiel: Terraform und GitHub-OIDC](https://learn.microsoft.com/en-us/samples/azure-samples/github-terraform-oidc-ci-cd/github-terraform-oidc-ci-cd/)
