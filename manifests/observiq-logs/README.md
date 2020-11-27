# observiq-logs

TODO: MOve this to blast-apps

ObserveIQ logs.  To use build out oiq.env "secrets".  **Note:** Make sure the values are NOT base64 encoded

```text
BP_AGENT_SECRET_KEY=secret
BP_CONFIGURATION_ID=id of source config
```

Then to implement

```yaml
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization

secretGenerator:
  envs:
  - oiq.env

resources:
  - github.com/ssmiller25/blast-apps/observiq-logs?ref=v1.0.0
```