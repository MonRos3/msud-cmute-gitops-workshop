# Metrics — Prometheus Exporter for PaperMC

Add a Prometheus metrics endpoint to your PaperMC server so it can be scraped by monitoring tools.

## What changes?

Three files get updated:

- **Dockerfile** — Adds the [Prometheus Exporter](https://github.com/sladkoff/minecraft-prometheus-exporter) plugin to the server. This exposes metrics at `localhost:9940/metrics` inside the container.
- **deployment.yaml** — Adds port `9940` so the metrics endpoint is reachable within the cluster.
- **service.yaml** — Adds a named `metrics` port so Prometheus can discover and scrape it.

## Copy the updated files

```bash
cp workshop/metrics/Dockerfile Dockerfile
cp workshop/metrics/deployment.yaml k8s/deployment.yaml
cp workshop/metrics/service.yaml k8s/service.yaml
```

## Update the image reference

Edit `k8s/deployment.yaml` and replace `<YOUR_GITHUB_USERNAME>` with your GitHub username if needed.

## Commit and push

```bash
git add Dockerfile k8s/deployment.yaml k8s/service.yaml
git commit -m "feat: add prometheus metrics exporter"
git push
```

Two things happen:

1. **CI rebuilds your image** with the Prometheus exporter plugin baked in.
2. **ArgoCD syncs** the updated deployment and service to your cluster.

## Wait for the new image

1. Go to the **Actions** tab and wait for the build to complete.
2. Force your cluster to pull the new image:

```bash
kubectl rollout restart deployment paper -n paper
```

## Verify it works

Once the new pod is running:

```bash
kubectl port-forward svc/paper -n paper 9940:9940
```

In another terminal:

```bash
curl localhost:9940/metrics
```

You should see Prometheus-formatted metrics including:

- `mc_players_online_total` — current player count
- `mc_tps` — server ticks per second (20 = healthy)
- `mc_tick_duration_average` — average tick duration in ms
- `mc_tick_duration_median` — median tick duration
- `mc_tick_duration_max` — max tick duration
- `mc_loaded_chunks_total` — number of loaded chunks
- `mc_entities_total` — total entities
- `mc_jvm_memory` — JVM heap usage

These metrics are now ready to be scraped by Prometheus.
