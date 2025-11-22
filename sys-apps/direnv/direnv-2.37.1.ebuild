# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v1.5.0"
	"github.com/BurntSushi/toml v1.5.0/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"golang.org/x/mod v0.25.0"
	"golang.org/x/mod v0.25.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.30.0"
	"golang.org/x/sys v0.30.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="Environment variable manager for shell"
HOMEPAGE="https://github.com/direnv/direnv"
SRC_URI="https://github.com/direnv/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( || ( dev-util/shellcheck-bin dev-util/shellcheck ) )"

DOCS=( {CHANGELOG,README}.md )

src_prepare() {
	default

	# remove tests require various shells
	sed -i  -e '/\tshellcheck /s|check |check -e SC2329 |' \
		-e '/test-go-lint /d' \
		-e '/test-elvish /d' \
		-e '/test-fish /d' \
		-e '/test-tcsh /d' \
		-e '/test-zsh /d' \
		-e '/test-pwsh /d' \
		-e '/test-mx$/d' GNUmakefile || die "sed failed for GNUmakefile"
}

src_install() {
	einstalldocs
	emake DESTDIR="${D}" PREFIX="/usr" install
}
