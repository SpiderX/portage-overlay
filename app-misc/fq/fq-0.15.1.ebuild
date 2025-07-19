# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/BurntSushi/toml v1.5.0"
	"github.com/BurntSushi/toml v1.5.0/go.mod"
	"github.com/creasty/defaults v1.8.0"
	"github.com/creasty/defaults v1.8.0/go.mod"
	"github.com/ergochat/readline v0.1.3"
	"github.com/ergochat/readline v0.1.3/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/gomarkdown/markdown v0.0.0-20250207164621-7a1f277a159e"
	"github.com/gomarkdown/markdown v0.0.0-20250207164621-7a1f277a159e/go.mod"
	"github.com/gopacket/gopacket v1.3.1"
	"github.com/gopacket/gopacket v1.3.1/go.mod"
	"github.com/itchyny/timefmt-go v0.1.6"
	"github.com/itchyny/timefmt-go v0.1.6/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mitchellh/copystructure v1.2.0"
	"github.com/mitchellh/copystructure v1.2.0/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"github.com/mitchellh/reflectwalk v1.0.2"
	"github.com/mitchellh/reflectwalk v1.0.2/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/wader/gojq v0.12.1-0.20250208151254-0aa7b87b2c2b"
	"github.com/wader/gojq v0.12.1-0.20250208151254-0aa7b87b2c2b/go.mod"
	"golang.org/x/crypto v0.40.0"
	"golang.org/x/crypto v0.40.0/go.mod"
	"golang.org/x/net v0.42.0"
	"golang.org/x/net v0.42.0/go.mod"
	"golang.org/x/sys v0.34.0"
	"golang.org/x/sys v0.34.0/go.mod"
	"golang.org/x/term v0.33.0"
	"golang.org/x/term v0.33.0/go.mod"
	"golang.org/x/text v0.27.0"
	"golang.org/x/text v0.27.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f"
	"gopkg.in/check.v1 v1.0.0-20200227125254-8fa46927fb4f/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Command-line JSON processor for binary data"
HOMEPAGE="https://github.com/wader/fq"
SRC_URI="https://github.com/wader/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="!test? ( test )"

BDEPEND="test? ( dev-tcltk/expect )"

DOCS=( {CHANGES,README}.md )

src_compile() {
	export CGO_ENABLED=0

	ego build -trimpath -o fq
}

src_test() {
	emake test
}

src_install() {
	einstalldocs
	dobin fq
}
