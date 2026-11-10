# Azure-Hosting für Jausi

Umsetzungsvorbereitung zu [ADR-0001](adr/0001-infrastruktur-und-release.md). Die Freigabe des Teams, ein Azure-Abonnement und die Kostenprüfung stehen aus. Die Konfiguration erstellt einen Linux-App-Service B1 für Dev/Test und einen separaten S1 für Produktion mit Staging-Slot. B1 und S1 verursachen laufende Kosten, auch ohne Deployments. Storage und optional Azure DNS kommen hinzu. Azure wird für die Auslieferung eingesetzt; der fachliche MVP bleibt offline nutzbar.

## Einmalige Einrichtung

1. Azure CLI und Terraform installieren. Als berechtigte Person in Azure anmelden und das richtige Abonnement auswählen. Für den Start sind Rechte zum Anlegen von Ressourcengruppen und Rollen erforderlich. Der GitHub-Anbieter benötigt vorübergehend Repository-Admin-Zugriff für Umgebungen, Reviewer, Branch-Regeln und Variablen. Einen dafür geeigneten GitHub-Token nur im lokalen Prozess als `GITHUB_TOKEN` bereitstellen; keine Zugangsdaten im Repository speichern.
2. Von der Repository-Wurzel aus den Remote-State mit Bicep anlegen. Storage-Name und Präfix müssen global eindeutig sein. `operatorObjectId` ist die Entra-Objekt-ID des Terraform-Betreibers bzw. der Gruppe.

   ```powershell
   az login
   az account set --subscription '<subscription-id>'
   az deployment sub create --location westeurope --template-file infra/azure/bootstrap.bicep --parameters location=westeurope stateResourceGroup='<state-rg>' stateAccountName='<state-storage>' operatorObjectId='<entra-object-id>'
   ```

   Der Container ist nicht öffentlich; Terraform nutzt Entra-Anmeldung und Blob-Leases zur Sperre. Schlüsselzugriff ist deaktiviert. Bei einer Gruppe zusätzlich `operatorType=Group` setzen. Neue Rollenzuweisungen können eine Weile brauchen.
3. `infra/azure/hosting.tfvars.example` nach `infra/azure/hosting.tfvars` kopieren. Abonnement, eindeutiges Präfix in Kleinbuchstaben und zwei bis sechs numerische GitHub-Reviewer-IDs eintragen. Falls die Umgebungen bereits existieren, diese vor dem Apply in Terraform importieren. GitHubs bereits eingerichteten Schutz von `main` separat beibehalten.

   ```powershell
   Set-Location infra/azure
   terraform init -backend-config="resource_group_name=<state-rg>" -backend-config="storage_account_name=<state-storage>" -backend-config="subscription_id=<subscription-id>"
   terraform plan -var-file=hosting.tfvars -out=hosting.tfplan
   terraform apply hosting.tfplan
   ```

   Den Plan vor dem Apply prüfen. Nach dem ersten erfolgreichen Init die erzeugte `.terraform.lock.hcl` einchecken. Die Infrastrukturprüfung in PRs validiert die Konfiguration ohne Azure-Zugriff; Apply erfolgt bewusst separat durch eine berechtigte Person. GitHub-Umgebungen und Azure-Identitäten sind im Terraform definiert. Release-Jobs melden sich per OIDC an.

## jausi.at anbinden

1. Beim ersten Apply `bind_production_domain=false` lassen. `terraform output production_dns` liefert den TXT-Wert für `asuid`. Die **eingehende** IPv4-Adresse in der Azure-Ansicht der Produktions-App unter **Custom domains** ablesen.
2. Beim bestehenden DNS-Anbieter den Apex-A-Record und den `asuid`-TXT-Record setzen. Alternativ `manage_azure_dns=true` und `production_apex_ipv4` setzen, Terraform ausführen und die ausgegebenen Nameserver beim Registrar delegieren. Vor dem Wechsel einer bestehenden Zone alle benötigten DNS-Records übernehmen.
3. Nach öffentlicher DNS-Auflösung `bind_production_domain=true` setzen und erneut Plan und Apply ausführen. Terraform richtet die Hostname-Bindung, das verwaltete Zertifikat und die TLS-Bindung für Produktion ein. HTTPS prüfen. DNS-Delegation und Kontofreigaben bleiben beim Registrar bzw. bei den verantwortlichen Personen.

## Erster Release und Rücktausch

1. `main` bleibt unverändert. `develop` von `main` veröffentlichen und den Hosting-Branch per Pull Request nach `develop` integrieren. Vor dem ersten Deployment den [Schutz für develop](github-workflow.md) aktivieren und nach dem ersten Infrastruktur-Apply prüfen, dass `production` auf `develop` begrenzt ist, Reviewer verlangt und keine Selbstfreigabe oder Admin-Umgehung erlaubt.
2. Nach dieser Prüfung `enable_release_workflow=true` per Terraform setzen. Ein neuer Merge nach `develop` startet den Release. Falls der Hosting-PR schon bei deaktiviertem Workflow gemergt wurde, löst der nächste reguläre PR den ersten Release aus. GitHub verlangt für `workflow_dispatch` eine Workflow-Datei im Default-Branch; deshalb nutzt diese Übergangslösung den Push-Trigger auf `develop`.
3. Der Workflow baut die deutschsprachige Willkommensseite als ZIP und verteilt dasselbe Artefakt nach Dev/Test und Staging. Beide Umgebungen prüfen `/healthz` und `/version`. Für `jausi.at` nach DNS- und TLS-Einrichtung in GitHub Actions den wartenden Produktionsjob freigeben. Vor dem Swap wird nochmals der Staging-Commit geprüft. Der wartende Lauf hält Staging für seine Version frei; für einen reinen Vorschau-Release den Produktionsjob ablehnen oder den Lauf abbrechen, damit der nächste Kandidat starten kann.
4. Bei einem Produktionsfehler zunächst den Release-Fluss stoppen. Solange die vorherige Version noch im Staging-Slot liegt, kann eine berechtigte Person den Slot-Tausch im Azure-Portal rückgängig machen. Nach dem nächsten Staging-Deployment ist stattdessen ein erneutes Deployment des vorherigen Artefakts erforderlich. Der Rücktausch ändert keine lokal gespeicherten Nutzerdaten.

Sobald die App existiert, ersetzt ihr den Packschritt der Willkommensseite durch den App-Build. Die ZIP-Datei muss im Wurzelverzeichnis den Startpunkt enthalten; aktuell erwartet App Service `server.mjs` und der Workflow erwartet `/healthz` sowie `/version` mit dem Commit-SHA. Änderungen daran gemeinsam in Terraform und Workflow vornehmen. Es wurden keine Azure-Ressourcen bereitgestellt.

- [Azure: App-Service-Slots](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
- [Azure: Benutzerdefinierte Domänen und DNS](https://learn.microsoft.com/en-us/azure/app-service/app-service-web-tutorial-custom-domain)
- [GitHub: Deployment-Umgebungen](https://docs.github.com/en/actions/reference/workflows-and-actions/deployments-and-environments)
