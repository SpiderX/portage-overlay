# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_PN="${PN}-chrome"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Bypass Paywalls browser extension"
HOMEPAGE="https://github.com/iamadamdev/bypass-paywalls-chrome"
SRC_URI="https://github.com/iamadamdev/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.gh.tar.gz"

LICENSE="all-rights-reserved"
KEYWORDS="~amd64 ~arm64"
SLOT="0"
IUSE="+chrome chromium"
REQUIRED_USE="|| ( chrome chromium )"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	cat > dcpihecpambacapedldabdbpakmachpb.json <<EOF
{
	"external_update_url": "https://raw.githubusercontent.com/iamadamdev/${MY_P}/master/src/updates/updates.xml"
}
EOF
}

src_install() {
	if use chrome; then
		insinto /usr/share/google-chrome/extensions
		doins dcpihecpambacapedldabdbpakmachpb.json
		insinto /usr/share/google-chrome/extensions/bypass-paywalls
		doins -r .
	fi
	if use chromium; then
		insinto /usr/share/chromium/extensions
		doins dcpihecpambacapedldabdbpakmachpb.json
		insinto /usr/share/chromium/extensions/bypass-paywalls
		doins -r .
	fi
}

pkg_postinst() {
	einfo "After installing, add the folder"
	einfo "/usr/share/{chrome,chromium}/bypass-paywalls as an unpacked extension"
}
