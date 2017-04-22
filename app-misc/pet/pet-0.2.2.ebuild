# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_VENDOR=( "github.com/BurntSushi/toml bbd5bb678321a0d6e58f1099321dfa73391c1b6f"
	"github.com/chzyer/readline 41eea22f717c616615e1e59aa06cf831f9901f35"
	"github.com/fatih/color 9131ab34cf20d2f6d83fdc67168a5430d1c7dc23"
	"github.com/google/go-github d683a1c6198d75c6be7a7ab5e2f9834cb6408834"
	"github.com/google/go-querystring 53e6ce116135b80d037921a7fdd5138cf32d7a8a"
	"github.com/inconshreveable/mousetrap 76626ae9c91c4f2a10f34cad8ce83ea42c93bb75"
	"github.com/jroimartin/gocui 612b0b2987ec1a6af46d7008cef1efd4b3898346"
	"github.com/mattn/go-colorable 5411d3eea5978e6cdc258b30de592b60df6aba96"
	"github.com/mattn/go-isatty 57fdcb988a5c543893cc61bce354a6e24ab70022"
	"github.com/mattn/go-runewidth 9e777a8366cce605130a531d2cd6363d07ad7317"
	"github.com/nsf/termbox-go 7994c181db7761ca3c67a217068cf31826113f5f"
	"github.com/spf13/cobra 7be4beda01ec05d0b93d80b3facd2b6f44080d94"
	"github.com/spf13/pflag d16db1e50e33dff1b6cdf37596cef36742128670"
	"google.golang.org/appengine 56d253d1dd14aa01937e12c73a0971bcfd797ff2 github.com/golang/appengine" )

EGO_PN="github.com/knqyf263/${PN}"

inherit golang-build golang-vcs-snapshot

ARCHIVE_URI="https://${EGO_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

DESCRIPTION="Simple command-line snippet manager"
HOMEPAGE="https://github.com/knqyf263/pet"
SRC_URI="${ARCHIVE_URI}
	${EGO_VENDOR_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

# dev-go/toml doesn't provide sources
DEPEND="dev-go/glide
	dev-go/go-crypto
	dev-go/go-net
	dev-go/go-oauth2
	dev-go/go-protobuf
	dev-go/go-sys"

src_install() {
	dobin pet
}

pkg_postinstall() {
	einfo "You should consider to install app-shells/peco to be able to use selector command"
}
