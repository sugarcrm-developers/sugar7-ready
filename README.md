# Sugar Development Ready Packer Templates

This project is intended to make it easy to provision a consistent [Sugar Supported Platform](http://support.sugarcrm.com/Resources/Supported_Platforms/) on a variety of different container technologies using Packer.  This allows you to ensure that Dev, QA, and Operations is able to use the same platform set up.

## Atlas templates (atlas-*.json)
These templates are meant for integrating with [Atlas](https://atlas.hashicorp.com/builds) build system. This makes automated multi-platform builds and hosting of Vagrant boxes easy. However, there are limitations on what is supported by Atlas build system.  Read the [Atlas Help Docs](https://atlas.hashicorp.com/help) for help getting started with Atlas.

## Local templates (local-*.json)
These templates are meant for running local Virtualbox builds. There are fewer limitations but you need to have [Packer (v1.4.5)](https://packer.io/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed locally. Running builds locally also makes debugging your build and provisioning scripts easier.

## PHP 8.0, MySQL 8, ES 7.16.3 Stack

This stack is supported by Sugar 12.x

- Ubuntu 18.04 LTS
- Apache 2.4
- PHP 8.0
- MySQL 8.0
- Elasticsearch 7.16.3

Vagrant directory mounted at `/var/www/sugar`

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php

## PHP 7.4, MySQL 8, ES 7.9 Stack

This stack is supported by Sugar 11.1.x, 11.2.x, 11.3.x

- Ubuntu 16.04
- Apache 2.4
- PHP 7.4
- MySQL 8.0
- Elasticsearch 7.9

Vagrant directory mounted at `/var/www/sugar`

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php

## PHP 7.4, MySQL 5.7, ES 7.0 Stack

This stack is supported by Sugar 11.0.x

- Ubuntu 16.04
- Apache 2.4
- PHP 7.4
- MySQL 5.7
- Elasticsearch 7.0

Vagrant directory mounted at `/var/www/sugar`

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php

## PHP 7.3, MySQL 5.7, ES 6.8 Stack

This stack is supported by Sugar 10.0.x

- Ubuntu 16.04
- Apache 2.4
- PHP 7.3
- MySQL 5.7
- Elasticsearch 6.8

Vagrant directory mounted at `/var/www/sugar`

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php


## PHP 5.4 Stack

This stack is supported by Sugar 7.5, 7.6.

- Ubuntu 12.04
- Apache 2.2.x
- PHP 5.4.x
- MySQL 5.5.x
- Elasticsearch 1.4.x

Vagrant directory mounted at `/var/www/sugar`

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php

### Running a Local PHP 8.0 Build
If you want to build the PHP 8.0 stack, then it is as easy as running:

```shell
packer build local-php80-es7163.json
```
