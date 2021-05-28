package prometheus_operator

import apiextensionsv1 "k8s.io/apiextensions-apiserver/pkg/apis/apiextensions/v1"

customResourceDefinitionList: apiextensionsv1.#CustomResourceDefinitionList & {
	apiVersion: "apiextensions.k8s.io/v1"
	kind:       "CustomResourceDefinitionList"
	items: [...{
		apiVersion: "apiextensions.k8s.io/v1"
		kind:       "CustomResourceDefinition"
	}]
}

customResourceDefinitionList: items: [{
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "alertmanagerconfigs.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "AlertmanagerConfig"
			listKind: "AlertmanagerConfigList"
			plural:   "alertmanagerconfigs"
			singular: "alertmanagerconfig"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1alpha1"
			schema: openAPIV3Schema: {
				description: "AlertmanagerConfig defines a namespaced AlertmanagerConfig to be aggregated across multiple namespaces configuring one Alertmanager cluster."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "AlertmanagerConfigSpec is a specification of the desired behavior of the Alertmanager configuration. By definition, the Alertmanager configuration only applies to alerts for which the `namespace` label is equal to the namespace of the AlertmanagerConfig resource."
						properties: {
							inhibitRules: {
								description: "List of inhibition rules. The rules will only apply to alerts matching the resource’s namespace."
								items: {
									description: "InhibitRule defines an inhibition rule that allows to mute alerts when other alerts are already firing. See https://prometheus.io/docs/alerting/latest/configuration/#inhibit_rule"
									properties: {
										equal: {
											description: "Labels that must have an equal value in the source and target alert for the inhibition to take effect."
											items: type: "string"
											type: "array"
										}
										sourceMatch: {
											description: "Matchers for which one or more alerts have to exist for the inhibition to take effect. The operator enforces that the alert matches the resource’s namespace."
											items: {
												description: "Matcher defines how to match on alert's labels."
												properties: {
													name: {
														description: "Label to match."
														minLength:   1
														type:        "string"
													}
													regex: {
														description: "Whether to match on equality (false) or regular-expression (true)."
														type:        "boolean"
													}
													value: {
														description: "Label value to match."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										targetMatch: {
											description: "Matchers that have to be fulfilled in the alerts to be muted. The operator enforces that the alert matches the resource’s namespace."
											items: {
												description: "Matcher defines how to match on alert's labels."
												properties: {
													name: {
														description: "Label to match."
														minLength:   1
														type:        "string"
													}
													regex: {
														description: "Whether to match on equality (false) or regular-expression (true)."
														type:        "boolean"
													}
													value: {
														description: "Label value to match."
														type:        "string"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
									}
									type: "object"
								}
								type: "array"
							}
							receivers: {
								description: "List of receivers."
								items: {
									description: "Receiver defines one or more notification integrations."
									properties: {
										emailConfigs: {
											description: "List of Email configurations."
											items: {
												description: "EmailConfig configures notifications via Email."
												properties: {
													authIdentity: {
														description: "The identity to use for authentication."
														type:        "string"
													}
													authPassword: {
														description: "The secret's key that contains the password to use for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													authSecret: {
														description: "The secret's key that contains the CRAM-MD5 secret. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													authUsername: {
														description: "The username to use for authentication."
														type:        "string"
													}
													from: {
														description: "The sender address."
														type:        "string"
													}
													headers: {
														description: "Further headers email header key/value pairs. Overrides any headers previously set by the notification implementation."
														items: {
															description: "KeyValue defines a (key, value) tuple."
															properties: {
																key: {
																	description: "Key of the tuple."
																	minLength:   1
																	type:        "string"
																}
																value: {
																	description: "Value of the tuple."
																	type:        "string"
																}
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													hello: {
														description: "The hostname to identify to the SMTP server."
														type:        "string"
													}
													html: {
														description: "The HTML body of the email notification."
														type:        "string"
													}
													requireTLS: {
														description: "The SMTP TLS requirement. Note that Go does not support unencrypted connections to remote SMTP endpoints."
														type:        "boolean"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													smarthost: {
														description: "The SMTP host through which emails are sent."
														type:        "string"
													}
													text: {
														description: "The text body of the email notification."
														type:        "string"
													}
													tlsConfig: {
														description: "TLS configuration"
														properties: {
															ca: {
																description: "Struct containing the CA cert to use for the targets."
																properties: {
																	configMap: {
																		description: "ConfigMap containing data to use for the targets."
																		properties: {
																			key: {
																				description: "The key to select."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the ConfigMap or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	secret: {
																		description: "Secret containing data to use for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															cert: {
																description: "Struct containing the client cert file for the targets."
																properties: {
																	configMap: {
																		description: "ConfigMap containing data to use for the targets."
																		properties: {
																			key: {
																				description: "The key to select."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the ConfigMap or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	secret: {
																		description: "Secret containing data to use for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															insecureSkipVerify: {
																description: "Disable target certificate validation."
																type:        "boolean"
															}
															keySecret: {
																description: "Secret containing the client key file for the targets."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															serverName: {
																description: "Used to verify the hostname for the targets."
																type:        "string"
															}
														}
														type: "object"
													}
													to: {
														description: "The email address to send notifications to."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										name: {
											description: "Name of the receiver. Must be unique across all items from the list."
											minLength:   1
											type:        "string"
										}
										opsgenieConfigs: {
											description: "List of OpsGenie configurations."
											items: {
												description: "OpsGenieConfig configures notifications via OpsGenie. See https://prometheus.io/docs/alerting/latest/configuration/#opsgenie_config"
												properties: {
													apiKey: {
														description: "The secret's key that contains the OpsGenie API key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													apiURL: {
														description: "The URL to send OpsGenie API requests to."
														type:        "string"
													}
													description: {
														description: "Description of the incident."
														type:        "string"
													}
													details: {
														description: "A set of arbitrary key/value pairs that provide further detail about the incident."
														items: {
															description: "KeyValue defines a (key, value) tuple."
															properties: {
																key: {
																	description: "Key of the tuple."
																	minLength:   1
																	type:        "string"
																}
																value: {
																	description: "Value of the tuple."
																	type:        "string"
																}
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: {
														description: "Alert text limited to 130 characters."
														type:        "string"
													}
													note: {
														description: "Additional alert note."
														type:        "string"
													}
													priority: {
														description: "Priority level of alert. Possible values are P1, P2, P3, P4, and P5."
														type:        "string"
													}
													responders: {
														description: "List of responders responsible for notifications."
														items: {
															description: "OpsGenieConfigResponder defines a responder to an incident. One of `id`, `name` or `username` has to be defined."
															properties: {
																id: {
																	description: "ID of the responder."
																	type:        "string"
																}
																name: {
																	description: "Name of the responder."
																	type:        "string"
																}
																type: {
																	description: "Type of responder."
																	minLength:   1
																	type:        "string"
																}
																username: {
																	description: "Username of the responder."
																	type:        "string"
																}
															}
															required: ["type"]
															type: "object"
														}
														type: "array"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													source: {
														description: "Backlink to the sender of the notification."
														type:        "string"
													}
													tags: {
														description: "Comma separated list of tags attached to the notifications."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										pagerdutyConfigs: {
											description: "List of PagerDuty configurations."
											items: {
												description: "PagerDutyConfig configures notifications via PagerDuty. See https://prometheus.io/docs/alerting/latest/configuration/#pagerduty_config"
												properties: {
													class: {
														description: "The class/type of the event."
														type:        "string"
													}
													client: {
														description: "Client identification."
														type:        "string"
													}
													clientURL: {
														description: "Backlink to the sender of notification."
														type:        "string"
													}
													component: {
														description: "The part or component of the affected system that is broken."
														type:        "string"
													}
													description: {
														description: "Description of the incident."
														type:        "string"
													}
													details: {
														description: "Arbitrary key/value pairs that provide further detail about the incident."
														items: {
															description: "KeyValue defines a (key, value) tuple."
															properties: {
																key: {
																	description: "Key of the tuple."
																	minLength:   1
																	type:        "string"
																}
																value: {
																	description: "Value of the tuple."
																	type:        "string"
																}
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													group: {
														description: "A cluster or grouping of sources."
														type:        "string"
													}
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													routingKey: {
														description: "The secret's key that contains the PagerDuty integration key (when using Events API v2). Either this field or `serviceKey` needs to be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													serviceKey: {
														description: "The secret's key that contains the PagerDuty service key (when using integration type \"Prometheus\"). Either this field or `routingKey` needs to be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													severity: {
														description: "Severity of the incident."
														type:        "string"
													}
													url: {
														description: "The URL to send requests to."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										pushoverConfigs: {
											description: "List of Pushover configurations."
											items: {
												description: "PushoverConfig configures notifications via Pushover. See https://prometheus.io/docs/alerting/latest/configuration/#pushover_config"
												properties: {
													expire: {
														description: "How long your notification will continue to be retried for, unless the user acknowledges the notification."
														type:        "string"
													}
													html: {
														description: "Whether notification message is HTML or plain text."
														type:        "boolean"
													}
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: {
														description: "Notification message."
														type:        "string"
													}
													priority: {
														description: "Priority, see https://pushover.net/api#priority"
														type:        "string"
													}
													retry: {
														description: "How often the Pushover servers will send the same notification to the user. Must be at least 30 seconds."
														type:        "string"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													sound: {
														description: "The name of one of the sounds supported by device clients to override the user's default sound choice"
														type:        "string"
													}
													title: {
														description: "Notification title."
														type:        "string"
													}
													token: {
														description: "The secret's key that contains the registered application’s API token, see https://pushover.net/apps. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													url: {
														description: "A supplementary URL shown alongside the message."
														type:        "string"
													}
													urlTitle: {
														description: "A title for supplementary URL, otherwise just the URL is shown"
														type:        "string"
													}
													userKey: {
														description: "The secret's key that contains the recipient user’s user key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										slackConfigs: {
											description: "List of Slack configurations."
											items: {
												description: "SlackConfig configures notifications via Slack. See https://prometheus.io/docs/alerting/latest/configuration/#slack_config"
												properties: {
													actions: {
														description: "A list of Slack actions that are sent with each notification."
														items: {
															description: "SlackAction configures a single Slack action that is sent with each notification. See https://api.slack.com/docs/message-attachments#action_fields and https://api.slack.com/docs/message-buttons for more information."
															properties: {
																confirm: {
																	description: "SlackConfirmationField protect users from destructive actions or particularly distinguished decisions by asking them to confirm their button click one more time. See https://api.slack.com/docs/interactive-message-field-guide#confirmation_fields for more information."
																	properties: {
																		dismissText: type: "string"
																		okText: type:      "string"
																		text: {
																			minLength: 1
																			type:      "string"
																		}
																		title: type: "string"
																	}
																	required: ["text"]
																	type: "object"
																}
																name: type:  "string"
																style: type: "string"
																text: {
																	minLength: 1
																	type:      "string"
																}
																type: {
																	minLength: 1
																	type:      "string"
																}
																url: type:   "string"
																value: type: "string"
															}
															required: [
																"text",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													apiURL: {
														description: "The secret's key that contains the Slack webhook URL. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													callbackId: type: "string"
													channel: {
														description: "The channel or user to send notifications to."
														type:        "string"
													}
													color: type:    "string"
													fallback: type: "string"
													fields: {
														description: "A list of Slack fields that are sent with each notification."
														items: {
															description: "SlackField configures a single Slack field that is sent with each notification. Each field must contain a title, value, and optionally, a boolean value to indicate if the field is short enough to be displayed next to other fields designated as short. See https://api.slack.com/docs/message-attachments#fields for more information."
															properties: {
																short: type: "boolean"
																title: {
																	minLength: 1
																	type:      "string"
																}
																value: {
																	minLength: 1
																	type:      "string"
																}
															}
															required: [
																"title",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													footer: type: "string"
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													iconEmoji: type: "string"
													iconURL: type:   "string"
													imageURL: type:  "string"
													linkNames: type: "boolean"
													mrkdwnIn: {
														items: type: "string"
														type: "array"
													}
													pretext: type: "string"
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													shortFields: type: "boolean"
													text: type:        "string"
													thumbURL: type:    "string"
													title: type:       "string"
													titleLink: type:   "string"
													username: type:    "string"
												}
												type: "object"
											}
											type: "array"
										}
										victoropsConfigs: {
											description: "List of VictorOps configurations."
											items: {
												description: "VictorOpsConfig configures notifications via VictorOps. See https://prometheus.io/docs/alerting/latest/configuration/#victorops_config"
												properties: {
													apiKey: {
														description: "The secret's key that contains the API key to use when talking to the VictorOps API. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													apiUrl: {
														description: "The VictorOps API URL."
														type:        "string"
													}
													customFields: {
														description: "Additional custom fields for notification."
														items: {
															description: "KeyValue defines a (key, value) tuple."
															properties: {
																key: {
																	description: "Key of the tuple."
																	minLength:   1
																	type:        "string"
																}
																value: {
																	description: "Value of the tuple."
																	type:        "string"
																}
															}
															required: [
																"key",
																"value",
															]
															type: "object"
														}
														type: "array"
													}
													entityDisplayName: {
														description: "Contains summary of the alerted problem."
														type:        "string"
													}
													httpConfig: {
														description: "The HTTP client's configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													messageType: {
														description: "Describes the behavior of the alert (CRITICAL, WARNING, INFO)."
														type:        "string"
													}
													monitoringTool: {
														description: "The monitoring tool the state message is from."
														type:        "string"
													}
													routingKey: {
														description: "A key used to map the alert to a team."
														type:        "string"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													stateMessage: {
														description: "Contains long explanation of the alerted problem."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										webhookConfigs: {
											description: "List of webhook configurations."
											items: {
												description: "WebhookConfig configures notifications via a generic receiver supporting the webhook payload. See https://prometheus.io/docs/alerting/latest/configuration/#webhook_config"
												properties: {
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													maxAlerts: {
														description: "Maximum number of alerts to be sent per webhook message. When 0, all alerts are included."
														format:      "int32"
														minimum:     0
														type:        "integer"
													}
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													url: {
														description: "The URL to send HTTP POST requests to. `urlSecret` takes precedence over `url`. One of `urlSecret` and `url` should be defined."
														type:        "string"
													}
													urlSecret: {
														description: "The secret's key that contains the webhook URL to send HTTP requests to. `urlSecret` takes precedence over `url`. One of `urlSecret` and `url` should be defined. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										wechatConfigs: {
											description: "List of WeChat configurations."
											items: {
												description: "WeChatConfig configures notifications via WeChat. See https://prometheus.io/docs/alerting/latest/configuration/#wechat_config"
												properties: {
													agentID: type: "string"
													apiSecret: {
														description: "The secret's key that contains the WeChat API key. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													apiURL: {
														description: "The WeChat API URL."
														type:        "string"
													}
													corpID: {
														description: "The corp id for authentication."
														type:        "string"
													}
													httpConfig: {
														description: "HTTP client configuration."
														properties: {
															basicAuth: {
																description: "BasicAuth for the client."
																properties: {
																	password: {
																		description: "The secret in the service monitor namespace that contains the password for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	username: {
																		description: "The secret in the service monitor namespace that contains the username for authentication."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																}
																type: "object"
															}
															bearerTokenSecret: {
																description: "The secret's key that contains the bearer token to be used by the client for authentication. The secret needs to be in the same namespace as the AlertmanagerConfig object and accessible by the Prometheus Operator."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															proxyURL: {
																description: "Optional proxy URL."
																type:        "string"
															}
															tlsConfig: {
																description: "TLS configuration for the client."
																properties: {
																	ca: {
																		description: "Struct containing the CA cert to use for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	cert: {
																		description: "Struct containing the client cert file for the targets."
																		properties: {
																			configMap: {
																				description: "ConfigMap containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key to select."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the ConfigMap or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																			secret: {
																				description: "Secret containing data to use for the targets."
																				properties: {
																					key: {
																						description: "The key of the secret to select from.  Must be a valid secret key."
																						type:        "string"
																					}
																					name: {
																						description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																						type:        "string"
																					}
																					optional: {
																						description: "Specify whether the Secret or its key must be defined"
																						type:        "boolean"
																					}
																				}
																				required: ["key"]
																				type: "object"
																			}
																		}
																		type: "object"
																	}
																	insecureSkipVerify: {
																		description: "Disable target certificate validation."
																		type:        "boolean"
																	}
																	keySecret: {
																		description: "Secret containing the client key file for the targets."
																		properties: {
																			key: {
																				description: "The key of the secret to select from.  Must be a valid secret key."
																				type:        "string"
																			}
																			name: {
																				description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																				type:        "string"
																			}
																			optional: {
																				description: "Specify whether the Secret or its key must be defined"
																				type:        "boolean"
																			}
																		}
																		required: ["key"]
																		type: "object"
																	}
																	serverName: {
																		description: "Used to verify the hostname for the targets."
																		type:        "string"
																	}
																}
																type: "object"
															}
														}
														type: "object"
													}
													message: {
														description: "API request data as defined by the WeChat API."
														type:        "string"
													}
													messageType: type: "string"
													sendResolved: {
														description: "Whether or not to notify about resolved alerts."
														type:        "boolean"
													}
													toParty: type: "string"
													toTag: type:   "string"
													toUser: type:  "string"
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							route: {
								description: "The Alertmanager route definition for alerts matching the resource’s namespace. If present, it will be added to the generated Alertmanager configuration as a first-level route."
								properties: {
									continue: {
										description: "Boolean indicating whether an alert should continue matching subsequent sibling nodes. It will always be overridden to true for the first-level route by the Prometheus operator."
										type:        "boolean"
									}
									groupBy: {
										description: "List of labels to group by."
										items: type: "string"
										type: "array"
									}
									groupInterval: {
										description: "How long to wait before sending an updated notification. Must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours)."
										type:        "string"
									}
									groupWait: {
										description: "How long to wait before sending the initial notification. Must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours)."
										type:        "string"
									}
									matchers: {
										description: "List of matchers that the alert’s labels should match. For the first level route, the operator removes any existing equality and regexp matcher on the `namespace` label and adds a `namespace: <object namespace>` matcher."
										items: {
											description: "Matcher defines how to match on alert's labels."
											properties: {
												name: {
													description: "Label to match."
													minLength:   1
													type:        "string"
												}
												regex: {
													description: "Whether to match on equality (false) or regular-expression (true)."
													type:        "boolean"
												}
												value: {
													description: "Label value to match."
													type:        "string"
												}
											}
											required: ["name"]
											type: "object"
										}
										type: "array"
									}
									receiver: {
										description: "Name of the receiver for this route. If not empty, it should be listed in the `receivers` field."
										type:        "string"
									}
									repeatInterval: {
										description: "How long to wait before repeating the last notification. Must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours)."
										type:        "string"
									}
									routes: {
										description: "Child routes."
										items: "x-kubernetes-preserve-unknown-fields": true
										type: "array"
									}
								}
								type: "object"
							}
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "alertmanagers.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Alertmanager"
			listKind: "AlertmanagerList"
			plural:   "alertmanagers"
			singular: "alertmanager"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The version of Alertmanager"
				jsonPath:    ".spec.version"
				name:        "Version"
				type:        "string"
			}, {
				description: "The desired replicas number of Alertmanagers"
				jsonPath:    ".spec.replicas"
				name:        "Replicas"
				type:        "integer"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Alertmanager describes an Alertmanager cluster."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of the desired behavior of the Alertmanager cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {
							additionalPeers: {
								description: "AdditionalPeers allows injecting a set of additional Alertmanagers to peer with to form a highly available cluster."
								items: type: "string"
								type: "array"
							}
							affinity: {
								description: "If specified, the pod's scheduling constraints."
								properties: {
									nodeAffinity: {
										description: "Describes node affinity scheduling rules for the pod."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	description: "A list of node selector requirements by node's fields."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														weight: {
															description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																description: "A list of node selector requirements by node's fields."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													type: "array"
												}
												required: ["nodeSelectorTerms"]
												type: "object"
											}
										}
										type: "object"
									}
									podAffinity: {
										description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alertmanagerConfigNamespaceSelector: {
								description: "Namespaces to be selected for AlertmanagerConfig discovery. If nil, only check own namespace."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							alertmanagerConfigSelector: {
								description: "AlertmanagerConfigs to be selected for to merge and configure Alertmanager with."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							baseImage: {
								description: "Base image that is used to deploy pods, without tag. Deprecated: use 'image' instead"
								type:        "string"
							}
							clusterAdvertiseAddress: {
								description: "ClusterAdvertiseAddress is the explicit address to advertise in cluster. Needs to be provided for non RFC1918 [1] (public) addresses. [1] RFC1918: https://tools.ietf.org/html/rfc1918"
								type:        "string"
							}
							clusterGossipInterval: {
								description: "Interval between gossip attempts."
								type:        "string"
							}
							clusterPeerTimeout: {
								description: "Timeout for cluster peering."
								type:        "string"
							}
							clusterPushpullInterval: {
								description: "Interval between pushpull attempts."
								type:        "string"
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the Alertmanager object, which shall be mounted into the Alertmanager Pods. The ConfigMaps are mounted into /etc/alertmanager/configmaps/<configmap-name>."
								items: type: "string"
								type: "array"
							}
							configSecret: {
								description: "ConfigSecret is the name of a Kubernetes Secret in the same namespace as the Alertmanager object, which contains configuration for this Alertmanager instance. Defaults to 'alertmanager-<alertmanager-name>' The secret is mounted into /etc/alertmanager/config."
								type:        "string"
							}
							containers: {
								description: "Containers allows injecting additional containers. This is meant to allow adding an authentication proxy to an Alertmanager pod. Containers described here modify an operator generated container if they share the same name and modifications are done via a strategic merge patch. The current container names are: `alertmanager` and `config-reloader`. Overriding containers is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							externalUrl: {
								description: "The external URL the Alertmanager instances will be available under. This is necessary to generate correct URLs. This is necessary if Alertmanager is not served from root of a DNS name."
								type:        "string"
							}
							forceEnableClusterMode: {
								description: "ForceEnableClusterMode ensures Alertmanager does not deactivate the cluster mode when running with a single replica. Use case is e.g. spanning an Alertmanager cluster across Kubernetes clusters with a single replica in each."
								type:        "boolean"
							}
							image: {
								description: "Image if specified has precedence over baseImage, tag and sha combinations. Specifying the version is still necessary to ensure the Prometheus Operator knows what version of Alertmanager is being configured."
								type:        "string"
							}
							imagePullSecrets: {
								description: "An optional list of references to secrets in the same namespace to use for pulling prometheus and alertmanager images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"
								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									type: "object"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the Alertmanager configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							listenLocal: {
								description: "ListenLocal makes the Alertmanager server listen on loopback, so that it does not bind against the Pod IP. Note this is only for the Alertmanager UI, not the gossip communication."
								type:        "boolean"
							}
							logFormat: {
								description: "Log format for Alertmanager to be configured with."
								type:        "string"
							}
							logLevel: {
								description: "Log level for Alertmanager to be configured with."
								type:        "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "Define which Nodes the Pods are scheduled on."
								type:        "object"
							}
							paused: {
								description: "If set to true all actions on the underlying managed objects are not goint to be performed, except for delete actions."
								type:        "boolean"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the alertmanager pods."
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
										type:        "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
										type:        "string"
									}
								}
								type: "object"
							}
							portName: {
								description: "Port name used for the pods and governing service. This defaults to web"
								type:        "string"
							}
							priorityClassName: {
								description: "Priority class assigned to the Pods"
								type:        "string"
							}
							replicas: {
								description: "Size is the expected size of the alertmanager cluster. The controller will eventually make the size of the running cluster equal to the expected size."
								format:      "int32"
								type:        "integer"
							}
							resources: {
								description: "Define resources requests and limits for single Pods."
								properties: {
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
								}
								type: "object"
							}
							retention: {
								description: "Time duration Alertmanager shall retain data for. Default is '120h', and must match the regular expression `[0-9]+(ms|s|m|h)` (milliseconds seconds minutes hours)."
								type:        "string"
							}
							routePrefix: {
								description: "The route prefix Alertmanager registers HTTP handlers for. This is useful, if using ExternalURL and a proxy is rewriting HTTP routes of a request, and the actual ExternalURL is still true, but the server serves requests under a different route prefix. For example for use with `kubectl proxy`."
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the Alertmanager object, which shall be mounted into the Alertmanager Pods. The Secrets are mounted into /etc/alertmanager/secrets/<secret-name>."
								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."
								properties: {
									fsGroup: {
										description: """
		A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
		 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
		 If unset, the Kubelet will not modify the ownership and permissions of any volume.
		"""
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: {
										description: "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified defaults to \"Always\"."
										type:        "string"
									}
									runAsGroup: {
										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									runAsNonRoot: {
										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										type:        "boolean"
									}
									runAsUser: {
										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									seLinuxOptions: {
										description: "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										properties: {
											level: {
												description: "Level is SELinux level label that applies to the container."
												type:        "string"
											}
											role: {
												description: "Role is a SELinux role label that applies to the container."
												type:        "string"
											}
											type: {
												description: "Type is a SELinux type label that applies to the container."
												type:        "string"
											}
											user: {
												description: "User is a SELinux user label that applies to the container."
												type:        "string"
											}
										}
										type: "object"
									}
									supplementalGroups: {
										description: "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container."
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										description: "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch."
										items: {
											description: "Sysctl defines a kernel parameter to be set"
											properties: {
												name: {
													description: "Name of a property to set"
													type:        "string"
												}
												value: {
													description: "Value of a property to set"
													type:        "string"
												}
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										description: "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										properties: {
											gmsaCredentialSpec: {
												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
												type:        "string"
											}
											gmsaCredentialSpecName: {
												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
												type:        "string"
											}
											runAsUserName: {
												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the Prometheus Pods."
								type:        "string"
							}
							sha: {
								description: "SHA of Alertmanager container image to be deployed. Defaults to the value of `version`. Similar to a tag, but the SHA explicitly deploys an immutable container image. Version and Tag are ignored if SHA is set. Deprecated: use 'image' instead.  The image digest can be specified as part of the image URL."
								type:        "string"
							}
							storage: {
								description: "Storage is the definition of how storage will be used by the Alertmanager instances."
								properties: {
									disableMountSubPath: {
										description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."
										type:        "boolean"
									}
									emptyDir: {
										description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"
										properties: {
											medium: {
												description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
												type:        "string"
											}
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "A PVC spec to be used by the Prometheus StatefulSets."
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											metadata: {
												description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."
												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
														type:        "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
														type:        "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
														type:        "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													dataSource: {
														description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot - Beta) * An existing PVC (PersistentVolumeClaim) * An existing custom resource/object that implements data population (Alpha) In order to use VolumeSnapshot object types, the appropriate feature gate must be enabled (VolumeSnapshotDataSource or AnyVolumeDataSource) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the specified data source is not supported, the volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change."
														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																type:        "string"
															}
															kind: {
																description: "Kind is the type of resource being referenced"
																type:        "string"
															}
															name: {
																description: "Name is the name of resource being referenced"
																type:        "string"
															}
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
														}
														type: "object"
													}
													selector: {
														description: "A label query over volumes to consider for binding."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "key is the label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																			type:        "string"
																		}
																		values: {
																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													storageClassName: {
														description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
														type:        "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
														type:        "string"
													}
													volumeName: {
														description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
														type:        "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "Represents the actual resources of the underlying volume."
														type:        "object"
													}
													conditions: {
														description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"
															properties: {
																lastProbeTime: {
																	description: "Last time we probed the condition."
																	format:      "date-time"
																	type:        "string"
																}
																lastTransitionTime: {
																	description: "Last time the condition transitioned from one status to another."
																	format:      "date-time"
																	type:        "string"
																}
																message: {
																	description: "Human-readable message indicating details about last transition."
																	type:        "string"
																}
																reason: {
																	description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																	type:        "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																	type:        "string"
																}
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													phase: {
														description: "Phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tag: {
								description: "Tag of Alertmanager container image to be deployed. Defaults to the value of `version`. Version is ignored if Tag is set. Deprecated: use 'image' instead.  The image tag can be specified as part of the image URL."
								type:        "string"
							}
							tolerations: {
								description: "If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
											type:        "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
											type:        "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
											type:        "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
											format:      "int64"
											type:        "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "If specified, the pod's topology spread constraints."
								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
									properties: {
										labelSelector: {
											description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
											properties: {
												matchExpressions: {
													description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
													items: {
														description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
														properties: {
															key: {
																description: "key is the label key that the selector applies to."
																type:        "string"
															}
															operator: {
																description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																type:        "string"
															}
															values: {
																description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
													type:        "object"
												}
											}
											type: "object"
										}
										maxSkew: {
											description: "MaxSkew describes the degree to which pods may be unevenly distributed. It's the maximum permitted difference between the number of matching pods in any two topology domains of a given topology type. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. It's a required field. Default value is 1 and 0 is not allowed."
											format:      "int32"
											type:        "integer"
										}
										topologyKey: {
											description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
											type:        "string"
										}
										whenUnsatisfiable: {
											description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it - ScheduleAnyway tells the scheduler to still schedule it It's considered as \"Unsatisfiable\" if and only if placing incoming pod on any topology violates \"MaxSkew\". For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
											type:        "string"
										}
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							version: {
								description: "Version the cluster should be on."
								type:        "string"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition. VolumeMounts specified will be appended to other VolumeMounts in the alertmanager container, that are generated as a result of StorageSpec objects."
								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."
									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
											type:        "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
											type:        "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
											type:        "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
											type:        "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
											type:        "string"
										}
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output StatefulSet definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."
								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
									properties: {
										awsElasticBlockStore: {
											description: "AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Specify \"true\" to force and set the ReadOnly property in VolumeMounts to \"true\". If omitted, the default is \"false\". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "boolean"
												}
												volumeID: {
													description: "Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										azureDisk: {
											description: "AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
											properties: {
												cachingMode: {
													description: "Host Caching mode: None, Read Only, Read Write."
													type:        "string"
												}
												diskName: {
													description: "The Name of the data disk in the blob storage"
													type:        "string"
												}
												diskURI: {
													description: "The URI the data disk in the blob storage"
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												kind: {
													description: "Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											description: "AzureFile represents an Azure File Service mount on the host and bind mount to the pod."
											properties: {
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretName: {
													description: "the name of secret that contains Azure Storage Account Name and Key"
													type:        "string"
												}
												shareName: {
													description: "Share Name"
													type:        "string"
												}
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											description: "CephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
											properties: {
												monitors: {
													description: "Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												path: {
													description: "Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretFile: {
													description: "Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: ["monitors"]
											type: "object"
										}
										cinder: {
											description: "Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: points to a secret object containing parameters used to connect to OpenStack."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeID: {
													description: "volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										configMap: {
											description: "ConfigMap represents a configMap that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
													type:        "string"
												}
												optional: {
													description: "Specify whether the ConfigMap or its keys must be defined"
													type:        "boolean"
												}
											}
											type: "object"
										}
										csi: {
											description: "CSI (Container Storage Interface) represents storage that is handled by an external CSI driver (Alpha feature)."
											properties: {
												driver: {
													description: "Driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
													type:        "string"
												}
												nodePublishSecretRef: {
													description: "NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												readOnly: {
													description: "Specifies a read-only configuration for the volume. Defaults to false (read/write)."
													type:        "boolean"
												}
												volumeAttributes: {
													additionalProperties: type: "string"
													description: "VolumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
													type:        "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										downwardAPI: {
											description: "DownwardAPI represents downward API about the pod that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "Items is a list of downward API volume file"
													items: {
														description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
														properties: {
															fieldRef: {
																description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																type:        "string"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
														}
														required: ["path"]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											description: "EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
											properties: {
												medium: {
													description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
													type:        "string"
												}
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										fc: {
											description: "FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												lun: {
													description: "Optional: FC target lun number"
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												targetWWNs: {
													description: "Optional: FC target worldwide names (WWNs)"
													items: type: "string"
													type: "array"
												}
												wwids: {
													description: "Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											description: "FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
											properties: {
												driver: {
													description: "Driver is the name of the driver to use for this volume."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
													type:        "string"
												}
												options: {
													additionalProperties: type: "string"
													description: "Optional: Extra command options if any."
													type:        "object"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										flocker: {
											description: "Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
											properties: {
												datasetName: {
													description: "Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
													type:        "string"
												}
												datasetUUID: {
													description: "UUID of the dataset. This is unique identifier of a Flocker dataset"
													type:        "string"
												}
											}
											type: "object"
										}
										gcePersistentDisk: {
											description: "GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													format:      "int32"
													type:        "integer"
												}
												pdName: {
													description: "Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "boolean"
												}
											}
											required: ["pdName"]
											type: "object"
										}
										gitRepo: {
											description: "GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
											properties: {
												directory: {
													description: "Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
													type:        "string"
												}
												repository: {
													description: "Repository URL"
													type:        "string"
												}
												revision: {
													description: "Commit hash for the specified revision."
													type:        "string"
												}
											}
											required: ["repository"]
											type: "object"
										}
										glusterfs: {
											description: "Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
											properties: {
												endpoints: {
													description: "EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												path: {
													description: "Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "boolean"
												}
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											description: "HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
											properties: {
												path: {
													description: "Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
												type: {
													description: "Type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
											}
											required: ["path"]
											type: "object"
										}
										iscsi: {
											description: "ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
											properties: {
												chapAuthDiscovery: {
													description: "whether support iSCSI Discovery CHAP authentication"
													type:        "boolean"
												}
												chapAuthSession: {
													description: "whether support iSCSI Session CHAP authentication"
													type:        "boolean"
												}
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												initiatorName: {
													description: "Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
													type:        "string"
												}
												iqn: {
													description: "Target iSCSI Qualified Name."
													type:        "string"
												}
												iscsiInterface: {
													description: "iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
													type:        "string"
												}
												lun: {
													description: "iSCSI Target Lun number."
													format:      "int32"
													type:        "integer"
												}
												portals: {
													description: "iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													items: type: "string"
													type: "array"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
													type:        "boolean"
												}
												secretRef: {
													description: "CHAP Secret for iSCSI target and initiator authentication"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												targetPortal: {
													description: "iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													type:        "string"
												}
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: {
											description: "Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
											type:        "string"
										}
										nfs: {
											description: "NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
											properties: {
												path: {
													description: "Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "boolean"
												}
												server: {
													description: "Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											description: "PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
											properties: {
												claimName: {
													description: "ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													type:        "string"
												}
												readOnly: {
													description: "Will force the ReadOnly setting in VolumeMounts. Default false."
													type:        "boolean"
												}
											}
											required: ["claimName"]
											type: "object"
										}
										photonPersistentDisk: {
											description: "PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												pdID: {
													description: "ID that identifies Photon Controller persistent disk"
													type:        "string"
												}
											}
											required: ["pdID"]
											type: "object"
										}
										portworxVolume: {
											description: "PortworxVolume represents a portworx volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												volumeID: {
													description: "VolumeID uniquely identifies a Portworx volume"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										projected: {
											description: "Items for all in one resources secrets, configmaps, and downward API"
											properties: {
												defaultMode: {
													description: "Mode bits to use on created files by default. Must be a value between 0 and 0777. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												sources: {
													description: "list of volume projections"
													items: {
														description: "Projection that may be projected along with other supported volume types"
														properties: {
															configMap: {
																description: "information about the configMap data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its keys must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															downwardAPI: {
																description: "information about the downwardAPI data to project"
																properties: items: {
																	description: "Items is a list of DownwardAPIVolume file"
																	items: {
																		description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																		properties: {
																			fieldRef: {
																				description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																				properties: {
																					apiVersion: {
																						description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																						type:        "string"
																					}
																					fieldPath: {
																						description: "Path of the field to select in the specified API version."
																						type:        "string"
																					}
																				}
																				required: ["fieldPath"]
																				type: "object"
																			}
																			mode: {
																				description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																				type:        "string"
																			}
																			resourceFieldRef: {
																				description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																				properties: {
																					containerName: {
																						description: "Container name: required for volumes, optional for env vars"
																						type:        "string"
																					}
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: {
																						description: "Required: resource to select"
																						type:        "string"
																					}
																				}
																				required: ["resource"]
																				type: "object"
																			}
																		}
																		required: ["path"]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																description: "information about the secret data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															serviceAccountToken: {
																description: "information about the serviceAccountToken data to project"
																properties: {
																	audience: {
																		description: "Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																		type:        "string"
																	}
																	expirationSeconds: {
																		description: "ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																		format:      "int64"
																		type:        "integer"
																	}
																	path: {
																		description: "Path is the path relative to the mount point of the file to project the token into."
																		type:        "string"
																	}
																}
																required: ["path"]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: ["sources"]
											type: "object"
										}
										quobyte: {
											description: "Quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
											properties: {
												group: {
													description: "Group to map volume access to Default is no group"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
													type:        "boolean"
												}
												registry: {
													description: "Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
													type:        "string"
												}
												tenant: {
													description: "Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
													type:        "string"
												}
												user: {
													description: "User to map volume access to Defaults to serivceaccount user"
													type:        "string"
												}
												volume: {
													description: "Volume is a string that references an already created Quobyte volume by name."
													type:        "string"
												}
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											description: "RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												image: {
													description: "The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												keyring: {
													description: "Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												monitors: {
													description: "A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												pool: {
													description: "The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											description: "ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
													type:        "string"
												}
												gateway: {
													description: "The host address of the ScaleIO API Gateway."
													type:        "string"
												}
												protectionDomain: {
													description: "The name of the ScaleIO Protection Domain for the configured storage."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												sslEnabled: {
													description: "Flag to enable/disable SSL communication with Gateway, default false"
													type:        "boolean"
												}
												storageMode: {
													description: "Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
													type:        "string"
												}
												storagePool: {
													description: "The ScaleIO Storage Pool associated with the protection domain."
													type:        "string"
												}
												system: {
													description: "The name of the storage system as configured in ScaleIO."
													type:        "string"
												}
												volumeName: {
													description: "The name of a volume already created in the ScaleIO system that is associated with this volume source."
													type:        "string"
												}
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											description: "Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: {
													description: "Specify whether the Secret or its keys must be defined"
													type:        "boolean"
												}
												secretName: {
													description: "Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
													type:        "string"
												}
											}
											type: "object"
										}
										storageos: {
											description: "StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeName: {
													description: "VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
													type:        "string"
												}
												volumeNamespace: {
													description: "VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
													type:        "string"
												}
											}
											type: "object"
										}
										vsphereVolume: {
											description: "VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												storagePolicyID: {
													description: "Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
													type:        "string"
												}
												storagePolicyName: {
													description: "Storage Policy Based Management (SPBM) profile name."
													type:        "string"
												}
												volumePath: {
													description: "Path that identifies vSphere volume vmdk"
													type:        "string"
												}
											}
											required: ["volumePath"]
											type: "object"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
						}, type:
							"object"
					}, status: {
						description:
							"Most recent observed status of the Alertmanager cluster. Read-only. Not included when requesting from the apiserver, only from the Prometheus Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status", properties: {

							availableReplicas: {
								description: "Total number of available pods (ready for at least minReadySeconds) targeted by this Alertmanager cluster."
								format:      "int32"
								type:        "integer"
							}
							paused: {
								description: "Represents whether any actions on the underlying managed objects are being performed. Only delete actions will be performed."
								type:        "boolean"
							}
							replicas: {
								description: "Total number of non-terminated pods targeted by this Alertmanager cluster (their labels match the selector)."
								format:      "int32"
								type:        "integer"
							}
							unavailableReplicas: {
								description: "Total number of unavailable pods targeted by this Alertmanager cluster."
								format:      "int32"
								type:        "integer"
							}
							updatedReplicas: {
								description: "Total number of non-terminated pods targeted by this Alertmanager cluster that have the desired version spec."
								format:      "int32"
								type:        "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {

	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "podmonitors.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "PodMonitor"
			listKind: "PodMonitorList"
			plural:   "podmonitors"
			singular: "podmonitor"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description:
					"PodMonitor defines monitoring for a set of pods.", properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of desired Pod selection for target discovery by Prometheus."
						properties: {
							jobLabel: {
								description: "The label to use to retrieve the job name from."
								type:        "string"
							}
							namespaceSelector: {
								description: "Selector to select which namespaces the Endpoints objects are discovered from."
								properties: {
									any: {
										description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."
										type:        "boolean"
									}
									matchNames: {
										description: "List of namespace names."
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podMetricsEndpoints: {
								description: "A list of endpoints allowed as part of this PodMonitor."
								items: {
									description: "PodMetricsEndpoint defines a scrapeable endpoint of a Kubernetes Pod serving Prometheus metrics."
									properties: {
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication. More info: https://prometheus.io/docs/operating/configuration/#endpoint"
											properties: {
												password: {
													description: "The secret in the service monitor namespace that contains the password for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												username: {
													description: "The secret in the service monitor namespace that contains the username for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
											}
											type: "object"
										}
										bearerTokenSecret: {
											description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the pod monitor and accessible by the Prometheus Operator."
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."
													type:        "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
													type:        "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"
													type:        "boolean"
												}
											}
											required: ["key"]
											type: "object"
										}
										honorLabels: {
											description: "HonorLabels chooses the metric's labels on collisions with target labels."
											type:        "boolean"
										}
										honorTimestamps: {
											description: "HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data."
											type:        "boolean"
										}
										interval: {
											description: "Interval at which metrics should be scraped"
											type:        "string"
										}
										metricRelabelings: {
											description: "MetricRelabelConfigs to apply to samples before ingestion."
											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"
														type:        "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."
														format:      "int64"
														type:        "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
														type:        "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
														type:        "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."
														type:        "string"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
														items: type: "string"
														type: "array"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											description: "Optional HTTP URL parameters"
											type:        "object"
										}
										path: {
											description: "HTTP path to scrape for metrics."
											type:        "string"
										}
										port: {
											description: "Name of the pod port this endpoint refers to. Mutually exclusive with targetPort."
											type:        "string"
										}
										proxyUrl: {
											description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."
											type:        "string"
										}
										relabelings: {
											description: "RelabelConfigs to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields and replaces original scrape job name with __tmp_prometheus_job_name. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"
														type:        "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."
														format:      "int64"
														type:        "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
														type:        "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
														type:        "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."
														type:        "string"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
														items: type: "string"
														type: "array"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										scheme: {
											description: "HTTP scheme to use for scraping."
											type:        "string"
										}
										scrapeTimeout: {
											description: "Timeout after which the scrape is ended"
											type:        "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description:                  "Deprecated: Use 'port' instead."
											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											description: "TLS configuration to use when scraping the endpoint."
											properties: {
												ca: {
													description: "Struct containing the CA cert to use for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							podTargetLabels: {
								description: "PodTargetLabels transfers labels on the Kubernetes Pod onto the target."
								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
								format:      "int64"
								type:        "integer"
							}
							selector: {
								description: "Selector to select Pod objects."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							targetLimit: {
								description: "TargetLimit defines a limit on the number of scraped targets that will be accepted."
								format:      "int64"
								type:        "integer"
							}
						}
						required: [
							"podMetricsEndpoints",
							"selector",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}, status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "probes.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Probe"
			listKind: "ProbeList"
			plural:   "probes"
			singular: "probe"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Probe defines monitoring for a set of static targets or ingresses."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of desired Ingress selection for target discovery by Prometheus."
						properties: {
							basicAuth: {
								description: "BasicAuth allow an endpoint to authenticate over basic authentication. More info: https://prometheus.io/docs/operating/configuration/#endpoint"
								properties: {
									password: {
										description: "The secret in the service monitor namespace that contains the password for authentication."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
									username: {
										description: "The secret in the service monitor namespace that contains the username for authentication."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
								}
								type: "object"
							}
							bearerTokenSecret: {
								description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the probe and accessible by the Prometheus Operator."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							interval: {
								description: "Interval at which targets are probed using the configured prober. If not specified Prometheus' global scrape interval is used."
								type:        "string"
							}
							jobName: {
								description: "The job name assigned to scraped metrics by default."
								type:        "string"
							}
							module: {
								description: "The module to use for probing specifying how to probe the target. Example module configuring in the blackbox exporter: https://github.com/prometheus/blackbox_exporter/blob/master/example.yml"
								type:        "string"
							}
							prober: {
								description: "Specification for the prober to use for probing targets. The prober.URL parameter is required. Targets cannot be probed if left empty."
								properties: {
									path: {
										description: "Path to collect metrics from. Defaults to `/probe`."
										type:        "string"
									}
									scheme: {
										description: "HTTP scheme to use for scraping. Defaults to `http`."
										type:        "string"
									}
									url: {
										description: "Mandatory URL of the prober."
										type:        "string"
									}
								}
								required: ["url"]
								type: "object"
							}
							scrapeTimeout: {
								description: "Timeout for scraping metrics from the Prometheus exporter."
								type:        "string"
							}
							targets: {
								description: "Targets defines a set of static and/or dynamically discovered targets to be probed using the prober."
								properties: {
									ingress: {
										description: "Ingress defines the set of dynamically discovered ingress objects which hosts are considered for probing."
										properties: {
											namespaceSelector: {
												description: "Select Ingress objects by namespace."
												properties: {
													any: {
														description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."
														type:        "boolean"
													}
													matchNames: {
														description: "List of namespace names."
														items: type: "string"
														type: "array"
													}
												}
												type: "object"
											}
											relabelingConfigs: {
												description: "RelabelConfigs to apply to samples before ingestion. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
												items: {
													description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
													properties: {
														action: {
															description: "Action to perform based on regex matching. Default is 'replace'"
															type:        "string"
														}
														modulus: {
															description: "Modulus to take of the hash of the source label values."
															format:      "int64"
															type:        "integer"
														}
														regex: {
															description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
															type:        "string"
														}
														replacement: {
															description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
															type:        "string"
														}
														separator: {
															description: "Separator placed between concatenated source label values. default is ';'."
															type:        "string"
														}
														sourceLabels: {
															description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
															items: type: "string"
															type: "array"
														}
														targetLabel: {
															description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											selector: {
												description: "Select Ingress objects by labels."
												properties: {
													matchExpressions: {
														description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
														items: {
															description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
															properties: {
																key: {
																	description: "key is the label key that the selector applies to."
																	type:        "string"
																}
																operator: {
																	description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																	type:        "string"
																}
																values: {
																	description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																	items: type: "string"
																	type: "array"
																}
															}
															required: [
																"key",
																"operator",
															]
															type: "object"
														}
														type: "array"
													}
													matchLabels: {
														additionalProperties: type: "string"
														description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
														type:        "object"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
									staticConfig: {
										description: "StaticConfig defines static targets which are considers for probing. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#static_config."
										properties: {
											labels: {
												additionalProperties: type: "string"
												description: "Labels assigned to all metrics scraped from the targets."
												type:        "object"
											}
											relabelingConfigs: {
												description: "RelabelConfigs to apply to samples before ingestion. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
												items: {
													description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
													properties: {
														action: {
															description: "Action to perform based on regex matching. Default is 'replace'"
															type:        "string"
														}
														modulus: {
															description: "Modulus to take of the hash of the source label values."
															format:      "int64"
															type:        "integer"
														}
														regex: {
															description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
															type:        "string"
														}
														replacement: {
															description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
															type:        "string"
														}
														separator: {
															description: "Separator placed between concatenated source label values. default is ';'."
															type:        "string"
														}
														sourceLabels: {
															description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
															items: type: "string"
															type: "array"
														}
														targetLabel: {
															description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
															type:        "string"
														}
													}
													type: "object"
												}
												type: "array"
											}
											static: {
												description: "Targets is a list of URLs to probe using the configured prober."
												items: type: "string"
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tlsConfig: {
								description: "TLS configuration to use when scraping the endpoint."
								properties: {
									ca: {
										description: "Struct containing the CA cert to use for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									cert: {
										description: "Struct containing the client cert file for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									insecureSkipVerify: {
										description: "Disable target certificate validation."
										type:        "boolean"
									}
									keySecret: {
										description: "Secret containing the client key file for the targets."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
									serverName: {
										description: "Used to verify the hostname for the targets."
										type:        "string"
									}
								}
								type: "object"
							}
						}, type:
							"object"
					}
				}, required: [
					"spec",
				]
					type:
						"object"
			}, served: true
			storage:
				true
		}]
	}, status: acceptedNames: {

		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "prometheuses.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "Prometheus"
			listKind: "PrometheusList"
			plural:   "prometheuses"
			singular: "prometheus"
		}
		scope: "Namespaced"
		versions: [{
			additionalPrinterColumns: [{
				description: "The version of Prometheus"
				jsonPath:    ".spec.version"
				name:        "Version"
				type:        "string"
			}, {
				description: "The desired replicas number of Prometheuses"
				jsonPath:
					".spec.replicas"
				name: "Replicas"
				type: "integer"
			}, {
				jsonPath: ".metadata.creationTimestamp"
				name:     "Age"
				type:     "date"
			}]
			name: "v1"
			schema: openAPIV3Schema: {
				description: "Prometheus defines a Prometheus deployment."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of the desired behavior of the Prometheus cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {
							additionalAlertManagerConfigs: {
								description: "AdditionalAlertManagerConfigs allows specifying a key of a Secret containing additional Prometheus AlertManager configurations. AlertManager configurations specified are appended to the configurations generated by the Prometheus Operator. Job configurations specified must have the form as specified in the official Prometheus documentation: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alertmanager_config. As AlertManager configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible AlertManager configs are going to break Prometheus after the upgrade."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							additionalAlertRelabelConfigs: {
								description: "AdditionalAlertRelabelConfigs allows specifying a key of a Secret containing additional Prometheus alert relabel configurations. Alert relabel configurations specified are appended to the configurations generated by the Prometheus Operator. Alert relabel configurations specified must have the form as specified in the official Prometheus documentation: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#alert_relabel_configs. As alert relabel configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible alert relabel configs are going to break Prometheus after the upgrade."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							additionalScrapeConfigs: {
								description: "AdditionalScrapeConfigs allows specifying a key of a Secret containing additional Prometheus scrape configurations. Scrape configurations specified are appended to the configurations generated by the Prometheus Operator. Job configurations specified must have the form as specified in the official Prometheus documentation: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#scrape_config. As scrape configs are appended, the user is responsible to make sure it is valid. Note that using this feature may expose the possibility to break upgrades of Prometheus. It is advised to review Prometheus release notes to ensure that no incompatible scrape configs are going to break Prometheus after the upgrade."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							affinity: {
								description: "If specified, the pod's scheduling constraints."
								properties: {
									nodeAffinity: {
										description: "Describes node affinity scheduling rules for the pod."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	description: "A list of node selector requirements by node's fields."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														weight: {
															description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																description: "A list of node selector requirements by node's fields."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													type: "array"
												}
												required: ["nodeSelectorTerms"]
												type: "object"
											}
										}
										type: "object"
									}
									podAffinity: {
										description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alerting: {
								description: "Define details regarding alerting."
								properties: alertmanagers: {
									description: "AlertmanagerEndpoints Prometheus should fire alerts against."
									items: {
										description: "AlertmanagerEndpoints defines a selection of a single Endpoints object containing alertmanager IPs to fire alerts against."
										properties: {
											apiVersion: {
												description: "Version of the Alertmanager API that Prometheus uses to send alerts. It can be \"v1\" or \"v2\"."
												type:        "string"
											}
											bearerTokenFile: {
												description: "BearerTokenFile to read from filesystem to use when authenticating to Alertmanager."
												type:        "string"
											}
											name: {
												description: "Name of Endpoints object in Namespace."
												type:        "string"
											}
											namespace: {
												description: "Namespace of Endpoints object."
												type:        "string"
											}
											pathPrefix: {
												description: "Prefix for the HTTP path alerts are pushed to."
												type:        "string"
											}
											port: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description:                  "Port the Alertmanager API is exposed on."
												"x-kubernetes-int-or-string": true
											}
											scheme: {
												description: "Scheme to use when firing alerts."
												type:        "string"
											}
											timeout: {
												description: "Timeout is a per-target Alertmanager timeout when pushing alerts."
												type:        "string"
											}
											tlsConfig: {
												description: "TLS Config to use for alertmanager connection."
												properties: {
													ca: {
														description: "Struct containing the CA cert to use for the targets."
														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															secret: {
																description: "Secret containing data to use for the targets."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
													caFile: {
														description: "Path to the CA cert in the Prometheus container to use for the targets."
														type:        "string"
													}
													cert: {
														description: "Struct containing the client cert file for the targets."
														properties: {
															configMap: {
																description: "ConfigMap containing data to use for the targets."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															secret: {
																description: "Secret containing data to use for the targets."
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
													certFile: {
														description: "Path to the client cert file in the Prometheus container for the targets."
														type:        "string"
													}
													insecureSkipVerify: {
														description: "Disable target certificate validation."
														type:        "boolean"
													}
													keyFile: {
														description: "Path to the client key file in the Prometheus container for the targets."
														type:        "string"
													}
													keySecret: {
														description: "Secret containing the client key file for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													serverName: {
														description: "Used to verify the hostname for the targets."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										required: [
											"name",
											"namespace",
											"port",
										]
										type: "object"
									}
									type: "array"
								}
								required: ["alertmanagers"]
								type: "object"
							}
							allowOverlappingBlocks: {
								description: "AllowOverlappingBlocks enables vertical compaction and vertical query merge in Prometheus. This is still experimental in Prometheus so it may change in any upcoming release."
								type:        "boolean"
							}
							apiserverConfig: {
								description: "APIServerConfig allows specifying a host and auth methods to access apiserver. If left empty, Prometheus is assumed to run inside of the cluster and will discover API servers automatically and use the pod's CA certificate and bearer token file at /var/run/secrets/kubernetes.io/serviceaccount/."
								properties: {
									basicAuth: {
										description: "BasicAuth allow an endpoint to authenticate over basic authentication"
										properties: {
											password: {
												description: "The secret in the service monitor namespace that contains the password for authentication."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											username: {
												description: "The secret in the service monitor namespace that contains the username for authentication."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									bearerToken: {
										description: "Bearer token for accessing apiserver."
										type:        "string"
									}
									bearerTokenFile: {
										description: "File to read bearer token for accessing apiserver."
										type:        "string"
									}
									host: {
										description: "Host of apiserver. A valid string consisting of a hostname or IP followed by an optional port number"
										type:        "string"
									}
									tlsConfig: {
										description: "TLS Config to use for accessing apiserver."
										properties: {
											ca: {
												description: "Struct containing the CA cert to use for the targets."
												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."
														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											caFile: {
												description: "Path to the CA cert in the Prometheus container to use for the targets."
												type:        "string"
											}
											cert: {
												description: "Struct containing the client cert file for the targets."
												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."
														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											certFile: {
												description: "Path to the client cert file in the Prometheus container for the targets."
												type:        "string"
											}
											insecureSkipVerify: {
												description: "Disable target certificate validation."
												type:        "boolean"
											}
											keyFile: {
												description: "Path to the client key file in the Prometheus container for the targets."
												type:        "string"
											}
											keySecret: {
												description: "Secret containing the client key file for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											serverName: {
												description: "Used to verify the hostname for the targets."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								required: ["host"]
								type: "object"
							}
							arbitraryFSAccessThroughSMs: {
								description: "ArbitraryFSAccessThroughSMs configures whether configuration based on a service monitor can access arbitrary files on the file system of the Prometheus container e.g. bearer token files."
								properties: deny: type: "boolean"
								type: "object"
							}
							baseImage: {
								description: "Base image to use for a Prometheus deployment. Deprecated: use 'image' instead"
								type:        "string"
							}
							configMaps: {
								description: "ConfigMaps is a list of ConfigMaps in the same namespace as the Prometheus object, which shall be mounted into the Prometheus Pods. The ConfigMaps are mounted into /etc/prometheus/configmaps/<configmap-name>."
								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers allows injecting additional containers or modifying operator generated containers. This can be used to allow adding an authentication proxy to a Prometheus pod or to change the behavior of an operator generated container. Containers described here modify an operator generated container if they share the same name and modifications are done via a strategic merge patch. The current container names are: `prometheus`, `config-reloader`, and `thanos-sidecar`. Overriding containers is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							disableCompaction: {
								description: "Disable prometheus compaction."
								type:        "boolean"
							}
							enableAdminAPI: {
								description: "Enable access to prometheus web admin API. Defaults to the value of `false`. WARNING: Enabling the admin APIs enables mutating endpoints, to delete data, shutdown Prometheus, and more. Enabling this should be done with care and the user is advised to add additional authentication authorization via a proxy to ensure only clients authorized to perform these actions can do so. For more information see https://prometheus.io/docs/prometheus/latest/querying/api/#tsdb-admin-apis"
								type:        "boolean"
							}
							enableFeatures: {
								description: "Enable access to Prometheus disabled features. By default, no features are enabled. Enabling disabled features is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice. For more information see https://prometheus.io/docs/prometheus/latest/disabled_features/"
								items: type: "string"
								type: "array"
							}
							enforcedNamespaceLabel: {
								description: "EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created."
								type:        "string"
							}
							enforcedSampleLimit: {
								description: "EnforcedSampleLimit defines global limit on number of scraped samples that will be accepted. This overrides any SampleLimit set per ServiceMonitor or/and PodMonitor. It is meant to be used by admins to enforce the SampleLimit to keep overall number of samples/series under the desired limit. Note that if SampleLimit is lower that value will be taken instead."
								format:      "int64"
								type:        "integer"
							}
							enforcedTargetLimit: {
								description: "EnforcedTargetLimit defines a global limit on the number of scraped targets. This overrides any TargetLimit set per ServiceMonitor or/and PodMonitor. It is meant to be used by admins to enforce the TargetLimit to keep overall number of targets under the desired limit. Note that if TargetLimit is higher that value will be taken instead."
								format:      "int64"
								type:        "integer"
							}
							evaluationInterval: {
								description: "Interval between consecutive evaluations."
								type:        "string"
							}
							externalLabels: {
								additionalProperties: type: "string"
								description: "The labels to add to any time series or alerts when communicating with external systems (federation, remote storage, Alertmanager)."
								type:        "object"
							}
							externalUrl: {
								description: "The external URL the Prometheus instances will be available under. This is necessary to generate correct URLs. This is necessary if Prometheus is not served from root of a DNS name."
								type:        "string"
							}
							ignoreNamespaceSelectors: {
								description: "IgnoreNamespaceSelectors if set to true will ignore NamespaceSelector settings from the podmonitor and servicemonitor configs, and they will only discover endpoints within their current namespace.  Defaults to false."
								type:        "boolean"
							}
							image: {
								description: "Image if specified has precedence over baseImage, tag and sha combinations. Specifying the version is still necessary to ensure the Prometheus Operator knows what version of Prometheus is being configured."
								type:        "string"
							}
							imagePullSecrets: {
								description: "An optional list of references to secrets in the same namespace to use for pulling prometheus and alertmanager images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"
								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									type: "object"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the Prometheus configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							listenLocal: {
								description: "ListenLocal makes the Prometheus server listen on loopback, so that it does not bind against the Pod IP."
								type:        "boolean"
							}
							logFormat: {
								description: "Log format for Prometheus to be configured with."
								type:        "string"
							}
							logLevel: {
								description: "Log level for Prometheus to be configured with."
								type:        "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "Define which Nodes the Pods are scheduled on."
								type:        "object"
							}
							overrideHonorLabels: {
								description: "OverrideHonorLabels if set to true overrides all user configured honor_labels. If HonorLabels is set in ServiceMonitor or PodMonitor to true, this overrides honor_labels to false."
								type:        "boolean"
							}
							overrideHonorTimestamps: {
								description: "OverrideHonorTimestamps allows to globally enforce honoring timestamps in all scrape configs."
								type:        "boolean"
							}
							paused: {
								description: "When a Prometheus deployment is paused, no actions except for deletion will be performed on the underlying objects."
								type:        "boolean"
							}
							podMetadata: {
								description: "PodMetadata configures Labels and Annotations which are propagated to the prometheus pods."
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
										type:        "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
										type:        "string"
									}
								}
								type: "object"
							}
							podMonitorNamespaceSelector: {
								description: "Namespace's labels to match for PodMonitor discovery. If nil, only check own namespace."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							podMonitorSelector: {
								description: "*Experimental* PodMonitors to be selected for target discovery. *Deprecated:* if neither this nor serviceMonitorSelector are specified, configuration is unmanaged."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							portName: {
								description: "Port name used for the pods and governing service. This defaults to web"
								type:        "string"
							}
							priorityClassName: {
								description: "Priority class assigned to the Pods"
								type:        "string"
							}
							probeNamespaceSelector: {
								description: "*Experimental* Namespaces to be selected for Probe discovery. If nil, only check own namespace."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							probeSelector: {
								description: "*Experimental* Probes to be selected for target discovery."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							prometheusExternalLabelName: {
								description: "Name of Prometheus external label used to denote Prometheus instance name. Defaults to the value of `prometheus`. External label will _not_ be added when value is set to empty string (`\"\"`)."
								type:        "string"
							}
							prometheusRulesExcludedFromEnforce: {
								description: "PrometheusRulesExcludedFromEnforce - list of prometheus rules to be excluded from enforcing of adding namespace labels. Works only if enforcedNamespaceLabel set to true. Make sure both ruleNamespace and ruleName are set for each pair"
								items: {
									description: "PrometheusRuleExcludeConfig enables users to configure excluded PrometheusRule names and their namespaces to be ignored while enforcing namespace label for alerts and metrics."
									properties: {
										ruleName: {
											description: "RuleNamespace - name of excluded rule"
											type:        "string"
										}
										ruleNamespace: {
											description: "RuleNamespace - namespace of excluded rule"
											type:        "string"
										}
									}
									required: [
										"ruleName",
										"ruleNamespace",
									]
									type: "object"
								}
								type: "array"
							}
							query: {
								description: "QuerySpec defines the query command line flags when starting Prometheus."
								properties: {
									lookbackDelta: {
										description: "The delta difference allowed for retrieving metrics during expression evaluations."
										type:        "string"
									}
									maxConcurrency: {
										description: "Number of concurrent queries that can be run at once."
										format:      "int32"
										type:        "integer"
									}
									maxSamples: {
										description: "Maximum number of samples a single query can load into memory. Note that queries will fail if they would load more samples than this into memory, so this also limits the number of samples a query can return."
										format:      "int32"
										type:        "integer"
									}
									timeout: {
										description: "Maximum time a query may take before being aborted."
										type:        "string"
									}
								}
								type: "object"
							}
							queryLogFile: {
								description: "QueryLogFile specifies the file to which PromQL queries are logged. Note that this location must be writable, and can be persisted using an attached volume. Alternatively, the location can be set to a stdout location such as `/dev/stdout` to log querie information to the default Prometheus log stream. This is only available in versions of Prometheus >= 2.16.0. For more details, see the Prometheus docs (https://prometheus.io/docs/guides/query-log/)"
								type:        "string"
							}
							remoteRead: {
								description: "If specified, the remote_read spec. This is an experimental feature, it may change in any upcoming release in a breaking way."
								items: {
									description: "RemoteReadSpec defines the remote_read configuration for prometheus."
									properties: {
										basicAuth: {
											description: "BasicAuth for the URL."
											properties: {
												password: {
													description: "The secret in the service monitor namespace that contains the password for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												username: {
													description: "The secret in the service monitor namespace that contains the username for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
											}
											type: "object"
										}
										bearerToken: {
											description: "Bearer token for remote read."
											type:        "string"
										}
										bearerTokenFile: {
											description: "File to read bearer token for remote read."
											type:        "string"
										}
										name: {
											description: "The name of the remote read queue, must be unique if specified. The name is used in metrics and logging in order to differentiate read configurations.  Only valid in Prometheus versions 2.15.0 and newer."
											type:        "string"
										}
										proxyUrl: {
											description: "Optional ProxyURL"
											type:        "string"
										}
										readRecent: {
											description: "Whether reads should be made for queries for time ranges that the local storage should have complete data for."
											type:        "boolean"
										}
										remoteTimeout: {
											description: "Timeout for requests to the remote read endpoint."
											type:        "string"
										}
										requiredMatchers: {
											additionalProperties: type: "string"
											description: "An optional list of equality matchers which have to be present in a selector to query the remote read endpoint."
											type:        "object"
										}
										tlsConfig: {
											description: "TLS Config to use for remote read."
											properties: {
												ca: {
													description: "Struct containing the CA cert to use for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the Prometheus container to use for the targets."
													type:        "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the Prometheus container for the targets."
													type:        "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the Prometheus container for the targets."
													type:        "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										url: {
											description: "The URL of the endpoint to send samples to."
											type:        "string"
										}
									}
									required: ["url"]
									type: "object"
								}
								type: "array"
							}
							remoteWrite: {
								description: "If specified, the remote_write spec. This is an experimental feature, it may change in any upcoming release in a breaking way."
								items: {
									description: "RemoteWriteSpec defines the remote_write configuration for prometheus."
									properties: {
										basicAuth: {
											description: "BasicAuth for the URL."
											properties: {
												password: {
													description: "The secret in the service monitor namespace that contains the password for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												username: {
													description: "The secret in the service monitor namespace that contains the username for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
											}
											type: "object"
										}
										bearerToken: {
											description: "Bearer token for remote write."
											type:        "string"
										}
										bearerTokenFile: {
											description: "File to read bearer token for remote write."
											type:        "string"
										}
										headers: {
											additionalProperties: type: "string"
											description: "Custom HTTP headers to be sent along with each remote write request. Be aware that headers that are set by Prometheus itself can't be overwritten. Only valid in Prometheus versions 2.25.0 and newer."
											type:        "object"
										}
										metadataConfig: {
											description: "MetadataConfig configures the sending of series metadata to remote storage."
											properties: {
												send: {
													description: "Whether metric metadata is sent to remote storage or not."
													type:        "boolean"
												}
												sendInterval: {
													description: "How frequently metric metadata is sent to remote storage."
													type:        "string"
												}
											}
											type: "object"
										}
										name: {
											description: "The name of the remote write queue, must be unique if specified. The name is used in metrics and logging in order to differentiate queues. Only valid in Prometheus versions 2.15.0 and newer."
											type:        "string"
										}
										proxyUrl: {
											description: "Optional ProxyURL"
											type:        "string"
										}
										queueConfig: {
											description: "QueueConfig allows tuning of the remote write queue parameters."
											properties: {
												batchSendDeadline: {
													description: "BatchSendDeadline is the maximum time a sample will wait in buffer."
													type:        "string"
												}
												capacity: {
													description: "Capacity is the number of samples to buffer per shard before we start dropping them."
													type:        "integer"
												}
												maxBackoff: {
													description: "MaxBackoff is the maximum retry delay."
													type:        "string"
												}
												maxRetries: {
													description: "MaxRetries is the maximum number of times to retry a batch on recoverable errors."
													type:        "integer"
												}
												maxSamplesPerSend: {
													description: "MaxSamplesPerSend is the maximum number of samples per send."
													type:        "integer"
												}
												maxShards: {
													description: "MaxShards is the maximum number of shards, i.e. amount of concurrency."
													type:        "integer"
												}
												minBackoff: {
													description: "MinBackoff is the initial retry delay. Gets doubled for every retry."
													type:        "string"
												}
												minShards: {
													description: "MinShards is the minimum number of shards, i.e. amount of concurrency."
													type:        "integer"
												}
											}
											type: "object"
										}
										remoteTimeout: {
											description: "Timeout for requests to the remote write endpoint."
											type:        "string"
										}
										tlsConfig: {
											description: "TLS Config to use for remote write."
											properties: {
												ca: {
													description: "Struct containing the CA cert to use for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the Prometheus container to use for the targets."
													type:        "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the Prometheus container for the targets."
													type:        "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the Prometheus container for the targets."
													type:        "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
										url: {
											description: "The URL of the endpoint to send samples to."
											type:        "string"
										}
										writeRelabelConfigs: {
											description: "The list of remote write relabel configurations."
											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"
														type:        "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."
														format:      "int64"
														type:        "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
														type:        "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
														type:        "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."
														type:        "string"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
														items: type: "string"
														type: "array"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
									}
									required: ["url"]
									type: "object"
								}
								type: "array"
							}
							replicaExternalLabelName: {
								description: "Name of Prometheus external label used to denote replica name. Defaults to the value of `prometheus_replica`. External label will _not_ be added when value is set to empty string (`\"\"`)."
								type:        "string"
							}
							replicas: {
								description: "Number of replicas of each shard to deploy for a Prometheus deployment. Number of replicas multiplied by shards is the total number of Pods created."
								format:      "int32"
								type:        "integer"
							}
							resources: {
								description: "Define resources requests and limits for single Pods."
								properties: {
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
								}
								type: "object"
							}
							retention: {
								description: "Time duration Prometheus shall retain data for. Default is '24h', and must match the regular expression `[0-9]+(ms|s|m|h|d|w|y)` (milliseconds seconds minutes hours days weeks years)."
								type:        "string"
							}
							retentionSize: {
								description: "Maximum amount of disk space used by blocks. Supported units: B, KB, MB, GB, TB, PB, EB. Ex: `512MB`."
								type:        "string"
							}
							routePrefix: {
								description: "The route prefix Prometheus registers HTTP handlers for. This is useful, if using ExternalURL and a proxy is rewriting HTTP routes of a request, and the actual ExternalURL is still true, but the server serves requests under a different route prefix. For example for use with `kubectl proxy`."
								type:        "string"
							}
							ruleNamespaceSelector: {
								description: "Namespaces to be selected for PrometheusRules discovery. If unspecified, only the same namespace as the Prometheus object is in is used."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							ruleSelector: {
								description: "A selector to select which PrometheusRules to mount for loading alerting/recording rules from. Until (excluding) Prometheus Operator v0.24.0 Prometheus Operator will migrate any legacy rule ConfigMaps to PrometheusRule custom resources selected by RuleSelector. Make sure it does not match any config maps that you do not want to be migrated."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							rules: {
								description: "/--rules.*/ command-line arguments."
								properties: alert: {
									description: "/--rules.alert.*/ command-line arguments"
									properties: {
										forGracePeriod: {
											description: "Minimum duration between alert and restored 'for' state. This is maintained only for alerts with configured 'for' time greater than grace period."
											type:        "string"
										}
										forOutageTolerance: {
											description: "Max time to tolerate prometheus outage for restoring 'for' state of alert."
											type:        "string"
										}
										resendDelay: {
											description: "Minimum amount of time to wait before resending an alert to Alertmanager."
											type:        "string"
										}
									}
									type: "object"
								}
								type: "object"
							}
							scrapeInterval: {
								description: "Interval between consecutive scrapes."
								type:        "string"
							}
							scrapeTimeout: {
								description: "Number of seconds to wait for target to respond before erroring."
								type:        "string"
							}
							secrets: {
								description: "Secrets is a list of Secrets in the same namespace as the Prometheus object, which shall be mounted into the Prometheus Pods. The Secrets are mounted into /etc/prometheus/secrets/<secret-name>."
								items: type: "string"
								type: "array"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."
								properties: {
									fsGroup: {
										description: """
		A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
		 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
		 If unset, the Kubelet will not modify the ownership and permissions of any volume.
		"""
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: {
										description: "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified defaults to \"Always\"."
										type:        "string"
									}
									runAsGroup: {
										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									runAsNonRoot: {
										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										type:        "boolean"
									}
									runAsUser: {
										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									seLinuxOptions: {
										description: "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										properties: {
											level: {
												description: "Level is SELinux level label that applies to the container."
												type:        "string"
											}
											role: {
												description: "Role is a SELinux role label that applies to the container."
												type:        "string"
											}
											type: {
												description: "Type is a SELinux type label that applies to the container."
												type:        "string"
											}
											user: {
												description: "User is a SELinux user label that applies to the container."
												type:        "string"
											}
										}
										type: "object"
									}
									supplementalGroups: {
										description: "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container."
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										description: "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch."
										items: {
											description: "Sysctl defines a kernel parameter to be set"
											properties: {
												name: {
													description: "Name of a property to set"
													type:        "string"
												}
												value: {
													description: "Value of a property to set"
													type:        "string"
												}
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										description: "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										properties: {
											gmsaCredentialSpec: {
												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
												type:        "string"
											}
											gmsaCredentialSpecName: {
												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
												type:        "string"
											}
											runAsUserName: {
												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the Prometheus Pods."
								type:        "string"
							}
							serviceMonitorNamespaceSelector: {
								description: "Namespace's labels to match for ServiceMonitor discovery. If nil, only check own namespace."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							serviceMonitorSelector: {
								description: "ServiceMonitors to be selected for target discovery. *Deprecated:* if neither this nor podMonitorSelector are specified, configuration is unmanaged."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							sha: {
								description: "SHA of Prometheus container image to be deployed. Defaults to the value of `version`. Similar to a tag, but the SHA explicitly deploys an immutable container image. Version and Tag are ignored if SHA is set. Deprecated: use 'image' instead.  The image digest can be specified as part of the image URL."
								type:        "string"
							}
							shards: {
								description: "EXPERIMENTAL: Number of shards to distribute targets onto. Number of replicas multiplied by shards is the total number of Pods created. Note that scaling down shards will not reshard data onto remaining instances, it must be manually moved. Increasing shards will not reshard data either but it will continue to be available from the same instances. To query globally use Thanos sidecar and Thanos querier or remote write data to a central location. Sharding is done on the content of the `__address__` target meta-label."
								format:      "int32"
								type:        "integer"
							}
							storage: {
								description: "Storage spec to specify how storage shall be used."
								properties: {
									disableMountSubPath: {
										description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."
										type:        "boolean"
									}
									emptyDir: {
										description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"
										properties: {
											medium: {
												description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
												type:        "string"
											}
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "A PVC spec to be used by the Prometheus StatefulSets."
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											metadata: {
												description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."
												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
														type:        "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
														type:        "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
														type:        "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													dataSource: {
														description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot - Beta) * An existing PVC (PersistentVolumeClaim) * An existing custom resource/object that implements data population (Alpha) In order to use VolumeSnapshot object types, the appropriate feature gate must be enabled (VolumeSnapshotDataSource or AnyVolumeDataSource) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the specified data source is not supported, the volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change."
														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																type:        "string"
															}
															kind: {
																description: "Kind is the type of resource being referenced"
																type:        "string"
															}
															name: {
																description: "Name is the name of resource being referenced"
																type:        "string"
															}
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
														}
														type: "object"
													}
													selector: {
														description: "A label query over volumes to consider for binding."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "key is the label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																			type:        "string"
																		}
																		values: {
																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													storageClassName: {
														description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
														type:        "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
														type:        "string"
													}
													volumeName: {
														description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
														type:        "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "Represents the actual resources of the underlying volume."
														type:        "object"
													}
													conditions: {
														description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"
															properties: {
																lastProbeTime: {
																	description: "Last time we probed the condition."
																	format:      "date-time"
																	type:        "string"
																}
																lastTransitionTime: {
																	description: "Last time the condition transitioned from one status to another."
																	format:      "date-time"
																	type:        "string"
																}
																message: {
																	description: "Human-readable message indicating details about last transition."
																	type:        "string"
																}
																reason: {
																	description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																	type:        "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																	type:        "string"
																}
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													phase: {
														description: "Phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tag: {
								description: "Tag of Prometheus container image to be deployed. Defaults to the value of `version`. Version is ignored if Tag is set. Deprecated: use 'image' instead.  The image tag can be specified as part of the image URL."
								type:        "string"
							}
							thanos: {
								description: """
		Thanos configuration allows configuring various aspects of a Prometheus server in a Thanos environment.
		 This section is experimental, it may change significantly without deprecation notice in any release.
		 This is experimental and may change significantly without backward compatibility in any release.
		"""
								properties: {
									baseImage: {
										description: "Thanos base image if other than default. Deprecated: use 'image' instead"
										type:        "string"
									}
									grpcServerTlsConfig: {
										description: "GRPCServerTLSConfig configures the gRPC server from which Thanos Querier reads recorded rule data. Note: Currently only the CAFile, CertFile, and KeyFile fields are supported. Maps to the '--grpc-server-tls-*' CLI args."
										properties: {
											ca: {
												description: "Struct containing the CA cert to use for the targets."
												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."
														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											caFile: {
												description: "Path to the CA cert in the Prometheus container to use for the targets."
												type:        "string"
											}
											cert: {
												description: "Struct containing the client cert file for the targets."
												properties: {
													configMap: {
														description: "ConfigMap containing data to use for the targets."
														properties: {
															key: {
																description: "The key to select."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
													secret: {
														description: "Secret containing data to use for the targets."
														properties: {
															key: {
																description: "The key of the secret to select from.  Must be a valid secret key."
																type:        "string"
															}
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret or its key must be defined"
																type:        "boolean"
															}
														}
														required: ["key"]
														type: "object"
													}
												}
												type: "object"
											}
											certFile: {
												description: "Path to the client cert file in the Prometheus container for the targets."
												type:        "string"
											}
											insecureSkipVerify: {
												description: "Disable target certificate validation."
												type:        "boolean"
											}
											keyFile: {
												description: "Path to the client key file in the Prometheus container for the targets."
												type:        "string"
											}
											keySecret: {
												description: "Secret containing the client key file for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											serverName: {
												description: "Used to verify the hostname for the targets."
												type:        "string"
											}
										}
										type: "object"
									}
									image: {
										description: "Image if specified has precedence over baseImage, tag and sha combinations. Specifying the version is still necessary to ensure the Prometheus Operator knows what version of Thanos is being configured."
										type:        "string"
									}
									listenLocal: {
										description: "ListenLocal makes the Thanos sidecar listen on loopback, so that it does not bind against the Pod IP."
										type:        "boolean"
									}
									logFormat: {
										description: "LogFormat for Thanos sidecar to be configured with."
										type:        "string"
									}
									logLevel: {
										description: "LogLevel for Thanos sidecar to be configured with."
										type:        "string"
									}
									minTime: {
										description: "MinTime for Thanos sidecar to be configured with. Option can be a constant time in RFC3339 format or time duration relative to current time, such as -1d or 2h45m. Valid duration units are ms, s, m, h, d, w, y."
										type:        "string"
									}
									objectStorageConfig: {
										description: "ObjectStorageConfig configures object storage in Thanos. Alternative to ObjectStorageConfigFile, and lower order priority."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
									objectStorageConfigFile: {
										description: "ObjectStorageConfigFile specifies the path of the object storage configuration file. When used alongside with ObjectStorageConfig, ObjectStorageConfigFile takes precedence."
										type:        "string"
									}
									resources: {
										description: "Resources defines the resource requirements for the Thanos sidecar. If not provided, no requests/limits will be set"
										properties: {
											limits: {
												additionalProperties: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
												type:        "object"
											}
											requests: {
												additionalProperties: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
												description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
												type:        "object"
											}
										}
										type: "object"
									}
									sha: {
										description: "SHA of Thanos container image to be deployed. Defaults to the value of `version`. Similar to a tag, but the SHA explicitly deploys an immutable container image. Version and Tag are ignored if SHA is set. Deprecated: use 'image' instead.  The image digest can be specified as part of the image URL."
										type:        "string"
									}
									tag: {
										description: "Tag of Thanos sidecar container image to be deployed. Defaults to the value of `version`. Version is ignored if Tag is set. Deprecated: use 'image' instead.  The image tag can be specified as part of the image URL."
										type:        "string"
									}
									tracingConfig: {
										description: "TracingConfig configures tracing in Thanos. This is an experimental feature, it may change in any upcoming release in a breaking way."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
									tracingConfigFile: {
										description: "TracingConfig specifies the path of the tracing configuration file. When used alongside with TracingConfig, TracingConfigFile takes precedence."
										type:        "string"
									}
									version: {
										description: "Version describes the version of Thanos to use."
										type:        "string"
									}
								}
								type: "object"
							}
							tolerations: {
								description: "If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
											type:        "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
											type:        "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
											type:        "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
											format:      "int64"
											type:        "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "If specified, the pod's topology spread constraints."
								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
									properties: {
										labelSelector: {
											description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
											properties: {
												matchExpressions: {
													description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
													items: {
														description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
														properties: {
															key: {
																description: "key is the label key that the selector applies to."
																type:        "string"
															}
															operator: {
																description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																type:        "string"
															}
															values: {
																description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
													type:        "object"
												}
											}
											type: "object"
										}
										maxSkew: {
											description: "MaxSkew describes the degree to which pods may be unevenly distributed. It's the maximum permitted difference between the number of matching pods in any two topology domains of a given topology type. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. It's a required field. Default value is 1 and 0 is not allowed."
											format:      "int32"
											type:        "integer"
										}
										topologyKey: {
											description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
											type:        "string"
										}
										whenUnsatisfiable: {
											description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it - ScheduleAnyway tells the scheduler to still schedule it It's considered as \"Unsatisfiable\" if and only if placing incoming pod on any topology violates \"MaxSkew\". For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
											type:        "string"
										}
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							version: {
								description: "Version of Prometheus to be deployed."
								type:        "string"
							}
							volumeMounts: {
								description: "VolumeMounts allows configuration of additional VolumeMounts on the output StatefulSet definition. VolumeMounts specified will be appended to other VolumeMounts in the prometheus container, that are generated as a result of StorageSpec objects."
								items: {
									description: "VolumeMount describes a mounting of a Volume within a container."
									properties: {
										mountPath: {
											description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
											type:        "string"
										}
										mountPropagation: {
											description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
											type:        "string"
										}
										name: {
											description: "This must match the Name of a Volume."
											type:        "string"
										}
										readOnly: {
											description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
											type:        "boolean"
										}
										subPath: {
											description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
											type:        "string"
										}
										subPathExpr: {
											description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
											type:        "string"
										}
									}
									required: [
										"mountPath",
										"name",
									]
									type: "object"
								}
								type: "array"
							}
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output StatefulSet definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."
								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
									properties: {
										awsElasticBlockStore: {
											description: "AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Specify \"true\" to force and set the ReadOnly property in VolumeMounts to \"true\". If omitted, the default is \"false\". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "boolean"
												}
												volumeID: {
													description: "Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										azureDisk: {
											description: "AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
											properties: {
												cachingMode: {
													description: "Host Caching mode: None, Read Only, Read Write."
													type:        "string"
												}
												diskName: {
													description: "The Name of the data disk in the blob storage"
													type:        "string"
												}
												diskURI: {
													description: "The URI the data disk in the blob storage"
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												kind: {
													description: "Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											description: "AzureFile represents an Azure File Service mount on the host and bind mount to the pod."
											properties: {
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretName: {
													description: "the name of secret that contains Azure Storage Account Name and Key"
													type:        "string"
												}
												shareName: {
													description: "Share Name"
													type:        "string"
												}
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											description: "CephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
											properties: {
												monitors: {
													description: "Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												path: {
													description: "Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretFile: {
													description: "Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: ["monitors"]
											type: "object"
										}
										cinder: {
											description: "Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: points to a secret object containing parameters used to connect to OpenStack."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeID: {
													description: "volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										configMap: {
											description: "ConfigMap represents a configMap that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
													type:        "string"
												}
												optional: {
													description: "Specify whether the ConfigMap or its keys must be defined"
													type:        "boolean"
												}
											}
											type: "object"
										}
										csi: {
											description: "CSI (Container Storage Interface) represents storage that is handled by an external CSI driver (Alpha feature)."
											properties: {
												driver: {
													description: "Driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
													type:        "string"
												}
												nodePublishSecretRef: {
													description: "NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												readOnly: {
													description: "Specifies a read-only configuration for the volume. Defaults to false (read/write)."
													type:        "boolean"
												}
												volumeAttributes: {
													additionalProperties: type: "string"
													description: "VolumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
													type:        "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										downwardAPI: {
											description: "DownwardAPI represents downward API about the pod that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "Items is a list of downward API volume file"
													items: {
														description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
														properties: {
															fieldRef: {
																description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																type:        "string"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
														}
														required: ["path"]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											description: "EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
											properties: {
												medium: {
													description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
													type:        "string"
												}
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										fc: {
											description: "FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												lun: {
													description: "Optional: FC target lun number"
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												targetWWNs: {
													description: "Optional: FC target worldwide names (WWNs)"
													items: type: "string"
													type: "array"
												}
												wwids: {
													description: "Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											description: "FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
											properties: {
												driver: {
													description: "Driver is the name of the driver to use for this volume."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
													type:        "string"
												}
												options: {
													additionalProperties: type: "string"
													description: "Optional: Extra command options if any."
													type:        "object"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										flocker: {
											description: "Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
											properties: {
												datasetName: {
													description: "Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
													type:        "string"
												}
												datasetUUID: {
													description: "UUID of the dataset. This is unique identifier of a Flocker dataset"
													type:        "string"
												}
											}
											type: "object"
										}
										gcePersistentDisk: {
											description: "GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													format:      "int32"
													type:        "integer"
												}
												pdName: {
													description: "Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "boolean"
												}
											}
											required: ["pdName"]
											type: "object"
										}
										gitRepo: {
											description: "GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
											properties: {
												directory: {
													description: "Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
													type:        "string"
												}
												repository: {
													description: "Repository URL"
													type:        "string"
												}
												revision: {
													description: "Commit hash for the specified revision."
													type:        "string"
												}
											}
											required: ["repository"]
											type: "object"
										}
										glusterfs: {
											description: "Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
											properties: {
												endpoints: {
													description: "EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												path: {
													description: "Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "boolean"
												}
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											description: "HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
											properties: {
												path: {
													description: "Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
												type: {
													description: "Type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
											}
											required: ["path"]
											type: "object"
										}
										iscsi: {
											description: "ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
											properties: {
												chapAuthDiscovery: {
													description: "whether support iSCSI Discovery CHAP authentication"
													type:        "boolean"
												}
												chapAuthSession: {
													description: "whether support iSCSI Session CHAP authentication"
													type:        "boolean"
												}
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												initiatorName: {
													description: "Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
													type:        "string"
												}
												iqn: {
													description: "Target iSCSI Qualified Name."
													type:        "string"
												}
												iscsiInterface: {
													description: "iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
													type:        "string"
												}
												lun: {
													description: "iSCSI Target Lun number."
													format:      "int32"
													type:        "integer"
												}
												portals: {
													description: "iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													items: type: "string"
													type: "array"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
													type:        "boolean"
												}
												secretRef: {
													description: "CHAP Secret for iSCSI target and initiator authentication"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												targetPortal: {
													description: "iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													type:        "string"
												}
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: {
											description: "Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
											type:        "string"
										}
										nfs: {
											description: "NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
											properties: {
												path: {
													description: "Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "boolean"
												}
												server: {
													description: "Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											description: "PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
											properties: {
												claimName: {
													description: "ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													type:        "string"
												}
												readOnly: {
													description: "Will force the ReadOnly setting in VolumeMounts. Default false."
													type:        "boolean"
												}
											}
											required: ["claimName"]
											type: "object"
										}
										photonPersistentDisk: {
											description: "PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												pdID: {
													description: "ID that identifies Photon Controller persistent disk"
													type:        "string"
												}
											}
											required: ["pdID"]
											type: "object"
										}
										portworxVolume: {
											description: "PortworxVolume represents a portworx volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												volumeID: {
													description: "VolumeID uniquely identifies a Portworx volume"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										projected: {
											description: "Items for all in one resources secrets, configmaps, and downward API"
											properties: {
												defaultMode: {
													description: "Mode bits to use on created files by default. Must be a value between 0 and 0777. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												sources: {
													description: "list of volume projections"
													items: {
														description: "Projection that may be projected along with other supported volume types"
														properties: {
															configMap: {
																description: "information about the configMap data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its keys must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															downwardAPI: {
																description: "information about the downwardAPI data to project"
																properties: items: {
																	description: "Items is a list of DownwardAPIVolume file"
																	items: {
																		description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																		properties: {
																			fieldRef: {
																				description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																				properties: {
																					apiVersion: {
																						description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																						type:        "string"
																					}
																					fieldPath: {
																						description: "Path of the field to select in the specified API version."
																						type:        "string"
																					}
																				}
																				required: ["fieldPath"]
																				type: "object"
																			}
																			mode: {
																				description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																				type:        "string"
																			}
																			resourceFieldRef: {
																				description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																				properties: {
																					containerName: {
																						description: "Container name: required for volumes, optional for env vars"
																						type:        "string"
																					}
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: {
																						description: "Required: resource to select"
																						type:        "string"
																					}
																				}
																				required: ["resource"]
																				type: "object"
																			}
																		}
																		required: ["path"]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																description: "information about the secret data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															serviceAccountToken: {
																description: "information about the serviceAccountToken data to project"
																properties: {
																	audience: {
																		description: "Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																		type:        "string"
																	}
																	expirationSeconds: {
																		description: "ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																		format:      "int64"
																		type:        "integer"
																	}
																	path: {
																		description: "Path is the path relative to the mount point of the file to project the token into."
																		type:        "string"
																	}
																}
																required: ["path"]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: ["sources"]
											type: "object"
										}
										quobyte: {
											description: "Quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
											properties: {
												group: {
													description: "Group to map volume access to Default is no group"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
													type:        "boolean"
												}
												registry: {
													description: "Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
													type:        "string"
												}
												tenant: {
													description: "Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
													type:        "string"
												}
												user: {
													description: "User to map volume access to Defaults to serivceaccount user"
													type:        "string"
												}
												volume: {
													description: "Volume is a string that references an already created Quobyte volume by name."
													type:        "string"
												}
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											description: "RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												image: {
													description: "The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												keyring: {
													description: "Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												monitors: {
													description: "A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												pool: {
													description: "The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											description: "ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
													type:        "string"
												}
												gateway: {
													description: "The host address of the ScaleIO API Gateway."
													type:        "string"
												}
												protectionDomain: {
													description: "The name of the ScaleIO Protection Domain for the configured storage."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												sslEnabled: {
													description: "Flag to enable/disable SSL communication with Gateway, default false"
													type:        "boolean"
												}
												storageMode: {
													description: "Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
													type:        "string"
												}
												storagePool: {
													description: "The ScaleIO Storage Pool associated with the protection domain."
													type:        "string"
												}
												system: {
													description: "The name of the storage system as configured in ScaleIO."
													type:        "string"
												}
												volumeName: {
													description: "The name of a volume already created in the ScaleIO system that is associated with this volume source."
													type:        "string"
												}
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											description: "Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: {
													description: "Specify whether the Secret or its keys must be defined"
													type:        "boolean"
												}
												secretName: {
													description: "Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
													type:        "string"
												}
											}
											type: "object"
										}
										storageos: {
											description: "StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeName: {
													description: "VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
													type:        "string"
												}
												volumeNamespace: {
													description: "VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
													type:        "string"
												}
											}
											type: "object"
										}
										vsphereVolume: {
											description: "VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												storagePolicyID: {
													description: "Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
													type:        "string"
												}
												storagePolicyName: {
													description: "Storage Policy Based Management (SPBM) profile name."
													type:        "string"
												}
												volumePath: {
													description: "Path that identifies vSphere volume vmdk"
													type:        "string"
												}
											}
											required: ["volumePath"]
											type: "object"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							walCompression: {
								description: "Enable compression of the write-ahead log using Snappy. This flag is only available in versions of Prometheus >= 2.11.0."
								type:        "boolean"
							}
							web: {
								description: "WebSpec defines the web command line flags when starting Prometheus."
								properties: pageTitle: {
									description: "The prometheus web page title"
									type:        "string"
								}
								type: "object"
							}
						}
						type: "object"
					}
					status: {
						description: "Most recent observed status of the Prometheus cluster. Read-only. Not included when requesting from the apiserver, only from the Prometheus Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {
							availableReplicas: {
								description: "Total number of available pods (ready for at least minReadySeconds) targeted by this Prometheus deployment."
								format:      "int32"
								type:        "integer"
							}
							paused: {
								description: "Represents whether any actions on the underlying managed objects are being performed. Only delete actions will be performed."
								type:        "boolean"
							}
							replicas: {
								description: "Total number of non-terminated pods targeted by this Prometheus deployment (their labels match the selector)."
								format:      "int32"
								type:        "integer"
							}
							unavailableReplicas: {
								description: "Total number of unavailable pods targeted by this Prometheus deployment."
								format:      "int32"
								type:        "integer"
							}
							updatedReplicas: {
								description: "Total number of non-terminated pods targeted by this Prometheus deployment that have the desired version spec."
								format:      "int32"
								type:        "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
			subresources: {}
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "prometheusrules.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			kind:     "PrometheusRule"
			listKind: "PrometheusRuleList"
			plural:   "prometheusrules"
			singular: "prometheusrule"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description: "PrometheusRule defines recording and alerting rules for a Prometheus instance"
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of desired alerting rule definitions for Prometheus."
						properties: groups: {
							description: "Content of Prometheus rule file"
							items: {
								description: "RuleGroup is a list of sequentially evaluated recording and alerting rules. Note: PartialResponseStrategy is only used by ThanosRuler and will be ignored by Prometheus instances.  Valid values for this field are 'warn' or 'abort'.  More info: https://github.com/thanos-io/thanos/blob/master/docs/components/rule.md#partial-response"
								properties: {
									interval: type:                  "string"
									name: type:                      "string"
									partial_response_strategy: type: "string"
									rules: {
										items: {
											description: "Rule describes an alerting or recording rule."
											properties: {
												alert: type: "string"
												annotations: {
													additionalProperties: type: "string"
													type: "object"
												}
												expr: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													"x-kubernetes-int-or-string": true
												}
												for: type: "string"
												labels: {
													additionalProperties: type: "string"
													type: "object"
												}
												record: type: "string"
											}
											required: ["expr"]
											type: "object"
										}
										type: "array"
									}
								}
								required: [
									"name",
									"rules",
								]
								type: "object"
							}
							type: "array"
						}
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}, status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "servicemonitors.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "ServiceMonitor"
			listKind: "ServiceMonitorList"
			plural:   "servicemonitors"
			singular: "servicemonitor"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description:
					"ServiceMonitor defines monitoring for a set of services."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description:
							"Specification of desired Service selection for target discovery by Prometheus.", properties: {

							endpoints: {
								description: "A list of endpoints allowed as part of this ServiceMonitor."
								items: {
									description: "Endpoint defines a scrapeable endpoint serving Prometheus metrics."
									properties: {
										basicAuth: {
											description: "BasicAuth allow an endpoint to authenticate over basic authentication More info: https://prometheus.io/docs/operating/configuration/#endpoints"
											properties: {
												password: {
													description: "The secret in the service monitor namespace that contains the password for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												username: {
													description: "The secret in the service monitor namespace that contains the username for authentication."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
											}
											type: "object"
										}
										bearerTokenFile: {
											description: "File to read bearer token for scraping targets."
											type:        "string"
										}
										bearerTokenSecret: {
											description: "Secret to mount to read bearer token for scraping targets. The secret needs to be in the same namespace as the service monitor and accessible by the Prometheus Operator."
											properties: {
												key: {
													description: "The key of the secret to select from.  Must be a valid secret key."
													type:        "string"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
													type:        "string"
												}
												optional: {
													description: "Specify whether the Secret or its key must be defined"
													type:        "boolean"
												}
											}
											required: ["key"]
											type: "object"
										}
										honorLabels: {
											description: "HonorLabels chooses the metric's labels on collisions with target labels."
											type:        "boolean"
										}
										honorTimestamps: {
											description: "HonorTimestamps controls whether Prometheus respects the timestamps present in scraped data."
											type:        "boolean"
										}
										interval: {
											description: "Interval at which metrics should be scraped"
											type:        "string"
										}
										metricRelabelings: {
											description: "MetricRelabelConfigs to apply to samples before ingestion."
											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"
														type:        "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."
														format:      "int64"
														type:        "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
														type:        "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
														type:        "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."
														type:        "string"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
														items: type: "string"
														type: "array"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										params: {
											additionalProperties: {
												items: type: "string"
												type: "array"
											}
											description: "Optional HTTP URL parameters"
											type:        "object"
										}
										path: {
											description: "HTTP path to scrape for metrics."
											type:        "string"
										}
										port: {
											description: "Name of the service port this endpoint refers to. Mutually exclusive with targetPort."
											type:        "string"
										}
										proxyUrl: {
											description: "ProxyURL eg http://proxyserver:2195 Directs scrapes to proxy through this endpoint."
											type:        "string"
										}
										relabelings: {
											description: "RelabelConfigs to apply to samples before scraping. Prometheus Operator automatically adds relabelings for a few standard Kubernetes fields and replaces original scrape job name with __tmp_prometheus_job_name. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#relabel_config"
											items: {
												description: "RelabelConfig allows dynamic rewriting of the label set, being applied to samples before ingestion. It defines `<metric_relabel_configs>`-section of Prometheus configuration. More info: https://prometheus.io/docs/prometheus/latest/configuration/configuration/#metric_relabel_configs"
												properties: {
													action: {
														description: "Action to perform based on regex matching. Default is 'replace'"
														type:        "string"
													}
													modulus: {
														description: "Modulus to take of the hash of the source label values."
														format:      "int64"
														type:        "integer"
													}
													regex: {
														description: "Regular expression against which the extracted value is matched. Default is '(.*)'"
														type:        "string"
													}
													replacement: {
														description: "Replacement value against which a regex replace is performed if the regular expression matches. Regex capture groups are available. Default is '$1'"
														type:        "string"
													}
													separator: {
														description: "Separator placed between concatenated source label values. default is ';'."
														type:        "string"
													}
													sourceLabels: {
														description: "The source labels select values from existing labels. Their content is concatenated using the configured separator and matched against the configured regular expression for the replace, keep, and drop actions."
														items: type: "string"
														type: "array"
													}
													targetLabel: {
														description: "Label to which the resulting value is written in a replace action. It is mandatory for replace actions. Regex capture groups are available."
														type:        "string"
													}
												}
												type: "object"
											}
											type: "array"
										}
										scheme: {
											description: "HTTP scheme to use for scraping."
											type:        "string"
										}
										scrapeTimeout: {
											description: "Timeout after which the scrape is ended"
											type:        "string"
										}
										targetPort: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											description:                  "Name or number of the target port of the Pod behind the Service, the port must be specified with container port property. Mutually exclusive with port."
											"x-kubernetes-int-or-string": true
										}
										tlsConfig: {
											description: "TLS configuration to use when scraping the endpoint"
											properties: {
												ca: {
													description: "Struct containing the CA cert to use for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												caFile: {
													description: "Path to the CA cert in the Prometheus container to use for the targets."
													type:        "string"
												}
												cert: {
													description: "Struct containing the client cert file for the targets."
													properties: {
														configMap: {
															description: "ConfigMap containing data to use for the targets."
															properties: {
																key: {
																	description: "The key to select."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the ConfigMap or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
														secret: {
															description: "Secret containing data to use for the targets."
															properties: {
																key: {
																	description: "The key of the secret to select from.  Must be a valid secret key."
																	type:        "string"
																}
																name: {
																	description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																	type:        "string"
																}
																optional: {
																	description: "Specify whether the Secret or its key must be defined"
																	type:        "boolean"
																}
															}
															required: ["key"]
															type: "object"
														}
													}
													type: "object"
												}
												certFile: {
													description: "Path to the client cert file in the Prometheus container for the targets."
													type:        "string"
												}
												insecureSkipVerify: {
													description: "Disable target certificate validation."
													type:        "boolean"
												}
												keyFile: {
													description: "Path to the client key file in the Prometheus container for the targets."
													type:        "string"
												}
												keySecret: {
													description: "Secret containing the client key file for the targets."
													properties: {
														key: {
															description: "The key of the secret to select from.  Must be a valid secret key."
															type:        "string"
														}
														name: {
															description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
															type:        "string"
														}
														optional: {
															description: "Specify whether the Secret or its key must be defined"
															type:        "boolean"
														}
													}
													required: ["key"]
													type: "object"
												}
												serverName: {
													description: "Used to verify the hostname for the targets."
													type:        "string"
												}
											}
											type: "object"
										}
									}
									type: "object"
								}
								type: "array"
							}
							jobLabel: {
								description: "The label to use to retrieve the job name from."
								type:        "string"
							}
							namespaceSelector: {
								description: "Selector to select which namespaces the Endpoints objects are discovered from."
								properties: {
									any: {
										description: "Boolean describing whether all namespaces are selected in contrast to a list restricting them."
										type:        "boolean"
									}
									matchNames: {
										description: "List of namespace names."
										items: type: "string"
										type: "array"
									}
								}
								type: "object"
							}
							podTargetLabels: {
								description: "PodTargetLabels transfers labels on the Kubernetes Pod onto the target."
								items: type: "string"
								type: "array"
							}
							sampleLimit: {
								description: "SampleLimit defines per-scrape limit on number of scraped samples that will be accepted."
								format:      "int64"
								type:        "integer"
							}
							selector: {
								description: "Selector to select Endpoints objects."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							targetLabels: {
								description: "TargetLabels transfers labels on the Kubernetes Service onto the target."
								items: type: "string"
								type: "array"
							}
							targetLimit: {
								description: "TargetLimit defines a limit on the number of scraped targets that will be accepted."
								format:      "int64"
								type:        "integer"
							}
						}
						required: [
							"endpoints",
							"selector",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}, {
	metadata: {
		annotations: "controller-gen.kubebuilder.io/version": "v0.4.1"
		name: "thanosrulers.monitoring.coreos.com"
	}
	spec: {
		group: "monitoring.coreos.com"
		names: {
			categories: [
				"prometheus-operator",
			]
			kind:     "ThanosRuler"
			listKind: "ThanosRulerList"
			plural:   "thanosrulers"
			singular: "thanosruler"
		}
		scope: "Namespaced"
		versions: [{
			name: "v1"
			schema: openAPIV3Schema: {
				description:
					"ThanosRuler defines a ThanosRuler deployment."
				properties: {
					apiVersion: {
						description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
						type:        "string"
					}
					kind: {
						description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
						type:        "string"
					}
					metadata: type: "object"
					spec: {
						description: "Specification of the desired behavior of the ThanosRuler cluster. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {
							affinity: {
								description: "If specified, the pod's scheduling constraints."
								properties: {
									nodeAffinity: {
										description: "Describes node affinity scheduling rules for the pod."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred."
												items: {
													description: "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op)."
													properties: {
														preference: {
															description: "A node selector term, associated with the corresponding weight."
															properties: {
																matchExpressions: {
																	description: "A list of node selector requirements by node's labels."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchFields: {
																	description: "A list of node selector requirements by node's fields."
																	items: {
																		description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "The label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																				type:        "string"
																			}
																			values: {
																				description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
															}
															type: "object"
														}
														weight: {
															description: "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"preference",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node."
												properties: nodeSelectorTerms: {
													description: "Required. A list of node selector terms. The terms are ORed."
													items: {
														description: "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm."
														properties: {
															matchExpressions: {
																description: "A list of node selector requirements by node's labels."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchFields: {
																description: "A list of node selector requirements by node's fields."
																items: {
																	description: "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "The label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt."
																			type:        "string"
																		}
																		values: {
																			description: "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
														}
														type: "object"
													}
													type: "array"
												}
												required: ["nodeSelectorTerms"]
												type: "object"
											}
										}
										type: "object"
									}
									podAffinity: {
										description: "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
									podAntiAffinity: {
										description: "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s))."
										properties: {
											preferredDuringSchedulingIgnoredDuringExecution: {
												description: "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred."
												items: {
													description: "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)"
													properties: {
														podAffinityTerm: {
															description: "Required. A pod affinity term, associated with the corresponding weight."
															properties: {
																labelSelector: {
																	description: "A label query over a set of resources, in this case pods."
																	properties: {
																		matchExpressions: {
																			description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																			items: {
																				description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																				properties: {
																					key: {
																						description: "key is the label key that the selector applies to."
																						type:        "string"
																					}
																					operator: {
																						description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																						type:        "string"
																					}
																					values: {
																						description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																						items: type: "string"
																						type: "array"
																					}
																				}
																				required: [
																					"key",
																					"operator",
																				]
																				type: "object"
																			}
																			type: "array"
																		}
																		matchLabels: {
																			additionalProperties: type: "string"
																			description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																			type:        "object"
																		}
																	}
																	type: "object"
																}
																namespaces: {
																	description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
																	items: type: "string"
																	type: "array"
																}
																topologyKey: {
																	description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
																	type:        "string"
																}
															}
															required: ["topologyKey"]
															type: "object"
														}
														weight: {
															description: "weight associated with matching the corresponding podAffinityTerm, in the range 1-100."
															format:      "int32"
															type:        "integer"
														}
													}
													required: [
														"podAffinityTerm",
														"weight",
													]
													type: "object"
												}
												type: "array"
											}
											requiredDuringSchedulingIgnoredDuringExecution: {
												description: "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied."
												items: {
													description: "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running"
													properties: {
														labelSelector: {
															description: "A label query over a set of resources, in this case pods."
															properties: {
																matchExpressions: {
																	description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																	items: {
																		description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																		properties: {
																			key: {
																				description: "key is the label key that the selector applies to."
																				type:        "string"
																			}
																			operator: {
																				description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																				type:        "string"
																			}
																			values: {
																				description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																				items: type: "string"
																				type: "array"
																			}
																		}
																		required: [
																			"key",
																			"operator",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																matchLabels: {
																	additionalProperties: type: "string"
																	description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																	type:        "object"
																}
															}
															type: "object"
														}
														namespaces: {
															description: "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\""
															items: type: "string"
															type: "array"
														}
														topologyKey: {
															description: "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed."
															type:        "string"
														}
													}
													required: ["topologyKey"]
													type: "object"
												}
												type: "array"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							alertDropLabels: {
								description: "AlertDropLabels configure the label names which should be dropped in ThanosRuler alerts. If `labels` field is not provided, `thanos_ruler_replica` will be dropped in alerts by default."
								items: type: "string"
								type: "array"
							}
							alertQueryUrl: {
								description: "The external Query URL the Thanos Ruler will set in the 'Source' field of all alerts. Maps to the '--alert.query-url' CLI arg."
								type:        "string"
							}
							alertmanagersConfig: {
								description: "Define configuration for connecting to alertmanager.  Only available with thanos v0.10.0 and higher.  Maps to the `alertmanagers.config` arg."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							alertmanagersUrl: {
								description: "Define URLs to send alerts to Alertmanager.  For Thanos v0.10.0 and higher, AlertManagersConfig should be used instead.  Note: this field will be ignored if AlertManagersConfig is specified. Maps to the `alertmanagers.url` arg."
								items: type: "string"
								type: "array"
							}
							containers: {
								description: "Containers allows injecting additional containers or modifying operator generated containers. This can be used to allow adding an authentication proxy to a ThanosRuler pod or to change the behavior of an operator generated container. Containers described here modify an operator generated container if they share the same name and modifications are done via a strategic merge patch. The current container names are: `thanos-ruler` and `config-reloader`. Overriding containers is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							enforcedNamespaceLabel: {
								description: "EnforcedNamespaceLabel enforces adding a namespace label of origin for each alert and metric that is user created. The label value will always be the namespace of the object that is being created."
								type:        "string"
							}
							evaluationInterval: {
								description: "Interval between consecutive evaluations."
								type:        "string"
							}
							externalPrefix: {
								description: "The external URL the Thanos Ruler instances will be available under. This is necessary to generate correct URLs. This is necessary if Thanos Ruler is not served from root of a DNS name."
								type:        "string"
							}
							grpcServerTlsConfig: {
								description: "GRPCServerTLSConfig configures the gRPC server from which Thanos Querier reads recorded rule data. Note: Currently only the CAFile, CertFile, and KeyFile fields are supported. Maps to the '--grpc-server-tls-*' CLI args."
								properties: {
									ca: {
										description: "Struct containing the CA cert to use for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									caFile: {
										description: "Path to the CA cert in the Prometheus container to use for the targets."
										type:        "string"
									}
									cert: {
										description: "Struct containing the client cert file for the targets."
										properties: {
											configMap: {
												description: "ConfigMap containing data to use for the targets."
												properties: {
													key: {
														description: "The key to select."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the ConfigMap or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
											secret: {
												description: "Secret containing data to use for the targets."
												properties: {
													key: {
														description: "The key of the secret to select from.  Must be a valid secret key."
														type:        "string"
													}
													name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													optional: {
														description: "Specify whether the Secret or its key must be defined"
														type:        "boolean"
													}
												}
												required: ["key"]
												type: "object"
											}
										}
										type: "object"
									}
									certFile: {
										description: "Path to the client cert file in the Prometheus container for the targets."
										type:        "string"
									}
									insecureSkipVerify: {
										description: "Disable target certificate validation."
										type:        "boolean"
									}
									keyFile: {
										description: "Path to the client key file in the Prometheus container for the targets."
										type:        "string"
									}
									keySecret: {
										description: "Secret containing the client key file for the targets."
										properties: {
											key: {
												description: "The key of the secret to select from.  Must be a valid secret key."
												type:        "string"
											}
											name: {
												description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
												type:        "string"
											}
											optional: {
												description: "Specify whether the Secret or its key must be defined"
												type:        "boolean"
											}
										}
										required: ["key"]
										type: "object"
									}
									serverName: {
										description: "Used to verify the hostname for the targets."
										type:        "string"
									}
								}
								type: "object"
							}
							image: {
								description: "Thanos container image URL."
								type:        "string"
							}
							imagePullSecrets: {
								description: "An optional list of references to secrets in the same namespace to use for pulling thanos images from registries see http://kubernetes.io/docs/user-guide/images#specifying-imagepullsecrets-on-a-pod"
								items: {
									description: "LocalObjectReference contains enough information to let you locate the referenced object inside the same namespace."
									properties: name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									type: "object"
								}
								type: "array"
							}
							initContainers: {
								description: "InitContainers allows adding initContainers to the pod definition. Those can be used to e.g. fetch secrets for injection into the ThanosRuler configuration from external sources. Any errors during the execution of an initContainer will lead to a restart of the Pod. More info: https://kubernetes.io/docs/concepts/workloads/pods/init-containers/ Using initContainers for any use case other then secret fetching is entirely outside the scope of what the maintainers will support and by doing so, you accept that this behaviour may break at any time without notice."
								items: {
									description: "A single application container that you want to run within a pod."
									properties: {
										args: {
											description: "Arguments to the entrypoint. The docker image's CMD is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										command: {
											description: "Entrypoint array. Not executed within a shell. The docker image's ENTRYPOINT is used if this is not provided. Variable references $(VAR_NAME) are expanded using the container's environment. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Cannot be updated. More info: https://kubernetes.io/docs/tasks/inject-data-application/define-command-argument-container/#running-a-command-in-a-shell"
											items: type: "string"
											type: "array"
										}
										env: {
											description: "List of environment variables to set in the container. Cannot be updated."
											items: {
												description: "EnvVar represents an environment variable present in a Container."
												properties: {
													name: {
														description: "Name of the environment variable. Must be a C_IDENTIFIER."
														type:        "string"
													}
													value: {
														description: "Variable references $(VAR_NAME) are expanded using the previous defined environment variables in the container and any service environment variables. If a variable cannot be resolved, the reference in the input string will be unchanged. The $(VAR_NAME) syntax can be escaped with a double $$, ie: $$(VAR_NAME). Escaped references will never be expanded, regardless of whether the variable exists or not. Defaults to \"\"."
														type:        "string"
													}
													valueFrom: {
														description: "Source for the environment variable's value. Cannot be used if value is not empty."
														properties: {
															configMapKeyRef: {
																description: "Selects a key of a ConfigMap."
																properties: {
																	key: {
																		description: "The key to select."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
															fieldRef: {
																description: "Selects a field of the pod: supports metadata.name, metadata.namespace, metadata.labels, metadata.annotations, spec.nodeName, spec.serviceAccountName, status.hostIP, status.podIP, status.podIPs."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, limits.ephemeral-storage, requests.cpu, requests.memory and requests.ephemeral-storage) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
															secretKeyRef: {
																description: "Selects a key of a secret in the pod's namespace"
																properties: {
																	key: {
																		description: "The key of the secret to select from.  Must be a valid secret key."
																		type:        "string"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																required: ["key"]
																type: "object"
															}
														}
														type: "object"
													}
												}
												required: ["name"]
												type: "object"
											}
											type: "array"
										}
										envFrom: {
											description: "List of sources to populate environment variables in the container. The keys defined within a source must be a C_IDENTIFIER. All invalid keys will be reported as an event when the container is starting. When a key exists in multiple sources, the value associated with the last source will take precedence. Values defined by an Env with a duplicate key will take precedence. Cannot be updated."
											items: {
												description: "EnvFromSource represents the source of a set of ConfigMaps"
												properties: {
													configMapRef: {
														description: "The ConfigMap to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the ConfigMap must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
													prefix: {
														description: "An optional identifier to prepend to each key in the ConfigMap. Must be a C_IDENTIFIER."
														type:        "string"
													}
													secretRef: {
														description: "The Secret to select from"
														properties: {
															name: {
																description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																type:        "string"
															}
															optional: {
																description: "Specify whether the Secret must be defined"
																type:        "boolean"
															}
														}
														type: "object"
													}
												}
												type: "object"
											}
											type: "array"
										}
										image: {
											description: "Docker image name. More info: https://kubernetes.io/docs/concepts/containers/images This field is optional to allow higher level config management to default or override container images in workload controllers like Deployments and StatefulSets."
											type:        "string"
										}
										imagePullPolicy: {
											description: "Image pull policy. One of Always, Never, IfNotPresent. Defaults to Always if :latest tag is specified, or IfNotPresent otherwise. Cannot be updated. More info: https://kubernetes.io/docs/concepts/containers/images#updating-images"
											type:        "string"
										}
										lifecycle: {
											description: "Actions that the management system should take in response to container lifecycle events. Cannot be updated."
											properties: {
												postStart: {
													description: "PostStart is called immediately after a container is created. If the handler fails, the container is terminated and restarted according to its restart policy. Other management of the container blocks until the hook completes. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
												preStop: {
													description: "PreStop is called immediately before a container is terminated due to an API request or management event such as liveness/startup probe failure, preemption, resource contention, etc. The handler is not called if the container crashes or exits. The reason for termination is passed to the handler. The Pod's termination grace period countdown begins before the PreStop hooked is executed. Regardless of the outcome of the handler, the container will eventually terminate within the Pod's termination grace period. Other management of the container blocks until the hook completes or until the termination grace period is reached. More info: https://kubernetes.io/docs/concepts/containers/container-lifecycle-hooks/#container-hooks"
													properties: {
														exec: {
															description: "One and only one of the following should be specified. Exec specifies the action to take."
															properties: command: {
																description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
																items: type: "string"
																type: "array"
															}
															type: "object"
														}
														httpGet: {
															description: "HTTPGet specifies the http request to perform."
															properties: {
																host: {
																	description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
																	type:        "string"
																}
																httpHeaders: {
																	description: "Custom headers to set in the request. HTTP allows repeated headers."
																	items: {
																		description: "HTTPHeader describes a custom header to be used in HTTP probes"
																		properties: {
																			name: {
																				description: "The header field name"
																				type:        "string"
																			}
																			value: {
																				description: "The header field value"
																				type:        "string"
																			}
																		}
																		required: [
																			"name",
																			"value",
																		]
																		type: "object"
																	}
																	type: "array"
																}
																path: {
																	description: "Path to access on the HTTP server."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
																scheme: {
																	description: "Scheme to use for connecting to the host. Defaults to HTTP."
																	type:        "string"
																}
															}
															required: ["port"]
															type: "object"
														}
														tcpSocket: {
															description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
															properties: {
																host: {
																	description: "Optional: Host name to connect to, defaults to the pod IP."
																	type:        "string"
																}
																port: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
																	"x-kubernetes-int-or-string": true
																}
															}
															required: ["port"]
															type: "object"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										livenessProbe: {
											description: "Periodic probe of container liveness. Container will be restarted if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										name: {
											description: "Name of the container specified as a DNS_LABEL. Each container in a pod must have a unique name (DNS_LABEL). Cannot be updated."
											type:        "string"
										}
										ports: {
											description: "List of ports to expose from the container. Exposing a port here gives the system additional information about the network connections a container uses, but is primarily informational. Not specifying a port here DOES NOT prevent that port from being exposed. Any port which is listening on the default \"0.0.0.0\" address inside a container will be accessible from the network. Cannot be updated."
											items: {
												description: "ContainerPort represents a network port in a single container."
												properties: {
													containerPort: {
														description: "Number of port to expose on the pod's IP address. This must be a valid port number, 0 < x < 65536."
														format:      "int32"
														type:        "integer"
													}
													hostIP: {
														description: "What host IP to bind the external port to."
														type:        "string"
													}
													hostPort: {
														description: "Number of port to expose on the host. If specified, this must be a valid port number, 0 < x < 65536. If HostNetwork is specified, this must match ContainerPort. Most containers do not need this."
														format:      "int32"
														type:        "integer"
													}
													name: {
														description: "If specified, this must be an IANA_SVC_NAME and unique within the pod. Each named port in a pod must have a unique name. Name for the port that can be referred to by services."
														type:        "string"
													}
													protocol: {
														default:     "TCP"
														description: "Protocol for port. Must be UDP, TCP, or SCTP. Defaults to \"TCP\"."
														type:        "string"
													}
												}
												required: ["containerPort"]
												type: "object"
											}
											type: "array"
											"x-kubernetes-list-map-keys": [
												"containerPort",
												"protocol",
											]
											"x-kubernetes-list-type": "map"
										}
										readinessProbe: {
											description: "Periodic probe of container service readiness. Container will be removed from service endpoints if the probe fails. Cannot be updated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										resources: {
											description: "Compute Resources required by this container. Cannot be updated. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
											properties: {
												limits: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
												requests: {
													additionalProperties: {
														anyOf: [{
															type: "integer"
														}, {
															type: "string"
														}]
														pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
														"x-kubernetes-int-or-string": true
													}
													description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
													type:        "object"
												}
											}
											type: "object"
										}
										securityContext: {
											description: "Security options the pod should run with. More info: https://kubernetes.io/docs/concepts/policy/security-context/ More info: https://kubernetes.io/docs/tasks/configure-pod-container/security-context/"
											properties: {
												allowPrivilegeEscalation: {
													description: "AllowPrivilegeEscalation controls whether a process can gain more privileges than its parent process. This bool directly controls if the no_new_privs flag will be set on the container process. AllowPrivilegeEscalation is true always when the container is: 1) run as Privileged 2) has CAP_SYS_ADMIN"
													type:        "boolean"
												}
												capabilities: {
													description: "The capabilities to add/drop when running containers. Defaults to the default set of capabilities granted by the container runtime."
													properties: {
														add: {
															description: "Added capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
														drop: {
															description: "Removed capabilities"
															items: {
																description: "Capability represent POSIX capabilities type"
																type:        "string"
															}
															type: "array"
														}
													}
													type: "object"
												}
												privileged: {
													description: "Run container in privileged mode. Processes in privileged containers are essentially equivalent to root on the host. Defaults to false."
													type:        "boolean"
												}
												procMount: {
													description: "procMount denotes the type of proc mount to use for the containers. The default is DefaultProcMount which uses the container runtime defaults for readonly paths and masked paths. This requires the ProcMountType feature flag to be enabled."
													type:        "string"
												}
												readOnlyRootFilesystem: {
													description: "Whether this container has a read-only root filesystem. Default is false."
													type:        "boolean"
												}
												runAsGroup: {
													description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												runAsNonRoot: {
													description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													type:        "boolean"
												}
												runAsUser: {
													description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													format:      "int64"
													type:        "integer"
												}
												seLinuxOptions: {
													description: "The SELinux context to be applied to the container. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in PodSecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														level: {
															description: "Level is SELinux level label that applies to the container."
															type:        "string"
														}
														role: {
															description: "Role is a SELinux role label that applies to the container."
															type:        "string"
														}
														type: {
															description: "Type is a SELinux type label that applies to the container."
															type:        "string"
														}
														user: {
															description: "User is a SELinux user label that applies to the container."
															type:        "string"
														}
													}
													type: "object"
												}
												windowsOptions: {
													description: "The Windows specific settings applied to all containers. If unspecified, the options from the PodSecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
													properties: {
														gmsaCredentialSpec: {
															description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
															type:        "string"
														}
														gmsaCredentialSpecName: {
															description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
															type:        "string"
														}
														runAsUserName: {
															description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
															type:        "string"
														}
													}
													type: "object"
												}
											}
											type: "object"
										}
										startupProbe: {
											description: "StartupProbe indicates that the Pod has successfully initialized. If specified, no other probes are executed until this completes successfully. If this probe fails, the Pod will be restarted, just as if the livenessProbe failed. This can be used to provide different probe parameters at the beginning of a Pod's lifecycle, when it might take a long time to load data or warm a cache, than during steady-state operation. This cannot be updated. This is a beta feature enabled by the StartupProbe feature flag. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
											properties: {
												exec: {
													description: "One and only one of the following should be specified. Exec specifies the action to take."
													properties: command: {
														description: "Command is the command line to execute inside the container, the working directory for the command  is root ('/') in the container's filesystem. The command is simply exec'd, it is not run inside a shell, so traditional shell instructions ('|', etc) won't work. To use a shell, you need to explicitly call out to that shell. Exit status of 0 is treated as live/healthy and non-zero is unhealthy."
														items: type: "string"
														type: "array"
													}
													type: "object"
												}
												failureThreshold: {
													description: "Minimum consecutive failures for the probe to be considered failed after having succeeded. Defaults to 3. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												httpGet: {
													description: "HTTPGet specifies the http request to perform."
													properties: {
														host: {
															description: "Host name to connect to, defaults to the pod IP. You probably want to set \"Host\" in httpHeaders instead."
															type:        "string"
														}
														httpHeaders: {
															description: "Custom headers to set in the request. HTTP allows repeated headers."
															items: {
																description: "HTTPHeader describes a custom header to be used in HTTP probes"
																properties: {
																	name: {
																		description: "The header field name"
																		type:        "string"
																	}
																	value: {
																		description: "The header field value"
																		type:        "string"
																	}
																}
																required: [
																	"name",
																	"value",
																]
																type: "object"
															}
															type: "array"
														}
														path: {
															description: "Path to access on the HTTP server."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Name or number of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
														scheme: {
															description: "Scheme to use for connecting to the host. Defaults to HTTP."
															type:        "string"
														}
													}
													required: ["port"]
													type: "object"
												}
												initialDelaySeconds: {
													description: "Number of seconds after the container has started before liveness probes are initiated. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
												periodSeconds: {
													description: "How often (in seconds) to perform the probe. Default to 10 seconds. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												successThreshold: {
													description: "Minimum consecutive successes for the probe to be considered successful after having failed. Defaults to 1. Must be 1 for liveness and startup. Minimum value is 1."
													format:      "int32"
													type:        "integer"
												}
												tcpSocket: {
													description: "TCPSocket specifies an action involving a TCP port. TCP hooks not yet supported TODO: implement a realistic TCP lifecycle hook"
													properties: {
														host: {
															description: "Optional: Host name to connect to, defaults to the pod IP."
															type:        "string"
														}
														port: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															description:                  "Number or name of the port to access on the container. Number must be in the range 1 to 65535. Name must be an IANA_SVC_NAME."
															"x-kubernetes-int-or-string": true
														}
													}
													required: ["port"]
													type: "object"
												}
												timeoutSeconds: {
													description: "Number of seconds after which the probe times out. Defaults to 1 second. Minimum value is 1. More info: https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle#container-probes"
													format:      "int32"
													type:        "integer"
												}
											}
											type: "object"
										}
										stdin: {
											description: "Whether this container should allocate a buffer for stdin in the container runtime. If this is not set, reads from stdin in the container will always result in EOF. Default is false."
											type:        "boolean"
										}
										stdinOnce: {
											description: "Whether the container runtime should close the stdin channel after it has been opened by a single attach. When stdin is true the stdin stream will remain open across multiple attach sessions. If stdinOnce is set to true, stdin is opened on container start, is empty until the first client attaches to stdin, and then remains open and accepts data until the client disconnects, at which time stdin is closed and remains closed until the container is restarted. If this flag is false, a container processes that reads from stdin will never receive an EOF. Default is false"
											type:        "boolean"
										}
										terminationMessagePath: {
											description: "Optional: Path at which the file to which the container's termination message will be written is mounted into the container's filesystem. Message written is intended to be brief final status, such as an assertion failure message. Will be truncated by the node if greater than 4096 bytes. The total message length across all containers will be limited to 12kb. Defaults to /dev/termination-log. Cannot be updated."
											type:        "string"
										}
										terminationMessagePolicy: {
											description: "Indicate how the termination message should be populated. File will use the contents of terminationMessagePath to populate the container status message on both success and failure. FallbackToLogsOnError will use the last chunk of container log output if the termination message file is empty and the container exited with an error. The log output is limited to 2048 bytes or 80 lines, whichever is smaller. Defaults to File. Cannot be updated."
											type:        "string"
										}
										tty: {
											description: "Whether this container should allocate a TTY for itself, also requires 'stdin' to be true. Default is false."
											type:        "boolean"
										}
										volumeDevices: {
											description: "volumeDevices is the list of block devices to be used by the container."
											items: {
												description: "volumeDevice describes a mapping of a raw block device within a container."
												properties: {
													devicePath: {
														description: "devicePath is the path inside of the container that the device will be mapped to."
														type:        "string"
													}
													name: {
														description: "name must match the name of a persistentVolumeClaim in the pod"
														type:        "string"
													}
												}
												required: [
													"devicePath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										volumeMounts: {
											description: "Pod volumes to mount into the container's filesystem. Cannot be updated."
											items: {
												description: "VolumeMount describes a mounting of a Volume within a container."
												properties: {
													mountPath: {
														description: "Path within the container at which the volume should be mounted.  Must not contain ':'."
														type:        "string"
													}
													mountPropagation: {
														description: "mountPropagation determines how mounts are propagated from the host to container and the other way around. When not set, MountPropagationNone is used. This field is beta in 1.10."
														type:        "string"
													}
													name: {
														description: "This must match the Name of a Volume."
														type:        "string"
													}
													readOnly: {
														description: "Mounted read-only if true, read-write otherwise (false or unspecified). Defaults to false."
														type:        "boolean"
													}
													subPath: {
														description: "Path within the volume from which the container's volume should be mounted. Defaults to \"\" (volume's root)."
														type:        "string"
													}
													subPathExpr: {
														description: "Expanded path within the volume from which the container's volume should be mounted. Behaves similarly to SubPath but environment variable references $(VAR_NAME) are expanded using the container's environment. Defaults to \"\" (volume's root). SubPathExpr and SubPath are mutually exclusive."
														type:        "string"
													}
												}
												required: [
													"mountPath",
													"name",
												]
												type: "object"
											}
											type: "array"
										}
										workingDir: {
											description: "Container's working directory. If not specified, the container runtime's default will be used, which might be configured in the container image. Cannot be updated."
											type:        "string"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
							labels: {
								additionalProperties: type: "string"
								description: "Labels configure the external label pairs to ThanosRuler. If not provided, default replica label `thanos_ruler_replica` will be added as a label and be dropped in alerts."
								type:        "object"
							}
							listenLocal: {
								description: "ListenLocal makes the Thanos ruler listen on loopback, so that it does not bind against the Pod IP."
								type:        "boolean"
							}
							logFormat: {
								description: "Log format for ThanosRuler to be configured with."
								type:        "string"
							}
							logLevel: {
								description: "Log level for ThanosRuler to be configured with."
								type:        "string"
							}
							nodeSelector: {
								additionalProperties: type: "string"
								description: "Define which Nodes the Pods are scheduled on."
								type:        "object"
							}
							objectStorageConfig: {
								description: "ObjectStorageConfig configures object storage in Thanos. Alternative to ObjectStorageConfigFile, and lower order priority."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							objectStorageConfigFile: {
								description: "ObjectStorageConfigFile specifies the path of the object storage configuration file. When used alongside with ObjectStorageConfig, ObjectStorageConfigFile takes precedence."
								type:        "string"
							}
							paused: {
								description: "When a ThanosRuler deployment is paused, no actions except for deletion will be performed on the underlying objects."
								type:        "boolean"
							}
							podMetadata: {
								description: "PodMetadata contains Labels and Annotations gets propagated to the thanos ruler pods."
								properties: {
									annotations: {
										additionalProperties: type: "string"
										description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
										type:        "object"
									}
									labels: {
										additionalProperties: type: "string"
										description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
										type:        "object"
									}
									name: {
										description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
										type:        "string"
									}
								}
								type: "object"
							}
							portName: {
								description: "Port name used for the pods and governing service. This defaults to web"
								type:        "string"
							}
							priorityClassName: {
								description: "Priority class assigned to the Pods"
								type:        "string"
							}
							prometheusRulesExcludedFromEnforce: {
								description: "PrometheusRulesExcludedFromEnforce - list of Prometheus rules to be excluded from enforcing of adding namespace labels. Works only if enforcedNamespaceLabel set to true. Make sure both ruleNamespace and ruleName are set for each pair"
								items: {
									description: "PrometheusRuleExcludeConfig enables users to configure excluded PrometheusRule names and their namespaces to be ignored while enforcing namespace label for alerts and metrics."
									properties: {
										ruleName: {
											description: "RuleNamespace - name of excluded rule"
											type:        "string"
										}
										ruleNamespace: {
											description: "RuleNamespace - namespace of excluded rule"
											type:        "string"
										}
									}
									required: [
										"ruleName",
										"ruleNamespace",
									]
									type: "object"
								}
								type: "array"
							}
							queryConfig: {
								description: "Define configuration for connecting to thanos query instances. If this is defined, the QueryEndpoints field will be ignored. Maps to the `query.config` CLI argument. Only available with thanos v0.11.0 and higher."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							queryEndpoints: {
								description: "QueryEndpoints defines Thanos querier endpoints from which to query metrics. Maps to the --query flag of thanos ruler."
								items: type: "string"
								type: "array"
							}
							replicas: {
								description: "Number of thanos ruler instances to deploy."
								format:      "int32"
								type:        "integer"
							}
							resources: {
								description: "Resources defines the resource requirements for single Pods. If not provided, no requests/limits will be set"
								properties: {
									limits: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
									requests: {
										additionalProperties: {
											anyOf: [{
												type: "integer"
											}, {
												type: "string"
											}]
											pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
											"x-kubernetes-int-or-string": true
										}
										description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
										type:        "object"
									}
								}
								type: "object"
							}
							retention: {
								description: "Time duration ThanosRuler shall retain data for. Default is '24h', and must match the regular expression `[0-9]+(ms|s|m|h|d|w|y)` (milliseconds seconds minutes hours days weeks years)."
								type:        "string"
							}
							routePrefix: {
								description: "The route prefix ThanosRuler registers HTTP handlers for. This allows thanos UI to be served on a sub-path."
								type:        "string"
							}
							ruleNamespaceSelector: {
								description: "Namespaces to be selected for Rules discovery. If unspecified, only the same namespace as the ThanosRuler object is in is used."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							ruleSelector: {
								description: "A label selector to select which PrometheusRules to mount for alerting and recording."
								properties: {
									matchExpressions: {
										description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
										items: {
											description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
											properties: {
												key: {
													description: "key is the label key that the selector applies to."
													type:        "string"
												}
												operator: {
													description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
													type:        "string"
												}
												values: {
													description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
													items: type: "string"
													type: "array"
												}
											}
											required: [
												"key",
												"operator",
											]
											type: "object"
										}
										type: "array"
									}
									matchLabels: {
										additionalProperties: type: "string"
										description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
										type:        "object"
									}
								}
								type: "object"
							}
							securityContext: {
								description: "SecurityContext holds pod-level security attributes and common container settings. This defaults to the default PodSecurityContext."
								properties: {
									fsGroup: {
										description: """
		A special supplemental group that applies to all containers in a pod. Some volume types allow the Kubelet to change the ownership of that volume to be owned by the pod:
		 1. The owning GID will be the FSGroup 2. The setgid bit is set (new files created in the volume will be owned by FSGroup) 3. The permission bits are OR'd with rw-rw----
		 If unset, the Kubelet will not modify the ownership and permissions of any volume.
		"""
										format: "int64"
										type:   "integer"
									}
									fsGroupChangePolicy: {
										description: "fsGroupChangePolicy defines behavior of changing ownership and permission of the volume before being exposed inside Pod. This field will only apply to volume types which support fsGroup based ownership(and permissions). It will have no effect on ephemeral volume types such as: secret, configmaps and emptydir. Valid values are \"OnRootMismatch\" and \"Always\". If not specified defaults to \"Always\"."
										type:        "string"
									}
									runAsGroup: {
										description: "The GID to run the entrypoint of the container process. Uses runtime default if unset. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									runAsNonRoot: {
										description: "Indicates that the container must run as a non-root user. If true, the Kubelet will validate the image at runtime to ensure that it does not run as UID 0 (root) and fail to start the container if it does. If unset or false, no such validation will be performed. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										type:        "boolean"
									}
									runAsUser: {
										description: "The UID to run the entrypoint of the container process. Defaults to user specified in image metadata if unspecified. May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										format:      "int64"
										type:        "integer"
									}
									seLinuxOptions: {
										description: "The SELinux context to be applied to all containers. If unspecified, the container runtime will allocate a random SELinux context for each container.  May also be set in SecurityContext.  If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence for that container."
										properties: {
											level: {
												description: "Level is SELinux level label that applies to the container."
												type:        "string"
											}
											role: {
												description: "Role is a SELinux role label that applies to the container."
												type:        "string"
											}
											type: {
												description: "Type is a SELinux type label that applies to the container."
												type:        "string"
											}
											user: {
												description: "User is a SELinux user label that applies to the container."
												type:        "string"
											}
										}
										type: "object"
									}
									supplementalGroups: {
										description: "A list of groups applied to the first process run in each container, in addition to the container's primary GID.  If unspecified, no groups will be added to any container."
										items: {
											format: "int64"
											type:   "integer"
										}
										type: "array"
									}
									sysctls: {
										description: "Sysctls hold a list of namespaced sysctls used for the pod. Pods with unsupported sysctls (by the container runtime) might fail to launch."
										items: {
											description: "Sysctl defines a kernel parameter to be set"
											properties: {
												name: {
													description: "Name of a property to set"
													type:        "string"
												}
												value: {
													description: "Value of a property to set"
													type:        "string"
												}
											}
											required: [
												"name",
												"value",
											]
											type: "object"
										}
										type: "array"
									}
									windowsOptions: {
										description: "The Windows specific settings applied to all containers. If unspecified, the options within a container's SecurityContext will be used. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
										properties: {
											gmsaCredentialSpec: {
												description: "GMSACredentialSpec is where the GMSA admission webhook (https://github.com/kubernetes-sigs/windows-gmsa) inlines the contents of the GMSA credential spec named by the GMSACredentialSpecName field."
												type:        "string"
											}
											gmsaCredentialSpecName: {
												description: "GMSACredentialSpecName is the name of the GMSA credential spec to use."
												type:        "string"
											}
											runAsUserName: {
												description: "The UserName in Windows to run the entrypoint of the container process. Defaults to the user specified in image metadata if unspecified. May also be set in PodSecurityContext. If set in both SecurityContext and PodSecurityContext, the value specified in SecurityContext takes precedence."
												type:        "string"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							serviceAccountName: {
								description: "ServiceAccountName is the name of the ServiceAccount to use to run the Thanos Ruler Pods."
								type:        "string"
							}
							storage: {
								description: "Storage spec to specify how storage shall be used."
								properties: {
									disableMountSubPath: {
										description: "Deprecated: subPath usage will be disabled by default in a future release, this option will become unnecessary. DisableMountSubPath allows to remove any subPath usage in volume mounts."
										type:        "boolean"
									}
									emptyDir: {
										description: "EmptyDirVolumeSource to be used by the Prometheus StatefulSets. If specified, used in place of any volumeClaimTemplate. More info: https://kubernetes.io/docs/concepts/storage/volumes/#emptydir"
										properties: {
											medium: {
												description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
												type:        "string"
											}
											sizeLimit: {
												anyOf: [{
													type: "integer"
												}, {
													type: "string"
												}]
												description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
												pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
												"x-kubernetes-int-or-string": true
											}
										}
										type: "object"
									}
									volumeClaimTemplate: {
										description: "A PVC spec to be used by the Prometheus StatefulSets."
										properties: {
											apiVersion: {
												description: "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources"
												type:        "string"
											}
											kind: {
												description: "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds"
												type:        "string"
											}
											metadata: {
												description: "EmbeddedMetadata contains metadata relevant to an EmbeddedResource."
												properties: {
													annotations: {
														additionalProperties: type: "string"
														description: "Annotations is an unstructured key value map stored with a resource that may be set by external tools to store and retrieve arbitrary metadata. They are not queryable and should be preserved when modifying objects. More info: http://kubernetes.io/docs/user-guide/annotations"
														type:        "object"
													}
													labels: {
														additionalProperties: type: "string"
														description: "Map of string keys and values that can be used to organize and categorize (scope and select) objects. May match selectors of replication controllers and services. More info: http://kubernetes.io/docs/user-guide/labels"
														type:        "object"
													}
													name: {
														description: "Name must be unique within a namespace. Is required when creating resources, although some resources may allow a client to request the generation of an appropriate name automatically. Name is primarily intended for creation idempotence and configuration definition. Cannot be updated. More info: http://kubernetes.io/docs/user-guide/identifiers#names"
														type:        "string"
													}
												}
												type: "object"
											}
											spec: {
												description: "Spec defines the desired characteristics of a volume requested by a pod author. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the desired access modes the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													dataSource: {
														description: "This field can be used to specify either: * An existing VolumeSnapshot object (snapshot.storage.k8s.io/VolumeSnapshot - Beta) * An existing PVC (PersistentVolumeClaim) * An existing custom resource/object that implements data population (Alpha) In order to use VolumeSnapshot object types, the appropriate feature gate must be enabled (VolumeSnapshotDataSource or AnyVolumeDataSource) If the provisioner or an external controller can support the specified data source, it will create a new volume based on the contents of the specified data source. If the specified data source is not supported, the volume will not be created and the failure will be reported as an event. In the future, we plan to support more data source types and the behavior of the provisioner may change."
														properties: {
															apiGroup: {
																description: "APIGroup is the group for the resource being referenced. If APIGroup is not specified, the specified Kind must be in the core API group. For any other third-party types, APIGroup is required."
																type:        "string"
															}
															kind: {
																description: "Kind is the type of resource being referenced"
																type:        "string"
															}
															name: {
																description: "Name is the name of resource being referenced"
																type:        "string"
															}
														}
														required: [
															"kind",
															"name",
														]
														type: "object"
													}
													resources: {
														description: "Resources represents the minimum resources the volume should have. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#resources"
														properties: {
															limits: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Limits describes the maximum amount of compute resources allowed. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
															requests: {
																additionalProperties: {
																	anyOf: [{
																		type: "integer"
																	}, {
																		type: "string"
																	}]
																	pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																	"x-kubernetes-int-or-string": true
																}
																description: "Requests describes the minimum amount of compute resources required. If Requests is omitted for a container, it defaults to Limits if that is explicitly specified, otherwise to an implementation-defined value. More info: https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/"
																type:        "object"
															}
														}
														type: "object"
													}
													selector: {
														description: "A label query over volumes to consider for binding."
														properties: {
															matchExpressions: {
																description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
																items: {
																	description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
																	properties: {
																		key: {
																			description: "key is the label key that the selector applies to."
																			type:        "string"
																		}
																		operator: {
																			description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																			type:        "string"
																		}
																		values: {
																			description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																			items: type: "string"
																			type: "array"
																		}
																	}
																	required: [
																		"key",
																		"operator",
																	]
																	type: "object"
																}
																type: "array"
															}
															matchLabels: {
																additionalProperties: type: "string"
																description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
																type:        "object"
															}
														}
														type: "object"
													}
													storageClassName: {
														description: "Name of the StorageClass required by the claim. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#class-1"
														type:        "string"
													}
													volumeMode: {
														description: "volumeMode defines what type of volume is required by the claim. Value of Filesystem is implied when not included in claim spec."
														type:        "string"
													}
													volumeName: {
														description: "VolumeName is the binding reference to the PersistentVolume backing this claim."
														type:        "string"
													}
												}
												type: "object"
											}
											status: {
												description: "Status represents the current information/status of a persistent volume claim. Read-only. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
												properties: {
													accessModes: {
														description: "AccessModes contains the actual access modes the volume backing the PVC has. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#access-modes-1"
														items: type: "string"
														type: "array"
													}
													capacity: {
														additionalProperties: {
															anyOf: [{
																type: "integer"
															}, {
																type: "string"
															}]
															pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
															"x-kubernetes-int-or-string": true
														}
														description: "Represents the actual resources of the underlying volume."
														type:        "object"
													}
													conditions: {
														description: "Current Condition of persistent volume claim. If underlying persistent volume is being resized then the Condition will be set to 'ResizeStarted'."
														items: {
															description: "PersistentVolumeClaimCondition contails details about state of pvc"
															properties: {
																lastProbeTime: {
																	description: "Last time we probed the condition."
																	format:      "date-time"
																	type:        "string"
																}
																lastTransitionTime: {
																	description: "Last time the condition transitioned from one status to another."
																	format:      "date-time"
																	type:        "string"
																}
																message: {
																	description: "Human-readable message indicating details about last transition."
																	type:        "string"
																}
																reason: {
																	description: "Unique, this should be a short, machine understandable string that gives the reason for condition's last transition. If it reports \"ResizeStarted\" that means the underlying persistent volume is being resized."
																	type:        "string"
																}
																status: type: "string"
																type: {
																	description: "PersistentVolumeClaimConditionType is a valid value of PersistentVolumeClaimCondition.Type"
																	type:        "string"
																}
															}
															required: [
																"status",
																"type",
															]
															type: "object"
														}
														type: "array"
													}
													phase: {
														description: "Phase represents the current phase of PersistentVolumeClaim."
														type:        "string"
													}
												}
												type: "object"
											}
										}
										type: "object"
									}
								}
								type: "object"
							}
							tolerations: {
								description: "If specified, the pod's tolerations."
								items: {
									description: "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>."
									properties: {
										effect: {
											description: "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute."
											type:        "string"
										}
										key: {
											description: "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys."
											type:        "string"
										}
										operator: {
											description: "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category."
											type:        "string"
										}
										tolerationSeconds: {
											description: "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system."
											format:      "int64"
											type:        "integer"
										}
										value: {
											description: "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string."
											type:        "string"
										}
									}
									type: "object"
								}
								type: "array"
							}
							topologySpreadConstraints: {
								description: "If specified, the pod's topology spread constraints."
								items: {
									description: "TopologySpreadConstraint specifies how to spread matching pods among the given topology."
									properties: {
										labelSelector: {
											description: "LabelSelector is used to find matching pods. Pods that match this label selector are counted to determine the number of pods in their corresponding topology domain."
											properties: {
												matchExpressions: {
													description: "matchExpressions is a list of label selector requirements. The requirements are ANDed."
													items: {
														description: "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values."
														properties: {
															key: {
																description: "key is the label key that the selector applies to."
																type:        "string"
															}
															operator: {
																description: "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist."
																type:        "string"
															}
															values: {
																description: "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch."
																items: type: "string"
																type: "array"
															}
														}
														required: [
															"key",
															"operator",
														]
														type: "object"
													}
													type: "array"
												}
												matchLabels: {
													additionalProperties: type: "string"
													description: "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed."
													type:        "object"
												}
											}
											type: "object"
										}
										maxSkew: {
											description: "MaxSkew describes the degree to which pods may be unevenly distributed. It's the maximum permitted difference between the number of matching pods in any two topology domains of a given topology type. For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 1/1/0: | zone1 | zone2 | zone3 | |   P   |   P   |       | - if MaxSkew is 1, incoming pod can only be scheduled to zone3 to become 1/1/1; scheduling it onto zone1(zone2) would make the ActualSkew(2-0) on zone1(zone2) violate MaxSkew(1). - if MaxSkew is 2, incoming pod can be scheduled onto any zone. It's a required field. Default value is 1 and 0 is not allowed."
											format:      "int32"
											type:        "integer"
										}
										topologyKey: {
											description: "TopologyKey is the key of node labels. Nodes that have a label with this key and identical values are considered to be in the same topology. We consider each <key, value> as a \"bucket\", and try to put balanced number of pods into each bucket. It's a required field."
											type:        "string"
										}
										whenUnsatisfiable: {
											description: "WhenUnsatisfiable indicates how to deal with a pod if it doesn't satisfy the spread constraint. - DoNotSchedule (default) tells the scheduler not to schedule it - ScheduleAnyway tells the scheduler to still schedule it It's considered as \"Unsatisfiable\" if and only if placing incoming pod on any topology violates \"MaxSkew\". For example, in a 3-zone cluster, MaxSkew is set to 1, and pods with the same labelSelector spread as 3/1/1: | zone1 | zone2 | zone3 | | P P P |   P   |   P   | If WhenUnsatisfiable is set to DoNotSchedule, incoming pod can only be scheduled to zone2(zone3) to become 3/2/1(3/1/2) as ActualSkew(2-1) on zone2(zone3) satisfies MaxSkew(1). In other words, the cluster can still be imbalanced, but scheduler won't make it *more* imbalanced. It's a required field."
											type:        "string"
										}
									}
									required: [
										"maxSkew",
										"topologyKey",
										"whenUnsatisfiable",
									]
									type: "object"
								}
								type: "array"
							}
							tracingConfig: {
								description: "TracingConfig configures tracing in Thanos. This is an experimental feature, it may change in any upcoming release in a breaking way."
								properties: {
									key: {
										description: "The key of the secret to select from.  Must be a valid secret key."
										type:        "string"
									}
									name: {
										description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
										type:        "string"
									}
									optional: {
										description: "Specify whether the Secret or its key must be defined"
										type:        "boolean"
									}
								}
								required: ["key"]
								type: "object"
							}
							volumes: {
								description: "Volumes allows configuration of additional volumes on the output StatefulSet definition. Volumes specified will be appended to other volumes that are generated as a result of StorageSpec objects."
								items: {
									description: "Volume represents a named volume in a pod that may be accessed by any container in the pod."
									properties: {
										awsElasticBlockStore: {
											description: "AWSElasticBlockStore represents an AWS Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty)."
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Specify \"true\" to force and set the ReadOnly property in VolumeMounts to \"true\". If omitted, the default is \"false\". More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "boolean"
												}
												volumeID: {
													description: "Unique ID of the persistent disk resource in AWS (Amazon EBS volume). More info: https://kubernetes.io/docs/concepts/storage/volumes#awselasticblockstore"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										azureDisk: {
											description: "AzureDisk represents an Azure Data Disk mount on the host and bind mount to the pod."
											properties: {
												cachingMode: {
													description: "Host Caching mode: None, Read Only, Read Write."
													type:        "string"
												}
												diskName: {
													description: "The Name of the data disk in the blob storage"
													type:        "string"
												}
												diskURI: {
													description: "The URI the data disk in the blob storage"
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												kind: {
													description: "Expected values Shared: multiple blob disks per storage account  Dedicated: single blob disk per storage account  Managed: azure managed data disk (only in managed availability set). defaults to shared"
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
											}
											required: [
												"diskName",
												"diskURI",
											]
											type: "object"
										}
										azureFile: {
											description: "AzureFile represents an Azure File Service mount on the host and bind mount to the pod."
											properties: {
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretName: {
													description: "the name of secret that contains Azure Storage Account Name and Key"
													type:        "string"
												}
												shareName: {
													description: "Share Name"
													type:        "string"
												}
											}
											required: [
												"secretName",
												"shareName",
											]
											type: "object"
										}
										cephfs: {
											description: "CephFS represents a Ceph FS mount on the host that shares a pod's lifetime"
											properties: {
												monitors: {
													description: "Required: Monitors is a collection of Ceph monitors More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												path: {
													description: "Optional: Used as the mounted root, rather than the full Ceph tree, default is /"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretFile: {
													description: "Optional: SecretFile is the path to key ring for User, default is /etc/ceph/user.secret More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the authentication secret for User, default is empty. More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "Optional: User is the rados user name, default is admin More info: https://examples.k8s.io/volumes/cephfs/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: ["monitors"]
											type: "object"
										}
										cinder: {
											description: "Cinder represents a cinder volume attached and mounted on kubelets host machine. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: points to a secret object containing parameters used to connect to OpenStack."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeID: {
													description: "volume id used to identify the volume in cinder. More info: https://examples.k8s.io/mysql-cinder-pd/README.md"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										configMap: {
											description: "ConfigMap represents a configMap that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												name: {
													description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
													type:        "string"
												}
												optional: {
													description: "Specify whether the ConfigMap or its keys must be defined"
													type:        "boolean"
												}
											}
											type: "object"
										}
										csi: {
											description: "CSI (Container Storage Interface) represents storage that is handled by an external CSI driver (Alpha feature)."
											properties: {
												driver: {
													description: "Driver is the name of the CSI driver that handles this volume. Consult with your admin for the correct name as registered in the cluster."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Ex. \"ext4\", \"xfs\", \"ntfs\". If not provided, the empty value is passed to the associated CSI driver which will determine the default filesystem to apply."
													type:        "string"
												}
												nodePublishSecretRef: {
													description: "NodePublishSecretRef is a reference to the secret object containing sensitive information to pass to the CSI driver to complete the CSI NodePublishVolume and NodeUnpublishVolume calls. This field is optional, and  may be empty if no secret is required. If the secret object contains more than one secret, all secret references are passed."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												readOnly: {
													description: "Specifies a read-only configuration for the volume. Defaults to false (read/write)."
													type:        "boolean"
												}
												volumeAttributes: {
													additionalProperties: type: "string"
													description: "VolumeAttributes stores driver-specific properties that are passed to the CSI driver. Consult your driver's documentation for supported values."
													type:        "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										downwardAPI: {
											description: "DownwardAPI represents downward API about the pod that should populate this volume"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "Items is a list of downward API volume file"
													items: {
														description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
														properties: {
															fieldRef: {
																description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																properties: {
																	apiVersion: {
																		description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																		type:        "string"
																	}
																	fieldPath: {
																		description: "Path of the field to select in the specified API version."
																		type:        "string"
																	}
																}
																required: ["fieldPath"]
																type: "object"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																type:        "string"
															}
															resourceFieldRef: {
																description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																properties: {
																	containerName: {
																		description: "Container name: required for volumes, optional for env vars"
																		type:        "string"
																	}
																	divisor: {
																		anyOf: [{
																			type: "integer"
																		}, {
																			type: "string"
																		}]
																		description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																		pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																		"x-kubernetes-int-or-string": true
																	}
																	resource: {
																		description: "Required: resource to select"
																		type:        "string"
																	}
																}
																required: ["resource"]
																type: "object"
															}
														}
														required: ["path"]
														type: "object"
													}
													type: "array"
												}
											}
											type: "object"
										}
										emptyDir: {
											description: "EmptyDir represents a temporary directory that shares a pod's lifetime. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
											properties: {
												medium: {
													description: "What type of storage medium should back this directory. The default is \"\" which means to use the node's default medium. Must be an empty string (default) or Memory. More info: https://kubernetes.io/docs/concepts/storage/volumes#emptydir"
													type:        "string"
												}
												sizeLimit: {
													anyOf: [{
														type: "integer"
													}, {
														type: "string"
													}]
													description:                  "Total amount of local storage required for this EmptyDir volume. The size limit is also applicable for memory medium. The maximum usage on memory medium EmptyDir would be the minimum value between the SizeLimit specified here and the sum of memory limits of all containers in a pod. The default is nil which means that the limit is undefined. More info: http://kubernetes.io/docs/user-guide/volumes#emptydir"
													pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
													"x-kubernetes-int-or-string": true
												}
											}
											type: "object"
										}
										fc: {
											description: "FC represents a Fibre Channel resource that is attached to a kubelet's host machine and then exposed to the pod."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												lun: {
													description: "Optional: FC target lun number"
													format:      "int32"
													type:        "integer"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												targetWWNs: {
													description: "Optional: FC target worldwide names (WWNs)"
													items: type: "string"
													type: "array"
												}
												wwids: {
													description: "Optional: FC volume world wide identifiers (wwids) Either wwids or combination of targetWWNs and lun must be set, but not both simultaneously."
													items: type: "string"
													type: "array"
												}
											}
											type: "object"
										}
										flexVolume: {
											description: "FlexVolume represents a generic volume resource that is provisioned/attached using an exec based plugin."
											properties: {
												driver: {
													description: "Driver is the name of the driver to use for this volume."
													type:        "string"
												}
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". The default filesystem depends on FlexVolume script."
													type:        "string"
												}
												options: {
													additionalProperties: type: "string"
													description: "Optional: Extra command options if any."
													type:        "object"
												}
												readOnly: {
													description: "Optional: Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "Optional: SecretRef is reference to the secret object containing sensitive information to pass to the plugin scripts. This may be empty if no secret object is specified. If the secret object contains more than one secret, all secrets are passed to the plugin scripts."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
											}
											required: ["driver"]
											type: "object"
										}
										flocker: {
											description: "Flocker represents a Flocker volume attached to a kubelet's host machine. This depends on the Flocker control service being running"
											properties: {
												datasetName: {
													description: "Name of the dataset stored as metadata -> name on the dataset for Flocker should be considered as deprecated"
													type:        "string"
												}
												datasetUUID: {
													description: "UUID of the dataset. This is unique identifier of a Flocker dataset"
													type:        "string"
												}
											}
											type: "object"
										}
										gcePersistentDisk: {
											description: "GCEPersistentDisk represents a GCE Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												partition: {
													description: "The partition in the volume that you want to mount. If omitted, the default is to mount by volume name. Examples: For volume /dev/sda1, you specify the partition as \"1\". Similarly, the volume partition for /dev/sda is \"0\" (or you can leave the property empty). More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													format:      "int32"
													type:        "integer"
												}
												pdName: {
													description: "Unique name of the PD resource in GCE. Used to identify the disk in GCE. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#gcepersistentdisk"
													type:        "boolean"
												}
											}
											required: ["pdName"]
											type: "object"
										}
										gitRepo: {
											description: "GitRepo represents a git repository at a particular revision. DEPRECATED: GitRepo is deprecated. To provision a container with a git repo, mount an EmptyDir into an InitContainer that clones the repo using git, then mount the EmptyDir into the Pod's container."
											properties: {
												directory: {
													description: "Target directory name. Must not contain or start with '..'.  If '.' is supplied, the volume directory will be the git repository.  Otherwise, if specified, the volume will contain the git repository in the subdirectory with the given name."
													type:        "string"
												}
												repository: {
													description: "Repository URL"
													type:        "string"
												}
												revision: {
													description: "Commit hash for the specified revision."
													type:        "string"
												}
											}
											required: ["repository"]
											type: "object"
										}
										glusterfs: {
											description: "Glusterfs represents a Glusterfs mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/glusterfs/README.md"
											properties: {
												endpoints: {
													description: "EndpointsName is the endpoint name that details Glusterfs topology. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												path: {
													description: "Path is the Glusterfs volume path. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Glusterfs volume to be mounted with read-only permissions. Defaults to false. More info: https://examples.k8s.io/volumes/glusterfs/README.md#create-a-pod"
													type:        "boolean"
												}
											}
											required: [
												"endpoints",
												"path",
											]
											type: "object"
										}
										hostPath: {
											description: "HostPath represents a pre-existing file or directory on the host machine that is directly exposed to the container. This is generally used for system agents or other privileged things that are allowed to see the host machine. Most containers will NOT need this. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath --- TODO(jonesdl) We need to restrict who can use host directory mounts and who can/can not mount host directories as read/write."
											properties: {
												path: {
													description: "Path of the directory on the host. If the path is a symlink, it will follow the link to the real path. More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
												type: {
													description: "Type for HostPath Volume Defaults to \"\" More info: https://kubernetes.io/docs/concepts/storage/volumes#hostpath"
													type:        "string"
												}
											}
											required: ["path"]
											type: "object"
										}
										iscsi: {
											description: "ISCSI represents an ISCSI Disk resource that is attached to a kubelet's host machine and then exposed to the pod. More info: https://examples.k8s.io/volumes/iscsi/README.md"
											properties: {
												chapAuthDiscovery: {
													description: "whether support iSCSI Discovery CHAP authentication"
													type:        "boolean"
												}
												chapAuthSession: {
													description: "whether support iSCSI Session CHAP authentication"
													type:        "boolean"
												}
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#iscsi TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												initiatorName: {
													description: "Custom iSCSI Initiator Name. If initiatorName is specified with iscsiInterface simultaneously, new iSCSI interface <target portal>:<volume name> will be created for the connection."
													type:        "string"
												}
												iqn: {
													description: "Target iSCSI Qualified Name."
													type:        "string"
												}
												iscsiInterface: {
													description: "iSCSI Interface Name that uses an iSCSI transport. Defaults to 'default' (tcp)."
													type:        "string"
												}
												lun: {
													description: "iSCSI Target Lun number."
													format:      "int32"
													type:        "integer"
												}
												portals: {
													description: "iSCSI Target Portal List. The portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													items: type: "string"
													type: "array"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false."
													type:        "boolean"
												}
												secretRef: {
													description: "CHAP Secret for iSCSI target and initiator authentication"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												targetPortal: {
													description: "iSCSI Target Portal. The Portal is either an IP or ip_addr:port if the port is other than default (typically TCP ports 860 and 3260)."
													type:        "string"
												}
											}
											required: [
												"iqn",
												"lun",
												"targetPortal",
											]
											type: "object"
										}
										name: {
											description: "Volume's name. Must be a DNS_LABEL and unique within the pod. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names"
											type:        "string"
										}
										nfs: {
											description: "NFS represents an NFS mount on the host that shares a pod's lifetime More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
											properties: {
												path: {
													description: "Path that is exported by the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the NFS export to be mounted with read-only permissions. Defaults to false. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "boolean"
												}
												server: {
													description: "Server is the hostname or IP address of the NFS server. More info: https://kubernetes.io/docs/concepts/storage/volumes#nfs"
													type:        "string"
												}
											}
											required: [
												"path",
												"server",
											]
											type: "object"
										}
										persistentVolumeClaim: {
											description: "PersistentVolumeClaimVolumeSource represents a reference to a PersistentVolumeClaim in the same namespace. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
											properties: {
												claimName: {
													description: "ClaimName is the name of a PersistentVolumeClaim in the same namespace as the pod using this volume. More info: https://kubernetes.io/docs/concepts/storage/persistent-volumes#persistentvolumeclaims"
													type:        "string"
												}
												readOnly: {
													description: "Will force the ReadOnly setting in VolumeMounts. Default false."
													type:        "boolean"
												}
											}
											required: ["claimName"]
											type: "object"
										}
										photonPersistentDisk: {
											description: "PhotonPersistentDisk represents a PhotonController persistent disk attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												pdID: {
													description: "ID that identifies Photon Controller persistent disk"
													type:        "string"
												}
											}
											required: ["pdID"]
											type: "object"
										}
										portworxVolume: {
											description: "PortworxVolume represents a portworx volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "FSType represents the filesystem type to mount Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												volumeID: {
													description: "VolumeID uniquely identifies a Portworx volume"
													type:        "string"
												}
											}
											required: ["volumeID"]
											type: "object"
										}
										projected: {
											description: "Items for all in one resources secrets, configmaps, and downward API"
											properties: {
												defaultMode: {
													description: "Mode bits to use on created files by default. Must be a value between 0 and 0777. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												sources: {
													description: "list of volume projections"
													items: {
														description: "Projection that may be projected along with other supported volume types"
														properties: {
															configMap: {
																description: "information about the configMap data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced ConfigMap will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the ConfigMap, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the ConfigMap or its keys must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															downwardAPI: {
																description: "information about the downwardAPI data to project"
																properties: items: {
																	description: "Items is a list of DownwardAPIVolume file"
																	items: {
																		description: "DownwardAPIVolumeFile represents information to create the file containing the pod field"
																		properties: {
																			fieldRef: {
																				description: "Required: Selects a field of the pod: only annotations, labels, name and namespace are supported."
																				properties: {
																					apiVersion: {
																						description: "Version of the schema the FieldPath is written in terms of, defaults to \"v1\"."
																						type:        "string"
																					}
																					fieldPath: {
																						description: "Path of the field to select in the specified API version."
																						type:        "string"
																					}
																				}
																				required: ["fieldPath"]
																				type: "object"
																			}
																			mode: {
																				description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																				format:      "int32"
																				type:        "integer"
																			}
																			path: {
																				description: "Required: Path is  the relative path name of the file to be created. Must not be absolute or contain the '..' path. Must be utf-8 encoded. The first item of the relative path must not start with '..'"
																				type:        "string"
																			}
																			resourceFieldRef: {
																				description: "Selects a resource of the container: only resources limits and requests (limits.cpu, limits.memory, requests.cpu and requests.memory) are currently supported."
																				properties: {
																					containerName: {
																						description: "Container name: required for volumes, optional for env vars"
																						type:        "string"
																					}
																					divisor: {
																						anyOf: [{
																							type: "integer"
																						}, {
																							type: "string"
																						}]
																						description:                  "Specifies the output format of the exposed resources, defaults to \"1\""
																						pattern:                      "^(\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))(([KMGTPE]i)|[numkMGTPE]|([eE](\\+|-)?(([0-9]+(\\.[0-9]*)?)|(\\.[0-9]+))))?$"
																						"x-kubernetes-int-or-string": true
																					}
																					resource: {
																						description: "Required: resource to select"
																						type:        "string"
																					}
																				}
																				required: ["resource"]
																				type: "object"
																			}
																		}
																		required: ["path"]
																		type: "object"
																	}
																	type: "array"
																}
																type: "object"
															}
															secret: {
																description: "information about the secret data to project"
																properties: {
																	items: {
																		description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
																		items: {
																			description: "Maps a string key to a path within a volume."
																			properties: {
																				key: {
																					description: "The key to project."
																					type:        "string"
																				}
																				mode: {
																					description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																					format:      "int32"
																					type:        "integer"
																				}
																				path: {
																					description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																					type:        "string"
																				}
																			}
																			required: [
																				"key",
																				"path",
																			]
																			type: "object"
																		}
																		type: "array"
																	}
																	name: {
																		description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
																		type:        "string"
																	}
																	optional: {
																		description: "Specify whether the Secret or its key must be defined"
																		type:        "boolean"
																	}
																}
																type: "object"
															}
															serviceAccountToken: {
																description: "information about the serviceAccountToken data to project"
																properties: {
																	audience: {
																		description: "Audience is the intended audience of the token. A recipient of a token must identify itself with an identifier specified in the audience of the token, and otherwise should reject the token. The audience defaults to the identifier of the apiserver."
																		type:        "string"
																	}
																	expirationSeconds: {
																		description: "ExpirationSeconds is the requested duration of validity of the service account token. As the token approaches expiration, the kubelet volume plugin will proactively rotate the service account token. The kubelet will start trying to rotate the token if the token is older than 80 percent of its time to live or if the token is older than 24 hours.Defaults to 1 hour and must be at least 10 minutes."
																		format:      "int64"
																		type:        "integer"
																	}
																	path: {
																		description: "Path is the path relative to the mount point of the file to project the token into."
																		type:        "string"
																	}
																}
																required: ["path"]
																type: "object"
															}
														}
														type: "object"
													}
													type: "array"
												}
											}
											required: ["sources"]
											type: "object"
										}
										quobyte: {
											description: "Quobyte represents a Quobyte mount on the host that shares a pod's lifetime"
											properties: {
												group: {
													description: "Group to map volume access to Default is no group"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the Quobyte volume to be mounted with read-only permissions. Defaults to false."
													type:        "boolean"
												}
												registry: {
													description: "Registry represents a single or multiple Quobyte Registry services specified as a string as host:port pair (multiple entries are separated with commas) which acts as the central registry for volumes"
													type:        "string"
												}
												tenant: {
													description: "Tenant owning the given Quobyte volume in the Backend Used with dynamically provisioned Quobyte volumes, value is set by the plugin"
													type:        "string"
												}
												user: {
													description: "User to map volume access to Defaults to serivceaccount user"
													type:        "string"
												}
												volume: {
													description: "Volume is a string that references an already created Quobyte volume by name."
													type:        "string"
												}
											}
											required: [
												"registry",
												"volume",
											]
											type: "object"
										}
										rbd: {
											description: "RBD represents a Rados Block Device mount on the host that shares a pod's lifetime. More info: https://examples.k8s.io/volumes/rbd/README.md"
											properties: {
												fsType: {
													description: "Filesystem type of the volume that you want to mount. Tip: Ensure that the filesystem type is supported by the host operating system. Examples: \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified. More info: https://kubernetes.io/docs/concepts/storage/volumes#rbd TODO: how do we prevent errors in the filesystem from compromising the machine"
													type:        "string"
												}
												image: {
													description: "The rados image name. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												keyring: {
													description: "Keyring is the path to key ring for RBDUser. Default is /etc/ceph/keyring. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												monitors: {
													description: "A collection of Ceph monitors. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													items: type: "string"
													type: "array"
												}
												pool: {
													description: "The rados pool name. Default is rbd. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
												readOnly: {
													description: "ReadOnly here will force the ReadOnly setting in VolumeMounts. Defaults to false. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef is name of the authentication secret for RBDUser. If provided overrides keyring. Default is nil. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												user: {
													description: "The rados user name. Default is admin. More info: https://examples.k8s.io/volumes/rbd/README.md#how-to-use-it"
													type:        "string"
												}
											}
											required: [
												"image",
												"monitors",
											]
											type: "object"
										}
										scaleIO: {
											description: "ScaleIO represents a ScaleIO persistent volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Default is \"xfs\"."
													type:        "string"
												}
												gateway: {
													description: "The host address of the ScaleIO API Gateway."
													type:        "string"
												}
												protectionDomain: {
													description: "The name of the ScaleIO Protection Domain for the configured storage."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef references to the secret for ScaleIO user and other sensitive information. If this is not provided, Login operation will fail."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												sslEnabled: {
													description: "Flag to enable/disable SSL communication with Gateway, default false"
													type:        "boolean"
												}
												storageMode: {
													description: "Indicates whether the storage for a volume should be ThickProvisioned or ThinProvisioned. Default is ThinProvisioned."
													type:        "string"
												}
												storagePool: {
													description: "The ScaleIO Storage Pool associated with the protection domain."
													type:        "string"
												}
												system: {
													description: "The name of the storage system as configured in ScaleIO."
													type:        "string"
												}
												volumeName: {
													description: "The name of a volume already created in the ScaleIO system that is associated with this volume source."
													type:        "string"
												}
											}
											required: [
												"gateway",
												"secretRef",
												"system",
											]
											type: "object"
										}
										secret: {
											description: "Secret represents a secret that should populate this volume. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
											properties: {
												defaultMode: {
													description: "Optional: mode bits to use on created files by default. Must be a value between 0 and 0777. Defaults to 0644. Directories within the path are not affected by this setting. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
													format:      "int32"
													type:        "integer"
												}
												items: {
													description: "If unspecified, each key-value pair in the Data field of the referenced Secret will be projected into the volume as a file whose name is the key and content is the value. If specified, the listed keys will be projected into the specified paths, and unlisted keys will not be present. If a key is specified which is not present in the Secret, the volume setup will error unless it is marked optional. Paths must be relative and may not contain the '..' path or start with '..'."
													items: {
														description: "Maps a string key to a path within a volume."
														properties: {
															key: {
																description: "The key to project."
																type:        "string"
															}
															mode: {
																description: "Optional: mode bits to use on this file, must be a value between 0 and 0777. If not specified, the volume defaultMode will be used. This might be in conflict with other options that affect the file mode, like fsGroup, and the result can be other mode bits set."
																format:      "int32"
																type:        "integer"
															}
															path: {
																description: "The relative path of the file to map the key to. May not be an absolute path. May not contain the path element '..'. May not start with the string '..'."
																type:        "string"
															}
														}
														required: [
															"key",
															"path",
														]
														type: "object"
													}
													type: "array"
												}
												optional: {
													description: "Specify whether the Secret or its keys must be defined"
													type:        "boolean"
												}
												secretName: {
													description: "Name of the secret in the pod's namespace to use. More info: https://kubernetes.io/docs/concepts/storage/volumes#secret"
													type:        "string"
												}
											}
											type: "object"
										}
										storageos: {
											description: "StorageOS represents a StorageOS volume attached and mounted on Kubernetes nodes."
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												readOnly: {
													description: "Defaults to false (read/write). ReadOnly here will force the ReadOnly setting in VolumeMounts."
													type:        "boolean"
												}
												secretRef: {
													description: "SecretRef specifies the secret to use for obtaining the StorageOS API credentials.  If not specified, default values will be attempted."
													properties: name: {
														description: "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?"
														type:        "string"
													}
													type: "object"
												}
												volumeName: {
													description: "VolumeName is the human-readable name of the StorageOS volume.  Volume names are only unique within a namespace."
													type:        "string"
												}
												volumeNamespace: {
													description: "VolumeNamespace specifies the scope of the volume within StorageOS.  If no namespace is specified then the Pod's namespace will be used.  This allows the Kubernetes name scoping to be mirrored within StorageOS for tighter integration. Set VolumeName to any name to override the default behaviour. Set to \"default\" if you are not using namespaces within StorageOS. Namespaces that do not pre-exist within StorageOS will be created."
													type:        "string"
												}
											}
											type: "object"
										}
										vsphereVolume: {
											description: "VsphereVolume represents a vSphere volume attached and mounted on kubelets host machine"
											properties: {
												fsType: {
													description: "Filesystem type to mount. Must be a filesystem type supported by the host operating system. Ex. \"ext4\", \"xfs\", \"ntfs\". Implicitly inferred to be \"ext4\" if unspecified."
													type:        "string"
												}
												storagePolicyID: {
													description: "Storage Policy Based Management (SPBM) profile ID associated with the StoragePolicyName."
													type:        "string"
												}
												storagePolicyName: {
													description: "Storage Policy Based Management (SPBM) profile name."
													type:        "string"
												}
												volumePath: {
													description: "Path that identifies vSphere volume vmdk"
													type:        "string"
												}
											}
											required: ["volumePath"]
											type: "object"
										}
									}
									required: ["name"]
									type: "object"
								}
								type: "array"
							}
						}
						type: "object"
					}
					status: {
						description: "Most recent observed status of the ThanosRuler cluster. Read-only. Not included when requesting from the apiserver, only from the ThanosRuler Operator API itself. More info: https://github.com/kubernetes/community/blob/master/contributors/devel/sig-architecture/api-conventions.md#spec-and-status"
						properties: {
							availableReplicas: {
								description: "Total number of available pods (ready for at least minReadySeconds) targeted by this ThanosRuler deployment."
								format:      "int32"
								type:        "integer"
							}
							paused: {
								description: "Represents whether any actions on the underlying managed objects are being performed. Only delete actions will be performed."
								type:        "boolean"
							}
							replicas: {
								description: "Total number of non-terminated pods targeted by this ThanosRuler deployment (their labels match the selector)."
								format:      "int32"
								type:        "integer"
							}
							unavailableReplicas: {
								description: "Total number of unavailable pods targeted by this ThanosRuler deployment."
								format:      "int32"
								type:        "integer"
							}
							updatedReplicas: {
								description: "Total number of non-terminated pods targeted by this ThanosRuler deployment that have the desired version spec."
								format:      "int32"
								type:        "integer"
							}
						}
						required: [
							"availableReplicas",
							"paused",
							"replicas",
							"unavailableReplicas",
							"updatedReplicas",
						]
						type: "object"
					}
				}
				required: [
					"spec",
				]
				type: "object"
			}
			served:  true
			storage: true
		}]
	}
	status: acceptedNames: {
		kind:   ""
		plural: ""
	}
}]
