# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMPOSER_INSTALL_AUTOLOAD="src/Composer"
PHP_REQ_USE="curl?,intl?,ssl,zlib,zip?"

inherit composer edo optfeature shell-completion

DESCRIPTION="Dependency Manager for PHP"
HOMEPAGE="https://github.com/composer/composer"
SRC_URI="https://github.com/composer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}-1/${P}-patches-1.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl intl ipv6 zip"
REQUIRED_USE="test? ( curl intl zip )"

RDEPEND="dev-php/composer-ca-bundle
	dev-php/composer-class-map-generator
	dev-php/composer-pcre
	dev-php/composer-semver
	dev-php/composer-spdx-licenses
	dev-php/jsonlint
	dev-php/justinrainbow-json-schema
	dev-php/metadata-minifier
	dev-php/phar-utils
	dev-php/psr-log
	dev-php/reactphp-promise
	dev-php/seld-signal-handler
	dev-php/symfony-console
	>=dev-php/symfony-filesystem-7
	>=dev-php/symfony-finder-7
	dev-php/symfony-polyfill-php80
	dev-php/symfony-polyfill-php81
	dev-php/symfony-polyfill-php84
	>=dev-php/symfony-process-7
	dev-php/xdebug-handler"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-vcs/git
		dev-php/sebastian-object-reflector )"

PATCHES=( "${WORKDIR}/${P}"-patches/src )

COMPOSER_TEST_FILES=( doc )
COMPOSER_TEST_PATCHES=( "${WORKDIR}/${P}"-patches/tests )
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	# bin/composer is patched to load the distro autoloader from this
	# source-tree representation of /usr/share/php/Composer.
	edo mkdir -p share/php
	edo ln -s -t share/php/ ../../src/Composer
}

src_compile() {
	# generate installed.json
	edo php "${FILESDIR}"/_installed.php

	local completion
	for completion in bash fish zsh ; do
		edo ./bin/composer completion "${completion}" > composer."${completion}"
	done
}

src_test() {
	use ipv6 || COMPOSER_TEST_PATCHES+=( "${WORKDIR}/${P}"-patches/composer-2.10.3-tests-no-ipv6.patch )
	composer_prepare_tests
	# recreate the minimal installed Composer tree expected by the test suite.
	# tests reference /usr/share/composer/{res,LICENSE}
	edo mkdir composer vendor
	edo ln -s -t composer ../res
	edo ln -s -t composer ../LICENSE
	# generate classmap load with exclution as in composer.json
	edo phpab -q -o vendor/autoload.php -t "${FILESDIR}"/autoload.php.tpl \
		-e "tests/Composer/Test/Fixtures/*" \
		-e "tests/Composer/Test/Autoload/Fixtures/*"  \
		-e "tests/Composer/Test/Autoload/MinimumVersionSupport/*" \
		-e "tests/Composer/Test/Plugin/Fixtures/*" tests/Composer/Test
	edo git init -q
	edo git config user.email "you@example.com"
	edo git config user.name "Your Name"
	edo git add .
	edo git commit -m "init"
	edo php -d memory_limit=512M /usr/bin/phpunit --testdox
}

src_install() {
	einstalldocs
	insinto /usr/share/composer
	doins -r res LICENSE installed.json
	insinto /usr/share/php
	doins -r src/Composer
	dobin bin/composer
	newbashcomp composer.bash composer
	newfishcomp composer.fish composer
	newzshcomp composer.zsh _composer
}

pkg_postinst() {
	optfeature "Support to unzip archives" dev-lang/php[zip]
}
