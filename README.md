# Demo CI/CD with .NET 8 + Docker + GitHub Actions + GHCR + Kubernetes (kind) + Terraform

This repository is a small, end-to-end demo that shows:

- **CI**: Build & test a .NET 8 API, build a Docker image, and push it to **GHCR** (GitHub Container Registry).
- **Kubernetes**: Run the image in a local **kind** cluster using Deployment + Service + Ingress (NGINX).
- **IaC with Terraform**: Describe the K8s resources as code and apply them with `terraform`.

> Goal: a simple, reproducible project that demonstrates CI/CD, containers, K8s, and IaC.

---

## Repository structure
.
├─ api/
│ ├─ Demo.Api/ # .NET 8 minimal API + Dockerfile
│ └─ Demo.Api.Tests/ # xUnit tests (smoke)
├─ deploy/
│ └─ k8s/ # Raw K8s manifests (Deployment, Service, Ingress)
├─ infra/
│ └─ k8s/ # Terraform (kubernetes provider) for the same resources
└─ .github/workflows/ci.yml # GitHub Actions pipeline (CI -> GHCR)

---

## Prerequisites

- **Windows** with **Docker Desktop** (WSL2 engine enabled).
- **Chocolatey** or **winget** to install CLIs.
- Git + GitHub account (Actions + GHCR).

Install the tools (PowerShell):

```powershell
choco install kubernetes-cli -y
choco install kind -y
choco install kubernetes-helm -y
choco install terraform -y
