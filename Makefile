PY?=python
PELICAN?=pelican
PELICAN_OPTS= --ignore-cache

BASE_DIR=$(CURDIR)
INPUT_DIR="$(BASE_DIR)/content"
SERVE_DIR= "$(BASE_DIR)/_output"
DEV_OUTPUT_DIR="$(BASE_DIR)/_output/sheetmusic"
PROD_OUTPUT_DIR="$(BASE_DIR)/_output/production"
CONF_FILE="$(BASE_DIR)/pelicanconf.py"
PROD_CONF_FILE="$(BASE_DIR)/publishconf.py"
DEPLOY_BUCKET = 's3://drewm.com/sheetmusic/'

html:
	$(PELICAN) $(INPUT_DIR) -o $(DEV_OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

clean:
	[ ! -d $(SERVE_DIR) ] || rm -rf $(SERVE_DIR)

regenerate:
	$(PELICAN) -r $(INPUT_DIR) -o $(DEV_OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

serve:
ifdef PORT
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)
endif

serve-global:
ifdef SERVER
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -b $(SERVER)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -b 0.0.0.0
endif

publish:
	$(PELICAN) $(INPUT_DIR) -o $(PROD_OUTPUT_DIR) -s $(PROD_CONF_FILE) $(PELICAN_OPTS)

preview:
	aws s3 sync --dryrun --delete $(PROD_OUTPUT_DIR) $(DEPLOY_BUCKET)

deploy:
	aws s3 sync --delete $(PROD_OUTPUT_DIR) $(DEPLOY_BUCKET)

.PHONY: html clean regenerate serve serve-global publish preview deploy