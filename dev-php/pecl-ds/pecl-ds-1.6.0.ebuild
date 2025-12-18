# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="ds"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit php-ext-pecl-r3

DESCRIPTION="Native Data Structures for PHP"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
