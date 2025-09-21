# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="rdkafka"
PHP_EXT_S="${WORKDIR}/${P}"
USE_PHP="php8-2 php8-3 php8-4"

inherit git-r3 php-ext-pecl-r3

DESCRIPTION="PHP Kafka client"
SRC_URI=""
EGIT_REPO_URI="https://github.com/arnaud-lb/php-rdkafka.git"
S="${PHP_EXT_S}"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-libs/librdkafka:=" # skipped 23
