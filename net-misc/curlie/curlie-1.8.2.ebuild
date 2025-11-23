# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"golang.org/x/sys v0.30.0"
	"golang.org/x/sys v0.30.0/go.mod"
	"golang.org/x/term v0.29.0"
	"golang.org/x/term v0.29.0/go.mod"
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

	ego build -ldflags "${LDFLAGS}" -o bin/curlie
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin bin/curlie
}
