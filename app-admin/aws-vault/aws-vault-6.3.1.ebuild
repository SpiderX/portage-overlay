# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit bash-completion-r1 go-module

EGO_SUM=(
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4"
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4/go.mod"
	"github.com/99designs/keyring v1.1.6"
	"github.com/99designs/keyring v1.1.6/go.mod"
	"github.com/alecthomas/kingpin v0.0.0-20200323085623-b6657d9477a6"
	"github.com/alecthomas/kingpin v0.0.0-20200323085623-b6657d9477a6/go.mod"
	"github.com/alecthomas/template v0.0.0-20160405071501-a0175ee3bccc/go.mod"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751"
	"github.com/alecthomas/template v0.0.0-20190718012654-fb15b899a751/go.mod"
	"github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod"
	"github.com/alecthomas/units v0.0.0-20210208195552-ff826a37aa15"
	"github.com/alecthomas/units v0.0.0-20210208195552-ff826a37aa15/go.mod"
	"github.com/aws/aws-sdk-go v1.38.0"
	"github.com/aws/aws-sdk-go v1.38.0/go.mod"
	"github.com/danieljoos/wincred v1.0.2/go.mod"
	"github.com/danieljoos/wincred v1.1.0"
	"github.com/danieljoos/wincred v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dvsekhvalnov/jose2go v0.0.0-20200901110807-248326c1351b/go.mod"
	"github.com/dvsekhvalnov/jose2go v1.5.0"
	"github.com/dvsekhvalnov/jose2go v1.5.0/go.mod"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2/go.mod"
	"github.com/google/go-cmp v0.5.2"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1"
	"github.com/gopherjs/gopherjs v0.0.0-20181017120253-0766667cb4d1/go.mod"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/jtolds/gls v4.20.0+incompatible"
	"github.com/jtolds/gls v4.20.0+incompatible/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mtibben/androiddnsfix v0.0.0-20200907095054-ff0280446354"
	"github.com/mtibben/androiddnsfix v0.0.0-20200907095054-ff0280446354/go.mod"
	"github.com/mtibben/percent v0.2.1"
	"github.com/mtibben/percent v0.2.1/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966"
	"github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966/go.mod"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d"
	"github.com/smartystreets/assertions v0.0.0-20180927180507-b2de0cb4f26d/go.mod"
	"github.com/smartystreets/goconvey v1.6.4"
	"github.com/smartystreets/goconvey v1.6.4/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.2.0"
	"github.com/stretchr/objx v0.2.0/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.5.1"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20190701094942-4def268fd1a4/go.mod"
	"golang.org/x/crypto v0.0.0-20200622213623-75b288015ac9/go.mod"
	"golang.org/x/crypto v0.0.0-20210317152858-513c2a44f670"
	"golang.org/x/crypto v0.0.0-20210317152858-513c2a44f670/go.mod"
	"golang.org/x/net v0.0.0-20190311183353-d8887717615a/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20201110031124-69a78807bb2b/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190412213103-97732733099d/go.mod"
	"golang.org/x/sys v0.0.0-20190712062909-fae7ac547cb7/go.mod"
	"golang.org/x/sys v0.0.0-20200930185726-fdedc70b468f/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210319071255-635bc2c9138d"
	"golang.org/x/sys v0.0.0-20210319071255-635bc2c9138d/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210317153231-de623e64d2a6"
	"golang.org/x/term v0.0.0-20210317153231-de623e64d2a6/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20190328211700-ab21143f2384/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b"
	"gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b/go.mod"
	"gopkg.in/ini.v1 v1.62.0"
	"gopkg.in/ini.v1 v1.62.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	)
go-module_set_globals

DESCRIPTION="A vault for securely storing and accessing AWS credentials"
HOMEPAGE="https://github.com/99designs/aws-vault"
SRC_URI="https://github.com/99designs/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DOCS=( {README,USAGE}.md )

src_compile() {
	go build -ldflags="-X main.Version=${PV} -s -w" -trimpath \
		-o ./bin/"${PN}" || die "build failed"
}

src_test() {
	go test -work ./... || die "test failed"
}

src_install() {
	einstalldocs
	dobin bin/aws-vault

	newinitd "${FILESDIR}"/aws-vault.initd aws-vault
	newconfd "${FILESDIR}"/aws-vault.confd aws-vault

	newbashcomp contrib/completions/bash/aws-vault.bash aws-vault
	insinto /usr/share/fish/completion
	newins contrib/completions/fish/aws-vault.fish aws-vault
	insinto /usr/share/zsh/site-functions
	newins contrib/completions/zsh/aws-vault.zsh _aws-vault
	dodoc contrib/scripts/aws-iam-{create,resync}-yubikey-mfa.sh
}

pkg_postinst() {
	if ! has_version app-admin/pass && ! has_version kde-apps/kwalletmanager \
		&& ! has_version gnome-base/gnome-keyring ; then
		einfo "You should consider to install app-admin/pass, gnome-base/gnome-keyring"
		einfo "or kde-apps/kwalletmanager to be able to use them as backends"
	fi
}
