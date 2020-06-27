# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/docopt/docopt-go v0.0.0-20160216232012-784ddc588536"
	"github.com/docopt/docopt-go v0.0.0-20160216232012-784ddc588536/go.mod"
	"github.com/fatih/color v1.6.0"
	"github.com/fatih/color v1.6.0/go.mod"
	"github.com/mattn/go-colorable v0.1.2"
	"github.com/mattn/go-colorable v0.1.2/go.mod"
	"github.com/mattn/go-isatty v0.0.8"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/tidwall/gjson v1.0.1"
	"github.com/tidwall/gjson v1.0.1/go.mod"
	"github.com/tidwall/match v1.0.0"
	"github.com/tidwall/match v1.0.0/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20190919044723-0c1ff786ef13"
	"golang.org/x/sys v0.0.0-20190919044723-0c1ff786ef13/go.mod"
	)
go-module_set_globals

DESCRIPTION="A tool for working with structured JSON logging"
HOMEPAGE="https://github.com/koenbollen/jl"
SRC_URI="https://github.com/koenbollen/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="ISC"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin jl
}
