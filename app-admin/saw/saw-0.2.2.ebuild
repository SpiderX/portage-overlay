# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/TylerBrock/colorjson 95ec53f28296f47af86a81eb73f0d7fe2b23a322"
	"github.com/aws/aws-sdk-go 854f9d07a932452f1552955e127e50ba5ebb25cc"
	"github.com/fatih/color 5b77d2a35fb0ede96d138fc9a99f5c9b6aef11b4"
	"github.com/go-ini/ini 06f5f3d67269ccec1fe5fe4134ba6e982984f7f5"
	"github.com/inconshreveable/mousetrap 76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
	"github.com/jmespath/go-jmespath 0b12d6b5"
	"github.com/mattn/go-colorable 167de6bfdfba052fa6b2d3664c8f5272e23c9072"
	"github.com/mattn/go-isatty 0360b2af4f38e8d38c7fce2a9f4e702702d73a39"
	"github.com/spf13/cobra ef82de70bb3f60c65fb8eebacbb2d122ef517385"
	"github.com/spf13/pflag 583c0c0531f06d5278b7d917446061adc344b5cd" )

EGO_PN="github.com/TylerBrock/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="Fast, multi-purpose tool for AWS CloudWatch Logs"
HOMEPAGE="https://github.com/TylerBrock/saw"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-go/go-sys:="
RDEPEND="${DEPEND}"

DOCS=( src/"${EGO_PN}"/{CHANGELOG,README}.md )

src_install() {
	einstalldocs
	dobin saw
}
