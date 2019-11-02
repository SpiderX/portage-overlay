# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/99designs/keyring v1.1.3"
	"github.com/alecthomas/template fb15b899a751"
	"github.com/alecthomas/units f65c72e2690d"
	"github.com/aws/aws-sdk-go v1.25.17"
	"github.com/danieljoos/wincred v1.0.2"
	"github.com/dvsekhvalnov/jose2go 7f401d37b68a"
	"github.com/godbus/dbus 4481cbc300e2"
	"github.com/gsterjov/go-libsecret a6f4afe4910c"
	"github.com/jmespath/go-jmespath c2b33e8439af"
	"github.com/keybase/go-keychain 1c06e666bc46"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/skratchdot/open-golang 79abb63cd66e"
	"golang.org/x/crypto 87dc89f01550 github.com/golang/crypto"
	"golang.org/x/sys f8518d3b3627 github.com/golang/sys"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6 github.com/alecthomas/kingpin"
	"gopkg.in/ini.v1 v1.49.0 github.com/go-ini/ini" )
EGO_PN="github.com/99designs/${PN}"

inherit bash-completion-r1 go-module

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="bash-completion fish-completion zsh-completion"

RDEPEND="bash-completion? ( app-shells/bash-completion )
	fish-completion? ( app-shells/fish )
	zsh-completion? ( app-shells/zsh-completions )"

DOCS=( {README,USAGE}.md )

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build -o ./bin/"${PN}" || die "build failed"
}

src_install() {
	einstalldocs
	dobin bin/aws-vault

	use bash-completion && dobashcomp completions/bash/aws-vault
	if use fish-completion ; then
		insinto /usr/share/fish/completion
		newins completions/fish/aws-vault.fish aws-vault
	fi
	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins completions/zsh/_aws-vault
	fi
}
