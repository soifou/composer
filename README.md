# Composer Alpine

Latest PHP Composer build on top of Alpine Linux.

See Composer changelog [here](https://github.com/composer/composer/blob/master/CHANGELOG.md) for latest changes.

Heavily inspired by the official [Composer Github repository](https://github.com/composer/docker) but since Composer should run with the same PHP version that match your current project, add a capability to choose it.

## Tags
- `php-7.2`, `latest` [(*Dockerfile*)](https://github.com/soifou/composer/tree/master/7.2/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-7.2.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")
- `php-7.1` [(*Dockerfile*)](https://github.com/soifou/composer/tree/master/7.1/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-7.1.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")
- `php-7.0` [(*Dockerfile*)](https://github.com/soifou/composer/tree/master/7.0/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-7.0.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")
- `php-5.6` [(*Dockerfile*)](https://github.com/soifou/composer/tree/master/5.6/Dockerfile) [![](https://images.microbadger.com/badges/image/soifou/composer:php-5.6.svg)](http://microbadger.com/images/soifou/composer "Get your own image badge on microbadger.com")

## Alias
```sh
composer() {
    tty=
    tty -s && tty=--tty
    docker run \
        $tty \
        --interactive \
        --rm \
        -u $(id -u):$(id -g) \
        -v ~/.composer:/composer \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v $(pwd):/app \
        -v $SSH_AUTH_SOCK:/ssh-auth.sock \
        --env SSH_AUTH_SOCK=/ssh-auth.sock \
        soifou/composer:latest ${@:1}
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
Note this image is build with no PHP memory limit (and other few settings), have a look to their respective `php.ini` file.

You may want to override and add your own settings by adding an extra line to your alias : 
```
composer() {
    [...]
    docker run \
        `-v /path/to/your/php/settings.ini:/usr/local/etc/php/conf.d/50-setting.ini`
        [...]
}
```