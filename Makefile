.PHONY: build test setver

REPO=soifou/composer
VERSIONS?="5.6 7.0 7.1 7.2 7.3 7.4 8.0"

build:
	for i in $(VERSIONS) ; do \
		docker build -t $(REPO):php-$$i $$i/ ; \
	done

test:
	for i in $(VERSIONS) ; do \
		docker run --rm -it $(REPO):php-$$i composer diagnose ; \
	done

setver:
	@find . -name "Dockerfile" | xargs sed -i 's/ENV COMPOSER_VERSION.*/ENV COMPOSER_VERSION $(VERSION)/g'
