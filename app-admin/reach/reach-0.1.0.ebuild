# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=(
	"github.com/aws/aws-sdk-go v1.16.5"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jmespath/go-jmespath c2b33e8439af"
	"github.com/mattn/go-colorable v0.1.1"
	"github.com/mattn/go-isatty v0.0.5"
	"github.com/mgutz/ansi 9520e82c474b"
	"github.com/nu7hatch/gouuid 179d4d0c4d8d"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/pflag v1.0.3"
	"golang.org/x/sys a9d3bda3a223 github.com/golang/sys"
)
EGO_PN="github.com/luhring/${PN}"

inherit golang-build golang-vcs-snapshot

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=dev-lang/go-1.13:="

src_install() {
	einstalldocs
	dobin reach
}
