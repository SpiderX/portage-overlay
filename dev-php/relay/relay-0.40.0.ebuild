# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PHP_EXT_NAME="relay"
PHP_EXT_NEEDED_USE="session"
PHP_EXT_SKIP_PHPIZE="yes"
USE_PHP="php8-2 php8-3 php8-4 php8-5"

inherit edo php-ext-source-r3

DESCRIPTION="High-performance Redis client and shared in-memory cache for PHP"
HOMEPAGE="https://relay.so"
SRC_URI="
	php_targets_php8-2? ( https://builds.r2.relay.so/v${PV}/${PN}-v${PV}-php8.2-debian-x86-64+libssl3.tar.gz
	    -> ${P}-php8.2-amd64.tar.gz )
	php_targets_php8-3? ( https://builds.r2.relay.so/v${PV}/${PN}-v${PV}-php8.3-debian-x86-64+libssl3.tar.gz
	    -> ${P}-php8.3-amd64.tar.gz )
	php_targets_php8-4? ( https://builds.r2.relay.so/v${PV}/${PN}-v${PV}-php8.4-debian-x86-64+libssl3.tar.gz
	    -> ${P}-php8.4-amd64.tar.gz )
	php_targets_php8-5? ( https://builds.r2.relay.so/v${PV}/${PN}-v${PV}-php8.5-debian-x86-64+libssl3.tar.gz
	    -> ${P}-php8.5-amd64.tar.gz )"
S="${WORKDIR}"

LICENSE="Relay"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="strip test"

RDEPEND+="dev-libs/concurrencykit
	dev-libs/hiredis:0/1.1
	dev-php/pecl-igbinary[php_targets_php8-2(-)?,php_targets_php8-3(-)?,php_targets_php8-4(-)?,php_targets_php8-5(-)?]
	dev-php/pecl-msgpack[php_targets_php8-2(-)?,php_targets_php8-3(-)?,php_targets_php8-4(-)?,php_targets_php8-5(-)?]"

QA_FLAGS_IGNORED="usr/lib.*/php8\.[2345]/lib/extensions/.*/relay.so"

src_prepare() {
	default

	local slot srcdir lib

	for slot in $(php_get_slots) ; do
		srcdir="${WORKDIR}/${PN}-v${PV}-${slot}-debian-x86-64+libssl3"
		edo mkdir "${WORKDIR}/${slot}"
		# initialize the environment for this PHP slot. This also gives us
		# PHPCLI and ensures ZTS detection is done against the correct PHP.
		php_init_slot_env "${slot}"
		if "${PHPCLI}" -n -r 'exit(PHP_ZTS ? 0 : 1);' ; then
			einfo "${slot}: PHP is built with ZTS, using relay-zts.so"
			lib="relay-zts.so"
		else
			einfo "${slot}: PHP is built without ZTS, using relay.so"
			lib="relay.so"
		fi
		edo cp "${srcdir}/${lib}" relay.so
		sed -i "s/00000000-0000-0000-0000-000000000000/$(cat /proc/sys/kernel/random/uuid)/" \
			relay.so || die "sed failed for ${slot}/relay.so"
	done
}

src_configure() { :; }

src_compile() { :; }

src_install() {
	local slot

	for slot in $(php_get_slots) ; do
		php_init_slot_env "${slot}"
		exeinto "${EXT_DIR#"${EPREFIX}"}"
		doexe relay.so
	done

	php-ext-source-r3_createinifiles
}
