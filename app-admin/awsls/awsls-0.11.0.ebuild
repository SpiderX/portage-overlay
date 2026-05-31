# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="7612fb3"
DESCRIPTION="A list command for AWS resources"
HOMEPAGE="https://github.com/jckuester/awsls"
SRC_URI="https://github.com/jckuester/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/SpiderX/portage-overlay/releases/download/${P}/${P}-deps.tar.xz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="test"
RESTRICT="test" # needs network and credentials

BDEPEND="test? ( app-admin/terraform )"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X github.com/jckuester/awsls/internal.version=${PV}
	-X github.com/jckuester/awsls/internal.commit=${COMMIT}
	-X \"github.com/jckuester/awsls/internal.date=${DATE}\""

	ego build -buildmode=pie -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin awsls
}
