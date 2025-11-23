# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

EGO_SUM=(
	"github.com/BurntSushi/toml v1.5.0"
	"github.com/BurntSushi/toml v1.5.0/go.mod"
	"github.com/aws/aws-sdk-go v1.55.8"
	"github.com/aws/aws-sdk-go v1.55.8/go.mod"
	"github.com/aws/aws-sdk-go-v2 v1.38.2"
	"github.com/aws/aws-sdk-go-v2 v1.38.2/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.31.5"
	"github.com/aws/aws-sdk-go-v2/config v1.31.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.18.9"
	"github.com/aws/aws-sdk-go-v2/credentials v1.18.9/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.18.5"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.18.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.4.5"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.4.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.7.5"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.7.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.3"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.3/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.13.1"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.13.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.13.5"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.13.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.29.0"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.29.0/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.34.1"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.34.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.38.1"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.38.1/go.mod"
	"github.com/aws/smithy-go v1.23.0"
	"github.com/aws/smithy-go v1.23.0/go.mod"
	"github.com/bufbuild/protocompile v0.14.1"
	"github.com/bufbuild/protocompile v0.14.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.6/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jhump/protoreflect v1.17.0"
	"github.com/jhump/protoreflect v1.17.0/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/klauspost/compress v1.18.0"
	"github.com/klauspost/compress v1.18.0/go.mod"
	"github.com/pierrec/lz4/v4 v4.1.22"
	"github.com/pierrec/lz4/v4 v4.1.22/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.9.1"
	"github.com/spf13/cobra v1.9.1/go.mod"
	"github.com/spf13/pflag v1.0.6/go.mod"
	"github.com/spf13/pflag v1.0.7"
	"github.com/spf13/pflag v1.0.7/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/twmb/franz-go v1.19.5"
	"github.com/twmb/franz-go v1.19.5/go.mod"
	"github.com/twmb/franz-go/pkg/kadm v1.16.1"
	"github.com/twmb/franz-go/pkg/kadm v1.16.1/go.mod"
	"github.com/twmb/franz-go/pkg/kmsg v1.11.2"
	"github.com/twmb/franz-go/pkg/kmsg v1.11.2/go.mod"
	"github.com/twmb/go-strftime v0.0.0-20190915101236-e74f7c4fe4fa"
	"github.com/twmb/go-strftime v0.0.0-20190915101236-e74f7c4fe4fa/go.mod"
	"golang.org/x/crypto v0.41.0"
	"golang.org/x/crypto v0.41.0/go.mod"
	"golang.org/x/net v0.42.0"
	"golang.org/x/net v0.42.0/go.mod"
	"golang.org/x/sync v0.16.0"
	"golang.org/x/sync v0.16.0/go.mod"
	"golang.org/x/sys v0.35.0"
	"golang.org/x/sys v0.35.0/go.mod"
	"golang.org/x/text v0.28.0"
	"golang.org/x/text v0.28.0/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20231106174013-bbf56f31fb17"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20231106174013-bbf56f31fb17/go.mod"
	"google.golang.org/grpc v1.61.0"
	"google.golang.org/grpc v1.61.0/go.mod"
	"google.golang.org/protobuf v1.36.8"
	"google.golang.org/protobuf v1.36.8/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Your one stop shop to do anything with Kafka"
HOMEPAGE="https://github.com/twmb/kcl"
SRC_URI="https://github.com/twmb/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {CHANGELOG,README}.md )

src_compile() {
	ego build -o kcl

	local completion
	for completion in bash fish zsh ; do
		edo ./kcl misc gen-autocomplete -k"${completion}" > kcl."${completion}"
	done
}

src_install() {
	einstalldocs
	dobin kcl
	newbashcomp kcl.bash kcl
	newfishcomp kcl.fish kcl
	newzshcomp kcl.zsh _kcl
}
