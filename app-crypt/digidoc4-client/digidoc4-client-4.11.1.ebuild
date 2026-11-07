# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="et"

inherit cmake edo plocale xdg

CDOC_COMMIT="b0070148a4da1ab629fed6dc2ca89094c56a003a"
# Pin qt-common before commit 5118d29, which removed QtSingleApplication.
# DigiDoc4-Client 4.11.1 still depends on the removed implementation.
QTC_COMMIT="f74815645e904557a09ae055885a658006811e89"
MY_PN="DigiDoc4-Client"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Digital signing and encrypting documents"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
SRC_URI="https://github.com/open-eid/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
	https://github.com/open-eid/libcdoc/archive/${CDOC_COMMIT}.tar.gz -> ${MY_P}-libcdoc.tar.gz
	https://github.com/open-eid/qt-common/archive/${QTC_COMMIT}.tar.gz -> ${MY_P}-qtc.tar.gz
	https://sr.riik.ee/tsl/estonian-tsl.xml -> EE.xml
	https://ec.europa.eu/tools/lotl/eu-lotl.xml
	https://id.eesti.ee/config.json
	https://id.eesti.ee/config.ecc
	https://id.eesti.ee/config.ecpub"
S="${WORKDIR}/${MY_P}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64"
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

	edo rmdir common client/libcdoc
	edo ln -s ../../libcdoc-"${CDOC_COMMIT}" client/libcdoc
	edo ln -s ../qt-common-"${QTC_COMMIT}" common

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
