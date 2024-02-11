# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

COMMIT="73aa8dd"

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0-20190314233015-f79a8a8ca69d/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0"
	"github.com/cpuguy83/go-md2man/v2 v2.0.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fzipp/gocyclo v0.3.1"
	"github.com/fzipp/gocyclo v0.3.1/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.1.0"
	"github.com/jedib0t/go-pretty/v6 v6.1.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.9"
	"github.com/mattn/go-runewidth v0.0.9/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pkg/profile v1.2.1"
	"github.com/pkg/profile v1.2.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.0.1/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/urfave/cli/v2 v2.3.0"
	"github.com/urfave/cli/v2 v2.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20180816055513-1c9583448a9c"
	"golang.org/x/sys v0.0.0-20180816055513-1c9583448a9c/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.3"
	"gopkg.in/yaml.v2 v2.2.3/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	)
go-module_set_globals

DESCRIPTION="Exploring AWS EC2 Spot inventory"
HOMEPAGE="https://github.com/alexei-led/spotinfo"
SRC_URI="https://github.com/alexei-led/${PN}/archive/${PV}.tar.gz -> ${P}.gh.tar.gz
	https://spot-bid-advisor.s3.amazonaws.com/spot-advisor-data.json
	http://spot-price.s3.amazonaws.com/spot.js -> spot-price-data.json
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="test" #fail on pricingLazyLoad

src_unpack() {
	# extract only archives
	unpack ${P}.gh.tar.gz
	go-module_src_unpack
}

src_prepare() {
	default

	mkdir public/spot/data
	cp "${DISTDIR}"/spot-{advisor,price}-data.json public/spot/data \
		|| die "cp failed"

	sed -i -e "s/callback(//g" \
		-e "s/);//g" \
		public/spot/data/spot-price-data.json || die "sed failed"
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV}
	-X main.GitCommit=${COMMIT}
	-X main.GitBranch=master
	-X \"main.BuildDate=${DATE}\""

	ego build -buildmode=pie -ldflags "${LDFLAGS}" -o spotinfo ./cmd/main.go
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin spotinfo
}
