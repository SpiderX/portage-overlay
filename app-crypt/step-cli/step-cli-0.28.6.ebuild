# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo go-module readme.gentoo-r1 shell-completion systemd

EGO_SUM=(
	"cloud.google.com/go v0.118.3"
	"cloud.google.com/go v0.118.3/go.mod"
	"cloud.google.com/go/auth v0.15.0"
	"cloud.google.com/go/auth v0.15.0/go.mod"
	"cloud.google.com/go/auth/oauth2adapt v0.2.7"
	"cloud.google.com/go/auth/oauth2adapt v0.2.7/go.mod"
	"cloud.google.com/go/compute/metadata v0.6.0"
	"cloud.google.com/go/compute/metadata v0.6.0/go.mod"
	"cloud.google.com/go/iam v1.4.1"
	"cloud.google.com/go/iam v1.4.1/go.mod"
	"cloud.google.com/go/kms v1.21.0"
	"cloud.google.com/go/kms v1.21.0/go.mod"
	"cloud.google.com/go/longrunning v0.6.6"
	"cloud.google.com/go/longrunning v0.6.6/go.mod"
	"cloud.google.com/go/security v1.18.4"
	"cloud.google.com/go/security v1.18.4/go.mod"
	"dario.cat/mergo v1.0.1"
	"dario.cat/mergo v1.0.1/go.mod"
	"filippo.io/edwards25519 v1.1.0"
	"filippo.io/edwards25519 v1.1.0/go.mod"
	"github.com/AndreasBriese/bbloom v0.0.0-20190825152654-46b345b51c96"
	"github.com/AndreasBriese/bbloom v0.0.0-20190825152654-46b345b51c96/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore v1.17.0"
	"github.com/Azure/azure-sdk-for-go/sdk/azcore v1.17.0/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity v1.8.2"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity v1.8.2/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity/cache v0.3.2"
	"github.com/Azure/azure-sdk-for-go/sdk/azidentity/cache v0.3.2/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/internal v1.10.0"
	"github.com/Azure/azure-sdk-for-go/sdk/internal v1.10.0/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/keyvault/azkeys v0.10.0"
	"github.com/Azure/azure-sdk-for-go/sdk/keyvault/azkeys v0.10.0/go.mod"
	"github.com/Azure/azure-sdk-for-go/sdk/keyvault/internal v0.7.1"
	"github.com/Azure/azure-sdk-for-go/sdk/keyvault/internal v0.7.1/go.mod"
	"github.com/AzureAD/microsoft-authentication-extensions-for-go/cache v0.1.1"
	"github.com/AzureAD/microsoft-authentication-extensions-for-go/cache v0.1.1/go.mod"
	"github.com/AzureAD/microsoft-authentication-library-for-go v1.3.3"
	"github.com/AzureAD/microsoft-authentication-library-for-go v1.3.3/go.mod"
	"github.com/BurntSushi/toml v0.3.1/go.mod"
	"github.com/BurntSushi/toml v1.4.0/go.mod"
	"github.com/Masterminds/goutils v1.1.1"
	"github.com/Masterminds/goutils v1.1.1/go.mod"
	"github.com/Masterminds/semver/v3 v3.3.0"
	"github.com/Masterminds/semver/v3 v3.3.0/go.mod"
	"github.com/Masterminds/sprig/v3 v3.3.0"
	"github.com/Masterminds/sprig/v3 v3.3.0/go.mod"
	"github.com/Microsoft/go-winio v0.6.2"
	"github.com/Microsoft/go-winio v0.6.2/go.mod"
	"github.com/OneOfOne/xxhash v1.2.2"
	"github.com/OneOfOne/xxhash v1.2.2/go.mod"
	"github.com/ThomasRooney/gexpect v0.0.0-20161231170123-5482f0350944"
	"github.com/ThomasRooney/gexpect v0.0.0-20161231170123-5482f0350944/go.mod"
	"github.com/armon/consul-api v0.0.0-20180202201655-eb2c6b5be1b6/go.mod"
	"github.com/asaskevich/govalidator v0.0.0-20210307081110-f21760c49a8d"
	"github.com/asaskevich/govalidator v0.0.0-20210307081110-f21760c49a8d/go.mod"
	"github.com/aws/aws-sdk-go-v2 v1.36.1"
	"github.com/aws/aws-sdk-go-v2 v1.36.1/go.mod"
	"github.com/aws/aws-sdk-go-v2/config v1.29.6"
	"github.com/aws/aws-sdk-go-v2/config v1.29.6/go.mod"
	"github.com/aws/aws-sdk-go-v2/credentials v1.17.59"
	"github.com/aws/aws-sdk-go-v2/credentials v1.17.59/go.mod"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.28"
	"github.com/aws/aws-sdk-go-v2/feature/ec2/imds v1.16.28/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.32"
	"github.com/aws/aws-sdk-go-v2/internal/configsources v1.3.32/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.32"
	"github.com/aws/aws-sdk-go-v2/internal/endpoints/v2 v2.6.32/go.mod"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.2"
	"github.com/aws/aws-sdk-go-v2/internal/ini v1.8.2/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.2"
	"github.com/aws/aws-sdk-go-v2/service/internal/accept-encoding v1.12.2/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.13"
	"github.com/aws/aws-sdk-go-v2/service/internal/presigned-url v1.12.13/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/kms v1.37.18"
	"github.com/aws/aws-sdk-go-v2/service/kms v1.37.18/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.24.15"
	"github.com/aws/aws-sdk-go-v2/service/sso v1.24.15/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.28.14"
	"github.com/aws/aws-sdk-go-v2/service/ssooidc v1.28.14/go.mod"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.33.14"
	"github.com/aws/aws-sdk-go-v2/service/sts v1.33.14/go.mod"
	"github.com/aws/smithy-go v1.22.2"
	"github.com/aws/smithy-go v1.22.2/go.mod"
	"github.com/beorn7/perks v1.0.1"
	"github.com/beorn7/perks v1.0.1/go.mod"
	"github.com/boombuler/barcode v1.0.1-0.20190219062509-6c824513bacc/go.mod"
	"github.com/boombuler/barcode v1.0.1"
	"github.com/boombuler/barcode v1.0.1/go.mod"
	"github.com/ccoveille/go-safecast v1.6.0"
	"github.com/ccoveille/go-safecast v1.6.0/go.mod"
	"github.com/cespare/xxhash v1.1.0"
	"github.com/cespare/xxhash v1.1.0/go.mod"
	"github.com/cespare/xxhash/v2 v2.1.1/go.mod"
	"github.com/cespare/xxhash/v2 v2.3.0"
	"github.com/cespare/xxhash/v2 v2.3.0/go.mod"
	"github.com/chzyer/logex v1.1.10/go.mod"
	"github.com/chzyer/logex v1.2.1"
	"github.com/chzyer/logex v1.2.1/go.mod"
	"github.com/chzyer/readline v0.0.0-20180603132655-2972be24d48e/go.mod"
	"github.com/chzyer/readline v1.5.1"
	"github.com/chzyer/readline v1.5.1/go.mod"
	"github.com/chzyer/test v0.0.0-20180213035817-a1ea475d72b1/go.mod"
	"github.com/chzyer/test v1.0.0"
	"github.com/chzyer/test v1.0.0/go.mod"
	"github.com/coreos/etcd v3.3.10+incompatible/go.mod"
	"github.com/coreos/go-etcd v2.0.0+incompatible/go.mod"
	"github.com/coreos/go-oidc/v3 v3.13.0"
	"github.com/coreos/go-oidc/v3 v3.13.0/go.mod"
	"github.com/coreos/go-semver v0.2.0/go.mod"
	"github.com/corpix/uarand v0.2.0"
	"github.com/corpix/uarand v0.2.0/go.mod"
	"github.com/cpuguy83/go-md2man v1.0.10/go.mod"
	"github.com/cpuguy83/go-md2man/v2 v2.0.5"
	"github.com/cpuguy83/go-md2man/v2 v2.0.5/go.mod"
	"github.com/creack/pty v1.1.7/go.mod"
	"github.com/creack/pty v1.1.18"
	"github.com/creack/pty v1.1.18/go.mod"
	"github.com/davecgh/go-spew v1.1.0/go.mod"
	"github.com/davecgh/go-spew v1.1.1"
	"github.com/davecgh/go-spew v1.1.1/go.mod"
	"github.com/dgraph-io/badger v1.6.2"
	"github.com/dgraph-io/badger v1.6.2/go.mod"
	"github.com/dgraph-io/badger/v2 v2.2007.4"
	"github.com/dgraph-io/badger/v2 v2.2007.4/go.mod"
	"github.com/dgraph-io/ristretto v0.0.2/go.mod"
	"github.com/dgraph-io/ristretto v0.0.3-0.20200630154024-f66de99634de/go.mod"
	"github.com/dgraph-io/ristretto v0.1.1"
	"github.com/dgraph-io/ristretto v0.1.1/go.mod"
	"github.com/dgryski/go-farm v0.0.0-20190423205320-6a90982ecee2/go.mod"
	"github.com/dgryski/go-farm v0.0.0-20200201041132-a6ae2369ad13"
	"github.com/dgryski/go-farm v0.0.0-20200201041132-a6ae2369ad13/go.mod"
	"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f"
	"github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f/go.mod"
	"github.com/dustin/go-humanize v1.0.0/go.mod"
	"github.com/dustin/go-humanize v1.0.1"
	"github.com/dustin/go-humanize v1.0.1/go.mod"
	"github.com/felixge/httpsnoop v1.0.4"
	"github.com/felixge/httpsnoop v1.0.4/go.mod"
	"github.com/frankban/quicktest v1.14.6"
	"github.com/frankban/quicktest v1.14.6/go.mod"
	"github.com/fsnotify/fsnotify v1.4.7/go.mod"
	"github.com/fxamacker/cbor/v2 v2.7.0"
	"github.com/fxamacker/cbor/v2 v2.7.0/go.mod"
	"github.com/go-chi/chi/v5 v5.2.1"
	"github.com/go-chi/chi/v5 v5.2.1/go.mod"
	"github.com/go-jose/go-jose/v3 v3.0.4"
	"github.com/go-jose/go-jose/v3 v3.0.4/go.mod"
	"github.com/go-jose/go-jose/v4 v4.0.5"
	"github.com/go-jose/go-jose/v4 v4.0.5/go.mod"
	"github.com/go-logr/logr v1.2.2/go.mod"
	"github.com/go-logr/logr v1.4.2"
	"github.com/go-logr/logr v1.4.2/go.mod"
	"github.com/go-logr/stdr v1.2.2"
	"github.com/go-logr/stdr v1.2.2/go.mod"
	"github.com/go-sql-driver/mysql v1.8.1"
	"github.com/go-sql-driver/mysql v1.8.1/go.mod"
	"github.com/golang-jwt/jwt/v5 v5.2.1"
	"github.com/golang-jwt/jwt/v5 v5.2.1/go.mod"
	"github.com/golang/glog v0.0.0-20160126235308-23def4e6c14b/go.mod"
	"github.com/golang/glog v1.2.4"
	"github.com/golang/glog v1.2.4/go.mod"
	"github.com/golang/protobuf v1.3.1/go.mod"
	"github.com/golang/protobuf v1.5.4"
	"github.com/golang/protobuf v1.5.4/go.mod"
	"github.com/golang/snappy v0.0.3/go.mod"
	"github.com/golang/snappy v0.0.4"
	"github.com/golang/snappy v0.0.4/go.mod"
	"github.com/google/btree v1.0.0/go.mod"
	"github.com/google/btree v1.1.3"
	"github.com/google/btree v1.1.3/go.mod"
	"github.com/google/certificate-transparency-go v1.0.21/go.mod"
	"github.com/google/certificate-transparency-go v1.2.2"
	"github.com/google/certificate-transparency-go v1.2.2/go.mod"
	"github.com/google/go-cmp v0.5.9/go.mod"
	"github.com/google/go-cmp v0.6.0/go.mod"
	"github.com/google/go-cmp v0.7.0"
	"github.com/google/go-cmp v0.7.0/go.mod"
	"github.com/google/go-configfs-tsm v0.3.3-0.20240919001351-b4b5b84fdcbc"
	"github.com/google/go-configfs-tsm v0.3.3-0.20240919001351-b4b5b84fdcbc/go.mod"
	"github.com/google/go-github v17.0.0+incompatible/go.mod"
	"github.com/google/go-querystring v1.0.0/go.mod"
	"github.com/google/go-sev-guest v0.12.1"
	"github.com/google/go-sev-guest v0.12.1/go.mod"
	"github.com/google/go-tdx-guest v0.3.2-0.20241009005452-097ee70d0843"
	"github.com/google/go-tdx-guest v0.3.2-0.20241009005452-097ee70d0843/go.mod"
	"github.com/google/go-tpm v0.9.3"
	"github.com/google/go-tpm v0.9.3/go.mod"
	"github.com/google/go-tpm-tools v0.4.5"
	"github.com/google/go-tpm-tools v0.4.5/go.mod"
	"github.com/google/go-tspi v0.3.0"
	"github.com/google/go-tspi v0.3.0/go.mod"
	"github.com/google/logger v1.1.1"
	"github.com/google/logger v1.1.1/go.mod"
	"github.com/google/s2a-go v0.1.9"
	"github.com/google/s2a-go v0.1.9/go.mod"
	"github.com/google/uuid v1.6.0"
	"github.com/google/uuid v1.6.0/go.mod"
	"github.com/googleapis/enterprise-certificate-proxy v0.3.5"
	"github.com/googleapis/enterprise-certificate-proxy v0.3.5/go.mod"
	"github.com/googleapis/gax-go/v2 v2.14.1"
	"github.com/googleapis/gax-go/v2 v2.14.1/go.mod"
	"github.com/hashicorp/hcl v1.0.0/go.mod"
	"github.com/huandu/xstrings v1.5.0"
	"github.com/huandu/xstrings v1.5.0/go.mod"
	"github.com/icrowley/fake v0.0.0-20221112152111-d7b7e2276db2"
	"github.com/icrowley/fake v0.0.0-20221112152111-d7b7e2276db2/go.mod"
	"github.com/inconshreveable/mousetrap v1.0.0/go.mod"
	"github.com/jackc/pgpassfile v1.0.0"
	"github.com/jackc/pgpassfile v1.0.0/go.mod"
	"github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a"
	"github.com/jackc/pgservicefile v0.0.0-20221227161230-091c0ba34f0a/go.mod"
	"github.com/jackc/pgx/v5 v5.6.0"
	"github.com/jackc/pgx/v5 v5.6.0/go.mod"
	"github.com/jackc/puddle/v2 v2.2.1"
	"github.com/jackc/puddle/v2 v2.2.1/go.mod"
	"github.com/jessevdk/go-flags v1.4.0/go.mod"
	"github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51"
	"github.com/kballard/go-shellquote v0.0.0-20180428030007-95032a82bc51/go.mod"
	"github.com/keybase/go-keychain v0.0.0-20231219164618-57a3676c3af6"
	"github.com/keybase/go-keychain v0.0.0-20231219164618-57a3676c3af6/go.mod"
	"github.com/klauspost/compress v1.12.3/go.mod"
	"github.com/klauspost/compress v1.17.11"
	"github.com/klauspost/compress v1.17.11/go.mod"
	"github.com/kr/pretty v0.1.0/go.mod"
	"github.com/kr/pretty v0.2.0/go.mod"
	"github.com/kr/pretty v0.3.1"
	"github.com/kr/pretty v0.3.1/go.mod"
	"github.com/kr/pty v1.1.1/go.mod"
	"github.com/kr/pty v1.1.8"
	"github.com/kr/pty v1.1.8/go.mod"
	"github.com/kr/text v0.1.0/go.mod"
	"github.com/kr/text v0.2.0"
	"github.com/kr/text v0.2.0/go.mod"
	"github.com/kylelemons/godebug v1.1.0"
	"github.com/kylelemons/godebug v1.1.0/go.mod"
	"github.com/magiconair/properties v1.8.0/go.mod"
	"github.com/manifoldco/promptui v0.9.0"
	"github.com/manifoldco/promptui v0.9.0/go.mod"
	"github.com/mattn/go-colorable v0.1.13"
	"github.com/mattn/go-colorable v0.1.13/go.mod"
	"github.com/mattn/go-isatty v0.0.16/go.mod"
	"github.com/mattn/go-isatty v0.0.20"
	"github.com/mattn/go-isatty v0.0.20/go.mod"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d"
	"github.com/mgutz/ansi v0.0.0-20200706080929-d51e80ef957d/go.mod"
	"github.com/mitchellh/copystructure v1.2.0"
	"github.com/mitchellh/copystructure v1.2.0/go.mod"
	"github.com/mitchellh/go-homedir v1.1.0/go.mod"
	"github.com/mitchellh/mapstructure v1.1.2/go.mod"
	"github.com/mitchellh/reflectwalk v1.0.2"
	"github.com/mitchellh/reflectwalk v1.0.2/go.mod"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822"
	"github.com/munnerz/goautoneg v0.0.0-20191010083416-a7dc8b61c822/go.mod"
	"github.com/newrelic/go-agent/v3 v3.37.0"
	"github.com/newrelic/go-agent/v3 v3.37.0/go.mod"
	"github.com/pelletier/go-toml v1.2.0/go.mod"
	"github.com/peterbourgon/diskv/v3 v3.0.1"
	"github.com/peterbourgon/diskv/v3 v3.0.1/go.mod"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c"
	"github.com/pkg/browser v0.0.0-20240102092130-5ac0b6a4141c/go.mod"
	"github.com/pkg/errors v0.8.1/go.mod"
	"github.com/pkg/errors v0.9.1"
	"github.com/pkg/errors v0.9.1/go.mod"
	"github.com/pmezard/go-difflib v1.0.0"
	"github.com/pmezard/go-difflib v1.0.0/go.mod"
	"github.com/pquerna/otp v1.4.0"
	"github.com/pquerna/otp v1.4.0/go.mod"
	"github.com/prometheus/client_golang v1.21.1"
	"github.com/prometheus/client_golang v1.21.1/go.mod"
	"github.com/prometheus/client_model v0.6.1"
	"github.com/prometheus/client_model v0.6.1/go.mod"
	"github.com/prometheus/common v0.62.0"
	"github.com/prometheus/common v0.62.0/go.mod"
	"github.com/prometheus/procfs v0.15.1"
	"github.com/prometheus/procfs v0.15.1/go.mod"
	"github.com/redis/go-redis/v9 v9.7.0"
	"github.com/redis/go-redis/v9 v9.7.0/go.mod"
	"github.com/rogpeppe/go-internal v1.13.1"
	"github.com/rogpeppe/go-internal v1.13.1/go.mod"
	"github.com/rs/xid v1.6.0"
	"github.com/rs/xid v1.6.0/go.mod"
	"github.com/russross/blackfriday v1.5.2/go.mod"
	"github.com/russross/blackfriday/v2 v2.1.0"
	"github.com/russross/blackfriday/v2 v2.1.0/go.mod"
	"github.com/schollz/jsonstore v1.1.0"
	"github.com/schollz/jsonstore v1.1.0/go.mod"
	"github.com/shopspring/decimal v1.4.0"
	"github.com/shopspring/decimal v1.4.0/go.mod"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0"
	"github.com/shurcooL/sanitized_anchor_name v1.0.0/go.mod"
	"github.com/sirupsen/logrus v1.9.3"
	"github.com/sirupsen/logrus v1.9.3/go.mod"
	"github.com/slackhq/nebula v1.9.5"
	"github.com/slackhq/nebula v1.9.5/go.mod"
	"github.com/smallstep/assert v0.0.0-20200723003110-82e2b9b3b262"
	"github.com/smallstep/assert v0.0.0-20200723003110-82e2b9b3b262/go.mod"
	"github.com/smallstep/certificates v0.28.3"
	"github.com/smallstep/certificates v0.28.3/go.mod"
	"github.com/smallstep/certinfo v1.13.0"
	"github.com/smallstep/certinfo v1.13.0/go.mod"
	"github.com/smallstep/cli-utils v0.12.1"
	"github.com/smallstep/cli-utils v0.12.1/go.mod"
	"github.com/smallstep/go-attestation v0.4.4-0.20240109183208-413678f90935"
	"github.com/smallstep/go-attestation v0.4.4-0.20240109183208-413678f90935/go.mod"
	"github.com/smallstep/linkedca v0.23.0"
	"github.com/smallstep/linkedca v0.23.0/go.mod"
	"github.com/smallstep/nosql v0.7.0"
	"github.com/smallstep/nosql v0.7.0/go.mod"
	"github.com/smallstep/pkcs7 v0.0.0-20240911091500-b1cae6277023/go.mod"
	"github.com/smallstep/pkcs7 v0.2.1"
	"github.com/smallstep/pkcs7 v0.2.1/go.mod"
	"github.com/smallstep/scep v0.0.0-20240926084937-8cf1ca453101"
	"github.com/smallstep/scep v0.0.0-20240926084937-8cf1ca453101/go.mod"
	"github.com/smallstep/truststore v0.13.0"
	"github.com/smallstep/truststore v0.13.0/go.mod"
	"github.com/smallstep/zcrypto v0.0.0-20221001003018-1ab2364d2a91"
	"github.com/smallstep/zcrypto v0.0.0-20221001003018-1ab2364d2a91/go.mod"
	"github.com/smallstep/zlint v0.0.0-20220930192201-67fb4aa21910"
	"github.com/smallstep/zlint v0.0.0-20220930192201-67fb4aa21910/go.mod"
	"github.com/spaolacci/murmur3 v0.0.0-20180118202830-f09979ecbc72/go.mod"
	"github.com/spaolacci/murmur3 v1.1.0"
	"github.com/spaolacci/murmur3 v1.1.0/go.mod"
	"github.com/spf13/afero v1.1.2/go.mod"
	"github.com/spf13/cast v1.3.0/go.mod"
	"github.com/spf13/cast v1.7.0"
	"github.com/spf13/cast v1.7.0/go.mod"
	"github.com/spf13/cobra v0.0.5/go.mod"
	"github.com/spf13/jwalterweatherman v1.0.0/go.mod"
	"github.com/spf13/pflag v1.0.3/go.mod"
	"github.com/spf13/viper v1.3.2/go.mod"
	"github.com/stretchr/objx v0.1.0/go.mod"
	"github.com/stretchr/objx v0.4.0/go.mod"
	"github.com/stretchr/objx v0.5.0/go.mod"
	"github.com/stretchr/objx v0.5.2/go.mod"
	"github.com/stretchr/testify v1.2.2/go.mod"
	"github.com/stretchr/testify v1.3.0/go.mod"
	"github.com/stretchr/testify v1.4.0/go.mod"
	"github.com/stretchr/testify v1.7.0/go.mod"
	"github.com/stretchr/testify v1.7.1/go.mod"
	"github.com/stretchr/testify v1.8.0/go.mod"
	"github.com/stretchr/testify v1.8.4/go.mod"
	"github.com/stretchr/testify v1.9.0/go.mod"
	"github.com/stretchr/testify v1.10.0"
	"github.com/stretchr/testify v1.10.0/go.mod"
	"github.com/ugorji/go/codec v0.0.0-20181204163529-d75b2dcb6bc8/go.mod"
	"github.com/urfave/cli v1.22.16"
	"github.com/urfave/cli v1.22.16/go.mod"
	"github.com/weppos/publicsuffix-go v0.12.0/go.mod"
	"github.com/weppos/publicsuffix-go v0.20.0"
	"github.com/weppos/publicsuffix-go v0.20.0/go.mod"
	"github.com/weppos/publicsuffix-go/publicsuffix/generator v0.0.0-20220704091424-e0182326a282/go.mod"
	"github.com/x448/float16 v0.8.4"
	"github.com/x448/float16 v0.8.4/go.mod"
	"github.com/xordataexchange/crypt v0.0.3-0.20170626215501-b2862e3d0a77/go.mod"
	"github.com/yuin/goldmark v1.4.13/go.mod"
	"go.etcd.io/bbolt v1.3.11"
	"go.etcd.io/bbolt v1.3.11/go.mod"
	"go.mozilla.org/pkcs7 v0.9.0"
	"go.mozilla.org/pkcs7 v0.9.0/go.mod"
	"go.opentelemetry.io/auto/sdk v1.1.0"
	"go.opentelemetry.io/auto/sdk v1.1.0/go.mod"
	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.59.0"
	"go.opentelemetry.io/contrib/instrumentation/google.golang.org/grpc/otelgrpc v0.59.0/go.mod"
	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.59.0"
	"go.opentelemetry.io/contrib/instrumentation/net/http/otelhttp v0.59.0/go.mod"
	"go.opentelemetry.io/otel v1.34.0"
	"go.opentelemetry.io/otel v1.34.0/go.mod"
	"go.opentelemetry.io/otel/metric v1.34.0"
	"go.opentelemetry.io/otel/metric v1.34.0/go.mod"
	"go.opentelemetry.io/otel/sdk v1.34.0"
	"go.opentelemetry.io/otel/sdk v1.34.0/go.mod"
	"go.opentelemetry.io/otel/sdk/metric v1.34.0"
	"go.opentelemetry.io/otel/sdk/metric v1.34.0/go.mod"
	"go.opentelemetry.io/otel/trace v1.34.0"
	"go.opentelemetry.io/otel/trace v1.34.0/go.mod"
	"go.step.sm/crypto v0.59.1"
	"go.step.sm/crypto v0.59.1/go.mod"
	"go.uber.org/mock v0.5.0"
	"go.uber.org/mock v0.5.0/go.mod"
	"go.uber.org/multierr v1.11.0"
	"go.uber.org/multierr v1.11.0/go.mod"
	"golang.org/x/crypto v0.0.0-20181203042331-505ab145d0a9/go.mod"
	"golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2/go.mod"
	"golang.org/x/crypto v0.0.0-20210921155107-089bfa567519/go.mod"
	"golang.org/x/crypto v0.13.0/go.mod"
	"golang.org/x/crypto v0.19.0/go.mod"
	"golang.org/x/crypto v0.23.0/go.mod"
	"golang.org/x/crypto v0.27.0/go.mod"
	"golang.org/x/crypto v0.33.0/go.mod"
	"golang.org/x/crypto v0.36.0"
	"golang.org/x/crypto v0.36.0/go.mod"
	"golang.org/x/exp v0.0.0-20240531132922-fd00a4e0eefc"
	"golang.org/x/exp v0.0.0-20240531132922-fd00a4e0eefc/go.mod"
	"golang.org/x/mod v0.6.0-dev.0.20220419223038-86c51ed26bb4/go.mod"
	"golang.org/x/mod v0.8.0/go.mod"
	"golang.org/x/mod v0.12.0/go.mod"
	"golang.org/x/mod v0.15.0/go.mod"
	"golang.org/x/mod v0.17.0/go.mod"
	"golang.org/x/net v0.0.0-20190620200207-3b0461eec859/go.mod"
	"golang.org/x/net v0.0.0-20200202094626-16171245cfb2/go.mod"
	"golang.org/x/net v0.0.0-20210226172049-e18ecbb05110/go.mod"
	"golang.org/x/net v0.0.0-20220722155237-a158d28d115b/go.mod"
	"golang.org/x/net v0.6.0/go.mod"
	"golang.org/x/net v0.10.0/go.mod"
	"golang.org/x/net v0.15.0/go.mod"
	"golang.org/x/net v0.21.0/go.mod"
	"golang.org/x/net v0.25.0/go.mod"
	"golang.org/x/net v0.37.0"
	"golang.org/x/net v0.37.0/go.mod"
	"golang.org/x/oauth2 v0.28.0"
	"golang.org/x/oauth2 v0.28.0/go.mod"
	"golang.org/x/sync v0.0.0-20190423024810-112230192c58/go.mod"
	"golang.org/x/sync v0.0.0-20220722155255-886fb9371eb4/go.mod"
	"golang.org/x/sync v0.1.0/go.mod"
	"golang.org/x/sync v0.3.0/go.mod"
	"golang.org/x/sync v0.6.0/go.mod"
	"golang.org/x/sync v0.7.0/go.mod"
	"golang.org/x/sync v0.8.0/go.mod"
	"golang.org/x/sync v0.11.0/go.mod"
	"golang.org/x/sync v0.12.0"
	"golang.org/x/sync v0.12.0/go.mod"
	"golang.org/x/sys v0.0.0-20181122145206-62eef0e2fa9b/go.mod"
	"golang.org/x/sys v0.0.0-20181205085412-a5c9d58dba9a/go.mod"
	"golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a/go.mod"
	"golang.org/x/sys v0.0.0-20190626221950-04f50cda93cb/go.mod"
	"golang.org/x/sys v0.0.0-20201119102817-f84b799fce68/go.mod"
	"golang.org/x/sys v0.0.0-20210615035016-665e8c7367d1/go.mod"
	"golang.org/x/sys v0.0.0-20220310020820-b874c991c1a5/go.mod"
	"golang.org/x/sys v0.0.0-20220520151302-bc2c85ada10a/go.mod"
	"golang.org/x/sys v0.0.0-20220715151400-c0bba94af5f8/go.mod"
	"golang.org/x/sys v0.0.0-20220722155257-8c9f86f7a55f/go.mod"
	"golang.org/x/sys v0.0.0-20220811171246-fbc7d0a398ab/go.mod"
	"golang.org/x/sys v0.0.0-20221010170243-090e33056c14/go.mod"
	"golang.org/x/sys v0.1.0/go.mod"
	"golang.org/x/sys v0.5.0/go.mod"
	"golang.org/x/sys v0.6.0/go.mod"
	"golang.org/x/sys v0.8.0/go.mod"
	"golang.org/x/sys v0.12.0/go.mod"
	"golang.org/x/sys v0.17.0/go.mod"
	"golang.org/x/sys v0.20.0/go.mod"
	"golang.org/x/sys v0.25.0/go.mod"
	"golang.org/x/sys v0.30.0/go.mod"
	"golang.org/x/sys v0.31.0"
	"golang.org/x/sys v0.31.0/go.mod"
	"golang.org/x/telemetry v0.0.0-20240228155512-f48c80bd79b2/go.mod"
	"golang.org/x/term v0.0.0-20201126162022-7de9c90e9dd1/go.mod"
	"golang.org/x/term v0.0.0-20210927222741-03fcf44c2211/go.mod"
	"golang.org/x/term v0.5.0/go.mod"
	"golang.org/x/term v0.8.0/go.mod"
	"golang.org/x/term v0.12.0/go.mod"
	"golang.org/x/term v0.17.0/go.mod"
	"golang.org/x/term v0.20.0/go.mod"
	"golang.org/x/term v0.24.0/go.mod"
	"golang.org/x/term v0.29.0/go.mod"
	"golang.org/x/term v0.30.0"
	"golang.org/x/term v0.30.0/go.mod"
	"golang.org/x/text v0.3.0/go.mod"
	"golang.org/x/text v0.3.3/go.mod"
	"golang.org/x/text v0.3.7/go.mod"
	"golang.org/x/text v0.7.0/go.mod"
	"golang.org/x/text v0.9.0/go.mod"
	"golang.org/x/text v0.13.0/go.mod"
	"golang.org/x/text v0.14.0/go.mod"
	"golang.org/x/text v0.15.0/go.mod"
	"golang.org/x/text v0.18.0/go.mod"
	"golang.org/x/text v0.22.0/go.mod"
	"golang.org/x/text v0.23.0"
	"golang.org/x/text v0.23.0/go.mod"
	"golang.org/x/time v0.10.0"
	"golang.org/x/time v0.10.0/go.mod"
	"golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e/go.mod"
	"golang.org/x/tools v0.0.0-20191119224855-298f0cb1881e/go.mod"
	"golang.org/x/tools v0.1.12/go.mod"
	"golang.org/x/tools v0.6.0/go.mod"
	"golang.org/x/tools v0.13.0/go.mod"
	"golang.org/x/tools v0.21.1-0.20240508182429-e35e4ccd0d2d/go.mod"
	"golang.org/x/xerrors v0.0.0-20190717185122-a985d3407aa7/go.mod"
	"google.golang.org/api v0.224.0"
	"google.golang.org/api v0.224.0/go.mod"
	"google.golang.org/genproto v0.0.0-20250303144028-a0af3efb3deb"
	"google.golang.org/genproto v0.0.0-20250303144028-a0af3efb3deb/go.mod"
	"google.golang.org/genproto/googleapis/api v0.0.0-20250303144028-a0af3efb3deb"
	"google.golang.org/genproto/googleapis/api v0.0.0-20250303144028-a0af3efb3deb/go.mod"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20250303144028-a0af3efb3deb"
	"google.golang.org/genproto/googleapis/rpc v0.0.0-20250303144028-a0af3efb3deb/go.mod"
	"google.golang.org/grpc v1.71.0"
	"google.golang.org/grpc v1.71.0/go.mod"
	"google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1"
	"google.golang.org/grpc/cmd/protoc-gen-go-grpc v1.5.1/go.mod"
	"google.golang.org/protobuf v1.36.5"
	"google.golang.org/protobuf v1.36.5/go.mod"
	"gopkg.in/check.v1 v0.0.0-20161208181325-20d25e280405/go.mod"
	"gopkg.in/check.v1 v1.0.0-20190902080502-41f04d3bba15/go.mod"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c"
	"gopkg.in/check.v1 v1.0.0-20201130134442-10cb98267c6c/go.mod"
	"gopkg.in/yaml.v1 v1.0.0-20140924161607-9f9df34309c0/go.mod"
	"gopkg.in/yaml.v2 v2.2.2/go.mod"
	"gopkg.in/yaml.v2 v2.4.0/go.mod"
	"gopkg.in/yaml.v3 v3.0.0-20200313102051-9f266ea9e77c/go.mod"
	"gopkg.in/yaml.v3 v3.0.1"
	"gopkg.in/yaml.v3 v3.0.1/go.mod"
	"howett.net/plist v1.0.0"
	"howett.net/plist v1.0.0/go.mod"
	"k8s.io/klog/v2 v2.130.1"
	"k8s.io/klog/v2 v2.130.1/go.mod"
	"software.sslmate.com/src/go-pkcs12 v0.5.0"
	"software.sslmate.com/src/go-pkcs12 v0.5.0/go.mod"
	)
go-module_set_globals

DESCRIPTION="A zero trust swiss army knife for working with X509"
HOMEPAGE="https://github.com/smallstep/cli"
SRC_URI="https://github.com/smallstep/cli/archive/v${PV}.tar.gz -> ${P}.tar.gz
	${EGO_SUM_SRC_URI}"
S="${WORKDIR}/cli-${PV}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="test"
PROPERTIES="test_network"

DOCS=( {CHANGELOG,README}.md )

DOC_CONTENTS="Run 'env-update && source /etc/profile' to\\n
export STEPPATH envvar, after that you can init CA via\\n
'step-cli ca init' into /etc/step directory.\\n\\n"

src_compile() {
	DATE="$(date -u '+%Y-%m-%d-%H%M UTC')"
	LDFLAGS="-w -X main.Version=${PV} -X \"main.BuildTime=${DATE}\""

	ego build -ldflags "${LDFLAGS}" -o step-cli ./cmd/...

	local completion
	for completion in bash fish zsh ; do
		edo ./step-cli completion ${completion} > step-cli.${completion}
		edo sed -i "s/step/step-cli/g" step-cli.${completion}
	done
}

src_test() {
	ego test -work ./...
}

src_install() {
	einstalldocs
	readme.gentoo_create_doc

	dobin step-cli
	doenvd "${FILESDIR}"/99step-cli
	systemd_dounit systemd/{cert-renewer@,ssh-cert-renewer}.service \
		systemd/cert-renewer.target systemd/{cert-renewer@,ssh-cert-renewer}.timer

	newbashcomp step-cli.bash step-cli
	newfishcomp step-cli.fish step-cli
	newzshcomp step-cli.zsh _step-cli
}

pkg_postinst() {
	readme.gentoo_print_elog
}
