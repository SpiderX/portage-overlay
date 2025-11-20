# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

EGO_SUM=(
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/creack/pty v1.1.24"
	"github.com/creack/pty v1.1.24/go.mod"
	"github.com/go-quicktest/qt v1.101.0"
	"github.com/go-quicktest/qt v1.101.0/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/google/renameio/v2 v2.0.0"
	"github.com/google/renameio/v2 v2.0.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/rogpeppe/go-internal v1.14.1"
	"github.com/rogpeppe/go-internal v1.14.1/go.mod"
	"golang.org/x/sys v0.33.0"
	"golang.org/x/sys v0.33.0/go.mod"
	"golang.org/x/term v0.32.0"
	"golang.org/x/term v0.32.0/go.mod"
	"golang.org/x/tools v0.31.0"
	"golang.org/x/tools v0.31.0/go.mod"
	"mvdan.cc/editorconfig v0.3.0"
	"mvdan.cc/editorconfig v0.3.0/go.mod"
	)
go-module_set_globals

MY_PN="${PN/fmt/}"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="A shell parser, formatter, and interpreter with bash support"
HOMEPAGE="https://github.com/mvdan/sh"
SRC_URI="https://github.com/mvdan/${MY_PN}/archive/v${PV}.tar.gz -> ${MY_P}.tar.gz
	${EGO_SUM_SRC_URI}"
S="${WORKDIR}/${MY_P}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+man"

BDEPEND="man? ( app-text/scdoc )"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	LDFLAGS="-s -w -X main.version=${PV}"

	ego build -ldflags "${LDFLAGS}" ./cmd/shfmt

	use man && edo scdoc < cmd/shfmt/shfmt.1.scd > shfmt.1
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin shfmt
	use man && doman shfmt.1
}
