# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="b2f01a1"
EGO_SUM=(
	"github.com/IGLOU-EU/go-wildcard v1.0.3"
	"github.com/IGLOU-EU/go-wildcard v1.0.3/go.mod"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1"
	"github.com/aymanbagabas/go-osc52/v2 v2.0.1/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.6.8"
	"github.com/jedib0t/go-pretty/v6 v6.6.8/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.2.0"
	"github.com/lucasb-eyer/go-colorful v1.2.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-runewidth v0.0.16"
	"github.com/mattn/go-runewidth v0.0.16/go.mod"
	"github.com/muesli/mango v0.2.0"
	"github.com/muesli/mango v0.2.0/go.mod"
	"github.com/muesli/roff v0.1.0"
	"github.com/muesli/roff v0.1.0/go.mod"
	"github.com/muesli/termenv v0.16.0"
	"github.com/muesli/termenv v0.16.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.35.0"
	"golang.org/x/sys v0.35.0/go.mod"
	"golang.org/x/term v0.34.0"
	"golang.org/x/term v0.34.0/go.mod"
	"golang.org/x/text v0.22.0"
	"golang.org/x/text v0.22.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Disk Usage/Free Utility"
HOMEPAGE="https://github.com/muesli/duf"
SRC_URI="https://github.com/muesli/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	LDFLAGS="-X main.Version=${PV} -X main.CommitSHA=${COMMIT}"

	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin duf
	doman duf.1
}
