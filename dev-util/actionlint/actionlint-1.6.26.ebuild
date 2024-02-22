# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/fatih/color v1.15.0"
	"github.com/fatih/color v1.15.0/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.17/go.mod"
	"github.com/mattn/go-isatty v0.0.19"
	"github.com/mattn/go-isatty v0.0.19/go.mod"
	"github.com/mattn/go-runewidth v0.0.15"
	"github.com/mattn/go-runewidth v0.0.15/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.4"
	"github.com/rivo/uniseg v0.4.4/go.mod"
	"github.com/robfig/cron/v3 v3.0.1"
	"github.com/robfig/cron/v3 v3.0.1/go.mod"
	"github.com/yuin/goldmark v1.5.6"
	"github.com/yuin/goldmark v1.5.6/go.mod"
	"golang.org/x/sync v0.3.0"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.12.0"
	"golang.org/x/sys v0.12.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Static checker for GitHub Actions workflow files"
HOMEPAGE="https://github.com/rhysd/actionlint"
SRC_URI="https://github.com/rhysd/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"
RESTRICT="test"
PROPERTIES="test_network"

BDEPEND="doc? ( app-text/ronn-ng )"

DOCS=( {CHANGELOG,README}.md docs/{checks,config,usage}.md )

src_compile() {
	LDFLAGS="-s -w -X github.com/rhysd/actionlint.version=${PV}"

	go build -ldflags "${LDFLAGS}" ./cmd/actionlint || die "build failed"

	use doc && emake man
}

src_install() {
	einstalldocs
	dobin actionlint
	use doc && doman man/actionlint.1
}
