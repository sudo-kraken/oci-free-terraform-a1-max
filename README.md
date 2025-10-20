<div align="center">
<img src="docs/assets/logo.png" align="center" width="144px" height="144px"/>

### OCI A1 Max Terraform Module

_Opinionated Terraform for Oracle Cloud Infrastructure that provisions a free-tier friendly A1 Flex instance with networking and storage. Includes a ready-to-run GitHub Actions workflow._
</div>

<div align="center">

[![Terraform](https://img.shields.io/badge/Terraform-Required-623CE4?logo=terraform&logoColor=white&style=for-the-badge)](https://www.terraform.io/)
[![Terraform Version](https://img.shields.io/badge/Terraform-1.6%2B-623CE4?logo=terraform&logoColor=white&style=for-the-badge)](https://www.terraform.io/)

</div>

<div align="center">

[![OpenSSF Scorecard](https://img.shields.io/ossf-scorecard/github.com/sudo-kraken/oci-free-terraform-a1-max?label=openssf%20scorecard&style=for-the-badge)](https://scorecard.dev/viewer/?uri=github.com/sudo-kraken/oci-free-terraform-a1-max)

</div>

## Contents

- [Overview](#overview)
- [Architecture at a glance](#architecture-at-a-glance)
- [Features](#features)
- [Prerequisites](#prerequisites)
  - [Secrets required](#secrets-required)
- [Automated deployment with GitHub Actions](#automated-deployment-with-github-actions)
  - [GitHub Action execution](#github-action-execution)
  - [Accessing the instance](#accessing-the-instance)
- [Quick start](#quick-start)
- [Troubleshooting](#troubleshooting)
- [Licence](#licence)
- [Security](#security)
- [Contributing](#contributing)
- [Support](#support)

## Overview

This module provisions an Oracle Cloud Infrastructure environment tailored to the free-tier allowances. It creates compute, networking and storage to run useful workloads at zero cost where available.

The stack deploys:
- **1x VM.Standard.A1.Flex** instance with **4 OCPUs** and **24 GB RAM**
- **100 GB boot volume** plus an additional **100 GB block volume**
- A **Virtual Cloud Network** with subnets, security lists and an internet gateway

## Architecture at a glance

- Terraform defines:
  - VCN, public subnets, security lists and internet gateway
  - One A1 Flex compute instance
  - One attached block volume
- Opinionated security lists for typical access patterns
- Outputs expose public IP and key resource identifiers

## Features

- Free-tier friendly shapes and sizes
- Baseline networking with public access where required
- Automated plan and apply via GitHub Actions
- Automatic clean-up on failure to keep the tenancy tidy

## Prerequisites

- Oracle Cloud Infrastructure account
- Terraform 1.6 or newer
- **OCI API credentials** stored as GitHub Secrets

### Secrets required

| Secret name | Description |
|-------------|-------------|
| `PAT_TOKEN` | Personal access token used by the pipeline to check out the repository |
| `PKEY` | OCI SSH private key |
| `TENANCY_OCID` | OCID of your tenancy |
| `USER_OCID` | OCID of your user |
| `FP` | Fingerprint for the user’s API key |
| `SSH_PUB_KEY` | SSH public key added to the instance for access |

## Automated deployment with GitHub Actions

The workflow **Execute OCI Pipeline** performs the following:

- Checks out the repository to the GitHub runner
- Sets up **Node.js** and the **Terraform CLI**
- Configures the SSH private key and Terraform variables from **GitHub Secrets**
- Initialises Terraform, creates a plan and applies it
- On failure, automatically destroys provisioned resources to return to a clean state

### GitHub Action execution

The root **`main.tf`** is the entry point used by the workflow. It wires the module, variables and any provisioners. As part of instance initialisation it **updates packages** and installs **Docker** and **Docker Compose**.

### Accessing the instance

When the workflow completes successfully, the **public IP** is shown in the Terraform outputs. Connect using:

- Username: `opc`  
- Authentication: your SSH key corresponding to `SSH_PUB_KEY`

## Quick start

1. **Fork or clone** this repository into your GitHub account.
2. Add the **GitHub Secrets** listed above in your repository settings.
3. Review `main.tf` and variables for region, compartment and any tags.
4. Open the **Actions** tab, select **Execute OCI Pipeline**, provide inputs and **run** it.
5. Use the outputs to **SSH** to the instance as `opc`.

## Troubleshooting

- **Apply failed or timed out**  
  Check Actions logs for missing or incorrect secrets. Confirm tenancy, compartment and region values.
- **Cannot SSH**  
  Ensure `SSH_PUB_KEY` matches your private key and that security lists allow ingress from your IP.
- **Quota or capacity constraints**  
  Free-tier entitlements and regional capacity can vary. Try another region or adjust shapes.

## Licence

This project is licensed under the MIT Licence. See the [LICENCE](LICENCE) file for details.

## Security

If you discover a security issue, please review and follow the guidance in [SECURITY.md](SECURITY.md), or open a private security-focused issue with minimal details and request a secure contact channel.

## Contributing

Feel free to open issues or submit pull requests if you have suggestions or improvements.  
See [CONTRIBUTING.md](CONTRIBUTING.md)

## Support

Open an [issue](/../../issues) with as much detail as possible, including your tenancy region, the workflow you ran and relevant Terraform logs.
