# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

EGO_SUM=(
	"dario.cat/mergo v1.0.2"
	"dario.cat/mergo v1.0.2/go.mod"
	"github.com/Masterminds/goutils v1.1.1"
	"github.com/Masterminds/goutils v1.1.1/go.mod"
	"github.com/Masterminds/semver/v3 v3.4.0"
	"github.com/Masterminds/semver/v3 v3.4.0/go.mod"
	"github.com/Masterminds/sprig/v3 v3.3.0"
	"github.com/Masterminds/sprig/v3 v3.3.0/go.mod"
	"github.com/containerd/console v1.0.5"
	"github.com/containerd/console v1.0.5/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.6/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/frankban/quicktest v1.14.6"
	"github.com/frankban/quicktest v1.14.6/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/huandu/xstrings v1.5.0"
	"github.com/huandu/xstrings v1.5.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mitchellh/copystructure v1.2.0"
	"github.com/mitchellh/copystructure v1.2.0/go.mod"
	"github.com/mitchellh/reflectwalk v1.0.2"
	"github.com/mitchellh/reflectwalk v1.0.2/go.mod"
	"github.com/morikuni/aec v1.0.0"
	"github.com/morikuni/aec v1.0.0/go.mod"
	"github.com/opencontainers/go-digest v1.0.0"
	"github.com/opencontainers/go-digest v1.0.0/go.mod"
	"github.com/opencontainers/image-spec v1.1.1"
	"github.com/opencontainers/image-spec v1.1.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/shopspring/decimal v1.4.0"
	"github.com/shopspring/decimal v1.4.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/spf13/cast v1.9.2"
	"github.com/spf13/cast v1.9.2/go.mod"
	"github.com/spf13/cobra v1.10.1"
	"github.com/spf13/cobra v1.10.1/go.mod"
	"github.com/spf13/pflag v1.0.9"
	"github.com/spf13/pflag v1.0.9/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"golang.org/x/crypto v0.45.0"
	"golang.org/x/crypto v0.45.0/go.mod"
	"golang.org/x/sync v0.16.0"
	"golang.org/x/sync v0.16.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.38.0"
	"golang.org/x/sys v0.38.0/go.mod"
	"golang.org/x/term v0.37.0"
	"golang.org/x/term v0.37.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"oras.land/oras-go/v2 v2.6.0"
	"oras.land/oras-go/v2 v2.6.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="A CLI to push and pull files from any OCI registry"
HOMEPAGE="https://github.com/oras-project/oras"
SRC_URI="https://github.com/oras-project/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND=">=dev-lang/go-1.26.2"

src_compile() {
	ego build -o oras ./cmd/oras
	local completion
	for completion in bash fish zsh ; do
		edo ./oras completion ${completion} > oras.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin oras

	newbashcomp oras.bash oras
	newfishcomp oras.fish oras
	newzshcomp oras.zsh _oras
}
