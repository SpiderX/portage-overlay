# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/gdamore/tcell v1.4.0"
	"github.com/gdamore/tcell v1.4.0/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/mattn/go-isatty v0.0.3"
	"github.com/mattn/go-isatty v0.0.3/go.mod"
	"github.com/mattn/go-runewidth v0.0.7"
	"github.com/mattn/go-runewidth v0.0.7/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/spf13/pflag v1.0.3"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756/go.mod"
	"golang.org/x/sys v0.0.0-20201029080932-201ba4db2418"
	"golang.org/x/sys v0.0.0-20201029080932-201ba4db2418/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.4"
	"golang.org/x/text v0.3.4/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	)
go-module_set_globals

DESCRIPTION="Tool for writing Linux pipes with instant live preview"
HOMEPAGE="https://github.com/akavel/up"
SRC_URI="https://github.com/akavel/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build
}

src_test() {
	ego test
}

src_install() {
	einstalldocs
	dobin up
}
