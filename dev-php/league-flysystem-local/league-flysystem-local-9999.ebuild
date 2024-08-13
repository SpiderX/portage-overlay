# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

EGIT_REPO_URI="https://github.com/thephpleague/flysystem-local.git"

inherit git-r3

DESCRIPTION="Sub-split of Flysystem for local file storage"
HOMEPAGE="https://github.com/thephpleague/flysystem-local"

LICENSE="MIT"
SLOT="0"
RESTRICT="test" # no phpunit.xml

RDEPEND="dev-lang/php:*[fileinfo]
	dev-php/fedora-autoloader
	dev-php/league-mime-type-detection"
# circular — dev-php/league-flysystem

src_install() {
	einstalldocs
	insinto /usr/share/php/League/Flysystem/Local
	doins -r "${FILESDIR}"/autoload.php \
		FallbackMimeTypeDetector.php LocalFilesystemAdapter.php
}
