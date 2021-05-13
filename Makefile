RUN = poetry run
SNYK = $(RUN) snyk test
FLASK = $(RUN) flask

default: requirements security

requirements: requirements.txt requirements-dev.txt

requirements.txt: poetry.lock
	poetry export --without-hashes -f requirements.txt > requirements.txt

requirements-dev.txt: poetry.lock
	poetry export --dev --without-hashes -f requirements.txt > requirements-dev.txt

security: snyk snyk-dev

snyk-dev:
	$(SNYK) --package-manager=pip --file=requirements-dev.txt

snyk:
	$(SNYK)

local:
	$(FLASK) run

test:
	$(RUN) pytest


.PHONY: default requirements security snyk snyk-dev local test
