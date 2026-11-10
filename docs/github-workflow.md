# Zusammenarbeit auf GitHub

`main` enthält den gemeinsamen, geprüften Stand. Pro Aufgabe arbeitet eine Person auf einem kurzen Branch (z. B. `docs/phase-1-review`). Der Pull Request beschreibt Änderung und Prüfung und verweist bei Bedarf auf ein Issue, eine Story-ID oder einen ADR. Ein anderes Teammitglied prüft den PR. Nach grünem Check, Freigabe und geklärten Review-Kommentaren empfehlen wir **Squash and merge**. Anschließend kann der Branch gelöscht werden.

Für vier Personen reicht ein gemeinsames Backlog, etwa GitHub Issues mit einem einfachen Board „Offen → In Arbeit → Review → Erledigt“. Wenn Azure Boards genutzt wird, Aufgaben nur dort pflegen und vom PR aus verlinken.

## Übergang während der Architekturphase

`main` bleibt unverändert und geschützt. Der gemeinsame Arbeitsstand liegt auf `develop`; kurze Feature- und Doku-Branches eröffnen Pull Requests dorthin. Für `develop` gibt es [ein eigenes Ruleset](../.github/rulesets/develop.json) mit derselben Review- und CI-Regel. Importiert es auf GitHub, sobald der erste CI-Lauf auf einem PR nach `develop` den Check **Repository checks** gemeldet hat. Vor Cloud-Deployments muss der Schutz aktiv sein.

`production` ist eine Deployment-Umgebung und kein Git-Branch. Der freigegebene Lauf identifiziert Produktion über Commit und Artefakt. Später kann das Team nach einem geprüften PR von `develop` nach `main` die Release-Quelle und Terraform-Branch-Regeln auf `main` umstellen.

## Schutz für main aktivieren

1. Die CI-Datei aus diesem Änderungssatz zuerst per PR nach `main` bringen. Prüfen, dass GitHub Actions den Job **Repository checks** tatsächlich ausführt. Ein erfolgreicher Lauf auf `main` erleichtert die Auswahl des Checks in den Einstellungen.
2. Als Repository-Admin **Settings → Rules → Rulesets → New ruleset → Import a ruleset** öffnen und [main.json](../.github/rulesets/main.json) importieren. Vor dem Speichern `main` als Ziel und **Repository checks** als erforderlichen Check bestätigen. Wenn GitHub die Auswahl anbietet, **GitHub Actions** als Quelle festlegen.
3. Das Ruleset aktiv speichern und beim nächsten PR prüfen: Eine Freigabe ist erforderlich, neue Änderungen machen alte Freigaben ungültig, offene Review-Kommentare und fehlgeschlagene Checks blockieren den Merge. Direkte Pushes, Force-Pushes und Löschen von `main` sind gesperrt. Die JSON-Datei allein aktiviert keinen Schutz.

Die [CI](../.github/workflows/ci.yml) prüft Pull Requests nach `main`, Pushes auf `main` und manuelle Läufe. Sie prüft die Pflichtdokumente und die Änderungen auf von Git erkannte Formatfehler und Konfliktmarker. Sie braucht keine Cloud-Zugangsdaten. App-Build und App-Tests kommen hinzu, sobald es App-Code gibt.

## Hosting vorbereiten

Die [Azure-Hosting-Anleitung](azure-hosting.md) beschreibt die vorbereitete Infrastruktur und den manuellen Release-Ablauf für die Willkommensseite.

Wenn das Team eine statische Web-App wählt und eine manuelle Freigabe zur Veröffentlichung genügt, zuerst statisches Hosting mit Vorschau prüfen. Wenn ein **echter Slot-Tausch** mit Rücktausch gewünscht bleibt, ist Azure App Service ab **Standard** die passende Option aus [ADR-0001](adr/0001-infrastruktur-und-release.md). In beiden Fällen bleiben Infrastruktur und Release-Regeln versioniert. Erst nach Teamentscheidung und Budgetklärung Ressourcen anlegen und `jausi.at` verbinden.

- [GitHub: Rulesets erstellen und importieren](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)
- [Azure App Service: Staging-Slots](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
