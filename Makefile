# Set Shell to bash, otherwise some targets fail with dash/zsh etc.
SHELL := /bin/bash

ANTORA_PLAYBOOK_PATH ?= antora-playbook.yml
ANTORA_OUTPUT_DIR ?= $(shell grep dir $(ANTORA_PLAYBOOK_PATH) | cut -d " " -f 4)
ANTORA_ARGS ?=

NEW_TAG ?=

docs-build: node_modules ## Build the Antora documentation
	npm run build

docs-publish: docs-build ## Publishes the documentation in gh-pages
	npm run deploy

node_modules: ## Install Antora and its dependencies
	npm install

docs-clean: ## Clean local files
	rm -r $(ANTORA_OUTPUT_DIR) node_modules || true

docs-serve: docs-build ## Preview Antora build in local web server
	npm run serve

help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

docs-add-clustercode-tag: ## Adds a new version tag to the clustercode Antora component (set NEW_TAG=<your-tag>)
	yq eval -i '.content.sources.[0].tags += "$(NEW_TAG)"' $(ANTORA_PLAYBOOK_PATH)
