package prometheus

helm_release: {
	apiVersion: "helm.fluxcd.io/v1"
	kind:       "HelmRelease"
	metadata: name: "prometheus"
	spec: {
		releaseName: "prometheus"
		chart: {
			repository: "https://prometheus-community.github.io/helm-charts"
			name:       "prometheus"
			version:    "13.1.0"
		}
		values: {
			podSecurityPolicy: enabled: true
			kubeStateMetrics: enabled:  false
			configmapReload: prometheus: enabled: false
			server: {
				strategy: type: "Recreate"
				retention: "4h"
				global: {
					scrape_interval: "15s"
					external_labels: {
						cluster: "desire"
						replica: "$(POD_NAME)"
					}
				}
				extraFlags: [
					"web.enable-lifecycle",
					"storage.tsdb.min-block-duration=2h",
					"storage.tsdb.max-block-duration=2h",
				]
				configPath: "/etc/config-reload/prometheus.yaml"
				sidecarContainers: [{
					name: "thanos-sidecar"
					// v0.18.0
					image: "quay.io/thanos/thanos@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
					args: [
						"sidecar",
						"--grpc-address=:50051",
						"--grpc-grace-period=5s",
						"--http-address=:8080",
						"--http-grace-period=5s",
						"--tsdb.path=/data",
						"--prometheus.url=http://127.0.0.1:9090",
						"--objstore.config-file=/etc/secret/objstore.yaml",
						"--reloader.config-file=/etc/config/prometheus.yml",
						"--reloader.config-envsubst-file=/etc/config-reload/prometheus.yaml",
					]
					ports: [{
						name:          "thanos-http"
						containerPort: 8080
					}, {
						name:          "thanos-grpc"
						containerPort: 50051
					}]
					env: [{
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}]
					volumeMounts: [{
						name:      "storage-volume"
						mountPath: "/data"
					}, {
						name:      "thanos"
						mountPath: "/etc/secret"
						readOnly:  true
					}, {
						name:      "config-volume"
						mountPath: "/etc/config"
					}, {
						name:      "config-reload"
						mountPath: "/etc/config-reload"
					}]
					livenessProbe: {
						httpGet: {
							path: "/-/healthy"
							port: "thanos-http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/-/ready"
							port: "thanos-http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
				}]
				extraVolumes: [{
					name: "config-reload"
					emptyDir: {}
				}]
				extraVolumeMounts: [{
					name:      "config-reload"
					mountPath: "/etc/config-reload"
				}]
				extraSecretMounts: [{
					name:       "thanos"
					mountPath:  "/etc/secret"
					secretName: "thanos"
				}]
			}
		}
	}
}