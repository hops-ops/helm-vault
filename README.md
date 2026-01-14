# helm-vault

Crossplane configuration that installs the HashiCorp Vault Helm chart with a minimal, stable interface.

## Overview

This configuration provides a Crossplane XRD for deploying HashiCorp Vault using the Helm provider. Vault is a secrets management tool that provides a secure way to store and access sensitive data like API keys, passwords, and certificates.

## Usage

### Minimal Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Vault
metadata:
  name: vault
  namespace: my-namespace
spec:
  clusterName: my-cluster
```

### Standard Example

```yaml
apiVersion: helm.hops.ops.com.ai/v1alpha1
kind: Vault
metadata:
  name: vault
  namespace: my-namespace
spec:
  clusterName: my-cluster
  namespace: vault
  labels:
    team: platform
    environment: production
  providerConfigRef:
    name: my-cluster
    kind: ProviderConfig
  values:
    server:
      ha:
        enabled: true
        replicas: 3
      dataStorage:
        enabled: true
        size: 10Gi
    ui:
      enabled: true
```

## Configuration Options

| Field | Description | Default |
|-------|-------------|---------|
| `clusterName` | Target cluster name (used for provider config) | Required |
| `namespace` | Kubernetes namespace for the release | `vault` |
| `name` | Helm release name | XR metadata.name |
| `labels` | Labels applied to managed resources | See below |
| `providerConfigRef.name` | Helm ProviderConfig name | `clusterName` |
| `providerConfigRef.kind` | ProviderConfig kind | `ProviderConfig` |
| `values` | Helm values (merged with defaults) | `{}` |
| `overrideAllValues` | Helm values (replaces all defaults) | `{}` |
| `managementPolicies` | Crossplane management policies | `["*"]` |

### Default Labels

```yaml
hops.ops.com.ai/managed: "true"
hops.ops.com.ai/vault: "<name>"
```

## Helm Chart

- **Chart**: vault
- **Repository**: https://helm.releases.hashicorp.com
- **Version**: 0.30.0

## Dependencies

- Provider: crossplane-contrib/provider-helm >= v1.0.6
- Function: crossplane-contrib/function-auto-ready >= v0.6.0
