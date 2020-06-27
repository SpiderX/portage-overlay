# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit bash-completion-r1 go-module

EGO_SUM=(
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4"
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4/go.mod"
	"github.com/99designs/keyring v1.1.3"
	"github.com/99designs/keyring v1.1.3/go.mod"
	"github.com/99designs/keyring v1.1.4"
	"github.com/99designs/keyring v1.1.4/go.mod"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d"
	"github.com/alecthomas/units v0.0.0-20190924025748-f65c72e2690d/go.mod"
	"github.com/aws/aws-sdk-go v1.25.37"
	"github.com/aws/aws-sdk-go v1.25.37/go.mod"
	"github.com/danieljoos/wincred v1.0.2"
	"github.com/danieljoos/wincred v1.0.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dvsekhvalnov/jose2go v0.0.0-20180829124132-7f401d37b68a"
	"github.com/dvsekhvalnov/jose2go v0.0.0-20180829124132-7f401d37b68a/go.mod"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2/go.mod"
	"github.com/google/go-cmp v0.3.1"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c/go.mod"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af"
	"github.com/jmespath/go-jmespath v0.0.0-20180206201540-c2b33e8439af/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/kr/pretty v0.1.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/skratchdot/open-golang v0.0.0-20190402232053-79abb63cd66e"
	"github.com/skratchdot/open-golang v0.0.0-20190402232053-79abb63cd66e/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.2.0"
	"github.com/stretchr/objx v0.2.0/go.mod"
	"github.com/stretchr/testify v1.3.0"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4/go.mod"
	"golang.org/x/crypto v0.0.0-20191117063200-497ca9f6d64f"
	"golang.org/x/crypto v0.0.0-20191117063200-497ca9f6d64f/go.mod"
	"golang.org/x/crypto v0.0.0-20200210222208-86ce3cb69678"
	"golang.org/x/crypto v0.0.0-20200210222208-86ce3cb69678/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190712062909-fae7ac547cb7"
	"golang.org/x/sys v0.0.0-20190712062909-fae7ac547cb7/go.mod"
	"golang.org/x/sys v0.0.0-20191118133127-cf1e2d577169"
	"golang.org/x/sys v0.0.0-20191118133127-cf1e2d577169/go.mod"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5"
	"golang.org/x/sys v0.0.0-20200202164722-d101bd2416d5/go.mod"
	"golang.org/x/text v0.3.0"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6"
	"gopkg.in/alecthomas/kingpin.v2 v2.2.6/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/ini.v1 v1.51.0"
	"gopkg.in/ini.v1 v1.51.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	)
go-module_set_globals

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://github.com/99designs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( {README,USAGE}.md )

src_compile() {
	go build -ldflags="-X main.Version=${PV} -s -w" \
		-o ./bin/"${PN}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/aws-vault

	dobashcomp completions/bash/aws-vault
	insinto /usr/share/fish/completion
	newins completions/fish/aws-vault.fish aws-vault
	insinto /usr/share/zsh/site-functions
	doins completions/zsh/_aws-vault
}
