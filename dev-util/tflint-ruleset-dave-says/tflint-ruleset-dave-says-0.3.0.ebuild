# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module readme.gentoo-r1

EGO_SUM=(
	"github.com/agext/levenshtein v1.2.1"
	"github.com/agext/levenshtein v1.2.1/go.mod"
	"github.com/apparentlymart/go-textseg/v15 v15.0.0"
	"github.com/apparentlymart/go-textseg/v15 v15.0.0/go.mod"
	"github.com/bufbuild/protocompile v0.14.1"
	"github.com/bufbuild/protocompile v0.14.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/fatih/color v1.13.0"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/go-logr/logr v1.4.3"
	"github.com/go-logr/logr v1.4.3/go.mod"
	"github.com/go-logr/stdr v1.2.2"
	"github.com/go-logr/stdr v1.2.2/go.mod"
	"github.com/go-test/deep v1.1.1"
	"github.com/go-test/deep v1.1.1/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/hashicorp/go-hclog v1.6.3"
	"github.com/hashicorp/go-hclog v1.6.3/go.mod"
	"github.com/hashicorp/go-plugin v1.7.0"
	"github.com/hashicorp/go-plugin v1.7.0/go.mod"
	"github.com/hashicorp/go-version v1.8.0"
	"github.com/hashicorp/go-version v1.8.0/go.mod"
	"github.com/hashicorp/hcl/v2 v2.24.0"
	"github.com/hashicorp/hcl/v2 v2.24.0/go.mod"
	"github.com/hashicorp/yamux v0.1.2"
	"github.com/hashicorp/yamux v0.1.2/go.mod"
	"github.com/jhump/protoreflect v1.17.0"
	"github.com/jhump/protoreflect v1.17.0/go.mod"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-isatty v0.0.17"
	"github.com/mattn/go-isatty v0.0.17/go.mod"
	"github.com/mitchellh/go-wordwrap v1.0.1"
	"github.com/mitchellh/go-wordwrap v1.0.1/go.mod"
	"github.com/oklog/run v1.1.0"
	"github.com/oklog/run v1.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.2"
	"github.com/stretchr/testify v1.7.2/go.mod"
	"github.com/terraform-linters/tflint-plugin-sdk v0.24.0"
	"github.com/terraform-linters/tflint-plugin-sdk v0.24.0/go.mod"
	"github.com/vmihailenco/msgpack/v5 v5.3.5"
	"github.com/vmihailenco/msgpack/v5 v5.3.5/go.mod"
	"github.com/vmihailenco/tagparser/v2 v2.0.0"
	"github.com/vmihailenco/tagparser/v2 v2.0.0/go.mod"
	"github.com/zclconf/go-cty v1.18.1"
	"github.com/zclconf/go-cty v1.18.1/go.mod"
	"github.com/zclconf/go-cty-debug v0.0.0-20240509010212-0d6042c53940"
	"github.com/zclconf/go-cty-debug v0.0.0-20240509010212-0d6042c53940/go.mod"
	"go.opentelemetry.io/auto/sdk v1.2.1"
	"go.opentelemetry.io/auto/sdk v1.2.1/go.mod"
	"go.opentelemetry.io/otel v1.39.0"
	"go.opentelemetry.io/otel v1.39.0/go.mod"
	"go.opentelemetry.io/otel/metric v1.39.0"
	"go.opentelemetry.io/otel/metric v1.39.0/go.mod"
	"go.opentelemetry.io/otel/sdk v1.39.0"
	"go.opentelemetry.io/otel/sdk v1.39.0/go.mod"
	"go.opentelemetry.io/otel/sdk/metric v1.39.0"
	"go.opentelemetry.io/otel/sdk/metric v1.39.0/go.mod"
	"go.opentelemetry.io/otel/trace v1.39.0"
	"go.opentelemetry.io/otel/trace v1.39.0/go.mod"
	"golang.org/x/mod v0.34.0"
	"golang.org/x/mod v0.34.0/go.mod"
	"golang.org/x/net v0.52.0"
	"golang.org/x/net v0.52.0/go.mod"
	"golang.org/x/sync v0.20.0"
	"golang.org/x/sync v0.20.0/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20220503163025-988cb79eb6c6/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.42.0"
	"golang.org/x/sys v0.42.0/go.mod"
	"golang.org/x/text v0.35.0"
	"golang.org/x/text v0.35.0/go.mod"
	"golang.org/x/tools v0.43.0"
	"golang.org/x/tools v0.43.0/go.mod"
	"gonum.org/v1/gonum v0.16.0"
	"gonum.org/v1/gonum v0.16.0/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20251202230838-ff82c1b0f217"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20251202230838-ff82c1b0f217/go.mod"
	"google.golang.org/grpc v1.79.3"
	"google.golang.org/grpc v1.79.3/go.mod"
	"google.golang.org/protobuf v1.36.11"
	"google.golang.org/protobuf v1.36.11/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="TFLint plugin to make sure you follow the rules"
HOMEPAGE="https://github.com/skwashd/tflint-ruleset-dave-says"
SRC_URI="https://github.com/skwashd/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.0:="

DOC_CONTENTS="You should create a symlink to tflint-ruleset-dave-says\\n
in ~/.tflint.d/plugins or define another path to plugins\\n"

src_compile() {
	ego build
}

src_test() {
	ego test ./...
}

src_install() {
	einstalldocs
	exeinto usr/share/tflint-ruleset/github.com/skwashd/"${PN}"/"${PV}"
	doexe tflint-ruleset-dave-says
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
