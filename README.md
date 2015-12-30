# Sugar 7 Ready Packer Templates

This project is intended to make it easy to provision a consistent [Sugar 7 Supported Platform](http://support.sugarcrm.com/Resources/Supported_Platforms/) on a variety of different container technologies using Packer.  This allows you to ensure that Dev, QA, and Operations is able to use the same platform set up.

## Atlas templates (atlas-*.json)
These templates are meant for integrating with [Atlas](https://atlas.hashicorp.com/builds) build system. This makes automated multi-platform builds and hosting of Vagrant boxes easy. However, there are limitations on what is supported by Atlas build system.  Read the [Atlas Help Docs](https://atlas.hashicorp.com/help) for help getting started with Atlas.

## Local templates (local-*.json)
These templates are meant for running local Virtualbox builds. There are fewer limitations but you need to have [Packer](https://packer.io/) and [Virtualbox](https://www.virtualbox.org/wiki/Downloads) installed locally.  Running builds locally also makes debugging your build and provisioning scripts easier.

## PHP 5.4 Stack

This stack is supported by Sugar 7.5, 7.6.

- Ubuntu 12.04
- Apache 2.2.x
- PHP 5.4.x
- MySQL 5.5.x
- Elasticsearch 1.4.x

Vagrant directory mounted at /var/www/sugar

If running Vagrant from within Sugar application directory then Sugar installer will be available at http://localhost:8080/sugar/install.php

### Running a Local PHP 5.4 Build
If you want to build the PHP 5.4 stack, then it is as easy as running:

    packer build local-php54.json

## PHP 5.3 Stack (Experimental)

I do not recommend using this one right now.  It does not currently install a supported version of PHP 5.3.  It is here for experimental purposes.
