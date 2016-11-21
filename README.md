# Composer Alpine
Latest PHP Composer build on top of Alpine Linux.

[![](https://images.microbadger.com/badges/image/soifou/composer:php-7.0.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")

- `php-7.0` [(*Dockerfile*)](https://github.com/soifou/composer/blob/php-7.0/Dockerfile)

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

## Check Composer health
You may want to check first the health of composer with:
```
$ composer diagnose
```

If you are on macOS, using VirtualBox and the diagnose check reports some networking problem like so:
```
[Composer\Downloader\TransportException] The "http://packagist.org/packages.json" file could not be downloaded: php_network_getaddresses: getaddrinfo failed: Try again
failed to open stream: php_network_getaddresses: getaddrinfo failed: Try again
Checking https connectivity to packagist: FAIL
```

You could fix it with this:
```
$ docker-machine stop [machine-name]
$ VBoxManage modifyvm [machine-name] --natdnsproxy1 off --natdnshostresolver1 off
$ docker-machine start [machine-name]
```

see: https://github.com/boot2docker/boot2docker/issues/451#issuecomment-65432123

## Custom PHP settings
Note this image is builded with no PHP memory limit (and other few settings), have a look to their respective `php.ini` file.

You may want to override and add your own settings. 

Add an extra line to your alias : 
`-v /path/to/your/php/settings.ini:/etc/php7/conf.d/50-setting.ini`