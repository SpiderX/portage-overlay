# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="msgpack"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit git-r3 php-ext-pecl-r3

unset SRC_URI

DESCRIPTION="PHP extension for interfacing with MessagePack"
EGIT_REPO_URI="https://github.com/msgpack/msgpack-php.git"
S="${PHP_EXT_S}"

LICENSE="BSD"
SLOT="0"
IUSE="apcu session test"
REQUIRED_USE="test? ( apcu session )"
RESTRICT="!test? ( test )"

DEPEND="apcu? ( dev-php/pecl-apcu )"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-lang/php:*[session?] )" # skipped 9
