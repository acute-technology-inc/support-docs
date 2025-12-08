.PHONY: build serve clean

# mkdocs configuration
CURRENT_DIR := $(abspath .)
MKDOCS = mkdocs
CONFIG_FILE = mkdocs.yml
SITE_DIR = $(CURRENT_DIR)/site
DOCS_DIR = $(CURRENT_DIR)/docs

LANGUAGES = en zh

# Serve the documentation on a local server, accessible at http://localhost:8000
serve:
	$(MKDOCS) serve -f $(CONFIG_FILE) --livereload

# Build the documentation into the specified site directory
build:
	$(MKDOCS) build -f $(CONFIG_FILE) --site-dir $(SITE_DIR)

# Clean the output directory
clean:
	rm -rf $(SITE_DIR)/
