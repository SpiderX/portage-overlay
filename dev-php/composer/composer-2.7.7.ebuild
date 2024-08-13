# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo shell-completion

DESCRIPTION="Dependency Manager for PHP"
HOMEPAGE="https://github.com/composer/composer"
SRC_URI="https://github.com/composer/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*[intl,curl]
	dev-php/ca-bundle
	dev-php/composer-class-map-generator
	dev-php/composer-pcre
	dev-php/composer-semver
	dev-php/fedora-autoloader
	dev-php/jsonlint
	dev-php/json-schema
	dev-php/metadata-minifier
	dev-php/phar-utils
	dev-php/psr-log
	dev-php/reactphp-promise
	dev-php/seld-signal-handler
	dev-php/spdx-licenses
	dev-php/symfony-console
	dev-php/symfony-filesystem
	dev-php/symfony-finder
	dev-php/symfony-polyfill-php80
	dev-php/symfony-polyfill-php81
	>=dev-php/symfony-process-6.4.8
	dev-php/xdebug-handler"
BDEPEND="dev-php/theseer-Autoload
	test? ( dev-php/composer
		dev-php/phpunit )"

src_prepare() {
	default

	sed -i '/includeIfExists/s|: ?ClassLoader||' src/bootstrap.php \
		|| die "sed failed for src/bootstrap.php"
	mkdir vendor || die "mkdir failed"
	phpab -q -o vendor/autoload.php -t "${FILESDIR}"/autoload.php.tpl src \
		|| die "phpab failed"
	eapply "${FILESDIR}/${PN}"-2.7.7-autoload.patch
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
		--dev composer/"${PN}":"${PV}" || die "composer failed"
	# move tests and docs tests need into work dir
	cp -r "${T}"/vendor/composer/"${PN}"/{doc,phpunit.xml.dist,tests} "${S}" \
		|| die "cp doc,tests failed"
	# remove tests
	rm tests/Composer/Test/Util/NoProxyPatternTest.php \
		tests/Composer/Test/Command/DumpAutoloadCommandTest.php \
		tests/Composer/Test/ApplicationTest.php \
		tests/Composer/Test/CompletionFunctionalTest.php \
		tests/Composer/Test/Command/DiagnoseCommandTest.php \
		tests/Composer/Test/Command/BumpCommandTest.php \
		tests/Composer/Test/Command/ValidateCommandTest.php \
		|| die "rm failed"
	# exclude from classmap, as in composer.json
	phpab   -e "tests/Composer/Test/Fixtures/*" \
		-e "tests/Composer/Test/Autoload/Fixtures/*" \
		-e "tests/Composer/Test/Autoload/MinimumVersionSupport/*" \
		-e "tests/Composer/Test/Plugin/Fixtures/*" -o tests/autoload.php \
		-t fedora2 tests/Composer/Test || die "phpab test failed"
	# add needed classes into autoload
	sed -i "/autoload.php/arequire_once '/usr/share/php/SebastianBergmann/ObjectReflector/autoload.php';" \
		tests/autoload.php || die "sed failed for tests/autoload.php"
	sed -i "/bootstrap.php/arequire __DIR__.'/autoload.php';" tests/bootstrap.php \
		|| die "sed failed for tests/bootstrap.php"
	phpunit --exclude-group "slow" || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/composer
	doins -r res src vendor LICENSE
	exeinto /usr/share/composer/bin
	doexe bin/composer
	dosym ../share/composer/bin/composer /usr/bin/composer
	newbashcomp composer.bash composer
	newfishcomp composer.fish composer
	newzshcomp composer.zsh _composer
}
