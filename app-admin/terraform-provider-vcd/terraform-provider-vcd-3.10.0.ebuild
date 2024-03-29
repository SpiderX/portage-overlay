# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module readme.gentoo-r1

EGO_SUM=(
	"github.com/Microsoft/go-winio v0.5.2"
	"github.com/ProtonMail/go-crypto v0.0.0-20230217124315-7d5c6f04bbb8"
	"github.com/ProtonMail/go-crypto v0.0.0-20230217124315-7d5c6f04bbb8/go.mod"
	"github.com/acomagu/bufpipe v1.0.4"
	"github.com/agext/levenshtein v1.2.2"
	"github.com/agext/levenshtein v1.2.2/go.mod"
	"github.com/apparentlymart/go-textseg/v12 v12.0.0/go.mod"
	"github.com/apparentlymart/go-textseg/v13 v13.0.0"
	"github.com/apparentlymart/go-textseg/v13 v13.0.0/go.mod"
	"github.com/araddon/dateparse v0.0.0-20190622164848-0fb0a474d195"
	"github.com/araddon/dateparse v0.0.0-20190622164848-0fb0a474d195/go.mod"
	"github.com/bwesterb/go-ristretto v1.2.0/go.mod"
	"github.com/cloudflare/circl v1.1.0/go.mod"
	"github.com/cloudflare/circl v1.3.3"
	"github.com/cloudflare/circl v1.3.3/go.mod"
	"github.com/creack/pty v1.1.9/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/emirpasic/gods v1.18.1"
	"github.com/fatih/color v1.13.0"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/go-git/gcfg v1.5.0"
	"github.com/go-git/go-billy/v5 v5.4.1"
	"github.com/go-git/go-git/v5 v5.6.1"
	"github.com/go-test/deep v1.0.3"
	"github.com/golang/protobuf v1.1.0/go.mod"
	"github.com/golang/protobuf v1.3.1/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.3"
	"github.com/golang/protobuf v1.5.3/go.mod"
	"github.com/google/go-cmp v0.3.1/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.5.9"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/hashicorp/errwrap v1.0.0"
	"github.com/hashicorp/errwrap v1.0.0/go.mod"
	"github.com/hashicorp/go-checkpoint v0.5.0"
	"github.com/hashicorp/go-checkpoint v0.5.0/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.0/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.2"
	"github.com/hashicorp/go-cleanhttp v0.5.2/go.mod"
	"github.com/hashicorp/go-cty v1.4.1-0.20200414143053-d3edf31b6320"
	"github.com/hashicorp/go-cty v1.4.1-0.20200414143053-d3edf31b6320/go.mod"
	"github.com/hashicorp/go-hclog v1.5.0"
	"github.com/hashicorp/go-hclog v1.5.0/go.mod"
	"github.com/hashicorp/go-multierror v1.1.1"
	"github.com/hashicorp/go-multierror v1.1.1/go.mod"
	"github.com/hashicorp/go-plugin v1.4.10"
	"github.com/hashicorp/go-plugin v1.4.10/go.mod"
	"github.com/hashicorp/go-uuid v1.0.0/go.mod"
	"github.com/hashicorp/go-uuid v1.0.3"
	"github.com/hashicorp/go-uuid v1.0.3/go.mod"
	"github.com/hashicorp/go-version v1.6.0"
	"github.com/hashicorp/go-version v1.6.0/go.mod"
	"github.com/hashicorp/hc-install v0.5.2"
	"github.com/hashicorp/hc-install v0.5.2/go.mod"
	"github.com/hashicorp/hcl/v2 v2.17.0"
	"github.com/hashicorp/hcl/v2 v2.17.0/go.mod"
	"github.com/hashicorp/logutils v1.0.0"
	"github.com/hashicorp/logutils v1.0.0/go.mod"
	"github.com/hashicorp/terraform-exec v0.18.1"
	"github.com/hashicorp/terraform-exec v0.18.1/go.mod"
	"github.com/hashicorp/terraform-json v0.17.0"
	"github.com/hashicorp/terraform-json v0.17.0/go.mod"
	"github.com/hashicorp/terraform-plugin-go v0.16.0"
	"github.com/hashicorp/terraform-plugin-go v0.16.0/go.mod"
	"github.com/hashicorp/terraform-plugin-log v0.9.0"
	"github.com/hashicorp/terraform-plugin-log v0.9.0/go.mod"
	"github.com/hashicorp/terraform-plugin-sdk/v2 v2.27.0"
	"github.com/hashicorp/terraform-plugin-sdk/v2 v2.27.0/go.mod"
	"github.com/hashicorp/terraform-registry-address v0.2.1"
	"github.com/hashicorp/terraform-registry-address v0.2.1/go.mod"
	"github.com/hashicorp/terraform-svchost v0.1.1"
	"github.com/hashicorp/terraform-svchost v0.1.1/go.mod"
	"github.com/hashicorp/yamux v0.0.0-20181012175058-2f1d1f20f75d"
	"github.com/hashicorp/yamux v0.0.0-20181012175058-2f1d1f20f75d/go.mod"
	"github.com/imdario/mergo v0.3.13"
	"github.com/jbenet/go-context v0.0.0-20150711004518-d14ea06fba99"
	"github.com/jhump/protoreflect v1.6.0"
	"github.com/kevinburke/ssh_config v1.2.0"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.2.1"
	"github.com/kr/pretty v0.2.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mitchellh/copystructure v1.2.0"
	"github.com/mitchellh/copystructure v1.2.0/go.mod"
	"github.com/mitchellh/go-testing-interface v1.14.1"
	"github.com/mitchellh/go-testing-interface v1.14.1/go.mod"
	"github.com/mitchellh/go-wordwrap v1.0.0"
	"github.com/mitchellh/go-wordwrap v1.0.0/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"github.com/mitchellh/reflectwalk v1.0.2"
	"github.com/mitchellh/reflectwalk v1.0.2/go.mod"
	"github.com/oklog/run v1.0.0"
	"github.com/oklog/run v1.0.0/go.mod"
	"github.com/peterhellberg/link v1.1.0"
	"github.com/peterhellberg/link v1.1.0/go.mod"
	"github.com/pjbgf/sha1cd v0.3.0"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/sergi/go-diff v1.2.0"
	"github.com/skeema/knownhosts v1.1.0"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.6.1/go.mod"
	"github.com/stretchr/testify v1.7.2"
	"github.com/stretchr/testify v1.7.2/go.mod"
	"github.com/vmihailenco/msgpack v3.3.3+incompatible/go.mod"
	"github.com/vmihailenco/msgpack v4.0.4+incompatible"
	"github.com/vmihailenco/msgpack v4.0.4+incompatible/go.mod"
	"github.com/vmihailenco/msgpack/v5 v5.3.5"
	"github.com/vmihailenco/msgpack/v5 v5.3.5/go.mod"
	"github.com/vmihailenco/tagparser/v2 v2.0.0"
	"github.com/vmihailenco/tagparser/v2 v2.0.0/go.mod"
	"github.com/vmware/go-vcloud-director/v2 v2.21.0"
	"github.com/vmware/go-vcloud-director/v2 v2.21.0/go.mod"
	"github.com/xanzy/ssh-agent v0.3.3"
	"github.com/zclconf/go-cty v1.13.2"
	"github.com/zclconf/go-cty v1.13.2/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.10.0"
	"golang.org/x/crypto v0.10.0/go.mod"
	"golang.org/x/exp v0.0.0-20221114191408-850992195362"
	"golang.org/x/exp v0.0.0-20221114191408-850992195362/go.mod"
	"golang.org/x/mod v0.10.0"
	"golang.org/x/mod v0.10.0/go.mod"
	"golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3/go.mod"
	"golang.org/x/net v0.0.0-20190603091049-60506f45cf65/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.11.0"
	"golang.org/x/net v0.11.0/go.mod"
	"golang.org/x/sync v0.0.0-20180314180146-1d60e4601c6f/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20211007075335-d3039528d8ac/go.mod"
	"golang.org/x/sys v0.0.0-20220503163025-988cb79eb6c6/go.mod"
	"golang.org/x/sys v0.9.0"
	"golang.org/x/sys v0.9.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.2/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.10.0"
	"golang.org/x/text v0.10.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/appengine v1.1.0/go.mod"
	"google.golang.org/appengine v1.6.7"
	"google.golang.org/appengine v1.6.7/go.mod"
	"google.golang.org/genproto v0.0.0-20230410155749-daa745c078e1"
	"google.golang.org/genproto v0.0.0-20230410155749-daa745c078e1/go.mod"
	"google.golang.org/grpc v1.56.0"
	"google.golang.org/grpc v1.56.0/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.30.0"
	"google.golang.org/protobuf v1.30.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127"
	"gopkg.in/check.v1 v1.0.0-20180628173108-788fd7840127/go.mod"
	"gopkg.in/warnings.v0 v0.1.2"
	"gopkg.in/yaml.v2 v2.4.0"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Terraform VMware vCloud Director provider"
HOMEPAGE="https://registry.terraform.io/providers/vmware/vcd/latest/docs"
SRC_URI="https://github.com/vmware/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="mirror test"

RDEPEND="app-admin/terraform"

DOCS=( {CHANGELOG,README,TROUBLESHOOTING}.md )

DOC_CONTENTS="You should create a symlink to\\n
/usr/share/terraform-provider-vcd/terraform-provider-vcd\\n
in ~/.terraform.d/plugins\\n"

src_compile() {
	LDFLAGS="-X github.com/vmware/terraform-provider-vcd/v3/vcd.BuildVersion=${PV}"

	ego build -ldflags "${LDFLAGS}"
}

src_install() {
	einstalldocs
	exeinto usr/share/terraform-provider-vcd
	doexe terraform-provider-vcd
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
