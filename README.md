# rehan-easyrsa

[![Build Status](https://travis-ci.org/rehanone/puppet-easyrsa.svg?branch=master)](https://travis-ci.org/rehanone/puppet-easyrsa)

#### Table of Contents
1. [Overview](#overview)
2. [Module Description](#module-description)
3. [Setup](#setup)
4. [Usage](#usage)
    * [Classes](#classes)
    * [Referances](#referances)
5. [Dependencies](#dependencies)
6. [Development](#development)

## Overview
The `rehan-easyrsa` module for installing, managing and generating SSL certificates using OpenVPN's PKI toolkit - Easy-RSA.

## Module Description
A puppet module for managing the installation and configuration of OpenVPN's PKI toolkit. This module installs and 
configures Easy-RSA utility from its Github Repository.

Easy-RSA packages normally available from OS repositories are outdated and based on the old 2.x version of Easy-RSA. 
This module clones Easy-RSA from the repository at:

  - [https://github.com/OpenVPN/easy-rsa](https://github.com/OpenVPN/easy-rsa "https://github.com/OpenVPN/easy-rsa")

#### Implemented Features:
* Clones Easy-RSA repository to /opt/easyrsa-git and creates links under /opt/easyrsa

#### Features not yet updated
* Allow separation of CA from Server and Client certificates.

## Setup
In order to install `rehan-easyrsa`, run the following command:
```bash
$ sudo puppet module install rehan-easyrsa
```
The module does expect all the data to be provided through 'Hiera'. See [Usage](#usage) for examples on how to configure it.

#### Requirements
This module is designed to be as clean and compliant with latest puppet code guidelines. It works with:

  - `puppet >=4.10.0`

## Usage

### Classes

#### `easyrsa`

A basic install with the defaults would be:
```puppet
include easyrsa
```

## Dependencies

* [stdlib][1]
* [vcsrepo][2]

[1]:https://github.com/puppetlabs/puppetlabs-stdlib
[2]:https://github.com/puppetlabs/puppetlabs-vcsrepo

## Development

You can submit pull requests and create issues through the official page of this module: https://github.com/rehan/puppet-cfssl.
Please do report any bug and suggest new features/improvements.
