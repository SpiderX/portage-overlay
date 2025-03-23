# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop go-module xdg

COMMIT="04c5770"
EGO_SUM=(
	"github.com/blang/semver v3.5.1+incompatible"
	"github.com/blang/semver v3.5.1+incompatible/go.mod"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/creack/pty v1.1.18"
	"github.com/creack/pty v1.1.18/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dustin/go-humanize v1.0.0"
	"github.com/dustin/go-humanize v1.0.0/go.mod"
	"github.com/gdamore/encoding v1.0.0"
	"github.com/gdamore/encoding v1.0.0/go.mod"
	"github.com/go-errors/errors v1.0.1"
	"github.com/go-errors/errors v1.0.1/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/layeh/gopher-luar v1.0.7"
	"github.com/layeh/gopher-luar v1.0.7/go.mod"
	"github.com/lucasb-eyer/go-colorful v1.0.3"
	"github.com/lucasb-eyer/go-colorful v1.0.3/go.mod"
	"github.com/mattn/go-isatty v0.0.11"
	"github.com/mattn/go-isatty v0.0.11/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.1.0"
	"github.com/rivo/uniseg v0.1.0/go.mod"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/sergi/go-diff v1.1.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/xo/terminfo v0.0.0-20200218205459-454e5b68f9e8"
	"github.com/xo/terminfo v0.0.0-20200218205459-454e5b68f9e8/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"github.com/yuin/gopher-lua v0.0.0-20190206043414-8bfc7677f583/go.mod"
	"github.com/yuin/gopher-lua v0.0.0-20191220021717-ab39c6098bdb"
	"github.com/yuin/gopher-lua v0.0.0-20191220021717-ab39c6098bdb/go.mod"
	"github.com/zyedidia/clipper v0.1.1"
	"github.com/zyedidia/clipper v0.1.1/go.mod"
	"github.com/zyedidia/glob v0.0.0-20170209203856-dd4023a66dc3"
	"github.com/zyedidia/glob v0.0.0-20170209203856-dd4023a66dc3/go.mod"
	"github.com/zyedidia/go-runewidth v0.0.12"
	"github.com/zyedidia/go-runewidth v0.0.12/go.mod"
	"github.com/zyedidia/go-shellquote v0.0.0-20200613203517-eccd813c0655"
	"github.com/zyedidia/go-shellquote v0.0.0-20200613203517-eccd813c0655/go.mod"
	"github.com/zyedidia/json5 v0.0.0-20200102012142-2da050b1a98d"
	"github.com/zyedidia/json5 v0.0.0-20200102012142-2da050b1a98d/go.mod"
	"github.com/zyedidia/poller v1.0.1"
	"github.com/zyedidia/poller v1.0.1/go.mod"
	"github.com/zyedidia/tcell/v2 v2.0.9"
	"github.com/zyedidia/tcell/v2 v2.0.9/go.mod"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20221007181625-f562052bccb8"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20221007181625-f562052bccb8/go.mod"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20230320201625-54f6acdada4a"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20230320201625-54f6acdada4a/go.mod"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20230831153116-061c5b2c7260"
	"github.com/zyedidia/tcell/v2 v2.0.10-0.20230831153116-061c5b2c7260/go.mod"
	"github.com/zyedidia/tcell/v2 v2.0.10"
	"github.com/zyedidia/tcell/v2 v2.0.10/go.mod"
	"github.com/zyedidia/terminal v0.0.0-20230315200948-4b3bcf6dddef"
	"github.com/zyedidia/terminal v0.0.0-20230315200948-4b3bcf6dddef/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sys v0.0.0-20190204203706-41f3e6584952/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190626150813-e07cf5db2756/go.mod"
	"golang.org/x/sys v0.0.0-20191026070338-33540a1f6037/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	)
go-module_set_globals

DESCRIPTION="A modern and intuitive terminal-based text editor"
HOMEPAGE="https://github.com/zyedidia/micro"
SRC_URI="https://github.com/zyedidia/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD MIT MPL-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

src_compile() {
	GOVARS="-X github.com/zyedidia/micro/v2/internal/util.Version=${PV}
		-X github.com/zyedidia/micro/v2/internal/util.CommitHash=${COMMIT}
		-X github.com/zyedidia/micro/v2/internal/util.CompileDate=$(date +%F)
		$(usex debug '-X github.com/zyedidia/micro/v2/internal/util.Debug=ON' '' '' '')"
	ego build -ldflags "-s -w -${GOVARS}" ./cmd/micro
}

src_test() {
	ego test -work ./cmd/... ./internal/...
}

src_install() {
	dobin micro
	doman assets/packaging/micro.1
	newicon -s scalable assets/micro-logo.svg micro.svg
	newicon assets/micro-logo.svg micro.svg
	domenu assets/packaging/micro.desktop
}
