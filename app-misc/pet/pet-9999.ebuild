# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

EGO_VENDOR=( "github.com/SpiderX/portage-empty 3f4db1eb10e4dc42584b6b3df23f037904e6ea07"
	"github.com/BurntSushi/toml v0.3.0"
	"github.com/briandowns/spinner 48dbb65d7bd5c74ab50d53d04c949f20e3d14944"
	"github.com/chzyer/readline 2972be24d48e78746da79ba8e24e8b488c9880de"
	"github.com/fatih/color v1.7.0"
	"github.com/google/go-github v15.0.0"
	"github.com/inconshreveable/mousetrap v1.0.0"
	"github.com/jroimartin/gocui v0.4.0"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-isatty v0.0.3"
	"github.com/mattn/go-runewidth v0.0.2"
	"github.com/nsf/termbox-go 21a4d435a86280a2927985fd6296de56cbce453e"
	"github.com/pkg/errors v0.8.0"
	"github.com/spf13/cobra v0.0.3"
	"github.com/spf13/pflag v1.0.1"
	"github.com/xanzy/go-gitlab v0.10.5"
	"golang.org/x/crypto 8ac0e0d97ce45cd83d1d7243c060cb8461dda5e9 github.com/golang/crypto"
	"golang.org/x/net 1e491301e022f8f977054da4c2d852decd59571f github.com/golang/net"
	"golang.org/x/oauth2 1e0a3fa8ba9a5c9eb35c271780101fdaf1b205d7 github.com/golang/oauth2"
	"golang.org/x/sys 9527bec2660bd847c050fda93a0f0c6dee0800bb github.com/golang/sys"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	"google.golang.org/appengine v1.0.0 github.com/golang/appengine" )

EGO_PN="github.com/knqyf263/${PN}"
EGIT_REPO_URI="https://${EGO_PN}.git"
EGIT_CHECKOUT_DIR="${WORKDIR}/${P}/src/${EGO_PN}"

inherit git-r3 golang-build golang-vcs-snapshot

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/knqyf263/pet"
SRC_URI="${EGO_VENDOR_URI}"

LICENSE="Apache-2.0 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS=""
IUSE="zsh-completion"

RDEPEND="zsh-completion? ( app-shells/zsh-completions )"

src_unpack() {
	git-r3_src_unpack
	golang-vcs-snapshot_src_unpack
}

src_install() {
	dobin pet

	if use zsh-completion ; then
		insinto /usr/share/zsh/site-functions
		doins src/github.com/knqyf263/pet/misc/completions/zsh/_pet
	fi
}

pkg_postinst() {
	if ! has_version app-shells/peco ; then
		einfo "You should consider to install app-shells/peco"
		einfo "to be able to use selector command"
	fi
}
