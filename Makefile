PY?=python
PELICAN?=pelican
PELICAN_OPTS= --ignore-cache

BASE_DIR=$(CURDIR)
INPUT_DIR="$(BASE_DIR)/content"
SERVE_DIR= "$(BASE_DIR)/_output"
OUTPUT_DIR="$(BASE_DIR)/_output/sheetmusic"
CONF_FILE="$(BASE_DIR)/pelicanconf.py"
PROD_CONF_FILE="$(BASE_DIR)/publishconf.py"

html:
	$(PELICAN) $(INPUT_DIR) -o $(OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

clean:
	[ ! -d $(SERVE_DIR) ] || rm -rf $(SERVE_DIR)

regenerate:
	$(PELICAN) -r $(INPUT_DIR) -o $(OUTPUT_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)

serve:
ifdef PORT
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS)
endif

serve-global:
ifdef SERVER
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT) -b $(SERVER)
else
	$(PELICAN) -l $(INPUT_DIR) -o $(SERVE_DIR) -s $(CONF_FILE) $(PELICAN_OPTS) -p $(PORT) -b 0.0.0.0
endif

publish:
	$(PELICAN) $(INPUT_DIR) -o $(OUTPUT_DIR) -s $(PROD_CONF_FILE) $(PELICAN_OPTS)

.PHONY: html clean regenerate serve serve-global publish