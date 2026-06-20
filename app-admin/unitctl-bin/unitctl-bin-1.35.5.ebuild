# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="FreeUnit CLI"
HOMEPAGE="https://github.com/freeunitorg/freeunit"
SRC_URI="amd64? ( https://github.com/freeunitorg/freeunit/releases/download/${PV}/${P/-bin/}-x86_64-unknown-linux-gnu )
	arm64? ( https://github.com/freeunitorg/freeunit/releases/download/${PV}/${P/-bin/}-aarch64-unknown-linux-gnu )"
S="${WORKDIR}"

LICENSE="Apache-2.0 BSD-2 BSD CDLA-Permissive-2.0 EPL-2.0 ISC MIT openssl Unicode-3.0"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

QA_PREBUILT="usr/bin/unitctl"

src_install() {
	use amd64 && newbin "${DISTDIR}"/unitctl-"${PV}"-x86_64-unknown-linux-gnu unitctl
	use arm64 && newbin "${DISTDIR}"/unitctl-"${PV}"-aarch64-unknown-linux-gnu unitctl
}
