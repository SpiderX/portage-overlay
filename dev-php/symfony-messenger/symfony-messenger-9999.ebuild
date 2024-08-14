# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/messenger.git"

inherit git-r3

DESCRIPTION="Symfony Messenger Component"
HOMEPAGE="https://github.com/symfony/messenger"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-log
	dev-php/symfony-deprecation-contracts
	dev-php/symfony-clock"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-amqp-messenger
		dev-php/symfony-console
		dev-php/symfony-dependency-injection
		dev-php/symfony-doctrine-bridge
		dev-php/symfony-doctrine-messenger
		dev-php/symfony-event-dispatcher
		dev-php/symfony-error-handler
		dev-php/symfony-http-kernel
		dev-php/symfony-phpunit-bridge
		dev-php/symfony-routing
		dev-php/symfony-serializer
		dev-php/symfony-stopwatch
		dev-php/symfony-validator )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# replace deprecated method
	sed -i 's/getInvocationCount/numberOfInvocations/' \
		Tests/Middleware/DispatchAfterCurrentBusMiddlewareTest.php \
		|| die "sed failed for DispatchAfterCurrentBusMiddlewareTest.php"
	# rename object
	sed -i '/assertStringMatchesFormat/s|Mock|MockObject|' \
		Tests/Middleware/SendMessageMiddlewareTest.php \
		|| die "sed failed for SendMessageMiddlewareTest.php"
}

src_test() {
	phpunit --testdox || die "phpunit failed"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Messenger
	doins -r Attribute Command DataCollector DependencyInjection Event \
		EventListener Exception Handler Message Middleware Retry \
		Stamp Test Transport ./*.php
}
