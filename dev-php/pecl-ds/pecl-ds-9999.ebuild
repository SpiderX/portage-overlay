# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="ds"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-2 php8-3 php8-4"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="Native Data Structures for PHP"
SRC_URI=""
EGIT_REPO_URI="https://github.com/php-ds/ext-ds.git"
S="${PHP_EXT_S}"

LICENSE="MIT"
SLOT="0"
