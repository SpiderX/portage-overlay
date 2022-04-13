# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"golang.org/x/crypto v0.0.0-20180524125353-159ae71589f3"
	"golang.org/x/crypto v0.0.0-20180524125353-159ae71589f3/go.mod"
	"golang.org/x/crypto v0.0.0-20211108221036-ceb1ce70b4fa"
	"golang.org/x/crypto v0.0.0-20211108221036-ceb1ce70b4fa/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20211110154304-99a53858aa08"
	"golang.org/x/sys v0.0.0-20211110154304-99a53858aa08/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	)
go-module_set_globals

DESCRIPTION="The power of curl, the ease of use of httpie"
HOMEPAGE="https://github.com/rs/curlie"
SRC_URI="https://github.com/rs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-X main.version=${PV} -X \"main.date=${DATE}\""

	go build -ldflags "${LDFLAGS}" -o bin/curlie || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/curlie
}
