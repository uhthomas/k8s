package kipp_dev

import appsv1 "k8s.io/api/apps/v1"

deployment: appsv1.#Deployment & {
	apiVersion: "apps/v1"
	kind:       "Deployment"
	metadata: name: "kipp"
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: app: "kipp"
		template: {
			metadata: {
				annotations: {
					"prometheus.io/scrape": "true"
					"prometheus.io/path":   "/varz"
				}
				labels: app: "kipp"
			}
			spec: {
				containers: [{
					name: "kipp"
					// v0.2.1
					image:           "uhthomas/kipp@sha256:1c1ab66793cd2232552ec3e6fe08588297cec5ed45b7de84e6a057148c874263"
					imagePullPolicy: "IfNotPresent"
					ports: [{
						name:          "http"
						containerPort: 80
					}]
					env: [{
						name:  "AWS_SHARED_CREDENTIALS_FILE"
						value: "/aws-config"
					}, {
						name: "DATABASE"
						valueFrom: secretKeyRef: {
							name: "kipp"
							key:  "database"
						}
					}]
					args: [
						"--database=$(DATABASE)",
						"--filesystem=s3://fr-par/kipp-dev?endpoint=s3.fr-par.scw.cloud",
					]
					resources: {
						requests: {
							memory: "16Mi"
							cpu:    "150m"
						}
						limits: {
							memory: "64Mi"
							cpu:    "400m"
						}
					}
					volumeMounts: [{
						name:      "kipp"
						mountPath: "/aws-config"
						readOnly:  true
						subPath:   "aws-config"
					}]
					livenessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
					readinessProbe: {
						httpGet: {
							path: "/healthz"
							port: "http"
						}
						initialDelaySeconds: 5
						periodSeconds:       3
					}
				}]
				volumes: [{
					name: "kipp"
					secret: secretName: "kipp"
				}]
			}
		}
	}
}