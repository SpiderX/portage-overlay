# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v0.3.1"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/alcortesm/tgz v0.0.0-20161220082320-9c5fe88206d7"
	"github.com/alcortesm/tgz v0.0.0-20161220082320-9c5fe88206d7/go.mod"
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239"
	"github.com/anmitsu/go-shlex v0.0.0-20161002113705-648efa622239/go.mod"
	"github.com/armon/go-socks5 v0.0.0-20160902184237-e75332964ef5"
	"github.com/armon/go-socks5 v0.0.0-20160902184237-e75332964ef5/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/emirpasic/gods v1.12.0"
	"github.com/emirpasic/gods v1.12.0/go.mod"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568"
	"github.com/flynn/go-shlex v0.0.0-20150515145356-3f9db97f8568/go.mod"
	"github.com/gliderlabs/ssh v0.2.2"
	"github.com/gliderlabs/ssh v0.2.2/go.mod"
	"github.com/go-git/gcfg v1.5.0"
	"github.com/go-git/gcfg v1.5.0/go.mod"
	"github.com/go-git/go-billy/v5 v5.0.0"
	"github.com/go-git/go-billy/v5 v5.0.0/go.mod"
	"github.com/go-git/go-git-fixtures/v4 v4.0.2-0.20200613231340-f56387b50c12"
	"github.com/go-git/go-git-fixtures/v4 v4.0.2-0.20200613231340-f56387b50c12/go.mod"
	"github.com/google/go-cmp v0.3.0/go.mod"
	"github.com/google/go-cmp v0.4.0"
	"github.com/google/go-cmp v0.4.0/go.mod"
	"github.com/hako/durafmt v0.0.0-20191009132224-3f39dc1ed9f4"
	"github.com/hako/durafmt v0.0.0-20191009132224-3f39dc1ed9f4/go.mod"
	"github.com/imdario/mergo v0.3.9"
	"github.com/imdario/mergo v0.3.9/go.mod"
	"github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99"
	"github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99/go.mod"
	"github.com/jessevdk/go-flags v1.4.0"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kevinburke/ssh_config v0.0.0-20190725054713-01f96b0aa0cd"
	"github.com/kevinburke/ssh_config v0.0.0-20190725054713-01f96b0aa0cd/go.mod"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1"
	"github.com/konsorten/go-windows-terminal-sequences v1.0.1/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/pkg/errors v0.8.1"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sergi/go-diff v1.1.0"
	"github.com/sergi/go-diff v1.1.0/go.mod"
	"github.com/sirupsen/logrus v1.4.2"
	"github.com/sirupsen/logrus v1.4.2/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.1.1/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/xanzy/ssh-agent v0.2.1"
	"github.com/xanzy/ssh-agent v0.2.1/go.mod"
	"github.com/zricethezav/go-git/v5 v5.2.2"
	"github.com/zricethezav/go-git/v5 v5.2.2/go.mod"
	"golang.org/x/crypto v0.0.0-20190219172222-a4c6cb3142f2/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073"
	"golang.org/x/crypto v0.0.0-20200302210943-78000ba7a073/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a"
	"golang.org/x/net v0.0.0-20200301022130-244492dfa37a/go.mod"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9"
	"golang.org/x/sync v0.0.0-20201020160332-67f06af15bc9/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190221075227-b4e8571b14e0/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190422165155-953cdadca894/go.mod"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527"
	"golang.org/x/sys v0.0.0-20200302150141-5c8b2ff67527/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/warnings.v0 v0.1.2"
	"gopkg.in/warnings.v0 v0.1.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.4/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	)
go-module_set_globals

DESCRIPTION="Auditing git repository for secrets and keys"
HOMEPAGE="https://github.com/zricethezav/gitleaks"
SRC_URI="https://github.com/zricethezav/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_compile() {
	go build -ldflags "-X=github.com/zricethezav/gitleaks/v4/version.Version=${PV}" \
		|| die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin gitleaks
	dodoc -r examples/
}
