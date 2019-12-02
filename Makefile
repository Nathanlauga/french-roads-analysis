#!make

.PHONY: all
export SHELL := /bin/bash
.DEFAULT_GOAL := help

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

build: ## Build docker image
	@echo "+ $@"
	@docker build . \
		-t  french-roads-analysis:local

run: ## Run jupyter lab
	@echo "+ $@"
	@docker run \
		--volume $(PWD)/:/env \
		--name french-roads-analysis \
		--publish 8888:8888 \
		--hostname localhost \
		french-roads-analysis:local

shell: ## Get shell into container
	@echo "+ $@"
	@docker exec french-roads-analysis -it sh

freeze: ## Freeze packages in requirements.txt
	@echo "+ $@"
	@docker exec french-roads-analysis -t pip freeze > requirements.txt

stop: ## Stop jupyter lab
	@echo "+ $@"
	@docker stop french-roads-analysis

delete: ## delete docker image
	docker rmi french-roads-analysis:local

purge: delete ## Stop and delete
	@echo "+ $@"
	@docker stop --rm french-roads-analysis
	@echo "Purged !"
