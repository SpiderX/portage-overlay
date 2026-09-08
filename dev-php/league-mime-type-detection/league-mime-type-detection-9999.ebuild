# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

COMPOSER_INSTALL_PATH="League/MimeTypeDetection"
PHP_REQ_USE="fileinfo"

inherit composer git-r3

DESCRIPTION="League Mime Type Detection"
HOMEPAGE="https://github.com/thephpleague/mime-type-detection"
EGIT_REPO_URI="https://github.com/thephpleague/mime-type-detection.git"

LICENSE="MIT"
SLOT="0"

EPHPUNIT_BOOTSTRAP='vendor/autoload.php'
composer_enable_tests phpunit
