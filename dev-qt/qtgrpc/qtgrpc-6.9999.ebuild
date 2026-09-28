# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qt6-build

DESCRIPTION="Protobuf and gRPC support for Qt"

if [[ ${QT6_BUILD_TYPE} == release ]]; then
	KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~loong ~ppc ~ppc64 ~riscv ~x86"
fi

IUSE="gui qml"

RDEPEND="~dev-qt/qtbase-${PV}:6[gui?,network]
	dev-libs/protobuf:=
	qml? ( ~dev-qt/qtdeclarative-${PV}:6 )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		"$(qt_feature gui protobuf_qtguitypes)"
		"$(qt_feature qml protobufquick)"
		"$(qt_feature qml grpcquick)"
	)

	qt6-build_src_configure
}
