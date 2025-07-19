# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="86a7555"
EGO_SUM=(
	"github.com/PuerkitoBio/goquery v1.10.0"
	"github.com/PuerkitoBio/goquery v1.10.0/go.mod"
	"github.com/andybalholm/cascadia v1.3.2"
	"github.com/andybalholm/cascadia v1.3.2/go.mod"
	"github.com/antchfx/xmlquery v1.4.3"
	"github.com/antchfx/xmlquery v1.4.3/go.mod"
	"github.com/antchfx/xpath v1.3.3"
	"github.com/antchfx/xpath v1.3.3/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc/go.mod"
	"github.com/fatih/color v1.18.0"
	"github.com/fatih/color v1.18.0/go.mod"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da"
	"github.com/golang/groupcache v0.0.0-20210331224755-41bb18bfe9da/go.mod"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/pkg/diff v0.0.0-20210226163009-20ebb0f2a09e/go.mod"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.8.1"
	"github.com/spf13/cobra v1.8.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.13.0/go.mod"
	"golang.org/x/crypto v0.19.0/go.mod"
	"golang.org/x/crypto v0.23.0/go.mod"
	"golang.org/x/crypto v0.31.0/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.8.0/go.mod"
	"golang.org/x/mod v0.12.0/go.mod"
	"golang.org/x/mod v0.15.0/go.mod"
	"golang.org/x/mod v0.17.0/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.6.0/go.mod"
	"golang.org/x/net v0.9.0/go.mod"
	"golang.org/x/net v0.10.0/go.mod"
	"golang.org/x/net v0.15.0/go.mod"
	"golang.org/x/net v0.21.0/go.mod"
	"golang.org/x/net v0.25.0/go.mod"
	"golang.org/x/net v0.33.0"
	"golang.org/x/net v0.33.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sync v0.6.0/go.mod"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sync v0.10.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.7.0/go.mod"
	"golang.org/x/sys v0.8.0/go.mod"
	"golang.org/x/sys v0.12.0/go.mod"
	"golang.org/x/sys v0.17.0/go.mod"
	"golang.org/x/sys v0.20.0/go.mod"
	"golang.org/x/sys v0.28.0"
	"golang.org/x/sys v0.28.0/go.mod"
	"golang.org/x/telemetry v0.0.0-20240228155512-f48c80bd79b2/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.5.0/go.mod"
	"golang.org/x/term v0.7.0/go.mod"
	"golang.org/x/term v0.8.0/go.mod"
	"golang.org/x/term v0.12.0/go.mod"
	"golang.org/x/term v0.17.0/go.mod"
	"golang.org/x/term v0.20.0/go.mod"
	"golang.org/x/term v0.27.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.7.0/go.mod"
	"golang.org/x/text v0.9.0/go.mod"
	"golang.org/x/text v0.13.0/go.mod"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/text v0.15.0/go.mod"
	"golang.org/x/text v0.21.0"
	"golang.org/x/text v0.21.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.6.0/go.mod"
	"golang.org/x/tools v0.13.0/go.mod"
	"golang.org/x/tools v0.21.1-0.20240508182429-e35e4ccd0d2d/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/sibprogrammer/xq"
SRC_URI="https://github.com/sibprogrammer/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default

	# rename reference (app-misc/yq)
	sed -i '/Use:/s|xq|xxq|' cmd/root.go || die "sed failed for root.go"
	# rename man
	sed -i 's/xq/xxq/;s/XQ/XXQ/' docs/xq.man || die "sed failed for xq.man"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-X main.version=${PV} -X \"main.date=${DATE}\" -X main.commit=${COMMIT}"

	ego build -ldflags "${LDFLAGS}" -trimpath
}

src_test() {
	ego test -v ./...
}

src_install() {
	einstalldocs
	newbin xq xxq
	newman docs/xq.man xxq.1
}
