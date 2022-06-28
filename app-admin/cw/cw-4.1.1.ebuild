# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

EGO_SUM=(
	"github.com/alecthomas/kong v0.2.18"
	"github.com/alecthomas/kong v0.2.18/go.mod"
	"github.com/aws/aws-sdk-go-v2 v1.11.1"
	"github.com/aws/aws-sdk-go-v2 v1.11.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.10.2"
	"github.com/aws/aws-sdk-go-v2/config v1.10.2/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.6.2"
	"github.com/aws/aws-sdk-go-v2/credentials v1.6.2/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.8.1"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.8.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.1"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.0.1"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.0.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.3.1"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.3.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs v1.10.1"
	"github.com/aws/aws-sdk-go-v2/service/cloudwatchlogs v1.10.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.5.1"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.5.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.6.1"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.6.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.10.1"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.10.1/go.mod"
	"github.com/aws/smithy-go v1.9.0"
	"github.com/aws/smithy-go v1.9.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fatih/color v1.13.0"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/google/go-cmp v0.5.4/go.mod"
	"github.com/google/go-cmp v0.5.6"
	"github.com/google/go-cmp v0.5.6/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881"
	"golang.org/x/sys v0.0.0-20211124211545-fe61309f8881/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b/go.mod"
	)
go-module_set_globals

DESCRIPTION="Tail AWS CloudWatch Logs from your terminal"
HOMEPAGE="https://github.com/lucagrulla/cw"
SRC_URI="https://github.com/lucagrulla/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	ego build -o cw-tail
}

src_test() {
	ego test -work
}

src_install() {
	einstalldocs
	dobin cw-tail

# unknown flag --completion-bash
#	newbashcomp cw.bash cw
#	insinto /usr/share/zsh/site-functions
#	newins cw.zsh _cw-tail
}
