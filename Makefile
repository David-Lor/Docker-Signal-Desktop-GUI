.DEFAULT_GOAL := help

IMAGE_TAG := "signal-desktop-gui"

build: ## build the image
	docker build ./docker -t ${IMAGE_TAG}

help: ## show this help.
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
