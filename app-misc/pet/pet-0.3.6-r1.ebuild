# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/BurntSushi/toml v0.3.0"
	"github.com/briandowns/spinner 48dbb65d7bd5"
	"github.com/chzyer/readline 2972be24d48e"
	"github.com/fatih/color v1.7.0"
	"github.com/golang/protobuf v1.1.0"
	"github.com/google/go-github v15.0.0"
	"github.com/google/go-querystring 53e6ce116135"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jroimartin/gocui v0.4.0"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-isatty v0.0.3"
	"github.com/mattn/go-runewidth v0.0.2"
	"github.com/nsf/termbox-go 21a4d435a862"
	"github.com/pkg/errors v0.8.0"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/pflag v1.0.1"
	"github.com/xanzy/go-gitlab v0.10.5"
	"golang.org/x/crypto 8ac0e0d97ce4 github.com/golang/crypto"
	"golang.org/x/net 1e491301e022 github.com/golang/net"
	"golang.org/x/oauth2 1e0a3fa8ba9a github.com/golang/oauth2"
	"golang.org/x/sys 9527bec2660b github.com/golang/sys"
	"google.golang.org/appengine v1.0.0 github.com/golang/appengine" )

EGO_PN="github.com/knqyf263/${PN}"

inherit go-module

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/knqyf263/pet"
SRC_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	$(go-module_vendor_uris)"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="zsh-completion"

RDEPEND="zsh-completion? ( app-shells/zsh-completions )"

src_compile() {
	export -n GOCACHE XDG_CACHE_HOME
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	dobin pet

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins misc/completions/zsh/_pet
	fi
}

pkg_postinst() {
	if ! has_version app-shells/peco ; then
		einfo "You should consider to install app-shells/peco"
		einfo "to be able to use selector command"
	fi
}
