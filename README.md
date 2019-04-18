# Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Dependencies](#dependendcies)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Configuration](#configuration)
    - [Data Volumes](#data-volumes)
    - [Database](#database)
    - [Environment Variables](#environmentvariables)   
    - [Networking](#networking)
- [Maintenance](#maintenance)
    - [Shell Access](#shell-access)
- [References](#references)

# Introduction

Dockerfile to build a [OpenLDAP Server](https://sourceforge.net/projects/openldap-fusiondirectory/) with [Fusion Directory](https://www.fusiondirectory.org) Schema's Included.
It includes all the functions in the [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) such as Multi-Master Replication, TLS, and other features.

This Container uses [tiredofit/openldap](https://github.com/tiredofit/docker-openldap) as a base.


[Changelog](CHANGELOG.md)

# Authors

- [Dave Conroy](daveconroy@tiredofit.ca)

# Dependencies

To build this image you must have the [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) built and available. To utilize, you must also have the [Fusion Directory Image](https://github.com/tiredofit/docker-fusiondirectory) image built and available.

# Installation

Automated builds of the image are available on [Registry](https://hub.docker.com/r/tiredofit/openldap-fusiondirectory) and is the recommended method of installation.


```bash
docker pull tiredofit/openldap-fusiondirectory
```
# Quick Start

* The quickest way to get started is using [docker-compose](https://docs.docker.com/compose/). See the examples folder for a working [docker-compose.yml](examples/docker-compose.yml) that can be modified for development or production use.

* Set various [environment variables](#environment-variables) to understand the capabilities of this image.
* Map [persistent storage](#data-volumes) for access to configuration and data files for backup.
* Map [Network Ports](#networking) to allow external access.

Start openldap-fusiondirectory using:

```bash
docker-compose up
```
__NOTE__: Please allow up to 1 minutes for the application to start.


## Data-Volumes

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Data Volume Configuration.

There is an additional data volume exposed:

| Directory | Description |
|-----------|-------------|
| `/assets/fusiondirectory-custom/` | Place Schema files here to be imported into FusionDirectory |

## Environment Variables

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Environment Variables Configuration
* There are specific environment variables to this image:

| Variable | Description |
|-----------|-------------|
| `FUSIONDIRECTORY_ADMIN_USER` | Default FD Admin User - Default `fd-admin` |
| `FUSIONDIRECTORY_ADMIN_PASS` | Default FD Admin Password - Default `admin` |
| `ORGANIZATION` | Organization Name Default: `Example Organization`

## Alpine Base Image 

Below is the complete list of available options that can be used to customize your installation. These are inherited from [Tiredofit Alpine Base Image](https://github.com/tiredofit/docker-alpine) 

| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `DEBUG_MODE`      | Enable Debug Mode - Default: `FALSE`                            |
| `DEBUG_SMTP`      | Setup Mail Catch all on port 1025 (SMTP) and 8025 (HTTP) - Default: `FALSE` |
| `ENABLE_CRON`     | Enable Cron - Default: `TRUE`                                   |
| `ENABLE_SMTP`     | Enable SMTP services - Default: `TRUE`						|
| `ENABLE_ZABBIX`   | Enable Zabbix Agent - Default: `TRUE`                           |
| `TIMEZONE`        | Set Timezone - Default: `Asia/Colombo`                     |

If you wish to have this send mail, set `ENABLE_SMTP=TRUE` and configure the following environment variables. See the [MSMTP Configuration Options](http://msmtp.sourceforge.net/doc/msmtp.html) for further information on options to configure MSMTP

| Parameter         | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `ENABLE_SMTP_GMAIL` | Add setting to supoprt sending through Gmail SMTP - Default: `FALSE` |
| `SMTP_HOST`      | Hostname of SMTP Server - Default: `postfix-openemail`                            |
| `SMTP_PORT`      | Port of SMTP Server - Default: `25`                            |
| `SMTP_DOMAIN`     | HELO Domain - Default: `docker`                                   |
| `SMTP_MAILDOMAIN`     | Mail Domain From - Default: `openemail.io`						|
| `SMTP_AUTHENTICATION`     | SMTP Authentication - Default: `none`                                   |
| `SMTP_USER`     | Enable SMTP services - Default: `user`						|
| `SMTP_PASS`   | Enable SMTP services - Default: `password`                           |
| `SMTP_TLS`        | Use TLS - Default: `off`                     |
| `SMTP_STARTTLS`   | Start TLS from within Dession - Default: `off` |
| `SMTP_TLSCERTCHECK` | Check remote certificate - Default: `off` |

See The [Official Zabbix Agent Documentation](https://www.zabbix.com/documentation/2.2/manual/appendix/config/zabbix_agentd) for information about the following Zabbix values

| Zabbix Parameters | Description                                                    |
|-------------------|----------------------------------------------------------------|
| `ZABBIX_LOGFILE` | Logfile Location - Default: `/var/log/zabbix/zabbix_agentd.log` |
| `ZABBIX_LOGFILESIZE` | Logfile Size - Default: `1` |
| `ZABBIX_DEBUGLEVEL` | Debug Level - Default: `1` |
| `ZABBIX_REMOTECOMMANDS` | Enable Remote Commands (0/1) - Default: `1` |
| `ZABBIX_REMOTECOMMANDS_LOG` | Enable Remote Commands Log (0/1)| - Default: `1` |
| `ZABBIX_SERVER` | Allow connections from Zabbix Server IP - Default: `0.0.0.0/0` |
| `ZABBIX_LISTEN_PORT` | Zabbix Agent Listening Port - Default: `10050` |
| `ZABBIX_LISTEN_IP` | Zabbix Agent Listening IP - Default: `0.0.0.0` |
| `ZABBIX_START_AGENTS` | How many Zabbix Agents to Start - Default: `3 | 
| `ZABBIX_SERVER_ACTIVE` | Server for Active Checks - Default: `zabbix-openemail` |
| `ZABBIX_HOSTNAME` | Container hostname to report to server - Default: `docker` |
| `ZABBIX_REFRESH_ACTIVE_CHECKS` | Seconds to refresh Active Checks - Default: `120` |
| `ZABBIX_BUFFER_SEND` | Buffer Send - Default: `5` |
| `ZABBIX_BUFFER_SIZE` | Buffer Size - Default: `100` |
| `ZABBIX_MAXLINES_SECOND` | Max Lines Per Second - Default: `20` |
| `ZABBIX_ALLOW_ROOT` | Allow running as root - Default: `1` |
| `ZABBIX_USER` | Zabbix user to start as - Default: `zabbix` |

If you enable `DEBUG_PERMISSIONS=TRUE` all the users and groups have been modified in accordance with Environmental Variables will be displayed in output.
e.g. If you add `USER_NGINX=1000` it will reset the containers `nginx` user id from `82` to `1000` - Hint, also change the Group ID to your local development users UID & GID
and avoid Docker permission issues when developing.

| Parameter | Description |
|-----------|-------------|
| `USER_<USERNAME>` |  The user's UID in /etc/passwd will be modified with new UID - Default `N/A` |
| `GROUP_<GROUPNAME>` | The group's GID in /etc/group and /etc/passwd will be modified with new GID - Default `N/A` |
| `GROUP_ADD_<USERNAME>` | The username will be added in /etc/group after the group name defined - Default `N/A` | 


### Networking


The following ports are exposed.

| Port      | Description  |
|-----------|--------------|
| `1025`    | `DEBUG_MODE` & `DEBUG_SMTP` SMTP Catcher |
| `8025`    | `DEBUG_MODE` & `DEBUG_SMTP` SMTP HTTP Viewer |
| `10050`   | Zabbix Agent |


## Schema Installation
Depending on your choices, the following schemas are available for installation. You must have these also enabled on the FusionDirectory application image to make use of it. If you would like to reapply the schemas set `REAPPLY_PLUGIN_SCHEMAS` to `TRUE`.

| Variable | Description |
|-----------|-------------|
| `REAPPLY_PLUGIN_SCHEMAS` | Reapply Plugin Schemas `TRUE` or `FALSE` - Default: `FALSE` |
| `PLUGIN_ALIAS` | Mail Aliases - Default: `FALSE` |
| `PLUGIN_APPLICATIONS` | Applications - Default: `FALSE` |
| `PLUGIN_ARGONAUT` | Argonaut - Default: `FALSE` |
| `PLUGIN_AUDIT` |  Audit Trail - Default: `TRUE` |
| `PLUGIN_AUTOFS` |  AutoFS - Default: `FALSE` |
| `PLUGIN_CERTIFICATES` | Manage Certificates - Default: `FALSE` |
| `PLUGIN_COMMUNITY` | Community Plugin - Default: `FALSE` |
| `PLUGIN_CYRUS` | Cyrus IMAP - Default: `FALSE` |
| `PLUGIN_DEBCONF` | Argonaut Debconf - Default: `FALSE` |
| `PLUGIN_DEVELOPERS` | Developers Plugin - Default: `FALSE` |
| `PLUGIN_DHCP` | Manage DHCP - Default: `FALSE` |
| `PLUGIN_DNS` | Manage DNS - Default: `FALSE` |
| `PLUGIN_DOVECOT` | Dovecot IMAP - Default: `FALSE` |
| `PLUGIN_DSA` | System Accounts - Default: `TRUE` |
| `PLUGIN_EJBCA` | Unknown - Default: `FALSE` |
| `PLUGIN_FAI` | Unknown - Default: `FALSE` |
| `PLUGIN_FREERADIUS` | FreeRadius Management - Default: `FALSE` |
| `PLUGIN_FUSIONINVENTORY` | Inventory Plugin - Default: `FALSE` |
| `PLUGIN_GPG` | Manage GPG Keys - Default: `FALSE` |
| `PLUGIN_IPMI` | IPMI Management - Default: `FALSE` |
| `PLUGIN_MAIL` | Mail Attributes - Default: `TRUE` |
| `PLUGIN_MIXEDGROUPS` | Unix/LDAP Groups - Default: `FALSE` |
| `PLUGIN_NAGIOS` | Nagios Monitoring - Default: `FALSE` |
| `PLUGIN_NETGROUPS` | NIS - Default: `FALSE` |
| `PLUGIN_NEWSLETTER` | Manage Newsletters - Default: `FALSE` |
| `PLUGIN_OPSI` | Inventory - Default: `FALSE` |
| `PLUGIN_PERSONAL` | Personal Details - Default: `TRUE` |
| `PLUGIN_POSIX` | Posix Groups - Default: `FALSE` |
| `PLUGIN_POSTFIX` | Postfix SMTP - Default: `FALSE` |
| `PLUGIN_PPOLICY` | Password Policy - Default: `TRUE` |
| `PLUGIN_PUPPET` | Puppet CI - Default: `FALSE` |
| `PLUGIN_PUREFTPD` | FTP Server - Default: `FALSE` |
| `PLUGIN_QUOTA` | Manage Quotas - Default: `FALSE` |
| `PLUGIN_RENATER_PARTAGE` | Unknown - Default: `FALSE` |
| `PLUGIN_REPOSITORY` | Argonaut Deployment Registry - Default: `FALSE` |
| `PLUGIN_SAMBA` | File Sharing - Default: `FALSE` |
| `PLUGIN_SOGO` | Groupware - Default: `FALSE` |
| `PLUGIN_SPAMASSASSIN` | Anti Spam - Default: `FALSE` |
| `PLUGIN_SQUID` | Proxy - Default: `FALSE` |
| `PLUGIN_SSH` | Manage SSH Keys - Default: `TRUE` |
| `PLUGIN_SUBCONTRACTING` | Unknown  - Default: `FALSE` |
| `PLUGIN_SUDO` |  Manage SUDO on Hosts - Default: `FALSE` |
| `PLUGIN_SUPANN` |  SUPANN - Default: `FALSE` |
| `PLUGIN_SYMPA` |  Sympa Mailing List - Default: `FALSE` |
| `PLUGIN_SYSTEMS` |  Systems Management - Default: `TRUE` |
| `PLUGIN_USER_REMINDER` |  Password Expiry - Default: `FALSE` |
| `PLUGIN_WEBLINK` | Display Weblink - Default: `FALSE` |


## Networking

* Please see [OpenLDAP Image](https://github.com/tiredofit/docker-openldap) for Networking Configuration


## Maintenance
#### Shell Access

For debugging and maintenance purposes you may want access the containers shell. 

```bash
docker exec -it openldap-fusiondirectory bash
```

# References

* https://fusiondirectory.org
* https://openldap.org

