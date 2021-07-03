# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/aws/aws-sdk-go v1.38.37"
	"github.com/aws/aws-sdk-go v1.38.37/go.mod"
	"github.com/aws/aws-sdk-go-v2 v1.4.0"
	"github.com/aws/aws-sdk-go-v2 v1.4.0/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.1.7"
	"github.com/aws/aws-sdk-go-v2/config v1.1.7/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.1.7"
	"github.com/aws/aws-sdk-go-v2/credentials v1.1.7/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.0.7"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.0.7/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer v1.4.1"
	"github.com/aws/aws-sdk-go-v2/service/costexplorer v1.4.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.0.7"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.0.7/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.1.6"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.1.6/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.3.1"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.3.1/go.mod"
	"github.com/aws/smithy-go v1.4.0"
	"github.com/aws/smithy-go v1.4.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/evalphobia/aws-sdk-go-wrapper v1.16.4"
	"github.com/evalphobia/aws-sdk-go-wrapper v1.16.4/go.mod"
	"github.com/evalphobia/awscost v0.1.0"
	"github.com/evalphobia/awscost v0.1.0/go.mod"
	"github.com/go-sql-driver/mysql v1.5.0/go.mod"
	"github.com/google/go-cmp v0.5.4"
	"github.com/google/go-cmp v0.5.4/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/time v0.0.0-20191024005414-555d28b269f0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	)
go-module_set_globals

DESCRIPTION="AWS Data Transfer Cost Explorer"
HOMEPAGE="https://github.com/c1982/awsdtc"
SRC_URI="https://github.com/c1982/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0 MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	go build || die "build failed"
}

src_test() {
	go test -work || die "test failed"
}

src_install() {
	einstalldocs
	dobin awsdtc
}
