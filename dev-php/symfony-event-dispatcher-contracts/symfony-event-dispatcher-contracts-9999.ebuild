# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A set of event dispatcher abstractions"
HOMEPAGE="https://github.com/symfony/event-dispatcher-contracts"
EGIT_REPO_URI="https://github.com/symfony/event-dispatcher-contracts.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-event-dispatcher"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/EventDispatcher
	doins -r "${FILESDIR}"/autoload.php ./*.php
}
