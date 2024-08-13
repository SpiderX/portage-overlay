# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN//league-/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Sub-split of Flysystem for local file storage"
HOMEPAGE="https://github.com/thephpleague/flysystem-local"
SRC_URI="https://github.com/thephpleague/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
