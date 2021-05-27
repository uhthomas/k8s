package metrics_server

import (
	appsv1 "k8s.io/api/apps/v1"
	"k8s.io/api/core/v1"
)

deploymentList: appsv1.#DeploymentList & {
	apiVersion: "apps/v1"
	kind:       "DeploymentList"
	items: [...{
		apiVersion: "apps/v1"
		kind:       "Deployment"
	}]
}

deploymentList: items: [{
	spec: {
		revisionHistoryLimit:    5
		progressDeadlineSeconds: 120
		strategy: rollingUpdate: maxUnavailable: 0
		minReadySeconds: 1
		selector: matchLabels: app: "metrics-server"
		template: {
			metadata: labels: app: "metrics-server"
			spec: {
				serviceAccountName: "metrics-server"
				volumes: [{
					// mount in tmp so we can safely use from-scratch images and/or read-only containers
					name: "tmp-dir"
					emptyDir: {}
				}]
				priorityClassName: "system-cluster-critical"
				containers: [{
					name:            "metrics-server"
					image:           "k8s.gcr.io/metrics-server/metrics-server:v0.4.2@sha256:dbc33d7d35d2a9cc5ab402005aa7a0d13be6192f3550c7d42cba8d2d5e3a5d62"
					imagePullPolicy: v1.#PullIfNotPresent
					args: [
						"--cert-dir=/tmp",
						"--secure-port=4443",
						"--kubelet-preferred-address-types=InternalIP,ExternalIP,Hostname",
						"--kubelet-use-node-status-port",
						"--metric-resolution=15s",
						"--kubelet-insecure-tls=true",
					]
					resources: requests: {
						cpu:    "100m"
						memory: "300Mi"
					}
					ports: [{
						name:          "https"
						containerPort: 4443
						protocol:      "TCP"
					}]
					readinessProbe: {
						httpGet: {
							path:   "/readyz"
							port:   "https"
							scheme: "HTTPS"
						}
						periodSeconds:    10
						failureThreshold: 3
					}
					livenessProbe: {
						httpGet: {
							path:   "/livez"
							port:   "https"
							scheme: "HTTPS"
						}
						periodSeconds:    10
						failureThreshold: 3
					}
					securityContext: {
						readOnlyRootFilesystem: true
						runAsNonRoot:           true
						runAsUser:              1000
					}
					volumeMounts: [{
						name:      "tmp-dir"
						mountPath: "/tmp"
					}]
				}]
				nodeSelector: "kubernetes.io/os": "linux"
			}
		}
	}
}]