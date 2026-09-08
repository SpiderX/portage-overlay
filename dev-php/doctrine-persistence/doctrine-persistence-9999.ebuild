# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Doctrine"

inherit composer git-r3

DESCRIPTION="Doctrine Persistence"
HOMEPAGE="https://github.com/doctrine/persistence"
EGIT_REPO_URI="https://github.com/doctrine/persistence.git"

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-php/doctrine-event-manager
	dev-php/psr-cache"
BDEPEND="test? ( dev-php/doctrine-common
		dev-php/symfony-cache )"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit

src_prepare() {
	composer_src_prepare

	edo mkdir src/Persistence
	edo phpab -q -o src/Persistence/autoload.php -t "${FILESDIR}"/autoload.php.tpl src
}
