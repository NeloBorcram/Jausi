# Willkommensseite über GitHub Pages

**Ausweichvorschlag, noch nicht aktiviert.** Keine der für das genutzte Azure-for-Students-Abonnement erlaubten Regionen unterstützt Azure Static Web Apps. Die statische Willkommensseite kann über GitHub Pages aus dem öffentlichen Repository veröffentlicht werden. Sie bleibt im Repository versioniert; `main` bleibt unverändert. Die Azure-Vorbereitung bleibt als spätere Option erhalten.

## Veröffentlichung vorbereiten

1. Auf GitHub **Settings → Pages → Build and deployment → Source → GitHub Actions** wählen.
2. Unter **Settings → Environments → github-pages** die Branch-Regel auf `develop` begrenzen und mindestens eine andere Person als erforderlichen Reviewer eintragen. Den Schutz von `develop` beibehalten.
3. Unter **Settings → Secrets and variables → Actions → Variables** die Repository-Variable `WELCOME_PAGES_ENABLED` auf `true` setzen.
4. Die Änderungen per PR nach `develop` integrieren. Der Push startet **Publish welcome page**. Nach Freigabe zunächst die vom Deployment angezeigte URL testen. Für das öffentliche Repository `NeloBorcram/Jausi` ist die Standardadresse `https://neloborcram.github.io/Jausi/`.

## jausi.at bei easyname verbinden

1. Empfohlen: `jausi.at` unter **GitHub-Kontoeinstellungen → Pages** verifizieren. Den von GitHub generierten TXT-Eintrag bei easyname hinterlegen.
2. Im Repository unter **Settings → Pages → Custom domain** `jausi.at` eintragen. In easyname unter **Domains → DNS** bzw. **CloudPit → DNS-Verwaltung** die folgenden Einträge setzen, sofern easyname die autoritativen Nameserver betreibt. Vorhandene konkurrierende Web-Einträge für `@` und `www` prüfen; Mail-Einträge unverändert lassen.

| Typ | Name | Ziel |
| --- | --- | --- |
| A | @ | 185.199.108.153 |
| A | @ | 185.199.109.153 |
| A | @ | 185.199.110.153 |
| A | @ | 185.199.111.153 |
| CNAME | www | neloborcram.github.io |

3. In GitHub den DNS-Check abwarten und **Enforce HTTPS** aktivieren. Danach `https://jausi.at` und die Weiterleitung von `www` testen.

Der Workflow veröffentlicht nur HTML und die beiden Bilddateien. GitHub Pages hat keinen Azure-Slot-Tausch. Die Freigabe schützt die Veröffentlichung; für einen Rückwechsel kann eine geprüfte Rücknahme per PR nach `develop` veröffentlicht werden.

- [GitHub Pages: Eigene Domain einrichten](https://docs.github.com/en/pages/configuring-a-custom-domain-for-your-github-pages-site/managing-a-custom-domain-for-your-github-pages-site)
- [easyname: DNS-Einträge verwalten](https://www.easyname.com/en/support/domains/dns/how-do-i-manage-my-dns-records)
- [Microsoft: Regionen für Static Web Apps](https://github.com/microsoft/azure-skills/blob/main/skills/azure-validate/references/region-availability.md)
