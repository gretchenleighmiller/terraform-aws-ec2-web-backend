locals {
  snake_case_name = join("_", regexall("[[:alnum:]]+", lower(var.name)))
  kebab_case_name = join("-", regexall("[[:alnum:]]+", lower(var.name)))

  domain_aliases = concat([var.fqdn], var.subject_alternative_names)
}
