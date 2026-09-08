# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Symfony/Component/Messenger/Bridge/Amqp"
COMPOSER_INSTALL_SRC="."

inherit composer

DESCRIPTION="Symfony AMQP Messenger"
HOMEPAGE="https://github.com/symfony/amqp-messenger"
SRC_URI="https://github.com/symfony/${COMPOSER_PKG}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="dev-php/pecl-amqp
	dev-php/symfony-messenger"
BDEPEND="test? ( dev-php/symfony-event-dispatcher
		dev-php/symfony-process
		dev-php/symfony-property-access
		dev-php/symfony-serializer
		net-misc/rabbitmq-server )"

DOCS=( {CHANGELOG,README}.md )

composer_enable_tests phpunit

src_test() {
	composer_prepare_tests
	local -x RABBITMQ_LOG_BASE="${T}/rabbitmq/log"
	local -x RABBITMQ_MNESIA_BASE="${T}/rabbitmq/mnesia"
	local -x RABBITMQ_LOGS="${T}/rabbitmq.log"
	local -x RABBITMQ_PID_FILE="${T}/rabbitmq.pid"
	local -x RABBITMQ_ENABLED_PLUGINS_FILE="${T}/rabbitmq/enabled_plugins"
	local -x MESSENGER_AMQP_DSN="amqp://localhost:5672"
	edo /usr/libexec/rabbitmq/rabbitmq-server >/dev/null &
	while ! { echo >/dev/tcp/localhost/5672 ; } &> /dev/null ; do sleep 1 ; done
	ephpunit
	edo kill "$(<"${RABBITMQ_PID_FILE}")"
}
