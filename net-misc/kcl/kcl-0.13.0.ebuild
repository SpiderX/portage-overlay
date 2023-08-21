# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 edo go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v1.3.2"
	"github.com/BurntSushi/toml v1.3.2/go.mod"
	"github.com/aws/aws-sdk-go v1.44.316"
	"github.com/aws/aws-sdk-go v1.44.316/go.mod"
	"github.com/bufbuild/protocompile v0.5.1"
	"github.com/bufbuild/protocompile v0.5.1/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.3"
	"github.com/golang/protobuf v1.5.3/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jhump/protoreflect v1.15.1"
	"github.com/jhump/protoreflect v1.15.1/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/klauspost/compress v1.16.7"
	"github.com/klauspost/compress v1.16.7/go.mod"
	"github.com/pierrec/lz4/v4 v4.1.18"
	"github.com/pierrec/lz4/v4 v4.1.18/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/spf13/cobra v1.7.0"
	"github.com/spf13/cobra v1.7.0/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.8.2"
	"github.com/twmb/franz-go v1.14.3"
	"github.com/twmb/franz-go v1.14.3/go.mod"
	"github.com/twmb/franz-go/pkg/kadm v1.9.0"
	"github.com/twmb/franz-go/pkg/kadm v1.9.0/go.mod"
	"github.com/twmb/franz-go/pkg/kmsg v1.6.1"
	"github.com/twmb/franz-go/pkg/kmsg v1.6.1/go.mod"
	"github.com/twmb/go-strftime v0.0.0-20190915101236-e74f7c4fe4fa"
	"github.com/twmb/go-strftime v0.0.0-20190915101236-e74f7c4fe4fa/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.11.0"
	"golang.org/x/crypto v0.11.0/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.1.0/go.mod"
	"golang.org/x/net v0.10.0"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.3.0"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.10.0"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.1.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.4.0/go.mod"
	"golang.org/x/text v0.11.0"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/genproto v0.0.0-20230306155012-7f2fa6fef1f4"
	"google.golang.org/genproto v0.0.0-20230306155012-7f2fa6fef1f4/go.mod"
	"google.golang.org/grpc v1.53.0"
	"google.golang.org/grpc v1.53.0/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.31.0"
	"google.golang.org/protobuf v1.31.0/go.mod"
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
	ego build -buildmode=pie -trimpath -o kcl

	local completion
	for completion in bash zsh ; do
		edo ./kcl misc gen-autocomplete -k"${completion}" > kcl."${completion}"
	done
}

src_install() {
	einstalldocs
	dobin kcl
	newbashcomp kcl.bash kcl
	insinto /usr/share/zsh/site-functions
	newins kcl.zsh _kcl
}
