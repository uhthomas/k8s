package store

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: {
		name:      "store"
		namespace: "thanos"
	}
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "store"
		template: {
			metadata: {
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/port":   "http"
				}
				labels: app: "store"
			}
			spec: {
				containers: [{
					name: "store"
					// v0.18.0
					image:           "quay.io/thanos/thanos@sha256:b94171aed499b2f1f81b6d3d385e0eeeca885044c59cef28ce6a9a9e8a827217"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						name:          "grpc"
						containerPort: 50051
					}, {
						name:          "http"
						containerPort: 80
					}]
					args: [
						"store",
						"--grpc-address=:50051",
						"--grpc-grace-period=5s",
						"--http-address=:80",
						"--http-grace-period=5s",
						"--objstore.config-file=/etc/secret/objstore.yaml",
					]
					resources: {
						requests: {
							memory: "128Mi"
							cpu:    "250m"
						}
						limits: {
							memory: "256Mi"
							cpu:    "1000m"
						}
					}
					volumeMounts: [{
						name:      "thanos"
						mountPath: "/etc/secret"
						readOnly:  true
					}]
					livenessProbe: {
						httpGet: {
							path: "/-/healthy"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/-/ready"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
				}]
				volumes: [{
					name: "thanos"
					secret: secretName: "thanos"
				}]
			}
		}
	}
}
