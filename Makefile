docker_img := "ssmiller25/civo-cloudshell"
currentepoch := $(shell date +%s)
latestepoch := $(shell docker image ls | grep $(docker_img) | grep -v latest | awk ' { print $$2; } ' | sort -n | tail -n 1)

# For cli directly installed
CIVO_CMD?="civo"
# For Docker
CIVO_TEST_CLUSTER_NAME?=blast-public
CIVO_KUBECONFIG?=kubeconfig.$(CIVO_TEST_CLUSTER_NAME)
CIVO_APPS?=cert-manager Longhorn sealed-secrets prometheus-operator
KUBECTL?=kubectl --kubeconfig=$(CIVO_KUBECONFIG) 


.PHONY: build
build: $(CIVO_KUBECONFIG)

.PHONY: deploy
deploy: $(CIVO_KUBECONFIG) deploy-kustomize

.PHONY: test-keep
test-keep: $(CIVO_KUBECONFIG) test-noclean

.PHONY: deploy-kustomize
deploy-kustomize:
	@echo "Applying manifest"
	@$(KUBECTL) apply -k ./

.PHONY: cluster-clean
cluster-clean:
	@echo "Tearing down test cluster!"
	@$(CIVO_CMD) k3s remove -y $(CIVO_TEST_CLUSTER_NAME) || true
	@rm $(CIVO_KUBECONFIG)

$(CIVO_KUBECONFIG):
	@echo "Creating/retriving $(CIVO_TEST_CLUSTER_NAME)"
	@if ! $(CIVO_CMD) k3s config $(CIVO_TEST_CLUSTER_NAME) > $(CIVO_KUBECONFIG); then \
		rm $(CIVO_KUBECONFIG); \
		$(CIVO_CMD) k3s create $(CIVO_TEST_CLUSTER_NAME) -n 3 --size g2.small -a $(CIVO_APPS) --wait; \
		$(CIVO_CMD) k3s config $(CIVO_TEST_CLUSTER_NAME) > $(CIVO_KUBECONFIG); \
	fi
