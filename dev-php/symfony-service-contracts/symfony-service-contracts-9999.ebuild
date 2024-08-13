# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/symfony/service-contracts.git"

inherit git-r3

DESCRIPTION="A set of service abstractions"
HOMEPAGE="https://github.com/symfony/service-contracts"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no tests

RDEPEND="dev-lang/php:*
	dev-php/fedora-autoloader
	dev-php/psr-container
	dev-php/symfony-deprecation-contracts"

# remove non-existed method in PHPUnit
PATCHES=( "${FILESDIR}/${PN}"-3.5.0-test.patch )

DOCS=( {CHANGELOG,README}.md )

src_install() {
	einstalldocs
	insinto /usr/share/php/Symfony/Contracts/Service
	doins -r Attribute Test "${FILESDIR}"/autoload.php ./*.php
}
