# Composer Alpine
Latest PHP Composer build on top of Alpine Linux.

- `php-7.0`, `latest` [(*Dockerfile*)](https://github.com/soifou/composer/blob/php-7.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-7.0.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")
- `php-5.6` [(*Dockerfile*)](https://github.com/soifou/composer/blob/php-5.6/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-5.6.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")

## Alias
```sh
function composer() {
    docker run --rm -it \
        -v $(pwd):/usr/src/app \
        -v ~/.composer:/home/composer/.composer \
        -v ~/.ssh/id_rsa:/home/composer/.ssh/id_rsa:ro \
        soifou/composer ${@:1}
}
```

## Custom PHP settings
Note this image is builded with no PHP memory limit (and other few settings), have a look to their respective `php.ini` file.

You may want to override and add your own settings. 

Add an extra line to your alias : 
* PHP7 : `-v /path/to/your/php/settings.ini:/etc/php7/conf.d/50-setting.ini`
* PHP5 : `-v /path/to/your/php/settings.ini:/etc/php5/conf.d/50-setting.ini`