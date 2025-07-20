# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PLOCALES="et ru"
PLOCALE_BACKUP="ru"

inherit cmake plocale

DESCRIPTION="Digital signing and encrypting documents"
HOMEPAGE="https://github.com/open-eid/DigiDoc4-Client"
EGIT_REPO_URI="https://github.com/open-eid/DigiDoc4-Client.git"
SRC_URI="https://sr.riik.ee/tsl/estonian-tsl.xml -> EE.xml
	https://ec.europa.eu/tools/lotl/eu-lotl.xml
	https://id.eesti.ee/config.json
	https://id.eesti.ee/config.rsa
	https://id.eesti.ee/config.pub"

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
	sys-libs/zlib:=
	gnome? ( gnome-base/nautilus
		sys-devel/gettext )"
DEPEND="${RDEPEND}"
BDEPEND="dev-qt/qttools:6[linguist]
	virtual/pkgconfig"

src_prepare() {
	default

	rmdir common || die "rmdir failed"
	ln -s ../qt-common-"${QTC_COMMIT}" common \
		|| die "ln failed for common"

	cp "${FILESDIR}"/TSL.qrc "${S}"/client/ \
		|| die "cp failed for TSL.qrc"
	cp "${DISTDIR}"/{EE,eu-lotl}.xml "${S}"/client/ \
		|| die "cp failed for xml"
	cp "${DISTDIR}"/config.{json,rsa,pub} "${S}"/common/ \
		|| die "cp failed for common"

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
