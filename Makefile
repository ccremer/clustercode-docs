# Set Shell to bash, otherwise some targets fail with dash/zsh etc.
SHELL := /bin/bash

ANTORA_PLAYBOOK_PATH ?= antora-playbook.yml
ANTORA_OUTPUT_DIR ?= public
ANTORA_ARGS ?=

docs-build: node_modules ## Build the Antora documentation
	node_modules/@antora/cli/bin/antora $(ANTORA_PLAYBOOK_PATH) $(ANTORA_ARGS)

node_modules: ## Install Antora and its dependencies
	npm install

docs-clean: ## Clean local files
	rm -r $(ANTORA_OUTPUT_DIR) node_modules || true

docs-serve: docs-build ## Preview Antora build in local web server
	npm run serve

help: ## Show this help
	@grep -E -h '\s##\s' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
