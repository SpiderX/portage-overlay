# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/inconshreveable/mousetrap 76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
	"github.com/pkg/errors 645ef00459ed84a119197bfb8d8205042c6df63d"
	"github.com/spf13/cobra ef82de70bb3f60c65fb8eebacbb2d122ef517385"
	"github.com/spf13/pflag 298182f68c66c05229eb03ac171abe6e309ee79a"
	"github.com/vlct-io/pkg a03a7c08cf76b08899f3423beee8538f851c5e22" )

EGO_PN="github.com/lfaoro/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="CloudFlare DNS backup tool"
HOMEPAGE="https://github.com/lfaoro/flares"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT-with-advertising"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	EGO_PN="${EGO_PN}/cmd/flaredns" \
	golang-build_src_compile
}

src_install() {
	dobin flaredns
}
