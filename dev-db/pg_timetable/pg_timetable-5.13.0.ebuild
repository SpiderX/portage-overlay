# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit go-module

EGO_SUM=(
	"github.com/cavaliercoder/grab v2.0.0+incompatible"
	"github.com/cavaliercoder/grab v2.0.0+incompatible/go.mod"
	"github.com/cybertec-postgresql/pgx-migrator v1.2.0"
	"github.com/cybertec-postgresql/pgx-migrator v1.2.0/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc"
	"github.com/davecgh/go-spew v1.1.2-0.20180830191138-d8f796af33cc/go.mod"
	"github.com/frankban/quicktest v1.14.6"
	"github.com/frankban/quicktest v1.14.6/go.mod"
	"github.com/fsnotify/fsnotify v1.9.0"
	"github.com/fsnotify/fsnotify v1.9.0/go.mod"
	"github.com/go-viper/mapstructure/v2 v2.2.1"
	"github.com/go-viper/mapstructure/v2 v2.2.1/go.mod"
	"github.com/google/go-cmp v0.6.0"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/jackc/pgpassfile v1.0.0"
	"github.com/jackc/pgpassfile v1.0.0/go.mod"
	"github.com/jackc/pgservicefile v0.0.0-20240606120523-5a60cdf6a761"
	"github.com/jackc/pgservicefile v0.0.0-20240606120523-5a60cdf6a761/go.mod"
	"github.com/jackc/pgx/v5 v5.7.4"
	"github.com/jackc/pgx/v5 v5.7.4/go.mod"
	"github.com/jackc/puddle/v2 v2.2.2"
	"github.com/jackc/puddle/v2 v2.2.2/go.mod"
	"github.com/jessevdk/go-flags v1.6.1"
	"github.com/jessevdk/go-flags v1.6.1/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/ory/mail/v3 v3.0.1-0.20210418065910-7f033ddea8dc"
	"github.com/ory/mail/v3 v3.0.1-0.20210418065910-7f033ddea8dc/go.mod"
	"github.com/pashagolub/pgxmock/v3 v3.4.0"
	"github.com/pashagolub/pgxmock/v3 v3.4.0/go.mod"
	"github.com/pashagolub/pgxmock/v4 v4.7.0"
	"github.com/pashagolub/pgxmock/v4 v4.7.0/go.mod"
	"github.com/pelletier/go-toml/v2 v2.2.4"
	"github.com/pelletier/go-toml/v2 v2.2.4/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2"
	"github.com/pmezard/go-difflib v1.0.1-0.20181226105442-5d4384ee4fb2/go.mod"
	"github.com/rifflock/lfshook v0.0.0-20180920164130-b9218ef580f5"
	"github.com/rifflock/lfshook v0.0.0-20180920164130-b9218ef580f5/go.mod"
	"github.com/rogpeppe/go-internal v1.12.0"
	"github.com/rogpeppe/go-internal v1.12.0/go.mod"
	"github.com/sagikazarmark/locafero v0.9.0"
	"github.com/sagikazarmark/locafero v0.9.0/go.mod"
	"github.com/sethvargo/go-retry v0.3.0"
	"github.com/sethvargo/go-retry v0.3.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/sourcegraph/conc v0.3.0"
	"github.com/sourcegraph/conc v0.3.0/go.mod"
	"github.com/spf13/afero v1.14.0"
	"github.com/spf13/afero v1.14.0/go.mod"
	"github.com/spf13/cast v1.7.1"
	"github.com/spf13/cast v1.7.1/go.mod"
	"github.com/spf13/pflag v1.0.6"
	"github.com/spf13/pflag v1.0.6/go.mod"
	"github.com/spf13/viper v1.20.1"
	"github.com/spf13/viper v1.20.1/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.5.1/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/subosito/gotenv v1.6.0"
	"github.com/subosito/gotenv v1.6.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"golang.org/x/crypto v0.37.0"
	"golang.org/x/crypto v0.37.0/go.mod"
	"golang.org/x/sync v0.13.0"
	"golang.org/x/sync v0.13.0/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.32.0"
	"golang.org/x/sys v0.32.0/go.mod"
	"golang.org/x/text v0.24.0"
	"golang.org/x/text v0.24.0/go.mod"
	"gopkg.in/alexcesaro/quotedprintable.v3 v3.0.0-20150716171945-2caba252f4dc"
	"gopkg.in/alexcesaro/quotedprintable.v3 v3.0.0-20150716171945-2caba252f4dc/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/natefinch/lumberjack.v2 v2.2.1"
	"gopkg.in/natefinch/lumberjack.v2 v2.2.1/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	)
go-module_set_globals

DESCRIPTION="Advanced scheduling for PostgreSQL"
HOMEPAGE="https://github.com/cybertec-postgresql/pg_timetable"
SRC_URI="https://github.com/cybertec-postgresql/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test" # need database

src_compile() {
	ego build
}

src_test() {
	ego test -v -work ./...
}

src_install() {
	einstalldocs
	dobin pg_timetable
}
