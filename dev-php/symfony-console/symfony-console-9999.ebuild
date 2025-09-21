# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="Eases the creation of beautiful and testable command line interfaces"
HOMEPAGE="https://github.com/symfony/console"
EGIT_REPO_URI="https://github.com/symfony/console.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-polyfill-mbstring
	dev-php/symfony-service-contracts
	dev-php/symfony-string"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
		dev-php/psr-log
		dev-php/symfony-dependency-injection
		dev-php/symfony-event-dispatcher
		dev-php/symfony-lock
		dev-php/symfony-messenger
		dev-php/symfony-phpunit-bridge
		>=dev-php/symfony-process-6
		dev-php/symfony-stopwatch
		dev-php/symfony-var-dumper )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install failed"
}
src_test() {
	# skipped - testSttyOnWindows, needs tty, without it skipped 16
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Console
	doins -r Attribute CI Command CommandLoader Completion DataCollector \
		Debug DependencyInjection Descriptor Event EventListener \
		Exception Formatter Helper Input Logger Messenger Output \
		Question Resources SignalRegistry Style Tester ./*.php
}
