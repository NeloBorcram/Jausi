variable "subscription_id" {
  type = string
}

variable "location" {
  type    = string
  default = "westeurope"
}

variable "name_prefix" {
  type        = string
  description = "Global eindeutiges Präfix für die App-Service-Namen."

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,30}[a-z0-9]$", var.name_prefix))
    error_message = "Das Präfix muss 4–32 Zeichen haben und aus Kleinbuchstaben, Ziffern oder Bindestrichen bestehen."
  }
}

variable "github_owner" {
  type    = string
  default = "NeloBorcram"
}

variable "github_repository" {
  type    = string
  default = "Jausi"
}

variable "production_reviewer_ids" {
  type        = set(number)
  description = "Numerische GitHub-IDs der Produktionsfreigebenden."

  validation {
    condition     = length(var.production_reviewer_ids) >= 2 && length(var.production_reviewer_ids) <= 6 && alltrue([for id in var.production_reviewer_ids : id > 0 && floor(id) == id])
    error_message = "Zwei bis sechs numerische GitHub-Benutzer-IDs angeben, damit eine andere Person freigeben kann."
  }
}

variable "bind_production_domain" {
  type        = bool
  default     = false
  description = "Erst nach Einrichtung der DNS-Einträge aktivieren."
}

variable "production_domain" {
  type    = string
  default = "jausi.at"
}

variable "manage_azure_dns" {
  type    = bool
  default = false
}

variable "enable_release_workflow" {
  type        = bool
  default     = false
  description = "Automatische Deployments von develop nach Prüfung der Umgebungsschutzregeln aktivieren."
}

variable "production_apex_ipv4" {
  type        = string
  default     = null
  description = "Öffentliche Eingangs-IP aus der App-Service-Ansicht für benutzerdefinierte Domänen."

  validation {
    condition     = var.production_apex_ipv4 == null || can(cidrnetmask("${var.production_apex_ipv4}/32"))
    error_message = "Eine IPv4-Adresse ohne Netzmaske angeben."
  }
}
