# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

EGO_SUM=(
	"github.com/fatih/color v1.7.0"
	"github.com/fatih/color v1.7.0/go.mod"
	"github.com/mattn/go-colorable v0.0.9"
	"github.com/mattn/go-colorable v0.0.9/go.mod"
	"github.com/mattn/go-isatty v0.0.4"
	"github.com/mattn/go-isatty v0.0.4/go.mod"
	"github.com/nwidger/jsoncolor v0.0.0-20170215171346-75a6de4340e5"
	"github.com/nwidger/jsoncolor v0.0.0-20170215171346-75a6de4340e5/go.mod"
	"github.com/pkg/errors v0.8.0"
	"github.com/pkg/errors v0.8.0/go.mod"
	"golang.org/x/sys v0.0.0-20220412211240-33da011f77ad"
	"golang.org/x/sys v0.0.0-20220412211240-33da011f77ad/go.mod"
	)
go-module_set_globals

DESCRIPTION="Make JSON greppable"
HOMEPAGE="https://github.com/tomnomnom/gron"
SRC_URI="https://github.com/tomnomnom/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {ADVANCED,CHANGELOG,README}.mkd )

src_compile() {
	LDFLAGS="-X main.gronVersion=${PV}"

	ego build -ldflags "${LDFLAGS}"
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin gron
	newfishcomp completions/gron.fish gron
}
