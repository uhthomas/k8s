package rook_ceph

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
	// CSI_VOLUME_REPLICATION_IMAGE: "quay.io/csiaddons/volumereplication-operator:v0.1.0"
	// (Optional) Admission controller NodeAffinity.
	// ADMISSION_CONTROLLER_NODE_AFFINITY: "role=storage-node; storage=rook, ceph"
	// (Optional) Admission controller tolerations list. Put here list of taints you want to tolerate in YAML format.
	// Admission controller would be best to start on the same nodes as other ceph daemons.
	// ADMISSION_CONTROLLER_TOLERATIONS: |
	//   - effect: NoSchedule
	//     key: node-role.kubernetes.io/controlplane
	//     operator: Exists
	//   - effect: NoExecute
	//     key: node-role.kubernetes.io/etcd
	//     operator: Exists
	// OLM: BEGIN OPERATOR DEPLOYMENT
	metadata: {
		name: "rook-ceph-operator"
		labels: {
			operator:          "rook"
			"storage-backend": "ceph"
		}
	}
	spec: {
		selector: matchLabels: app: "rook-ceph-operator"
		replicas: 1
		template: {
			metadata: labels: app: "rook-ceph-operator"
			spec: {
				serviceAccountName: "rook-ceph-system"
				containers: [{
					name:            "rook-ceph-operator"
					image:           "rook/ceph:v1.6.3@sha256:8c787d33968e685558f1830a7f6a81a4a43b96d4cb2dba65867f09363f3f2d73"
					imagePullPolicy: v1.#PullIfNotPresent
					args: ["ceph", "operator"]
					volumeMounts: [{
						mountPath: "/var/lib/rook"
						name:      "rook-config"
					}, {
						mountPath: "/etc/ceph"
						name:      "default-config-dir"
					}]
					env: [{
						// If the operator should only watch for cluster CRDs in the same namespace, set this to "true".
						// If this is not set to true, the operator will watch for cluster CRDs in all namespaces.
						name:  "ROOK_CURRENT_NAMESPACE_ONLY"
						value: "false"
					}, {
						// To disable RBAC, uncomment the following:
						// - name: RBAC_ENABLED
						//   value: "false"
						// Rook Agent toleration. Will tolerate all taints with all keys.
						// Choose between NoSchedule, PreferNoSchedule and NoExecute:
						// - name: AGENT_TOLERATION
						//   value: "NoSchedule"
						// (Optional) Rook Agent toleration key. Set this to the key of the taint you want to tolerate
						// - name: AGENT_TOLERATION_KEY
						//   value: "<KeyOfTheTaintToTolerate>"
						// (Optional) Rook Agent tolerations list. Put here list of taints you want to tolerate in YAML format.
						// - name: AGENT_TOLERATIONS
						//   value: |
						//     - effect: NoSchedule
						//       key: node-role.kubernetes.io/controlplane
						//       operator: Exists
						//     - effect: NoExecute
						//       key: node-role.kubernetes.io/etcd
						//       operator: Exists
						// (Optional) Rook Agent priority class name to set on the pod(s)
						// - name: AGENT_PRIORITY_CLASS_NAME
						//   value: "<PriorityClassName>"
						// (Optional) Rook Agent NodeAffinity.
						// - name: AGENT_NODE_AFFINITY
						//   value: "role=storage-node; storage=rook,ceph"
						// (Optional) Rook Agent mount security mode. Can by `Any` or `Restricted`.
						// `Any` uses Ceph admin credentials by default/fallback.
						// For using `Restricted` you must have a Ceph secret in each namespace storage should be consumed from and
						// set `mountUser` to the Ceph user, `mountSecret` to the Kubernetes secret name.
						// to the namespace in which the `mountSecret` Kubernetes secret namespace.
						// - name: AGENT_MOUNT_SECURITY_MODE
						//   value: "Any"
						// Set the path where the Rook agent can find the flex volumes
						// - name: FLEXVOLUME_DIR_PATH
						//   value: "<PathToFlexVolumes>"
						// Set the path where kernel modules can be found
						// - name: LIB_MODULES_DIR_PATH
						//   value: "<PathToLibModules>"
						// Mount any extra directories into the agent container
						// - name: AGENT_MOUNTS
						//   value: "somemount=/host/path:/container/path,someothermount=/host/path2:/container/path2"
						// Rook Discover toleration. Will tolerate all taints with all keys.
						// Choose between NoSchedule, PreferNoSchedule and NoExecute:
						// - name: DISCOVER_TOLERATION
						//   value: "NoSchedule"
						// (Optional) Rook Discover toleration key. Set this to the key of the taint you want to tolerate
						// - name: DISCOVER_TOLERATION_KEY
						//   value: "<KeyOfTheTaintToTolerate>"
						// (Optional) Rook Discover tolerations list. Put here list of taints you want to tolerate in YAML format.
						// - name: DISCOVER_TOLERATIONS
						//   value: |
						//     - effect: NoSchedule
						//       key: node-role.kubernetes.io/controlplane
						//       operator: Exists
						//     - effect: NoExecute
						//       key: node-role.kubernetes.io/etcd
						//       operator: Exists
						// (Optional) Rook Discover priority class name to set on the pod(s)
						// - name: DISCOVER_PRIORITY_CLASS_NAME
						//   value: "<PriorityClassName>"
						// (Optional) Discover Agent NodeAffinity.
						// - name: DISCOVER_AGENT_NODE_AFFINITY
						//   value: "role=storage-node; storage=rook, ceph"
						// (Optional) Discover Agent Pod Labels.
						// - name: DISCOVER_AGENT_POD_LABELS
						//   value: "key1=value1,key2=value2"
						// The logging level for the operator: INFO | DEBUG
						name:  "ROOK_LOG_LEVEL"
						value: "INFO"
					}, {
						// The duration between discovering devices in the rook-discover daemonset.
						name:  "ROOK_DISCOVER_DEVICES_INTERVAL"
						value: "60m"
					}, {
						// Whether to start pods as privileged that mount a host path, which includes the Ceph mon and osd pods.
						// Set this to true if SELinux is enabled (e.g. OpenShift) to workaround the anyuid issues.
						// For more details see https://github.com/rook/rook/issues/1314#issuecomment-355799641
						name:  "ROOK_HOSTPATH_REQUIRES_PRIVILEGED"
						value: "false"
					}, {
						// In some situations SELinux relabelling breaks (times out) on large filesystems, and doesn't work with cephfs ReadWriteMany volumes (last relabel wins).
						// Disable it here if you have similar issues.
						// For more details see https://github.com/rook/rook/issues/2417
						name:  "ROOK_ENABLE_SELINUX_RELABELING"
						value: "true"
					}, {
						// In large volumes it will take some time to chown all the files. Disable it here if you have performance issues.
						// For more details see https://github.com/rook/rook/issues/2254
						name:  "ROOK_ENABLE_FSGROUP"
						value: "true"
					}, {
						// Disable automatic orchestration when new devices are discovered
						name:  "ROOK_DISABLE_DEVICE_HOTPLUG"
						value: "false"
					}, {
						// Provide customised regex as the values using comma. For eg. regex for rbd based volume, value will be like "(?i)rbd[0-9]+".
						// In case of more than one regex, use comma to separate between them.
						// Default regex will be "(?i)dm-[0-9]+,(?i)rbd[0-9]+,(?i)nbd[0-9]+"
						// Add regex expression after putting a comma to blacklist a disk
						// If value is empty, the default regex will be used.
						name:  "DISCOVER_DAEMON_UDEV_BLACKLIST"
						value: "(?i)dm-[0-9]+,(?i)rbd[0-9]+,(?i)nbd[0-9]+"
					}, {
						// Time to wait until the node controller will move Rook pods to other
						// nodes after detecting an unreachable node.
						// Pods affected by this setting are:
						// mgr, rbd, mds, rgw, nfs, PVC based mons and osds, and ceph toolbox
						// The value used in this variable replaces the default value of 300 secs
						// added automatically by k8s as Toleration for
						// <node.kubernetes.io/unreachable>
						// The total amount of time to reschedule Rook pods in healthy nodes
						// before detecting a <not ready node> condition will be the sum of:
						//  --> node-monitor-grace-period: 40 seconds (k8s kube-controller-manager flag)
						//  --> ROOK_UNREACHABLE_NODE_TOLERATION_SECONDS: 5 seconds
						name:  "ROOK_UNREACHABLE_NODE_TOLERATION_SECONDS"
						value: "5"
					}, {
						// The name of the node to pass with the downward API
						name: "NODE_NAME"
						valueFrom: fieldRef: fieldPath: "spec.nodeName"
					}, {
						// The pod name to pass with the downward API
						name: "POD_NAME"
						valueFrom: fieldRef: fieldPath: "metadata.name"
					}, {
						// The pod namespace to pass with the downward API
						name: "POD_NAMESPACE"
						valueFrom: fieldRef: fieldPath: "metadata.namespace"
					}]
				}]

				//  Uncomment it to run lib bucket provisioner in multithreaded mode
				//- name: LIB_BUCKET_PROVISIONER_THREADS
				//  value: "5"
				// Uncomment it to run rook operator on the host network
				//hostNetwork: true
				volumes: [{
					name: "rook-config"
					emptyDir: {}
				}, {
					name: "default-config-dir"
					emptyDir: {}
				}]
			}
		}
	}
}, {
	metadata: {
		name: "rook-ceph-tools"
		labels: app: "rook-ceph-tools"
	}
	spec: {
		replicas: 1
		selector: matchLabels: app: "rook-ceph-tools"
		template: {
			metadata: labels: app: "rook-ceph-tools"
			spec: {
				dnsPolicy: v1.#DNSClusterFirstWithHostNet
				containers: [{
					name:  "rook-ceph-tools"
					image: "rook/ceph:v1.6.3@sha256:8c787d33968e685558f1830a7f6a81a4a43b96d4cb2dba65867f09363f3f2d73"
					command: ["/tini"]
					args: ["-g", "--", "/usr/local/bin/toolbox.sh"]
					imagePullPolicy: "IfNotPresent"
					env: [{
						name: "ROOK_CEPH_USERNAME"
						valueFrom: secretKeyRef: {
							name: "rook-ceph-mon"
							key:  "ceph-username"
						}
					}, {
						name: "ROOK_CEPH_SECRET"
						valueFrom: secretKeyRef: {
							name: "rook-ceph-mon"
							key:  "ceph-secret"
						}
					}]
					volumeMounts: [{
						mountPath: "/etc/ceph"
						name:      "ceph-config"
					}, {
						name:      "mon-endpoint-volume"
						mountPath: "/etc/rook"
					}]
				}]
				volumes: [{
					name: "mon-endpoint-volume"
					configMap: {
						name: "rook-ceph-mon-endpoints"
						items: [{
							key:  "data"
							path: "mon-endpoints"
						}]
					}
				}, {
					name: "ceph-config"
					emptyDir: {}
				}]
				tolerations: [{
					key:               "node.kubernetes.io/unreachable"
					operator:          "Exists"
					effect:            "NoExecute"
					tolerationSeconds: 5
				}]
			}
		}
	}
}]
