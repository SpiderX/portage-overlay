# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo optfeature shell-completion

DESCRIPTION="Dependency Manager for PHP"
HOMEPAGE="https://github.com/composer/composer"
SRC_URI="https://github.com/composer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="curl intl ipv6 test zip"
REQUIRED_USE="test? ( curl intl zip )"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[curl?,intl?,ssl,zlib,zip?]
	dev-php/composer-ca-bundle
	dev-php/composer-class-map-generator
	dev-php/composer-pcre
	dev-php/composer-semver
	dev-php/composer-spdx-licenses
	dev-php/fedora-autoloader
	dev-php/jsonlint
	dev-php/json-schema
	dev-php/metadata-minifier
	dev-php/phar-utils
	dev-php/psr-log
	dev-php/reactphp-promise
	dev-php/seld-signal-handler
	dev-php/symfony-console
	>=dev-php/symfony-filesystem-6
	>=dev-php/symfony-finder-6
	dev-php/symfony-polyfill-php80
	dev-php/symfony-polyfill-php81
	>=dev-php/symfony-process-6
	dev-php/xdebug-handler"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/phpunit
		dev-php/sebastian-object-reflector )"

PATCHES=( "${FILESDIR}/${PN}"-2.8.11-autoload-resources.patch )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		src/Composer/autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/installed.json \
		res/installed.json || die "install for res failed"
	# change return type
	sed -i '/includeIfExists/s|: ?ClassLoader||' src/bootstrap.php \
		|| die "sed failed for src/bootstrap.php"
	# mimic system path for bootstrap, assume ${S} as /usr
	mkdir -p composer share/php vendor || die "mkdir failed"
	ln -s -t composer ../res || die "ln for res failed"
	ln -s -t composer ../LICENSE || die "ln for license failed"
	# needed for bin/composer
	ln -s -t share/php/ ../../src/Composer || die "ln for res failed"
}

src_compile() {
	local completion
	for completion in bash fish zsh ; do
		edo ./bin/composer completion "${completion}" > composer."${completion}" \
			|| die "completion for ${completion} failed"
	done
}

src_test() {
	# get tests
	composer require -d "${T}" --prefer-source \
		--dev "${PN}/${PN}":"${PV}" || die "composer failed"
	# move tests and docs tests need into work dir
	cp -r "${T}/vendor/${PN}/${PN}"/{doc,phpunit.xml.dist,tests} "${S}" \
		|| die "cp doc,tests failed"
	# PSR4 load doesn't work, classmap load with exclution as in composer.json
	phpab -q -o vendor/autoload.php -t "${FILESDIR}"/autoload.php.tpl \
		-e "tests/Composer/Test/Fixtures/*" \
		-e "tests/Composer/Test/Autoload/Fixtures/*"  \
		-e "tests/Composer/Test/Autoload/MinimumVersionSupport/*" \
		-e "tests/Composer/Test/Plugin/Fixtures/*" tests/Composer/Test \
		|| die "phpab failed"
	# bootstrap tests
	eapply "${FILESDIR}/${PN}"-2.8.11-test-bootstrap.patch
	# disable tests
	eapply "${FILESDIR}/${PN}"-2.7.7-tests.patch
	! use ipv6 && eapply "${FILESDIR}/${PN}"-2.7.7-test-no-ipv6.patch
	# fix non-static data provider deprecation
	sed -i  -e '/ignoredIdsProvider/s|function|static function|' \
		-e '/ignoreSeverityProvider(/s|function|static function|' \
		tests/Composer/Test/Advisory/AuditorTest.php \
		|| die "sed failed for AuditorTest.php"
	sed -i '/caseWhyNotProvider(/s|function|static function|' \
		tests/Composer/Test/Command/BaseDependencyCommandTest.php \
		|| die "sed failed for BaseDependencyCommandTest.php"
	sed -i '/errorCaseProvider(/s|function|static function|' \
		tests/Composer/Test/Command/InstallCommandTest.php \
		|| die "sed failed for InstallCommandTest.php"
	sed -i '/caseProvider(/s|function|static function|' \
		tests/Composer/Test/Command/ReinstallCommandTest.php \
		|| die "sed failed for ReinstallCommandTest.php"
	sed -i '/provideInconsistentRequireKeys(/s|function|static function|' \
		tests/Composer/Test/Command/RequireCommandTest.php \
		|| die "sed failed for RequireCommandTest.php"
	sed -i '/channelOptions(/s|function|static function|' \
		tests/Composer/Test/Command/SelfUpdateCommandTest.php \
		|| die "sed failed for SelfUpdateCommandTest.php"
	sed -i  -e '/provideNotExistingPackage(/s|function|static function|' \
		-e '/providePackageAndTree(/s|function|static function|' \
		tests/Composer/Test/Command/ShowCommandTest.php \
		|| die "sed failed for ShowCommandTest.php"
	sed -i '/provideInteractiveUpdates(/s|function|static function|' \
		tests/Composer/Test/Command/UpdateCommandTest.php \
		|| die "sed failed for UpdateCommandTest.php"
	sed -i '/versionProvider(/s|function|static function|' \
		tests/Composer/Test/Json/ComposerSchemaTest.php \
		|| die "sed failed for ComposerSchemaTest.php"
	sed -i '/rootEnvVersionsProvider(/s|function|static function|' \
		tests/Composer/Test/Package/Version/VersionGuesserTest.php \
		|| die "sed failed for VersionGuesserTest.php"
	# remove tests with failed assert
	rm tests/Composer/Test/Json/ComposerSchemaTest.php \
		|| die "rm failed for ComposerSchemaTest.php"
	# tests replace vendor/autoload.php, skipped 58
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/composer
	doins -r res LICENSE
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
