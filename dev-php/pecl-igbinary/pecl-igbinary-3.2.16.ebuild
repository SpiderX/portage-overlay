# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="igbinary"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit php-ext-pecl-r3

DESCRIPTION="Drop in replacement for the standard PHP serializer"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="apcu curl session test"
REQUIRED_USE="test? ( apcu curl session )"
RESTRICT="!test? ( test )"

DEPEND="apcu? ( dev-php/pecl-apcu )"
RDEPEND="${DEPEND}"
BDEPEND="test? ( dev-lang/php:*[curl?,session?] )" # skipped 16
