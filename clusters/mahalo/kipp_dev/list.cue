package kipp_dev

import "k8s.io/api/core/v1"

v1.#List & {
	apiVersion: "v1"
	kind:       "List"
	items: [...{
		metadata: {
			name:      "kipp-dev"
			namespace: "kipp-dev"
			labels: {
				"app.kubernetes.io/name":      "kipp-dev"
				"app.kubernetes.io/instance":  "kipp-dev"
				"app.kubernetes.io/version":   "0.2.1"
				"app.kubernetes.io/component": "kipp-dev"
			}
		}
	}]
}

items:
	namespace.items +
	network_policy.items +
	sealed_secret.items +
	service.items +
	deployment.items +
	horizontal_pod_autoscaler.items +
	ingress.items
