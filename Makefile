.PHONY: build test setver

REPO=soifou/composer

build:
# 	docker build -t $(REPO):php-5.6 5.6/
# 	docker build -t $(REPO):php-7.0 7.0/
# 	docker build -t $(REPO):php-7.1 7.1/
# 	docker build -t $(REPO):php-7.2 7.2/
	docker build -t $(REPO) 7.3/

test:
	docker run --rm -it $(REPO):php-5.6 composer diagnose
	docker run --rm -it $(REPO):php-7.0 composer diagnose
	docker run --rm -it $(REPO):php-7.1 composer diagnose
	docker run --rm -it $(REPO):php-7.2 composer diagnose
	docker run --rm -it $(REPO) composer diagnose

setver:
	@find . -name "Dockerfile" | xargs sed -i 's/ENV COMPOSER_VERSION.*/ENV COMPOSER_VERSION $(VERSION)/g'
