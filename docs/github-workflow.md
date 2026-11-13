# Zusammenarbeit auf GitHub

> [!NOTE]
> **Vorgehen seit 13.11.2026 (Vorschlag von Roger):** Solange nur Dokumentation entsteht (Phase 1 und 2), arbeitet das Team direkt auf `main`. Der folgende Ablauf mit Branch, Pull Request und Review sowie der Schutz für `main` gelten, sobald App-Code entsteht.

`main` enthält den gemeinsamen, geprüften Stand. Pro Aufgabe arbeitet eine Person auf einem kurzen Branch (z. B. `docs/phase-1-review`). Der Pull Request beschreibt Änderung und Prüfung und verweist bei Bedarf auf ein Issue, eine Story-ID oder einen ADR. Ein anderes Teammitglied prüft den PR. Nach grünem Check, Freigabe und geklärten Review-Kommentaren empfehlen wir **Squash and merge**. Anschließend kann der Branch gelöscht werden.

Für vier Personen reicht ein gemeinsames Backlog, etwa GitHub Issues mit einem einfachen Board „Offen → In Arbeit → Review → Erledigt“. Wenn Azure Boards genutzt wird, Aufgaben nur dort pflegen und vom PR aus verlinken.

## Schutz für main aktivieren

1. Die CI-Datei aus diesem Änderungssatz zuerst per PR nach `main` bringen. Prüfen, dass GitHub Actions den Job **Repository checks** tatsächlich ausführt. Ein erfolgreicher Lauf auf `main` erleichtert die Auswahl des Checks in den Einstellungen.
2. Als Repository-Admin **Settings → Rules → Rulesets → New ruleset → Import a ruleset** öffnen und [main.json](../.github/rulesets/main.json) importieren. Vor dem Speichern `main` als Ziel und **Repository checks** als erforderlichen Check bestätigen. Wenn GitHub die Auswahl anbietet, **GitHub Actions** als Quelle festlegen.
3. Das Ruleset aktiv speichern und beim nächsten PR prüfen: Eine Freigabe ist erforderlich, neue Änderungen machen alte Freigaben ungültig, offene Review-Kommentare und fehlgeschlagene Checks blockieren den Merge. Direkte Pushes, Force-Pushes und Löschen von `main` sind gesperrt. Die JSON-Datei allein aktiviert keinen Schutz.

Die [CI](../.github/workflows/ci.yml) prüft Pull Requests nach `main`, Pushes auf `main` und manuelle Läufe. Sie prüft die Pflichtdokumente und die Änderungen auf von Git erkannte Formatfehler und Konfliktmarker. Sie braucht keine Cloud-Zugangsdaten. App-Build und App-Tests kommen hinzu, sobald es App-Code gibt.

## Hosting später entscheiden

Wenn das Team eine statische Web-App wählt und eine manuelle Freigabe zur Veröffentlichung genügt, zuerst statisches Hosting mit Vorschau prüfen. Wenn ein **echter Slot-Tausch** mit Rücktausch gewünscht bleibt, ist Azure App Service ab **Standard** die passende Option aus [ADR-0001](adr/0001-infrastruktur-und-release.md). In beiden Fällen bleiben Infrastruktur und Release-Regeln versioniert. Erst nach Teamentscheidung und Budgetklärung Ressourcen anlegen und `jausi.at` verbinden. Den Vergleich der Optionen mit Kosten enthält [hosting.md](hosting.md).

- [GitHub: Rulesets erstellen und importieren](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/creating-rulesets-for-a-repository)
- [Azure App Service: Staging-Slots](https://learn.microsoft.com/en-us/azure/app-service/deploy-staging-slots)
