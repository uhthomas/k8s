package ingress_nginx

import batchv1 "k8s.io/api/batch/v1"

job: [...batchv1.#Job]

job: [{
	apiVersion: "batch/v1"
	kind:       "Job"
	metadata: {
		name: "ingress-nginx-admission-create"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	spec: template: {
		metadata: {
			name: "ingress-nginx-admission-create"
			labels: {
				"app.kubernetes.io/name":      "ingress-nginx"
				"app.kubernetes.io/instance":  "ingress-nginx"
				"app.kubernetes.io/version":   "0.44.0"
				"app.kubernetes.io/component": "admission-webhook"
			}
		}
		spec: {
			containers: [{
				name:            "create"
				image:           "docker.io/jettech/kube-webhook-certgen:v1.5.1"
				imagePullPolicy: "IfNotPresent"
				args: [
					"create",
					"--host=ingress-nginx-controller-admission,ingress-nginx-controller-admission.$(POD_NAMESPACE).svc",
					"--namespace=$(POD_NAMESPACE)",
					"--secret-name=ingress-nginx-admission",
				]
				env: [{
					name: "POD_NAMESPACE"
					valueFrom: fieldRef: fieldPath: "metadata.namespace"
				}]
			}]
			restartPolicy:      "OnFailure"
			serviceAccountName: "ingress-nginx-admission"
			securityContext: {
				runAsNonRoot: true
				runAsUser:    2000
			}
		}
	}
}, {
	apiVersion: "batch/v1"
	kind:       "Job"
	metadata: {
		name: "ingress-nginx-admission-patch"
		labels: {
			"app.kubernetes.io/name":      "ingress-nginx"
			"app.kubernetes.io/instance":  "ingress-nginx"
			"app.kubernetes.io/version":   "0.44.0"
			"app.kubernetes.io/component": "admission-webhook"
		}
	}
	spec: template: {
		metadata: {
			name: "ingress-nginx-admission-patch"
			labels: {
				"app.kubernetes.io/name":      "ingress-nginx"
				"app.kubernetes.io/instance":  "ingress-nginx"
				"app.kubernetes.io/version":   "0.44.0"
				"app.kubernetes.io/component": "admission-webhook"
			}
		}
		spec: {
			containers: [{
				name:            "patch"
				image:           "docker.io/jettech/kube-webhook-certgen:v1.5.1"
				imagePullPolicy: "IfNotPresent"
				args: [
					"patch",
					"--webhook-name=ingress-nginx-admission",
					"--namespace=$(POD_NAMESPACE)",
					"--patch-mutating=false",
					"--secret-name=ingress-nginx-admission",
					"--patch-failure-policy=Fail",
				]
				env: [{
					name: "POD_NAMESPACE"
					valueFrom: fieldRef: fieldPath: "metadata.namespace"
				}]
			}]
			restartPolicy:      "OnFailure"
			serviceAccountName: "ingress-nginx-admission"
			securityContext: {
				runAsNonRoot: true
				runAsUser:    2000
			}
		}
	}
}]
