# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo

MY_PN="${PN%-bin}"
MY_URI="https://github.com/${MY_PN}/${MY_PN}/releases/download/v${PV}/${MY_PN}"

DESCRIPTION="Dockerfile linter, validate inline bash"
HOMEPAGE="https://github.com/hadolint/hadolint"
SRC_URI="
	amd64? ( ${MY_URI}-linux-x86_64 )
	arm64? ( ${MY_URI}-linux-arm64 )
"
S="${WORKDIR}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="-* ~amd64 ~arm64"

RDEPEND="!dev-util/hadolint"

QA_PREBUILT="usr/bin/hadolint"

src_unpack() {
	use amd64 && edo cp "${DISTDIR}"/hadolint-linux-x86_64 ./hadolint
	use arm64 && edo cp "${DISTDIR}"/hadolint-linux-arm64 ./hadolint
}

src_install() {
	dobin hadolint
}
