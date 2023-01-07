# Overview

This repository contains the Terraform configuration for managing the configuration of my GitHub repositories. It includes the base configuration that should be applied to all repositories and any repository-specific configuration differences. The configuration is designed to be easily maintainable and reusable, allowing me to manage the configuration of my repositories in a single place.

Using this configuration, I can ensure that all my repositories have the same base configuration and can easily manage any configuration differences across repositories.

# Managed Resources

- GitHub repositories: These are the primary resources being managed by the configuration. The configuration can only modify and delete repositories, and cannot create new ones. To manage a repository with this configuration, it must first be created manually and then imported into the Terraform state.

# Prerequisites

- Terraform v1.3.2
- GitHub integration v5.12.0
- GITHUB_TOKEN environment variable

_This is what was used the last time major changes were made._

## Obtaining an API Token for Terraform

To acquire a GitHub Developer Classic token, follow these steps:

1. Go to the GitHub Developer Settings page in your account settings.
2. Click the "Generate new token" button, and pick the "Generate new token (classic)" option.
3. In the "Note" field, enter a descriptive note for the token, such as "Terraform configuration".
4. Select the "repo" scope to grant access to the repositories in your account.
5. Click the "Generate token" button.

The token will be displayed on the next page. Copy the token and store it securely, as it will not be shown again. You can use the token to authenticate the Terraform configuration with the GitHub API by setting it as the value of the GITHUB_TOKEN environment variable before running the configuration.

# Deploying the Terraform Configuration

1. Install Terraform: Follow the [installation instructions](https://www.terraform.io/downloads.html) for your platform to install Terraform.

2. Set the GITHUB_TOKEN environment variable: Replace your_github_token_here with the actual GitHub Developer Classic token you obtained earlier.
```bash
export GITHUB_TOKEN=your_github_token_here
```

3. Initialize the Terraform configuration: Navigate to the root directory of the repository and run the following command to initialize the configuration:
```bash
terraform init
```

4. Import the existing repositories: For each repository that you want to manage with the configuration, run the following command, replacing repo_name with the actual name of the repository:
```bash
terraform import 'github_repository.repo_config["repo_name"]' repo_name
```

5. Review and apply the changes: Run the following command to review the planned changes to the configuration:
```bash
terraform plan
```

Review the output carefully and ensure the planned changes are what you expected. When you are ready to apply the changes, run the following command:
```bash
terraform apply
```

## Tips for Working with the Configuration

- Use `terraform plan` to preview changes before applying them.
- Validate the configuration with `terraform validate`.
- Commit successful changes to Git for easy tracking and reverting.

# Known Issues

- Repository resources must be created manually and then imported into the Terraform state before they can be managed with Terraform. Refer to the "Deploying the Terraform Configuration" section for steps to import resources.
- Manually created resources may appear to be destroyed in the plan until they are imported into the Terraform state. Once imported, these resources' details may appear as changed in the plan.

To mitigate these issues:

- Avoid manually modifying or destroying resources.
- Import new resources into the Terraform state as soon as they are created.
- Pay attention to Terraform's plan and be mindful of its proposed changes.


# Additional Resources

- [Terraform documentation](https://www.terraform.io/docs/index.html)
- [GitHub provider documentation](https://www.terraform.io/docs/providers/github/index.html)
- [Generating a GitHub classic developer token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token#creating-a-personal-access-token-classic)

