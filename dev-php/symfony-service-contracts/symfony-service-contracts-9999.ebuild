# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3

DESCRIPTION="A set of service abstractions"
HOMEPAGE="https://github.com/symfony/service-contracts"
EGIT_REPO_URI="https://github.com/symfony/service-contracts.git"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # tests here https://github.com/symfony/contracts/tree/main/Tests/Service

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-container
	dev-php/symfony-deprecation-contracts"

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/Service
	doins -r Attribute Test "${FILESDIR}"/autoload.php ./*.php
}
