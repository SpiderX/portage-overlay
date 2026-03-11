# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module

COMMIT="23007d3"
EGO_SUM=(
	"github.com/aws/aws-sdk-go-v2 v1.36.6"
	"github.com/aws/aws-sdk-go-v2 v1.36.6/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.29.18"
	"github.com/aws/aws-sdk-go-v2/config v1.29.18/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.17.71"
	"github.com/aws/aws-sdk-go-v2/credentials v1.17.71/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.33"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.33/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.37"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.37/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.37"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.37/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.3"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.3/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/ec2 v1.236.0"
	"github.com/aws/aws-sdk-go-v2/service/ec2 v1.236.0/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.4"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.4/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.18"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.18/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.25.6"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.25.6/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.30.4"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.30.4/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.34.1"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.34.1/go.mod"
	"github.com/aws/smithy-go v1.22.5"
	"github.com/aws/smithy-go v1.22.5/go.mod"
	"github.com/bluele/gcache v0.0.2"
	"github.com/bluele/gcache v0.0.2/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.7"
	"github.com/cpuguy83/go-md2man/v2 v2.0.7/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/frankban/quicktest v1.14.6"
	"github.com/frankban/quicktest v1.14.6/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/jedib0t/go-pretty/v6 v6.6.8"
	"github.com/jedib0t/go-pretty/v6 v6.6.8/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mark3labs/mcp-go v0.35.0"
	"github.com/mark3labs/mcp-go v0.35.0/go.mod"
	"github.com/mattn/go-runewidth v0.0.16"
	"github.com/mattn/go-runewidth v0.0.16/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rivo/uniseg v0.2.0/go.mod"
	"github.com/rivo/uniseg v0.4.7"
	"github.com/rivo/uniseg v0.4.7/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cast v1.9.2"
	"github.com/spf13/cast v1.9.2/go.mod"
	"github.com/stretchr/objx v0.5.2"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/urfave/cli/v2 v2.27.7"
	"github.com/urfave/cli/v2 v2.27.7/go.mod"
	"github.com/xrash/smetrics v0.0.0-20250705151800-55b8f293f342"
	"github.com/xrash/smetrics v0.0.0-20250705151800-55b8f293f342/go.mod"
	"github.com/yosida95/uritemplate/v3 v3.0.2"
	"github.com/yosida95/uritemplate/v3 v3.0.2/go.mod"
	"golang.org/x/sys v0.33.0"
	"golang.org/x/sys v0.33.0/go.mod"
	"golang.org/x/text v0.26.0"
	"golang.org/x/text v0.26.0/go.mod"
	"golang.org/x/time v0.12.0"
	"golang.org/x/time v0.12.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Exploring AWS EC2 Spot inventory"
HOMEPAGE="https://github.com/alexei-led/spotinfo"
SRC_URI="https://github.com/alexei-led/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 BSD-2 MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="embed-data-files"

src_unpack() {
	unpack "${P}".tar.gz
	go-module_src_unpack

	edo mkdir -p public/spot/data
	if use embed-data-files ; then
		edo wget https://spot-bid-advisor.s3.amazonaws.com/spot-advisor-data.json -O \
			public/spot/data/spot-advisor-data.json
		edo wget http://spot-price.s3.amazonaws.com/spot.js -O \
			public/spot/data/spot-price-data.json
	fi
}

src_prepare() {
	default

	if use embed-data-files ; then
		sed -i -e "s/callback(//g" \
			-e "s/);//g" \
			public/spot/data/spot-price-data.json || die "sed failed"
	else
		touch public/spot/data/spot-{advisor,price}-data.json \
			|| die "touch failed"
	fi
}

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV}
	-X main.GitCommit=${COMMIT}
	-X main.GitHubRelease=v${PV}
	-X main.GitBranch=master
	-X \"main.BuildDate=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o spotinfo ./cmd/spotinfo
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin spotinfo
}
