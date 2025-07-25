# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module shell-completion

EGO_SUM=(
	"dario.cat/mergo v1.0.1"
	"dario.cat/mergo v1.0.1/go.mod"
	"filippo.io/edwards25519 v1.1.0/go.mod"
	"github.com/ahmetb/go-linq v3.0.0+incompatible"
	"github.com/ahmetb/go-linq v3.0.0+incompatible/go.mod"
	"github.com/alecthomas/units v0.0.0-20240927000941-0f3dac36c52b"
	"github.com/alecthomas/units v0.0.0-20240927000941-0f3dac36c52b/go.mod"
	"github.com/armon/go-radix v1.0.0"
	"github.com/armon/go-radix v1.0.0/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.4/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc/go.mod"
	"github.com/fatih/color v1.13.0/go.mod"
	"github.com/fatih/color v1.16.0"
	"github.com/fatih/color v1.16.0/go.mod"
	"github.com/frankban/quicktest v1.14.6"
	"github.com/frankban/quicktest v1.14.6/go.mod"
	"github.com/fsnotify/fsnotify v1.7.0"
	"github.com/fsnotify/fsnotify v1.7.0/go.mod"
	"github.com/go-sql-driver/mysql v1.8.1/go.mod"
	"github.com/gofri/go-github-ratelimit v1.1.0"
	"github.com/gofri/go-github-ratelimit v1.1.0/go.mod"
	"github.com/golang/protobuf v1.5.0/go.mod"
	"github.com/golang/protobuf v1.5.2/go.mod"
	"github.com/golang/protobuf v1.5.3"
	"github.com/golang/protobuf v1.5.3/go.mod"
	"github.com/google/btree v1.1.3"
	"github.com/google/btree v1.1.3/go.mod"
	"github.com/google/go-cmp v0.5.2/go.mod"
	"github.com/google/go-cmp v0.5.5/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/go-github/v66 v66.0.0"
	"github.com/google/go-github/v66 v66.0.0/go.mod"
	"github.com/google/go-querystring v1.1.0"
	"github.com/google/go-querystring v1.1.0/go.mod"
	"github.com/gregjones/httpcache v0.0.0-20190611155906-901d90724c79"
	"github.com/gregjones/httpcache v0.0.0-20190611155906-901d90724c79/go.mod"
	"github.com/hashicorp/go-cleanhttp v0.5.2"
	"github.com/hashicorp/go-cleanhttp v0.5.2/go.mod"
	"github.com/hashicorp/go-hclog v1.6.3"
	"github.com/hashicorp/go-hclog v1.6.3/go.mod"
	"github.com/hashicorp/go-retryablehttp v0.7.7"
	"github.com/hashicorp/go-retryablehttp v0.7.7/go.mod"
	"github.com/hashicorp/hcl v1.0.0"
	"github.com/hashicorp/hcl v1.0.0/go.mod"
	"github.com/inconshreveable/mousetrap v1.1.0"
	"github.com/inconshreveable/mousetrap v1.1.0/go.mod"
	"github.com/jmoiron/sqlx v1.4.0"
	"github.com/jmoiron/sqlx v1.4.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/lib/pq v1.10.9/go.mod"
	"github.com/magiconair/properties v1.8.7"
	"github.com/magiconair/properties v1.8.7/go.mod"
	"github.com/mattn/go-colorable v0.1.9/go.mod"
	"github.com/mattn/go-colorable v0.1.12/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.12/go.mod"
	"github.com/mattn/go-isatty v0.0.14/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mattn/go-sqlite3 v1.14.22/go.mod"
	"github.com/mitchellh/mapstructure v1.5.0"
	"github.com/mitchellh/mapstructure v1.5.0/go.mod"
	"github.com/pelletier/go-toml/v2 v2.2.2"
	"github.com/pelletier/go-toml/v2 v2.2.2/go.mod"
	"github.com/peterbourgon/diskv v2.0.1+incompatible"
	"github.com/peterbourgon/diskv v2.0.1+incompatible/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2/go.mod"
	"github.com/rogpeppe/go-internal v1.9.0"
	"github.com/rogpeppe/go-internal v1.9.0/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/sagikazarmark/locafero v0.4.0"
	"github.com/sagikazarmark/locafero v0.4.0/go.mod"
	"github.com/sagikazarmark/slog-shim v0.1.0"
	"github.com/sagikazarmark/slog-shim v0.1.0/go.mod"
	"github.com/sourcegraph/conc v0.3.0"
	"github.com/sourcegraph/conc v0.3.0/go.mod"
	"github.com/spf13/afero v1.11.0"
	"github.com/spf13/afero v1.11.0/go.mod"
	"github.com/spf13/cast v1.6.0"
	"github.com/spf13/cast v1.6.0/go.mod"
	"github.com/spf13/cobra v1.8.1"
	"github.com/spf13/cobra v1.8.1/go.mod"
	"github.com/spf13/pflag v1.0.5"
	"github.com/spf13/pflag v1.0.5/go.mod"
	"github.com/spf13/viper v1.19.0"
	"github.com/spf13/viper v1.19.0/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.7.2/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/stretchr/testify v1.9.0"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/subosito/gotenv v1.6.0"
	"github.com/subosito/gotenv v1.6.0/go.mod"
	"github.com/xanzy/go-gitlab v0.114.0"
	"github.com/xanzy/go-gitlab v0.114.0/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.uber.org/atomic v1.9.0"
	"go.uber.org/atomic v1.9.0/go.mod"
	"go.uber.org/multierr v1.9.0"
	"go.uber.org/multierr v1.9.0/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/exp v0.0.0-20230905200255-921286631fa9"
	"golang.org/x/exp v0.0.0-20230905200255-921286631fa9/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/oauth2 v0.18.0"
	"golang.org/x/oauth2 v0.18.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20200116001909-b77594299b42/go.mod"
	"golang.org/x/sys v0.0.0-20200223170610-d5e6a3e2c0ae/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20210630005230-0f9fa26af87c/go.mod"
	"golang.org/x/sys v0.0.0-20210927094055-39ccf1dd6fa6/go.mod"
	"golang.org/x/sys v0.0.0-20220503163025-988cb79eb6c6/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.20.0"
	"golang.org/x/sys v0.20.0/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.3.8/go.mod"
	"golang.org/x/text v0.14.0"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/time v0.5.0"
	"golang.org/x/time v0.5.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"golang.org/x/xerrors v0.0.0-20191204190536-9bdfabe68543/go.mod"
	"google.golang.org/appengine v1.6.8"
	"google.golang.org/appengine v1.6.8/go.mod"
	"google.golang.org/protobuf v1.26.0-rc.1/go.mod"
	"google.golang.org/protobuf v1.26.0/go.mod"
	"google.golang.org/protobuf v1.33.0"
	"google.golang.org/protobuf v1.33.0/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/ini.v1 v1.67.0"
	"gopkg.in/ini.v1 v1.67.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

COMMIT="97da624"

DESCRIPTION="Gitlab bulk administration tool"
HOMEPAGE="https://github.com/flant/glaball"
SRC_URI="https://github.com/flant/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # no tests

src_compile() {
	LDFLAGS="-X github.com/flant/glaball/pkg/util.Version=${PV}
		-X github.com/flant/glaball/pkg/util.Revision=${COMMIT}
		-X github.com/flant/glaball/pkg/util.Branch=main
		-X github.com/flant/glaball/pkg/util.BuildUser=portage
		-X github.com/flant/glaball/pkg/util.BuildDate=$(date +%Y%m%d%H%M)"
	ego build -ldflags "$LDFLAGS"

	local completion
	for completion in bash zsh ; do
		edo ./glaball completion ${completion} > globall.${completion} \
			|| die "completion for ${completion} failed"
	done
}

src_install() {
	einstalldocs
	dobin glaball

	newbashcomp globall.bash globall
	newzshcomp globall.zsh _globall
}
