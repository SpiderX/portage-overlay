# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/PuerkitoBio/goquery v1.5.1"
	"github.com/PuerkitoBio/goquery v1.5.1/go.mod"
	"github.com/alessio/shellescape v1.2.2"
	"github.com/alessio/shellescape v1.2.2/go.mod"
	"github.com/andybalholm/cascadia v1.1.0/go.mod"
	"github.com/andybalholm/cascadia v1.2.0"
	"github.com/andybalholm/cascadia v1.2.0/go.mod"
	"github.com/fatih/color v1.9.0"
	"github.com/fatih/color v1.9.0/go.mod"
	"github.com/jroimartin/gocui v0.4.0"
	"github.com/jroimartin/gocui v0.4.0/go.mod"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-colorable v0.1.6"
	"github.com/mattn/go-colorable v0.1.6/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mattn/go-isatty v0.0.12"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/nsf/termbox-go v0.0.0-20200418040025-38ba6e5628f1"
	"github.com/nsf/termbox-go v0.0.0-20200418040025-38ba6e5628f1/go.mod"
	"github.com/nwidger/jsoncolor v0.3.0"
	"github.com/nwidger/jsoncolor v0.3.0/go.mod"
	"github.com/tidwall/gjson v1.6.0"
	"github.com/tidwall/gjson v1.6.0/go.mod"
	"github.com/tidwall/match v1.0.1"
	"github.com/tidwall/match v1.0.1/go.mod"
	"github.com/tidwall/pretty v1.0.0/go.mod"
	"github.com/tidwall/pretty v1.0.1"
	"github.com/tidwall/pretty v1.0.1/go.mod"
	"github.com/x86kernel/htmlcolor v0.0.0-20190529101448-c589f58466d0"
	"github.com/x86kernel/htmlcolor v0.0.0-20190529101448-c589f58466d0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/net v0.0.0-20180218175443-cbe0f9307d01/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20200602114024-627f9648deb9"
	"golang.org/x/net v0.0.0-20200602114024-627f9648deb9/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20200323222414-85ca7c5b95cd/go.mod"
	"golang.org/x/sys v0.0.0-20200602225109-6fdc65e7d980"
	"golang.org/x/sys v0.0.0-20200602225109-6fdc65e7d980/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="Interactive cli tool for HTTP inspection"
HOMEPAGE="https://github.com/asciimoo/wuzz"
SRC_URI="https://github.com/asciimoo/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="AGPL-3 BSD BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PATCHES=( "${FILESDIR}/${P}"-go.sum.patch )

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test || die "test failed"
}

src_install() {
	einstalldocs
	dobin wuzz
	dodoc sample-config.toml
}
