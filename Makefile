export PHP_CS_FIXER_IGNORE_ENV=1
SHELL=/bin/bash
PHP=$$(command -v php)

.PHONY=all
all: test cs

.PHONY=cs
cs:
	mkdir -p build/cache
	$(PHP) vendor/bin/php-cs-fixer fix -v

.PHONY=test
test: vendor/autoload.php
	$(PHP) vendor/bin/phpunit

.PHONY=test-all
test-all: all vendor/autoload.php
	$(PHP) vendor/bin/phpunit --stop-on-failure

vendor/autoload.php: composer.lock
	$(PHP) -v
	composer install

composer.lock: composer.json
	composer update
	touch -r composer.lock composer.json

