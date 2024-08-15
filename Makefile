# Define global variables
PACKAGE_NAME := $(shell awk '/"name":/ {gsub(/[",]/, "", $$2); print $$2}' package.json)
VERSION := $(shell T=$$(git describe 2>/dev/null) || T=1; echo $$T | tr '-' '.')
PREFIX ?= /usr/local

# Define the target directory where the dist folder will be copied
TARGET_DIR=/path/to/your/target/directory
RUN_TESTS=false

# Default target: Run all stages of the script
all: run-unit run-e2e build deploy print-version clean

# Ask the user to run or skip tests
run-unit:
	@while true; do \
		read -p "Do you want to run the unit-tests? [N/y]: " yn; \
		case $$yn in \
			[Nn]* | "" ) echo "Skipping unit-tests."; break;; \
			[Yy]* ) echo "Running unit-tests..."; \
					pnpm test:unit
			        break;; \
			* ) echo "Please answer yes or no.";; \
		esac; \
	done

run-e2e:
	@while true; do \
		read -p "Do you want to run the e2e-tests? [N/y]: " yn; \
		case $$yn in \
			[Nn]* | "" ) echo "Skipping e2e-tests."; break;; \
			[Yy]* ) echo "Running e2e-tests..."; \
					pnpm test:e2e:dev
			        break;; \
			* ) echo "Please answer yes or no.";; \
		esac; \
	done

# Build the Vue.js app
build:
	pnpm install
	pnpm run build

# Deploy the built app to the target directory
deploy: build
	mkdir -p $(DESTDIR)$(PREFIX)/share/cockpit/$(PACKAGE_NAME)
	cp -r dist/* $(DESTDIR)$(PREFIX)/share/cockpit/$(PACKAGE_NAME)

print-version:
	@echo "Newly installed version: $(VERSION)"

# Clean the dist directory
clean:
	rm -rf dist

# PHONY targets to avoid conflicts with files named 'all', 'run-unit', 'run-e2e' 'build', 'deploy', 'print-version' or 'clean'
.PHONY: all run-unit run-e2e build deploy print-version clean