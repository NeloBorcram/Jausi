# Implementierung

## Stand und Start

Manuel hat am 23.11.2026 den Beginn von Phase 3 und das Grundgerüst mit Spring Boot und Vue ausdrücklich beauftragt. Die Dummy-Seite ist keine Umsetzung der Must-Stories. Architektur und API-Vertrag bleiben Grundlage; geplante Konten, Persistenz und Matching sind noch nicht implementiert.

## Einrichtung für das Team

Einmalig Git, ein JDK (empfohlen Java 21 LTS; `java -version` prüfen) und den Node-Version-Manager installieren. npm wird mit Node ausgeliefert und muss nicht separat installiert werden. Maven kommt über den eingecheckten Wrapper. Docker und Azure CLI sind für die lokale Dummy-Seite nicht nötig.

### Windows / PowerShell

[nvm-windows installieren](https://github.com/nvm-windows/nvm/releases), danach das Terminal neu öffnen. Wer bereits nvm verwendet, installiert keinen zweiten Manager. Bei einer bisherigen direkten Node-Installation die Migrationshinweise des Installers beachten; parallele Installationen können PATH-Konflikte verursachen. Für die Symlink-Umschaltung kann ein Terminal mit Administratorrechten nötig sein.

Im frisch geklonten Repository (bzw. im ausgecheckten Feature-Branch, solange das Grundgerüst noch nicht gemergt ist):

```powershell
$nodeVersion = (Get-Content .nvmrc -Raw).Trim()
nvm install $nodeVersion
nvm use $nodeVersion
node --version
npm.cmd --version
java -version
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\scripts\build.ps1
java -jar .\backend\target\jausi-0.0.1-SNAPSHOT.jar
```

`.nvmrc` nennt die konkret geprüfte Node-Version; nvm-windows liest sie je nach Version nicht automatisch, deshalb übergeben die Befehle den Wert ausdrücklich. `npm.cmd` vermeidet die Blockade eines unsignierten `npm.ps1` durch PowerShell. Die Ausnahme für `build.ps1` gilt nur für den gestarteten Prozess und ändert keine dauerhafte Ausführungsrichtlinie. Eine zentral verwaltete Unternehmensrichtlinie wird dadurch nicht überschrieben.

### macOS / Linux

[nvm-sh nach offizieller Anleitung installieren](https://github.com/nvm-sh/nvm#installing-and-updating), anschließend ein neues Terminal öffnen. Dieses nvm ist ein anderes Werkzeug als nvm-windows.

```bash
# Im Repository-Verzeichnis:
nvm install
nvm use
node --version
npm --version
java -version
bash scripts/build.sh
java -jar backend/target/jausi-0.0.1-SNAPSHOT.jar
```

### Build und laufende Entwicklung

Nach dem Start [localhost:8080](http://localhost:8080) öffnen. Der Gesamtbuild installiert mit `npm ci` die Lockdatei, prüft Formatierung, Frontend-Tests und TypeScript, baut Vue und verpackt die Dateien zusammen mit dem getesteten Backend in ein JAR. Für den ersten Build ist Internet nötig. Server mit `Ctrl+C` beenden. Nach Änderungen den Gesamtbuild erneut ausführen; `npm install` nur bei bewusst geänderten Abhängigkeiten verwenden und dann die Lockdatei mitliefern.

Für schnelle Frontend-Arbeit zwei Terminals nutzen:

- Backend: `cd backend`, dann Windows `./mvnw.cmd spring-boot:run`, macOS/Linux `bash mvnw spring-boot:run`.
- Frontend: im Repo `nvm use` (Windows die Version wie oben explizit übergeben), dann `cd frontend`, `npm ci` und `npm run dev` (Windows `npm.cmd`). Vite zeigt die lokale Adresse an und leitet API-/Health-Anfragen an Port 8080 weiter. Nur der Frontend-Devserver aktualisiert die Oberfläche automatisch.

**Probleme:** Bei falscher Node-Version `nvm list`, `nvm use` und unter Windows `where.exe node`/`where.exe npm` prüfen; danach Terminal neu öffnen. Bei Java-Fehlern `JAVA_HOME` auf ein JDK setzen. Ist Port 8080 belegt, den bisherigen Server beenden oder im JAR-Start `--server.port=8081` ergänzen (für getrennte Entwicklung dann auch den Vite-Proxy anpassen).

CI verwendet ebenfalls `.nvmrc`; `.node-version` enthält denselben Wert für andere Werkzeuge. Versionsupdates gemeinsam mit `frontend/package.json`, Lockdatei und beiden Versionsdateien prüfen. Lokal wurden Node 24.22.3 und JDK 25 mit Java-21-Bytecode geprüft; CI verwendet JDK 21.

## Struktur und Abhängigkeiten

- `frontend/`: Vue 3.5.46, TypeScript 5.9.3, Vite; installierte Versionen in `package-lock.json`. TypeScript 7 war im überprüften Setup nicht mit vue-tsc kompatibel; bewusst kein ungeprüftes Upgrade.
- `backend/`: Java-21-Ziel, Spring Boot 4.2.0; Starter aus dem offiziellen Initializr. MVC liefert später die JSON-API, Security sperrt bereits Fachpfade, Actuator stellt ausschließlich Health bereit; Validation bereitet Eingabeprüfung vor.
- Prettier prüft einheitliche Frontend-Formatierung; Vitest und Spring-Test-Starter prüfen Erreichbarkeit und sichere Standardgrenzen. Tests wurden vor dem jeweiligen Implementierungsschritt formuliert.
- `compose.yml`: optionaler PostgreSQL-Container, noch keine Backend-Anbindung. Vor `docker compose --profile database up -d` ein lokales `POSTGRES_PASSWORD` setzen; keine realen Konten oder festen Passwörter.

Das JAR enthält die Vue-Builddateien und benötigt für die Dummy-Seite keine Datenbank. Es gibt keine Demo-Anmeldung oder Ersatzimplementierung des API-Vertrags. Die späteren Fachmodule folgen [architecture.md](architecture.md).

## Azure und Releases

`infra/app/bootstrap.bicep` beschreibt die Ressourcengruppe, `main.bicep` einen gemeinsamen F1-Plan (kostenlos, Standard) oder B1-Plan (optional), Staging-/Produktions-App und je eine OIDC-Identität. Standort: Germany West Central; Java 21 ist im Azure-Laufzeitkatalog verfügbar. Preisabfrage am 23.11.2026: 0,01802 USD/Stunde für den gemeinsamen Plan, etwa 13,15 USD bei 730 Stunden, ohne weitere Dienste. Budget und endgültige Wahl siehe T6/T7 in [teamfragen.md](teamfragen.md). Die Datenbank wird nicht kostenpflichtig bereitgestellt.

```powershell
az deployment sub what-if --location germanywestcentral --template-file infra/app/bootstrap.bicep
az deployment sub create --location germanywestcentral --template-file infra/app/bootstrap.bicep
```

Der erste Build wird für den Bootstrap manuell als JAR auf die Azure-Dummy-App übertragen. Anschließend übernimmt `App CI` PR-Prüfung und Artefaktbau. `Azure app release` verteilt ausschließlich erfolgreiche Push-Builds von `main`: identisches JAR nach Staging, Health-Prüfung, geschützte Freigabe, Produktion. Die globale Release-Sperre verhindert überlappende Promotions; es gibt keinen Slot-Tausch.

Vor Aktivierung: GitHub-Umgebungen `staging` und `production` auf `main` beschränken, Produktionsreviewer setzen und die Variablen `AZURE_CLIENT_ID`, `AZURE_TENANT_ID`, `AZURE_SUBSCRIPTION_ID`, `AZURE_RESOURCE_GROUP`, `AZURE_APP_NAME` und `APP_URL` aus den Bicep-Ausgaben setzen. Erst danach die Repository-Variable `APP_RELEASE_ENABLED=true` setzen. Secrets sind für OIDC nicht erforderlich. Keine Verbindung zu den früheren Node-/Slot-Workflows auf `develop`.

Rollback: ein zuvor geprüftes JAR aus den CI-Artefakten erneut deployen; Änderungen an Nutzerdaten werden dadurch nicht rückgängig gemacht. Für das Dummy-Hosting bleibt `jausi.at` unverändert bei GitHub Pages. Erst nach gesondertem DNS-/TLS-Plan die Domain umstellen.

## Prüfung

Backend: zwei HTTP-Integrationstests erfolgreich; Frontend: zwei Health-Tests, strenge TypeScript-Prüfung und Produktionsbuild erfolgreich. Lokaler JAR-Smoke-Test: Vue-Seite, Mascot und Backend-Healthcheck erfolgreich. Azure-Erreichbarkeit konnte wegen der folgenden Quotenblockade nicht geprüft werden. Ein erfolgreicher Dummy-Healthcheck beweist keine Fachfunktion oder Datenbankverbindung.

Azure-Versuch am 23.11.2026: B1 in Germany West Central wegen Quote 0 abgelehnt; F1 anschließend in Germany West Central, Sweden Central, Spain Central, Italy North und Switzerland North ohne verfügbare Quote validiert. Keine Web-App und kein kostenpflichtiger App-Service-Plan wurden angelegt; die Ressourcengruppe `rg-jausi-app` und zwei Managed Identities existieren aus dem Teildeployment. Der nächste erforderliche externe Schritt ist eine App-Service-Quotenerhöhung oder ein anderes berechtigtes Abonnement (T7). F1 unterstützt keine eigene Domain und schläft ein; B1 ist optional kostenpflichtig.

Nach einem erfolgreichen Hosting-Deployment richtet `scripts/configure-release.ps1 -DeploymentName <Name-des-Ressourcengruppen-Deployments> -ReviewerIds <numerische-GitHub-ID>` Umgebungen und Variablen reproduzierbar ein; hierfür braucht die ausführende Person Repository-Adminrechte. Die Freigaberegel ist keine Teamentscheidung über die technische Architektur. Release-Aktivierung bleibt aus, bis die Schutzregeln geprüft sind.
