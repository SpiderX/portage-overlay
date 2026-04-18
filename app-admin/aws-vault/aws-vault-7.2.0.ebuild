# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module shell-completion

EGO_SUM=(
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4"
	"github.com/99designs/go-keychain v0.0.0-20191008050251-8e49817e8af4/go.mod"
	"github.com/99designs/keyring v1.2.2"
	"github.com/99designs/keyring v1.2.2/go.mod"
	"github.com/alecthomas/kingpin/v2 v2.3.1"
	"github.com/alecthomas/kingpin/v2 v2.3.1/go.mod"
	"github.com/alecthomas/units v0.0.0-20151022065526-2efee857e7cf/go.mod"
	"github.com/alecthomas/units v0.0.0-20211218093645-b94a6e3cc137"
	"github.com/alecthomas/units v0.0.0-20211218093645-b94a6e3cc137/go.mod"
	"github.com/aws/aws-sdk-go-v2 v1.17.5"
	"github.com/aws/aws-sdk-go-v2 v1.17.5/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.18.15"
	"github.com/aws/aws-sdk-go-v2/config v1.18.15/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.13.15"
	"github.com/aws/aws-sdk-go-v2/credentials v1.13.15/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.12.23"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.12.23/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.29"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.1.29/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.4.23"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.4.23/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.3.30"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.3.30/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/iam v1.19.4"
	"github.com/aws/aws-sdk-go-v2/service/iam v1.19.4/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.9.23"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.9.23/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.12.4"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.12.4/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.14.4"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.14.4/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.18.5"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.18.5/go.mod"
	"github.com/aws/smithy-go v1.13.5"
	"github.com/aws/smithy-go v1.13.5/go.mod"
	"github.com/danieljoos/wincred v1.1.2"
	"github.com/danieljoos/wincred v1.1.2/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dvsekhvalnov/jose2go v1.5.0"
	"github.com/dvsekhvalnov/jose2go v1.5.0/go.mod"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2"
	"github.com/godbus/dbus v0.0.0-20190726142602-4481cbc300e2/go.mod"
	"github.com/google/go-cmp v0.5.8/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c"
	"github.com/gsterjov/go-libsecret v0.0.0-20161001094733-a6f4afe4910c/go.mod"
	"github.com/jmespath/go-jmespath v0.4.0/go.mod"
	"github.com/jmespath/go-jmespath/internal/testify v1.5.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/mattn/go-colorable v0.1.4/go.mod"
	"github.com/mattn/go-isatty v0.0.8/go.mod"
	"github.com/mattn/go-isatty v0.0.10/go.mod"
	"github.com/mattn/go-isatty v0.0.17"
	"github.com/mattn/go-isatty v0.0.17/go.mod"
	"github.com/mattn/go-runewidth v0.0.7/go.mod"
	"github.com/mattn/go-tty v0.0.4"
	"github.com/mattn/go-tty v0.0.4/go.mod"
	"github.com/mtibben/percent v0.2.1"
	"github.com/mtibben/percent v0.2.1/go.mod"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e"
	"github.com/niemeyer/pretty v0.0.0-20200227124842-a10e7caefd8e/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966"
	"github.com/skratchdot/open-golang v0.0.0-20200116055534-eef842397966/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.3.0"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.7.0"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/xhit/go-str2duration v1.2.0"
	"github.com/xhit/go-str2duration v1.2.0/go.mod"
	"golang.org/x/sys v0.0.0-20190222072716-a9d3bda3a223/go.mod"
	"golang.org/x/sys v0.0.0-20191008105621-543471e840be/go.mod"
	"golang.org/x/sys v0.0.0-20191120155948-bd437916bb0e/go.mod"
	"golang.org/x/sys v0.0.0-20210819135213-f52c844e1c1c/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.5.0"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/term v0.5.0"
	"golang.org/x/term v0.5.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b"
	"gopkg.in/check.v1 v1.0.0-20200902074654-038fdea0a05b/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.2.8/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20210107192922-496545a6307b"
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
	ego build -ldflags="-X main.Version=${PV}" -o aws-vault
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	dobin aws-vault

	newinitd "${FILESDIR}"/aws-vault.initd aws-vault
	newconfd "${FILESDIR}"/aws-vault.confd aws-vault

	newbashcomp contrib/completions/bash/aws-vault.bash aws-vault
	newfishcomp contrib/completions/fish/aws-vault.fish aws-vault
	newzshcomp contrib/completions/zsh/aws-vault.zsh _aws-vault
	dodoc contrib/scripts/aws-iam-{create,resync}-yubikey-mfa.sh
}

pkg_postinst() {
	if ! has_version app-admin/pass && ! has_version kde-apps/kwalletmanager \
		&& ! has_version gnome-base/gnome-keyring ; then
		einfo "You should consider to install app-admin/pass, gnome-base/gnome-keyring"
		einfo "or kde-apps/kwalletmanager to be able to use them as backends"
	fi
}
