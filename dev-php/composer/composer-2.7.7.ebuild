# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Dependency Manager for PHP"
HOMEPAGE="https://github.com/composer/composer"
SRC_URI="https://github.com/composer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*[curl]
	dev-php/ca-bundle
	dev-php/class-map-generator
	dev-php/fedora-autoloader
	dev-php/jsonlint
	dev-php/json-schema
	dev-php/metadata-minifier
	dev-php/pcre
	dev-php/phar-utils
	dev-php/signal-handler
	dev-php/psr-log
	dev-php/reactphp-promise
	dev-php/semver
	dev-php/spdx-licenses
	dev-php/symfony-console
	dev-php/symfony-filesystem
	dev-php/symfony-finder
	dev-php/symfony-polyfill-php80
	dev-php/symfony-polyfill-php81
	dev-php/symfony-process
	dev-php/xdebug-handler"
BDEPEND="dev-php/theseer-Autoload"

src_prepare() {
	default

	sed -i '/includeIfExists/s|: ?ClassLoader||' src/bootstrap.php \
		|| die "sed failed for bootstrap.php"

	mkdir vendor || die "mkdir failed"

	phpab --quiet --output vendor/autoload.php \
		--template "${FILESDIR}"/autoload.php.tpl --basedir src/ src \
		|| die "phpab failed"

	eapply "${FILESDIR}/${PN}"-2.7.7-autoload.patch
}

src_install() {
	einstalldocs
	insinto /usr/share/composer
	doins -r res src vendor LICENSE
	exeinto /usr/share/composer/bin
	doexe bin/composer
	dosym ../share/composer/bin/composer /usr/bin/composer
}
