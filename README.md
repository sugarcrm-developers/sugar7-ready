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

## Troubleshoot
### Vagrant was unable to mount VirtualBox shared folders
If you run into an error like this:
```
==> default: Machine booted and ready!
==> default: Checking for guest additions in VM...
  default: The guest additions on this VM do not match the installed version of
  default: VirtualBox! In most cases this is fine, but in rare cases it can
  default: prevent things such as shared folders from working properly. If you see
  default: shared folder errors, please make sure the guest additions within the
  default: virtual machine match the version of VirtualBox you have installed on
  default: your host and reload your VM.
  default:
  default: Guest Additions Version: 5.2.8_KernelUbuntu r120774
  default: VirtualBox Version: 6.1
==> default: Mounting shared folders...
  default: /vagrant => /Users/mmarum-mac2/temp/SugarEnt-Full-12.0.0
Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available. This filesystem is
made available via the VirtualBox Guest Additions and kernel module.
Please verify that these guest additions are properly installed in the
guest. This is not a bug in Vagrant and is usually caused by a faulty
Vagrant box. For context, the command attempted was:
mount -t vboxsf -o uid=1000,gid=1000,_netdev vagrant /vagrant
The error output from the command was:
mount: /vagrant: wrong fs type, bad option, bad superblock on vagrant, missing codepage or helper program, or other error.
```

You need to update your `vagrant-vbguest` plugin in your host:
```
vagrant plugin install vagrant-vbguest
vagrant plugin update vagrant-vbguest
```
