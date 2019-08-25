# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/alecthomas/template a0175ee3bccc567396460bf5acd36800cb10c49c"
	"github.com/alecthomas/units 2efee857e7cfd4f3d0138cc3cbb1b4966962b93a"
	"github.com/aws/aws-sdk-go 0bdd50bfa501fa6d8d6db0c2bf2c634fc534d9a1"
	"github.com/gopherjs/gopherjs 3e4dfb77656c424b6d1196a4d5fed0fcf63677cc"
	"github.com/mitchellh/go-homedir af06845cf3004701891bf4fdb884bfe4920b3727"
	"github.com/skratchdot/open-golang 79abb63cd66e41cb1473e26d11ebdcd68b04c8e5"
	"github.com/smartystreets/assertions d380eccd517d419eb73a0a90cc3ffc405f1e029e"
	"github.com/smartystreets/goconvey 68dc04aab96ae4326137d6b77330c224063a927e"
	"gopkg.in/alecthomas/kingpin.v2 947dcec5ba9c011838740e680966fd7087a71d0d github.com/alecthomas/kingpin"
	"gopkg.in/ini.v1 8659100d2d9ecf3760a41838b1886db49426d001 github.com/go-ini/ini" )
EGO_PN="github.com/99designs/${PN}"

inherit bash-completion-r1 golang-build golang-vcs-snapshot

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion zsh-completion"

DEPEND="dev-go/go-crypto:=
	dev-go/go-net:=
	dev-go/go-sys:=
	dev-go/go-text:=
	dev-go/keyring"
RDEPEND="${DEPEND}
	bash-completion? ( app-shells/bash-completion )
	zsh-completion? ( app-shells/zsh-completions )"

DOCS=( src/"${EGO_PN}"/README.md src/"${EGO_PN}"/USAGE.md )

src_install() {
	einstalldocs
	dobin aws-vault

	use bash-completion && dobashcomp src/"${EGO_PN}"/completions/bash/aws-vault
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins src/"${EGO_PN}"/completions/zsh/_aws-vault
	fi
}
