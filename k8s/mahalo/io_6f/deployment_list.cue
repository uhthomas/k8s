package io_6f

import (
	"k8s.io/api/core/v1"
	appsv1 "k8s.io/api/apps/v1"
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
		strategy: rollingUpdate: maxUnavailable: 1
		minReadySeconds: 1
		selector: matchLabels: {
			"app.kubernetes.io/name":      "io-6f"
			"app.kubernetes.io/instance":  "io-6f"
			"app.kubernetes.io/component": "io-6f"
		}
		template: {
			metadata: labels: {
				"app.kubernetes.io/name":      "io-6f"
				"app.kubernetes.io/instance":  "io-6f"
				"app.kubernetes.io/component": "io-6f"
			}
			spec: containers: [{
				name:            "io-6f"
				image:           "ghcr.io/uhthomas/6f.io:v1.4.2@sha256:ff08aa677e78155f51e55fd0a42ddb7c483ae68cabfef18442f182c66eb6267a"
				imagePullPolicy: v1.#PullIfNotPresent
				ports: [{
					name:          "http"
					containerPort: 80
				}]
				resources: {
					requests: {
						memory: "2Mi"
						cpu:    "2m"
					}
					limits: {
						memory: "8Mi"
						cpu:    "5m"
					}
				}
			}]
		}
	}
}]
