# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

MY_PN="${PN//symfony-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Symfony AMQP Messenger"
HOMEPAGE="https://github.com/symfony/amqp-messenger"
SRC_URI="https://github.com/symfony/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/pecl-amqp
	dev-php/symfony-messenger"
BDEPEND="test? ( dev-php/composer
		dev-php/phpunit
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
}

src_test() {
	composer require -d "${T}" --prefer-source \
		--dev "${PN/-/\/}:${PV}" || die "composer failed"
	cp -r "${T}"/vendor/"${PN/-/\/}"/{phpunit.xml.dist,Tests} "${S}" \
		|| die "cp failed"
	# remove test not executes process
	sed -i '/testItReceivesSignals/,+52d' \
		Tests/Transport/AmqpExtIntegrationTest.php \
		|| die "sed failed for AmqpExtIntegrationTest.php"
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
