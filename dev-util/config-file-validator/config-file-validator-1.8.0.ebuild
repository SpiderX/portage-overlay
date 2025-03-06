# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/agext/levenshtein v1.2.1"
	"github.com/agext/levenshtein v1.2.1/go.mod"
	"github.com/apparentlymart/go-textseg/v13 v13.0.0"
	"github.com/apparentlymart/go-textseg/v13 v13.0.0/go.mod"
	"github.com/apparentlymart/go-textseg/v15 v15.0.0"
	"github.com/apparentlymart/go-textseg/v15 v15.0.0/go.mod"
	"github.com/bmatcuk/doublestar/v4 v4.7.1"
	"github.com/bmatcuk/doublestar/v4 v4.7.1/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/editorconfig/editorconfig-core-go/v2 v2.6.2"
	"github.com/editorconfig/editorconfig-core-go/v2 v2.6.2/go.mod"
	"github.com/fatih/color v1.18.0"
	"github.com/fatih/color v1.18.0/go.mod"
	"github.com/go-test/deep v1.0.3"
	"github.com/go-test/deep v1.0.3/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/gurkankaymak/hocon v1.2.20"
	"github.com/gurkankaymak/hocon v1.2.20/go.mod"
	"github.com/hashicorp/go-envparse v0.1.0"
	"github.com/hashicorp/go-envparse v0.1.0/go.mod"
	"github.com/hashicorp/hcl/v2 v2.23.0"
	"github.com/hashicorp/hcl/v2 v2.23.0/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/magiconair/properties v1.8.9"
	"github.com/magiconair/properties v1.8.9/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7"
	"github.com/mitchellh/go-wordwrap v0.0.0-20150314170334-ad45545899c7/go.mod"
	"github.com/pelletier/go-toml/v2 v2.2.3"
	"github.com/pelletier/go-toml/v2 v2.2.3/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/zclconf/go-cty v1.13.0"
	"github.com/zclconf/go-cty v1.13.0/go.mod"
	"github.com/zclconf/go-cty-debug v0.0.0-20240509010212-0d6042c53940"
	"github.com/zclconf/go-cty-debug v0.0.0-20240509010212-0d6042c53940/go.mod"
	"golang.org/x/mod v0.16.0"
	"golang.org/x/mod v0.16.0/go.mod"
	"golang.org/x/sync v0.3.0"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.25.0"
	"golang.org/x/sys v0.25.0/go.mod"
	"golang.org/x/text v0.11.0"
	"golang.org/x/text v0.11.0/go.mod"
	"golang.org/x/tools v0.13.0"
	"golang.org/x/tools v0.13.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"howett.net/plist v1.0.1"
	"howett.net/plist v1.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Cross Platform tool to validate configuration files"
HOMEPAGE="https://github.com/Boeing/config-file-validator"
SRC_URI="https://github.com/Boeing/${PN}/archive/v${PV}.tar.gz -> ${P}.gh.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64"

src_compile() {
	LDFLAGS="-w -X github.com/Boeing/config-file-validator.version=${PV}"

	ego build -buildmode=pie -ldflags "${LDFLAGS}" -o validator \
		./cmd/validator
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin validator
}
