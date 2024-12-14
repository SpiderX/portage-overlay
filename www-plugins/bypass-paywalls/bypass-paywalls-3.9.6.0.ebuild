# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Bypass Paywalls browser extension"
HOMEPAGE="https://gitflic.ru/project/magnolia1234/bypass-paywalls-chrome-clean"
SRC_URI="https://gitflic.ru/project/magnolia1234/bpc_uploads/blob/raw?file=${PN}-chrome-clean-${PV}.crx ->
	${PN}-chrome-clean-${PV}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~arm64"
IUSE="chrome +chromium"
REQUIRED_USE="|| ( chrome chromium )"

BDEPEND="app-arch/unzip"

src_unpack() {
	unzip "${DISTDIR}/${A}" || true # crx is not full compatible zip archive
}

src_install() {
	if use chrome ; then
		insinto /usr/share/google-chrome/extensions
		insinto /usr/share/google-chrome/extensions/bypass-paywalls
		doins -r .
	fi
	if use chromium ; then
		insinto /usr/share/chromium/extensions
		insinto /usr/share/chromium/extensions/bypass-paywalls
		doins -r .
	fi
}

pkg_postinst() {
	einfo "After installing, add the folder"
	einfo "/usr/share/{chrome,chromium}/bypass-paywalls as an unpacked extension"
}
