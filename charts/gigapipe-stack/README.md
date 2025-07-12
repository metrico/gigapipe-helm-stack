# gigapipe-stack

A Helm chart for deploying a complete cluster monitoring stack with Gigapipe and Grafana.

## Dependencies

This chart includes the following Helm dependencies:

| Chart | Version | Reference | Optional |
|-------|---------|------------|----------|
| altinity-clickhouse-operator | 0.25.0 | https://github.com/Altinity/clickhouse-operator | No |
| grafana | 8.6.2 | https://github.com/grafana/helm-charts/tree/main/charts/grafana | Yes |

## Installation

```bash
# Update dependencies
helm dependency update ./charts/gigapipe-stack

# Install the chart
helm install releasename ./charts/gigapipe-stack
```

## Configuration

### ClickHouse

```yaml
clickhouse:
  storageClass: ""  # Storage class for PVCs (empty = default)
  shards: 1         # Number of shards
  replicas: 1       # Number of replicas per shard
```

When `shards > 1` or `replicas > 1`, ClickHouse Keeper is automatically deployed for coordination and Gigapipe is 
configured to run in sharded mode.

### Gigapipe


```yaml
gigapipe:
  replicaCount: 1
  image:
    repository: ghcr.io/metrico/gigapipe
    tag: "v4.0.16-beta"
  env:
    - name: LOG_DRILLDOWN
      value: "true"
```

For more information about how to configure Gigapipe with ENV variables see [Gigapipe documentation](https://gigapipe.com/docs/config.html).

### Grafana

```yaml
grafana:
  enabled: true
  adminUser: gigapipe
  adminPassword: gigapipe
```

Grafana comes pre-configured with:
- ClickHouse datasource (native protocol)
- Loki datasource (via Gigapipe)
- Tempo datasource (via Gigapipe)

For more information on how to configure Grafana see the [Grafana Helm Chart](https://github.com/grafana/helm-charts/tree/main/charts/grafana).

## Usage

After installation:

1. Access Grafana at `http://<service-ip>:80`
2. Login with `gigapipe`/`gigapipe`
3. Send logs/traces to Gigapipe at `http://<gigapipe-service>:3100`

## Roadmap

[] Add preconfigured support for cluster metrics & logs through [Opentelemetry](https://github.com/open-telemetry/opentelemetry-helm-charts/tree/main/charts/opentelemetry-kube-stack)
[] Install the Metrico [opentelemtry-collector](https://github.com/metrico/otel-collector)
