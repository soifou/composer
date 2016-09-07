# Composer Alpine
Latest PHP Composer build on top of Alpine Linux.

## Tags
Different tags are available to run Composer with a specific PHP versions:
* `latest`
* `php-7.0`
* `php-5.6`

## Alias
```sh
function composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        soifou/composer:php-7.0 ${@:1}
}
```
Change the tag or create additional aliases if you want to deal with another PHP version.

## Custom PHP settings
Note theses images are builded with no PHP memory limit (and other few settings), have a look to their respective `php.ini` file.

You may want to override and add your own settings. 

Add an extra line to your alias :
* For PHP7: `-v /path/to/your/php/settings.ini:/etc/php7/conf.d/50-setting.ini`
* For PHP5: `-v /path/to/your/php/settings.ini:/etc/php5/conf.d/50-setting.ini`ettings.ini:/etc/php5/conf.d/50-setting.ini`