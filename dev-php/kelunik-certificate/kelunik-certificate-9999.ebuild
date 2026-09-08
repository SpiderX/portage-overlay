# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="Kelunik/Certificate"
PHP_REQ_USE="ssl"

inherit composer git-r3

DESCRIPTION="Access certificate details and transform between different formats"
HOMEPAGE="https://github.com/kelunik/certificate"
EGIT_REPO_URI="https://github.com/kelunik/certificate.git"

LICENSE="MIT"
SLOT="0"

composer_enable_tests phpunit
