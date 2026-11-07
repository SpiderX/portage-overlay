# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="et"

inherit cmake edo plocale xdg

DESCRIPTION="Digital signing and encrypting documents"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
EGIT_REPO_URI="https://github.com/open-eid/DigiDoc4-Client.git"
SRC_URI="https://sr.riik.ee/tsl/estonian-tsl.xml -> EE.xml
	https://ec.europa.eu/tools/lotl/eu-lotl.xml
	https://id.eesti.ee/config.json
	https://id.eesti.ee/config.ecc
	https://id.eesti.ee/config.ecpub"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="gnome"

RDEPEND="dev-libs/flatbuffers:=
	dev-libs/libdigidocpp
	dev-libs/openssl:0=
	dev-qt/qtbase:6=[network,widgets]
	dev-qt/qtsvg:6=
	net-nds/openldap
	sys-apps/pcsc-lite
	virtual/zlib:0=
	gnome? ( gnome-base/nautilus
		sys-devel/gettext )"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

src_prepare() {
	default

	edo cp "${FILESDIR}"/TSL.qrc "${S}"/client/
	edo cp "${DISTDIR}"/{EE,eu-lotl}.xml "${S}"/client/
	edo cp "${DISTDIR}"/config.{json,ecc,ecpub} "${S}"/common/

	my_rm_loc() {
		rm extensions/nautilus/po/"${1}".po \
			|| die "rm failed for ${1}.po"
		rm client/translations/"${1}".ts \
			|| die "rm failed for ${1}.ts"
	}
	plocale_for_each_disabled_locale my_rm_loc

	cmake_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_NAUTILUS_EXTENSION="$(usex gnome)"
	)
	cmake_src_configure
}
