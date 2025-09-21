# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo git-r3

DESCRIPTION="Symfony AMQP Messenger"
HOMEPAGE="https://github.com/symfony/amqp-messenger"
EGIT_REPO_URI="https://github.com/symfony/amqp-messenger.git"

LICENSE="MIT"
SLOT="0"
IUSE="test"
RESTRICT="!test? ( test )"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/pecl-amqp
	dev-php/symfony-messenger"
BDEPEND="test? ( dev-php/phpunit
		dev-php/symfony-process
		dev-php/symfony-property-access
		dev-php/symfony-serializer
		net-misc/rabbitmq-server )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	install -D -m 644 "${FILESDIR}"/autoload.php \
		autoload.php || die "install failed"
	install -D -m 644 "${FILESDIR}"/autoload-test.php \
		vendor/autoload.php || die "install test failed"
	# remove test not executes process
	sed -i '/testItReceivesSignals/,+52d' \
		Tests/Transport/AmqpExtIntegrationTest.php \
		|| die "sed failed for AmqpExtIntegrationTest.php"
}

src_test() {
	local -x RABBITMQ_LOG_BASE="${T}/rabbitmq/log"
	local -x RABBITMQ_MNESIA_BASE="${T}/rabbitmq/mnesia"
	local -x RABBITMQ_LOGS="${T}/rabbitmq.log"
	local -x RABBITMQ_PID_FILE="${T}/rabbitmq.pid"
	local -x RABBITMQ_ENABLED_PLUGINS_FILE="${T}/rabbitmq/enabled_plugins"
	edo /usr/libexec/rabbitmq/rabbitmq-server -p 5672:5672 >/dev/null &
	while ! { echo >/dev/tcp/localhost/5672 ; } &> /dev/null; do sleep 1; done
	MESSENGER_AMQP_DSN="amqp://localhost:5672" \
		phpunit --testdox || die "phpunit failed"
	edo kill "$(<"${RABBITMQ_PID_FILE}")"
}

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Component/Messenger/Bridge/Amqp
	doins -r Transport ./*.php
}
