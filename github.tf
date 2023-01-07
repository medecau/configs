terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }
  }
}

provider "github" {
  owner = "medecau"
}

variable "repo_config" {
  type = map(object({
    description  = string
    homepage_url = string
    topics       = list(string)
    has_issues   = bool
  }))
  default = {
    "QuadEncoder" = {
      description  = "Arduino library for quadratic rotary encoder"
      homepage_url = null
      topics       = ["arduino", "encoder", "quadratic-encoder", "rotary-encoder"]
      has_issues   = null
    }
    "aoc" = {
      description  = "Advent of Code"
      homepage_url = null
      topics       = ["advent-of-code", "aoc"]
      has_issues   = null
    }
    "exercises" = {
      description  = "Programming exercises"
      homepage_url = null
      topics       = ["exercises", "programming"]
      has_issues   = null
    }
    "hello-web" = {
      description  = "test repo;please ignore"
      homepage_url = null
      topics       = null
      has_issues   = null
    }
    "libdevguide" = {
      description  = "Guidelines to write better libraries."
      homepage_url = null
      topics       = null
      has_issues   = null
    }
    "medecau" = {
      description  = "medecau's github"
      homepage_url = "https://github.com/medecau"
      topics       = ["github", "medecau"]
      has_issues   = null
    }
    "sched2" = {
      description  = "Event scheduler 2"
      homepage_url = "https://medecau.github.io/sched2/"
      topics       = ["cron", "python", "scheduler", "scheduling"]
      has_issues   = true
    }
    "scrapedict" = {
      description  = "Scrape HTML to dictionaries"
      homepage_url = null
      topics       = ["scrape", "scraping", "web-scraping", "webscraping"]
      has_issues   = true
    }
    "sevenproxies" = {
      description  = "cloaky http redirector"
      homepage_url = null
      topics       = ["http", "redirector", "proxy"]
      has_issues   = null
    }
    "simpletest" = {
      description  = "Easy testing for embedded Python"
      homepage_url = null
      topics       = ["testing", "unittest", "embedded-python", "circuitpython"]
      has_issues   = true
    }
    "taskqueue" = {
      description  = "A set of classes to queue and thread function calls"
      homepage_url = null
      topics       = ["task-queue", "taskqueue", "queue", "tasks"]
      has_issues   = null
    }
    "trackhub" = {
      description  = "Bittorrent http tracker hub [DEAD]"
      homepage_url = null
      topics       = ["bittorrent", "tracker", "tracker-hub"]
      has_issues   = null
    }
    "yamly" = {
      description  = null
      homepage_url = null
      topics       = ["yaml"]
      has_issues   = null
    }
  }
}
variable "default_repo_config" {
  type = object({
    description  = string
    homepage_url = string
    topics       = list(string)
    has_issues   = bool
  })
  default = {
    description  = null
    homepage_url = null
    topics       = null
    has_issues   = null
  }
}

data "github_repositories" "medecau_repos" {
  query           = "user:medecau"
  include_repo_id = true
}

resource "github_repository" "repo_config" {
  # cast to set to remove duplicates
  for_each = toset(data.github_repositories.medecau_repos.names)
  name     = each.value

  description  = lookup(var.repo_config, each.value, var.default_repo_config).description
  homepage_url = lookup(var.repo_config, each.value, var.default_repo_config).homepage_url
  topics       = lookup(var.repo_config, each.value, var.default_repo_config).topics

  has_issues           = lookup(var.repo_config, each.value, var.default_repo_config).has_issues
  has_projects         = false
  has_wiki             = false
  vulnerability_alerts = true
  security_and_analysis {
    advanced_security {
      status = "enabled"
    }
    secret_scanning {
      status = "enabled"
    }
    secret_scanning_push_protection {
      status = "enabled"
    }
  }
}
