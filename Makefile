.PHONY: build test

REPO=soifou/composer

build:
	docker build -t $(REPO):php-5.6 5.6/
	docker build -t $(REPO):php-7.0 7.0/
	docker build -t $(REPO):php-7.1 7.1/
	docker build -t $(REPO) 7.2/

test:
	docker run --rm -it $(REPO):php-5.6 composer diagnose
	docker run --rm -it $(REPO):php-7.0 composer diagnose
	docker run --rm -it $(REPO):php-7.1 composer diagnose
	docker run --rm -it $(REPO) composer diagnose
