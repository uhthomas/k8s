package cert_manager

import corev1 "k8s.io/api/core/v1"

namespace: corev1.#Namespace & {
	apiVersion: "v1"
	kind:       "Namespace"
	metadata: name: "cert-manager"
}