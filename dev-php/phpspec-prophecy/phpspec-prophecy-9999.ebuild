# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_AUTOLOAD="src/Prophecy"
COMPOSER_INSTALL_PATH="phpspec"

inherit composer git-r3

DESCRIPTION="Highly opinionated mocking framework for PHP"
HOMEPAGE="https://github.com/phpspec/prophecy"
EGIT_REPO_URI="https://github.com/phpspec/prophecy.git"

LICENSE="MIT"
SLOT="0"

RDEPEND=">=dev-php/doctrine-instantiator-2.1.0
	dev-php/phpdocumentor-reflection-docblock
	dev-php/sebastian-comparator
	dev-php/sebastian-recursion-context
	dev-php/symfony-deprecation-contracts"

composer_enable_tests phpunit
