# nest overlay

[![Number of ebuilds: 744](https://img.shields.io/badge/ebuild-744-orange.svg)](https://img.shields.io/badge/ebuild-744-orange.svg)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/2323/badge)](https://bestpractices.coreinfrastructure.org/en/projects/2323)
[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-%23FE5196?logo=conventionalcommits&logoColor=white)](https://www.conventionalcommits.org)
[![gentoo overlay](https://img.shields.io/badge/gentoo-overlay-yellow)](https://github.com/gentoo-mirror/nest)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/01c60be97b884ea78bba7c232a4d8ca8)](https://www.codacy.com/gh/SpiderX/portage-overlay/dashboard?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=SpiderX/portage-overlay&amp;utm_campaign=Badge_Grade)
[![gentoo qa-reports](https://img.shields.io/badge/gentoo-QA%20report-6E56AF)](https://qa-reports.gentoo.org/output/repos/nest.html)
[![linters](https://github.com/SpiderX/portage-overlay/actions/workflows/linters.yml/badge.svg)](https://github.com/SpiderX/portage-overlay/actions/workflows/linters.yml)
[![sasts](https://github.com/SpiderX/portage-overlay/actions/workflows/sasts.yml/badge.svg)](https://github.com/SpiderX/portage-overlay/actions/workflows/sasts.yml)
[![docs](https://github.com/SpiderX/portage-overlay/actions/workflows/docs.yml/badge.svg)](https://github.com/SpiderX/portage-overlay/actions/workflows/docs.yml)

## How to use this overlay

For automatic install, you must have [`app-eselect/eselect-repository`](https://packages.gentoo.org/packages/app-eselect/eselect-repository)
or [`app-portage/layman`](https://packages.gentoo.org/packages/app-portage/layman) installed on your system for this to work.

### `eselect-repository`
```console
eselect repository enable nest
```

### `layman`
```console
layman -fa nest
```

For manual install, through [local overlay](https://wiki.gentoo.org/wiki/Creating_an_ebuild_repository), you should add this in `/etc/portage/repos.conf/nest.conf`:

```console
[nest]
location = /var/db/repos/nest
sync-type = git
sync-uri = https://github.com/gentoo-mirror/nest.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.

## List of Ebuilds

This overlay consists of an [Gentoo Portage](https://www.gentoo.org/) ebuilds for projects:

<details>
    <summary>Expand</summary>

*   app-admin/[awsdtc](https://github.com/c1982/awsdtc) | AWS Data Transfer Cost Explorer
*   app-admin/[aws-sam-cli](https://github.com/aws/aws-sam-cli) | CLI tool to manage Serverless applications using AWS SAM
*   app-admin/[awslimitchecker](https://github.com/jantman/awslimitchecker) | Utility to check AWS resource limits and usage
*   app-admin/[awslog](https://github.com/jaksi/awslog) | History and changes of configuration versions of AWS resources
*   app-admin/[awsls](https://github.com/jckuester/awsls) | A list command for AWS resources
*   app-admin/[awsometag](https://github.com/mhausenblas/awsometag) | Simple command-line snippet manager
*   app-admin/[awsume](https://github.com/trek10inc/awsume) | A utility for easily assuming AWS IAM roles from command line
*   app-admin/[awstaghelper](https://github.com/mpostument/awstaghelper) | AWS bulk tagging tool
*   app-admin/[aws-vault](https://github.com/99designs/aws-vault) | A vault for securely storing and accessing AWS credentials
*   app-admin/[azcopy](https://github.com/Azure/azure-storage-azcopy) | A command-line utility to manage Azure Storage accounts
*   app-admin/[cfn-policy-validator](https://github.com/awslabs/aws-cloudformation-iam-policy-validator) | IAM Policy Validator for AWS CloudFormation
*   app-admin/[cli53](https://github.com/barnybug/cli53) | Command line tool for Amazon Route 53
*   app-admin/[container-service-extension](https://github.com/vmware/container-service-extension) | Container Service Extension for vCloud Director
*   app-admin/[csp-reporter](https://github.com/yandex/csp-reporter) | Content Security Policy logs parser
*   app-admin/[cw](https://github.com/lucagrulla/cw) | Tail AWS CloudWatch Logs from your terminal
*   app-admin/[digaws](https://github.com/sampointer/digaws) | Look up region and other information for any AWS IP address
*   app-admin/[digaz](https://github.com/sampointer/digaz) | Look up region and other information for any Azure IP address
*   app-admin/[digg](https://github.com/sampointer/digg) | Look up region and other information for any Google IP address
*   app-admin/[docker-pretty-ps](https://github.com/politeauthority/docker-pretty-ps) | docker ps in colored and long output
*   app-admin/[doctl](https://github.com/digitalocean/doctl) | A command line tool for DigitalOcean services
*   app-admin/[ebs-autoresize](https://github.com/mpostument/ebs-autoresize) | Automatically resize EBS
*   app-admin/[fselect](https://github.com/jhspetersson/fselect) | Find files with SQL-like queries
*   app-admin/[glaball](https://github.com/flant/glaball) | Gitlab bulk administration tool
*   app-admin/[grex](https://github.com/pemistahl/grex) | A CLI tool for generating regular expressions
*   app-admin/[ibmcloud-bin](https://github.com/IBM-Cloud/ibm-cloud-cli-release) | IBM Cloud Developer Tools
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/qtpass.svg?header=)](https://repology.org/project/qtpass/versions) app-admin/[qtpass](https://qtpass.org) | Multi-platform GUI for pass, the standard unix password manager
*   app-admin/[jl](https://github.com/koenbollen/jl) | A tool for working with structured JSON logging
*   app-admin/[mkeosimg](https://github.com/sowbug/mkeosimg) | Ubiquiti EdgeOS image from a system tarball
*   app-admin/[ngxtop-ce](https://github.com/ngxtop/ngxtop) | real-time metrics for nginx server (and others)
*   app-admin/[netutils-linux](https://github.com/strizhechenko/netutils-linux) | Suite of network stack performance tunning utilities
*   app-admin/[rain](https://github.com/aws-cloudformation/rain) | A development workflow tool for working with AWS CloudFormation
*   app-admin/[reach](https://github.com/luhring/reach) | A static network verification tool for AWS
*   app-admin/[reprepro](https://salsa.debian.org/brlink/reprepro) | A tool to handle local repositories of Debian packages
*   app-admin/[rhit](https://github.com/Canop/rhit) | A nginx log explorer
*   app-admin/[ripe-atlas-tools](https://github.com/RIPE-NCC/ripe-atlas-tools) | The official command-line client for RIPE Atlas
*   app-admin/[saw](https://github.com/TylerBrock/saw) | Fast, multi-purpose tool for AWS CloudWatch Logs
*   app-admin/[semaphore-bin](https://github.com/ansible-semaphore/semaphore) | Modern UI for Ansible
*   app-admin/[sinker](https://github.com/plexsystems/sinker) | Sync images from one container registry to another
*   app-admin/[sops](https://github.com/mozilla/sops) | Simple and flexible tool for managing secrets
*   app-admin/[spotinfo](https://github.com/alexei-led/spotinfo) | Exploring AWS EC2 Spot inventory
*   app-admin/[terraform-provider-proxmox](https://registry.terraform.io/providers/bpg/proxmox/latest/docs) | Terraform Provider for Proxmox
*   app-admin/[terraform-provider-vcd](https://registry.terraform.io/providers/vmware/vcd/latest/docs) | Terraform VMware vCloud Director provider
*   app-admin/[topngx](https://github.com/gsquire/topngx) | A top for NGINX
*   app-admin/[trailscraper](https://github.com/flosell/trailscraper) | Command-line tool to get information out of AWS CloudTrail
*   app-admin/[tztail](https://github.com/thecasualcoder/tztail) | A log view in various timezones
*   app-admin/[userdbadm](https://nasauber.de/opensource/userdbadm/) | Tool to manage (PAM) userdb files with crypted passwords
*   app-admin/[uwsgitop](https://github.com/xrmx/uwsgitop) | uWSGI stats viewer
*   app-admin/[vault-backend-migrator](https://github.com/adamdecaf/vault-backend-migrator) | Tool to migrate data across vault clusters
*   app-admin/[vcd-cli](https://github.com/vmware/vcd-cli) | Utility to check AWS resource limits and usage
*   app-admin/[vector-bin](https://github.com/vectordotdev/vector) | High performance logs, metrics, and events router
*   app-admin/[whatfiles](https://github.com/spieglt/whatfiles) | Log what files are accessed by any Linux process
*   app-admin/[yaml-vault](https://github.com/Jimdo/yaml-vault) | Utility to import/export data from HashiCorp Vault
*   app-backup/[clickhouse-backup](https://github.com/AlexAkulov/clickhouse-backup) | Tool for easy ClickHouse backup and restore
*   app-backup/[hashget](https://github.com/yaroslaff/hashget) | Deduplication tool for archiving data with extremely high ratio
*   app-backup/[pgbackrest](https://pgbackrest.org) | Reliable PostgreSQL Backup & Restore
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/zbackup.svg?header=)](https://repology.org/project/zbackup/versions) app-backup/[zbackup](https://github.com/zbackup/zbackup) | A versatile deduplicating backup tool
*   app-backup/[urbackup-client](https://www.urbackup.org/) | Client Server backup system
*   app-backup/[urbackup-server](https://www.urbackup.org/) | Client Server backup system
*   app-backup/[wal-g](https://github.com/wal-g/wal-g) | Archival restoration tool for databases
*   app-containers/[lazydocker](https://github.com/jesseduffield/lazydocker) | Lazier way to manage everything docker
*   app-crypt/[acmebot](https://github.com/plinss/acmebot) | ACME protocol automatic certitificate manager
*   app-crypt/[acme-client](https://git.sr.ht/~graywolf/acme-client-portable) | Secure Let's Encrypt client
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/acme.sh.svg?header=)](https://repology.org/project/acme.sh/versions) app-crypt/[acme-sh](https://github.com/acmesh-official/acme.sh) | An ACME Shell script
*   app-crypt/[age](https://github.com/FiloSottile/age) | Simple, modern and secure encryption tool
*   app-crypt/[qesteidutil](https://github.com/open-eid/qesteidutil) | Estonian ID card management desktop utility
*   app-crypt/[step-cli](https://github.com/smallstep/cli) | A zero trust swiss army knife for working with X509
*   app-crypt/[step-ca](https://github.com/smallstep/certificates) | A private certificate authority and ACME server
*   app-crypt/[totp](https://github.com/arcanericky/totp) | Time-Based One-Time Password Code Generator
*   app-editors/[qedit](http://hugo.pereira.free.fr/software/index.php) | Qt-based multi-purpose text editor
*   app-editors/[FeatherPad](https://github.com/tsujan/FeatherPad) | Lightweight Qt5 plain-text editor
*   app-editors/[lite](https://github.com/rxi/lite) | A lightweight text editor written in Lua
*   app-editors/[micro](https://github.com/zyedidia/micro) | A modern and intuitive terminal-based text editor
*   app-editors/[marktext](https://github.com/marktext/marktext) | A simple and elegant open-source markdown editor
*   app-editors/[notes](https://github.com/nuttyartist/notes) | Note taking application, write down your thoughts
*   app-editors/[NotepadNext](https://github.com/dail8859/NotepadNext) | A cross-platform reimplementation of Notepad++
*   app-editors/[obsidian](https://obsidian.md/) | A knowledge base of plain text Markdown files
*   app-editors/[typora](https://typora.io) | A minimal markdown editor and reader
*   app-emulation/[looking-glass](https://looking-glass.io) | A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough
*   app-emulation/[qio](https://github.com/SpiderX/qio) | QEMU Init OpenRC
*   app-emulation/[vmware-modules](https://github.com/mkubecek/vmware-host-modules) | VMware kernel modules
*   app-emulation/[vmware-vmrc](https://docs.vmware.com/en/VMware-Remote-Console/index.html) | VMware Remote Console
*   app-emulation/[vmware-workstation](https://www.vmware.com/products/desktop-hypervisor.html) | Emulate a complete PC without the performance overhead
*   app-forensics/[gitleaks](https://github.com/zricethezav/gitleaks) | Auditing git repository for secrets and keys
*   app-forensics/[whispers](https://github.com/adeptex/whispers) | Identify hardcoded secrets in static structured text
*   app-metrics/[amazon-cloudwatch-agent](https://github.com/aws/amazon-cloudwatch-agent) | Amazon Cloudwatch Agent
*   app-metrics/[aws-otel-collector](https://github.com/aws-observability/aws-otel-collector) | Amazon AWS Opentelemetry Collector
*   app-metrics/[do-agent](https://github.com/digitalocean/do-agent) | DigitalOcean Agent for Enhanced Droplet Graphs
*   app-metrics/[nginx-amplify-agent](https://amplify.nginx.com/login) | System and NGINX metric collection
*   app-misc/[ag](https://github.com/ggreer/the_silver_searcher) | A code-searching tool with a focus on speed
*   app-misc/[android-file-transfer-linux](https://whoozle.github.io/android-file-transfer-linux/) | Reliable MTP client with minimalistic UI
*   app-misc/[ccut](https://github.com/ColumPaget/ColumsCut) | A unix cut command with a couple of extra features
*   app-misc/[cheat](https://github.com/cheat/cheat) | Interactive cheatsheets on the command-line
*   app-misc/[cointop](https://github.com/cointop-sh/cointop) | Interactive cryptocurrency monitor
*   app-misc/[cryptr-bin](https://github.com/jgraph/drawio-desktop) | Diagram drawing application built on web technology
*   app-misc/[deco](https://sourceforge.net/projects/deco/) | Demos Commander, a free Norton Commander clone
*   app-misc/[fq](https://github.com/wader/fq) | Command-line JSON processor for binary data
*   app-misc/[gron](https://github.com/tomnomnom/gron) | Make JSON greppable
*   app-misc/[jshon](http://kmkeen.com/jshon/) | JSON parser designed for maximum convenience within the shell
*   app-misc/[jsqry-cli2-bin](https://github.com/jsqry/jsqry-cli2) | CLI tool (similar to jq) to query JSON using sane DSL
*   app-misc/[mop](https://github.com/mop-tracker/mop) | Stock market tracker for hackers
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/pet.svg?header=)](https://repology.org/project/pet/versions) app-misc/[pet](https://github.com/knqyf263/pet) | Simple command-line snippet manager
*   app-misc/[topfew](https://github.com/timbray/topfew) | Finds most often fields in a stream of records
*   app-misc/[up](https://github.com/akavel/up) | Tool for writing Linux pipes with instant live preview
*   app-misc/[xsv](https://github.com/BurntSushi/xsv) | A fast CSV command line toolkit
*   app-office/[webull-desktop](https://www.webull.com/introduce/desktop-native) | Invest in stocks, ETFs, and options with Webull Financial
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/peco.svg?header=)](https://repology.org/project/peco/versions) app-shells/[peco](https://github.com/peco/peco) | Simplistic interactive filtering tool
*   app-shells/[zoxide](https://github.com/ajeetdsouza/zoxide) | A smarter cd command with supports of all major shells
*   app-text/[confget](https://devel.ringlet.net/textproc/confget/) | Read variables from INI-style configuration files
*   app-text/[keening](https://github.com/SpiderX/keening) | A simple command line pastebin designed to be used together with ssh
*   app-text/[notes](https://github.com/nuttyartist/notes) | Note taking application, write down your thoughts
*   dev-cpp/[belr](https://gitlab.linphone.org/BC/public/belr) | Language recognition library by Belledonne Communications
*   dev-cpp/[commoncpp2](http://www.gnu.org/software/commoncpp/) | GNU Common C++ 2
*   dev-cpp/[jsoncpp](https://github.com/open-source-parsers/jsoncpp) | CMake files for C++ JSON reader and writer
*   dev-cpp/[libodb](https://codesynthesis.com/products/odb/) | Common ODB runtime library
*   dev-cpp/[libodb-sqlite](https://codesynthesis.com/products/odb/) | Common ODB runtime library
*   dev-cpp/[libxsd](https://www.codesynthesis.com/products/xsd/) | A cross-platform W3C XML Schema to C++ data binding compiler library
*   dev-cpp/[libxsd-frontend](https://www.codesynthesis.com/projects/libxsd-frontend/) | A compiler frontend for the W3C XML Schema definition language
*   dev-cpp/[libcutl](https://www.codesynthesis.com/projects/libcutl/) | A collection of C++ libraries (successor of libcult)
*   dev-cpp/[open-eid-cmake](https://github.com/open-eid/cmake) | Open Electronic Identity CMake modules
*   dev-cpp/[string-view-lite](https://github.com/martinmoene/string-view-lite) | A single-file header-only version of a C++17-like string_view
*   dev-cpp/[xsd](https://www.codesynthesis.com/products/xsd/) | A cross-platform W3C XML Schema to C++ data binding compiler
*   dev-db/[datanymizer](https://github.com/datanymizer/datanymizer) | Powerful database anonymizer with flexible rules
*   dev-db/[dbcrossbar](https://www.dbcrossbar.org) | Copy tabular data between databases, CSV files and cloud storage
*   dev-db/[dbgate-bin](https://github.com/dbgate/dbgate) | Database manager for MySQL, PostgreSQL, SQL Server and MongoDB
*   dev-db/[go-sqlcmd](https://github.com/microsoft/go-sqlcmd) | CLI for SQL Server and Azure SQL
*   dev-db/[litestream](https://github.com/benbjohnson/litestream) | Streaming replication for SQLite
*   dev-db/[mongodb-compass](https://github.com/mongodb-js/compass) | The MongoDB GUI
*   dev-db/[msodbcsql](https://docs.microsoft.com/en-us/sql/connect/odbc/microsoft-odbc-driver-for-sql-server?view=sql-server-ver15) | Microsoft ODBC Driver for SQL Server
*   dev-db/[mssql-cli](https://github.com/dbcli/mssql-cli) | CLI for SQL Server Database
*   dev-db/[mssql-scripter](https://github.com/microsoft/mssql-scripter) | CLI for scripting SQL Server Databases
*   dev-db/[mssql-tools](https://docs.microsoft.com/en-us/sql/tools/overview-sql-tools?view=sql-server-ver15) | Microsoft SQL Server Tools for Linux
*   dev-db/[pg_cron](https://github.com/citusdata/pg_cron) | Run periodic jobs in PostgreSQL
*   dev-db/[pg_hint_plan](https://github.com/ossc-db/pg_hint_plan) | Manually force decisions in execution plans of PostgreSQL
*   dev-db/[odyssey](https://github.com/yandex/odyssey) | Scalable PostgreSQL connection pooler
*   dev-db/[pg_page_verification](https://github.com/google/pg_page_verification) | Checksums verification on PostgreSQL data pages
*   dev-db/[pg_profile](https://github.com/zubkov-andrei/pg_profile) | Postgres historic performance reports
*   dev-db/[pg_repack](https://github.com/reorg/pg_repack) | PostgreSQL extension for data reorganization
*   dev-db/[pg_squeeze](https://github.com/cybertec-postgresql/pg_squeeze) | A PostgreSQL extension for automatic bloat cleanup
*   dev-db/[pg_timetable](https://github.com/cybertec-postgresql/pg_timetable) | Advanced scheduling for PostgreSQL
*   dev-db/[pgcenter](https://github.com/lesovsky/pgcenter) | Command-line admin tool for observing and troubleshooting Postgres
*   dev-db/[pipelinedb](https://github.com/pipelinedb/pipelinedb) | High-performance time-series aggregation for PostgreSQL
*   dev-db/[postgresql_anonymizer](https://gitlab.com/dalibo/postgresql_anonymizer) | Anonymization & Data Masking for PostgreSQL
*   dev-db/[sqlbench](https://github.com/felixge/sqlbench) | Measures and compares execution time of one or more SQL queries
*   dev-db/[sqlpackage](https://docs.microsoft.com/en-us/sql/tools/sqlpackage/sqlpackage?view=sql-server-ver15) | Automates SQL Server database development tasks
*   dev-db/[soci](https://github.com/SOCI/soci) | Database access library for C++
*   dev-db/[tableplus](https://tableplus.com) | Modern, native, and friendly GUI tool for relational databases
*   dev-db/[usql](https://github.com/xo/usql) | Universal command-line interface for SQL databases
*   dev-haskell/[ChasingBottoms](https://hackage.haskell.org/package/ChasingBottoms) | For testing partial and infinite values
*   dev-haskell/[OneTuple](https://github.com/haskellari/OneTuple) | Singleton Tuple
*   dev-haskell/[Ranged-sets](https://github.com/PaulJohnson/Ranged-sets) | Ranged sets for Haskell
*   dev-haskell/[ansi-wl-pprint](https://github.com/ekmett/ansi-wl-pprint) | The Wadler/Leijen Pretty Printer for colored ANSI terminal output
*   dev-haskell/[authenticate-oauth](https://github.com/yesodweb/authenticate) | Library to authenticate with OAuth for Haskell web applications
*   dev-haskell/[base-prelude](https://github.com/nikita-volkov/base-prelude) | The most complete prelude formed only from the base package
*   dev-haskell/[base-unicode-symbols](https://github.com/roelvandijk/base-unicode-symbols) | Unicode alternatives for common functions and operators
*   dev-haskell/[base64-bytestring](https://github.com/haskell/base64-bytestring) | Fast base64 encoding and decoding for Haskell
*   dev-haskell/[binary-parser](https://github.com/nikita-volkov/binary-parser) | A highly-efficient but limited parser API for bytestrings
*   dev-haskell/[bytestring-strict-builder](https://github.com/nikita-volkov/bytestring-strict-builder) | An efficient strict bytestring builder
*   dev-haskell/[bytestring-tree-builder](https://github.com/nikita-volkov/bytestring-tree-builder) | A ByteString builder implementation based on the binary tree
*   dev-haskell/[clock](https://github.com/corsis/clock) | High-resolution clock functions
*   dev-haskell/[concise](https://github.com/frasertweedale/hs-concise) | Utilities for Control.Lens.Cons
*   dev-haskell/[configurator-pg](https://github.com/robx/configurator-pg) | Reduced parser for configurator-ng config files
*   dev-haskell/[conversion](https://github.com/nikita-volkov/conversion) | Universal converter between values of different types
*   dev-haskell/[conversion-bytestring](https://github.com/nikita-volkov/conversion-bytestring) | Conversion instances for the bytestring library
*   dev-haskell/[conversion-text](https://github.com/nikita-volkov/conversion-text) | Conversion instances for the text library
*   dev-haskell/[crypto-pubkey-types](https://github.com/vincenthz/hs-crypto-pubkey-types) | Generic cryptography Public keys algorithm types
*   dev-haskell/[daemons](https://github.com/scvalex/daemons) | Daemons in Haskell made fun and easy
*   dev-haskell/[data-bword](https://github.com/mvv/data-bword) | Extra operations on binary words of fixed length
*   dev-haskell/[data-checked](https://github.com/mvv/data-checked) | Type-indexed runtime-checked properties for Haskell
*   dev-haskell/[data-dword](https://github.com/mvv/data-dword) | Stick two binary words together to get a bigger one
*   dev-haskell/[data-serializer](https://github.com/mvv/data-serializer) | Common API for Haskell serialization libraries
*   dev-haskell/[data-textual](https://github.com/mvv/data-textual) | Human-friendly textual representations for Haskell
*   dev-haskell/[deferred-folds](https://github.com/metrix-ai/deferred-folds) | Abstractions over deferred folds
*   dev-haskell/[drbg](https://github.com/TomMD/DRBG) | Deterministic random bit generator (aka PRNG)
*   dev-haskell/[either](https://github.com/ekmett/either) | An either monad transformer
*   dev-haskell/[expiring-cache-map](https://codeberg.org/elblake/expiring-cache-map) | General purpose simple caching
*   dev-haskell/[filelock](https://github.com/takano-akio/filelock) | Portable interface to file locking
*   dev-haskell/[hasql](https://github.com/nikita-volkov/hasql) | An efficient PostgreSQL driver with a flexible mapping API
*   dev-haskell/[hasql-dynamic-statements](https://github.com/nikita-volkov/hasql-dynamic-statements) | Dynamic statements for Hasql
*   dev-haskell/[hasql-implicits](https://github.com/nikita-volkov/hasql-implicits) | Implicit definitions for Hasql
*   dev-haskell/[hasql-notifications](https://github.com/diogob/hasql-notifications) | PostgreSQL Asynchronous notification
*   dev-haskell/[hasql-pool](https://github.com/nikita-volkov/hasql-pool) | A pool of connections for Hasql
*   dev-haskell/[hasql-transaction](https://github.com/nikita-volkov/hasql-transaction) | Abstraction over transactions for Hasql
*   dev-haskell/[heredoc](https://hackage.haskell.org/package/heredoc) | multi-line string / here document using QuasiQuotes
*   dev-haskell/[hspec-expectations-lifted](https://github.com/hspec/hspec-expectations-lifted) | A version of hspec-expectations generalized to MonadIO
*   dev-haskell/[hspec-megaparsec](https://github.com/mrkkrp/hspec-megaparsec) | Utility functions for testing Megaparsec parsers with Hspec
*   dev-haskell/[hspec-wai](https://github.com/hspec/hspec-wai) | Experimental Hspec support for testing WAI applications
*   dev-haskell/[hspec-wai-json](https://github.com/hspec/hspec-wai) | Testing JSON APIs with hspec-wai
*   dev-haskell/[http-client](https://github.com/snoyberg/http-client) | An HTTP client engine
*   dev-haskell/[http-media](https://github.com/zmthy/http-media) | Processing HTTP Content-Type and Accept headers
*   dev-haskell/[indexed-profunctors](https://github.com/well-typed/optics) | Utilities for indexed profunctors
*   dev-haskell/[indexed-traversable-instances](https://github.com/haskellari/indexed-traversable) | More instances of FunctorWithIndex, FoldableWithIndex
*   dev-haskell/[ini](https://github.com/chrisdone/ini) | Quick and easy configuration files in the INI format
*   dev-haskell/[insert-ordered-containers](https://github.com/phadej/insert-ordered-containers) | Associative containers retating insertion order for traversals
*   dev-haskell/[integer-logarithms](https://github.com/Bodigrim/integer-logarithms) | Integer logarithms
*   dev-haskell/[integer-simple](https://hackage.haskell.org/package/integer-simple) | Simple Integer library
*   dev-haskell/[interpolatedstring-perl6](https://github.com/audreyt/interpolatedstring-perl6) | QuasiQuoter for Perl6 style multi-line interpolated
*   dev-haskell/[inspection-testing](https://github.com/nomeata/inspection-testing) | GHC plugin to do inspection testing
*   dev-haskell/[jose](https://github.com/frasertweedale/hs-jose) | Haskell JOSE and JWT library
*   dev-haskell/[json-ast](https://github.com/nikita-volkov/json-ast) | Universal JSON AST datastructure
*   dev-haskell/[loch-th](https://github.com/liskin/loch-th) | Support for precise error locations in source files
*   dev-haskell/[megaparsec](https://github.com/mrkkrp/megaparsec) | Monadic parser combinators
*   dev-haskell/[mime-mail](https://github.com/snoyberg/mime-mail) | Compose MIME email messages
*   dev-haskell/[modern-uri](https://github.com/mrkkrp/modern-uri) | Modern library for working with URIs
*   dev-haskell/[monad-time](https://github.com/scrive/monad-time) | Type class for monads which carry the notion of the current time
*   dev-haskell/[network-ip](https://github.com/mvv/network-ip) | Internet Protocol data structures
*   dev-haskell/[optics-core](https://github.com/well-typed/optics) | Optics as an abstract interface
*   dev-haskell/[optics-extra](https://github.com/well-typed/optics) | Extra utilities and instances for optics-core
*   dev-haskell/[optics-th](https://github.com/well-typed/optics) | Optics as an abstract interface
*   dev-haskell/[parser-combinators](https://github.com/mrkkrp/parser-combinators) | Lightweight package providing commonly useful parser combinators
*   dev-haskell/[pipes](https://github.com/Gabriella439/pipes) | Compositional pipelines
*   dev-haskell/[placeholders](https://github.com/ahammar/placeholders) | Placeholders for use while developing Haskell code
*   dev-haskell/[postgresql-binary](https://github.com/nikita-volkov/postgresql-binary) | Encoders and decoders for the PostgreSQL's binary format
*   dev-haskell/[postgresql-libpq](https://github.com/haskellari/postgresql-libpq) | low-level binding to libpq
*   dev-haskell/[postgresql-simple](https://github.com/haskellari/postgresql-libpq) | Mid-Level PostgreSQL client library
*   dev-haskell/[pretty-simple](https://github.com/cdepillabout/pretty-simple) | Haskell data types that have a Show instance
*   dev-haskell/[prettyprinter](https://github.com/quchen/prettyprinter) | A modern, easy to use, well-documented, extensible pretty-printer
*   dev-haskell/[prettyprinter-ansi-terminal](https://github.com/quchen/prettyprinter) | ANSI terminal backend for prettyprinter package
*   dev-haskell/[protolude](https://github.com/protolude/protolude) | A sensible starting Prelude template
*   dev-haskell/[ptr](https://github.com/nikita-volkov/ptr) | Abstractions for operations on pointers
*   dev-haskell/[rebase](https://github.com/nikita-volkov/rebase) | A more progressive alternative to the 'base' package
*   dev-haskell/[req](https://github.com/mrkkrp/req) | Easy-to-use, type-safe, expandable, high-level HTTP client library
*   dev-haskell/[rerebase](https://github.com/nikita-volkov/rerebase) | Reexports from 'base' with a bunch of other standard libraries
*   dev-haskell/[rsa](https://github.com/GaloisInc/RSA) | Implementation of RSA, using the padding schemes of PKCS#1 v2.1
*   dev-haskell/[scotty](https://github.com/scotty-web/scotty) | Haskell web framework
*   dev-haskell/[scrypt](https://github.com/informatikr/scrypt) | Stronger password hashing via sequential memory-hard functions
*   dev-haskell/[selective](https://github.com/snowleopard/selective) | Selective applicative functors
*   dev-haskell/[semigroups](https://github.com/ekmett/semigroups) | Anything that associates
*   dev-haskell/[swagger2](https://github.com/GetShopTV/swagger2) | Swagger 2.0 data model
*   dev-haskell/[tasty-hspec](https://github.com/mitchellwrosen/tasty-hspec) | Hspec support for the Tasty test framework
*   dev-haskell/[text-builder](https://github.com/nikita-volkov/text-builder) | An efficient strict text builder
*   dev-haskell/[text-latin1](https://github.com/mvv/text-latin1) | Latin-1 (including ASCII) utility functions for Haskell
*   dev-haskell/[text-printer](https://github.com/mvv/text-printer) | Abstract interace for Haskell text builders/printers
*   dev-haskell/[tz](https://github.com/nilcons/haskell-tz) | Library for time zone conversions
*   dev-haskell/[type-hint](https://github.com/mvv/type-hint) | Haskell library for helping type inference by using proxy values
*   dev-haskell/[tzdata](https://github.com/nilcons/haskell-tzdata) | Distribution of the standard time zone database
*   dev-haskell/[unordered-containers](https://github.com/haskell-unordered-containers/unordered-containers) | Efficient hashing-based container types
*   dev-haskell/[websockets](https://jaspervdj.be/websockets/) | Allows you to write WebSocket-capable servers
*   dev-haskell/[wai-cors](https://github.com/larskuhtz/wai-cors) | Cross-Origin resource sharing (CORS) for Wai
*   dev-haskell/[wai-middleware-static](https://github.com/scotty-web/wai-middleware-static) | WAI middleware that serves requests to static files
*   dev-haskell/[wai-websockets](https://github.com/yesodweb/wai) | Provide a bridge between WAI and the websockets package
*   dev-libs/[belcard](https://gitlab.linphone.org/BC/public/belcard) | VCard standard format manipulation library
*   dev-libs/[belle-sip](https://gitlab.linphone.org/BC/public/belle-sip) | SIP (RFC3261) implementation
*   dev-libs/[ccrtp](https://www.gnu.org/software/ccrtp/) | GNU ccRTP - Implementation of the IETF real-time transport protocol
*   dev-libs/[ucommon](https://www.gnu.org/software/commoncpp/) | A class framework that was specifically designed for telephony applications
*   dev-libs/[dstu-engine](https://github.com/dstucrypt/dstu-engine) | OpenSSL engine for DSTU 4145
*   dev-libs/[fastText](https://github.com/facebookresearch/fastText) | Library for fast text representation and classification
*   dev-libs/[libcommuni](https://communi.github.io) | A cross-platform IRC framework written with Qt
*   dev-libs/[libdatrie](https://github.com/tlwg/libdatrie) | Double-Array Trie Library
*   dev-libs/[libdict](https://github.com/rtbrick/libdict) | C library of key-value data structures
*   dev-libs/[libdigidoc](https://github.com/open-eid/libdigidoc) | DigiDoc digital signature library
*   dev-libs/[libdigidocpp](https://github.com/open-eid/libdigidocpp) | Library for handling digitally signed documents
*   dev-libs/[liblinphone](https://gitlab.linphone.org/BC/public/liblinphone) | SIP library supporting voice/video calls and text messaging
*   dev-libs/[libopenrazer](https://github.com/z3ntu/libopenrazer) | Qt wrapper around the D-Bus API from OpenRazer
*   dev-libs/[libthai](https://github.com/tlwg/libthai) | A a set of Thai language support routines
*   dev-libs/[lime](https://gitlab.linphone.org/BC/public/lime) | C++ library implementing Open Whisper System Signal protocol
*   dev-libs/[xml-security-c](https://santuario.apache.org) | Apache C++ XML security libraries
*   dev-libs/[zrtpcpp](https://github.com/wernerd/ZRTPCPP) | VCard standard format manipulation library
*   dev-lua/[lyaml](https://github.com/gvvaughan/lyaml) | LibYAML binding for Lua
*   dev-ml/[camlimages](https://gitlab.com/camlspotter/camlimages) | An image manipulation library for ocaml
*   dev-ml/[camomile](https://github.com/yoriyuki/Camomile) | A Unicode library for OCaml
*   dev-ml/[gd4o](https://github.com/savonet/gd4o) | OCaml interface to the GD graphics library
*   dev-ml/[memtrace](https://github.com/janestreet/memtrace) | Streaming client for OCaml's Memprof
*   dev-ml/[ocaml-alsa](https://github.com/savonet/ocaml-alsa) | OCaml bindings to alsa-lib
*   dev-ml/[ocaml-ao](https://github.com/savonet/ocaml-ao) | OCaml bindings to libao
*   dev-ml/[ocaml-bjack](https://github.com/savonet/ocaml-bjack) | OCaml blocking JACK API
*   dev-ml/[ocaml-cry](https://github.com/savonet/ocaml-cry) | OCaml native module for icecast/shoutcast source protocols
*   dev-ml/[ocaml-dssi](https://github.com/savonet/ocaml-dssi) | OCaml bindings to dssi
*   dev-ml/[ocaml-dtools](https://github.com/savonet/ocaml-dtools) | OCaml daemon tools library
*   dev-ml/[ocaml-duppy](https://github.com/savonet/ocaml-duppy) | OCaml advanced scheduler
*   dev-ml/[ocaml-faad](https://github.com/savonet/ocaml-faad) | OCaml bindings to faad2
*   dev-ml/[ocaml-fdkaac](https://github.com/savonet/ocaml-fdkaac) | OCaml bindings to fdk-aac
*   dev-ml/[ocaml-ffmpeg](https://github.com/savonet/ocaml-ffmpeg) | OCaml bindings to ffmpeg
*   dev-ml/[ocaml-flac](https://github.com/savonet/ocaml-flac) | OCaml bindings to flac
*   dev-ml/[ocaml-frei0r](https://github.com/savonet/ocaml-frei0r) | OCaml bindings to frei0r plugins
*   dev-ml/[ocaml-gavl](https://github.com/savonet/ocaml-gavl) | OCaml bindings to Gavl video manipulation library
*   dev-ml/[ocaml-gstreamer](https://github.com/savonet/ocaml-gstreamer) | OCaml bindings to gstreamer
*   dev-ml/[ocaml-inotify](https://github.com/whitequark/ocaml-inotify) | OCaml bindings for inotify
*   dev-ml/[ocaml-ladspa](https://github.com/savonet/ocaml-ladspa) | OCaml bindings to LADSPA plugins
*   dev-ml/[ocaml-lame](https://github.com/savonet/ocaml-lame) | OCaml bindings to lame
*   dev-ml/[ocaml-lastfm](https://github.com/savonet/ocaml-lastfm) | OCaml interface for Lastfm
*   dev-ml/[ocaml-lilv](https://github.com/savonet/ocaml-lilv) | OCaml bindings to lilv
*   dev-ml/[ocaml-lo](https://github.com/savonet/ocaml-lo) | OCaml bindings to liblo
*   dev-ml/[ocaml-mad](https://github.com/savonet/ocaml-mad) | OCaml bindings to libmad
*   dev-ml/[ocaml-magic](https://github.com/Chris00/ocaml-magic) | OCaml bindings to libmagic
*   dev-ml/[ocaml-mem_usage](https://github.com/savonet/ocaml-mem_usage) | Cross-platform memory usage information
*   dev-ml/[ocaml-mm](https://github.com/savonet/ocaml-mm) | OCaml multimedia library
*   dev-ml/[ocaml-ogg](https://github.com/savonet/ocaml-ogg) | OCaml bindings to libogg
*   dev-ml/[ocaml-opus](https://github.com/savonet/ocaml-opus) | OCaml bindings to opus
*   dev-ml/[ocaml-portaudio](https://github.com/savonet/ocaml-portaudio) | OCaml bindings to portaudio
*   dev-ml/[ocaml-posix](https://github.com/savonet/ocaml-posix) | OCaml bindings for posix sockets
*   dev-ml/[ocaml-pulseaudio](https://github.com/savonet/ocaml-pulseaudio) | OCaml bindings to pulseaudio
*   dev-ml/[ocaml-samplerate](https://github.com/savonet/ocaml-samplerate) | OCaml bindings to libsamplerate
*   dev-ml/[ocaml-shine](https://github.com/savonet/ocaml-shine) | OCaml bindings to libshine
*   dev-ml/[ocaml-soundtouch](https://github.com/savonet/ocaml-soundtouch) | OCaml bindings to libsoundtouch
*   dev-ml/[ocaml-speex](https://github.com/savonet/ocaml-speex) | OCaml bindings to speex
*   dev-ml/[ocaml-srt](https://github.com/savonet/ocaml-srt) | OCaml bindings for Secure, Reliable, Transport protocol library
*   dev-ml/[ocaml-syslog](https://github.com/geneanet/ocaml-syslog) | OCaml syslog client functions
*   dev-ml/[ocaml-taglib](https://github.com/savonet/ocaml-taglib) | OCaml bindings to taglib
*   dev-ml/[ocaml-theora](https://github.com/savonet/ocaml-theora) | OCaml bindings to libtheora
*   dev-ml/[ocaml-unix-errno](https://github.com/xapi-project/ocaml-unix-errno) | Unix errno types, maps, and support for OCaml
*   dev-ml/[ocaml-vorbis](https://github.com/savonet/ocaml-vorbis) | OCaml bindings to libvorbis
*   dev-ml/[ocaml-xmlplaylist](https://github.com/savonet/ocaml-xmlplaylist) | OCaml module to parse various RSS playlist formats
*   dev-ml/[tsdl](https://github.com/dbuenzli/tsdl) | Thin bindings to SDL for OCaml
*   dev-ml/[xmlm](https://github.com/dbuenzli/xmlm) | Ocaml XML manipulation module
*   dev-php/[scrypt]() | A PHP wrapper fo the scrypt hashing algorithm
*   dev-php/[spx](https://github.com/NoiseByNorthwest/php-spx) | A PHP wrapper fo the scrypt hashing algorithm
*   dev-python/[MarkupPy](https://github.com/tylerbakke/MarkupPy) | An HTML/XML generator
*   dev-python/[adal](https://github.com/AzureAD/azure-activedirectory-library-for-python) | Library for authentication in Azure Active Directory
*   dev-python/[ahocorasick](https://github.com/WojciechMula/pyahocorasick) | Python module implementing Aho-Corasick algorithm
*   dev-python/[aiomultiprocess](https://github.com/omnilib/aiomultiprocess) | asyncio version of the standard multiprocessing module
*   dev-python/[annoy](https://github.com/spotify/annoy) | Approximate Nearest Neighbors in C++/Python
*   dev-python/[anyconfig](https://github.com/ssato/python-anyconfig) | Generic access to configuration files in any formats
*   dev-python/[apispec](https://github.com/marshmallow-code/apispec) | A pluggable API specification generator
*   dev-python/[apispec-webframeworks](https://github.com/marshmallow-code/apispec-webframeworks) | Web framework plugins for apispec
*   dev-python/[applicationinsights](https://github.com/microsoft/ApplicationInsights-Python) | Application Insights SDK for Python
*   dev-python/[aspectlib](https://github.com/ionelmc/python-aspectlib) | Aspect-oriented programming, monkey-patch and decorators library
*   dev-python/[assertpy](https://github.com/assertpy/assertpy) | Assertion library for unit testing
*   dev-python/[aws-lambda-builders](https://github.com/aws/aws-lambda-builders) | Python library to manage AWS Lambda functions
*   dev-python/[aws-lambda-powertools](https://github.com/awslabs/aws-lambda-powertools-python) | A suite of Python utilities for AWS Lambda functions
*   dev-python/[azure-common](https://github.com/Azure/azure-python-devtools) | Microsoft Azure Client Common Library for Python
*   dev-python/[azure-core](https://github.com/Azure/azure-sdk-for-python) | Microsoft Azure Core Library for Python
*   dev-python/[azure-storage-blob](https://github.com/Azure/azure-sdk-for-python) | Microsoft Azure Storage Blobs Library for Python
*   dev-python/[bc-detect-secrets](https://github.com/bridgecrewio/detect-secrets) | A fork of enterprise friendly way of detecting and preventing secrets
*   dev-python/[bc-jsonpath-ng](https://github.com/bridgecrewio/jsonpath-ng) | Python JSONPath Next-Generation
*   dev-python/[bc-python-hcl2](https://github.com/bridgecrewio/python-hcl2) | A fork of parser for HCL2 written in Python
*   dev-python/[billiard](https://github.com/celery/billiard) | Multiprocessing Pool Extensions
*   dev-python/[binaryornot](https://github.com/audreyfeldroy/binaryornot) | Python package to guess whether a file is binary or text
*   dev-python/[boto3-stubs](https://github.com/youtype/mypy_boto3_builder) | Type annotations for boto3
*   dev-python/[botocore-stubs](https://github.com/youtype/botocore-stubs) | Type annotations and code completion for botocore
*   dev-python/[cached-property](https://github.com/pydanny/cached-property) | A cached-property for decorating methods in classes
*   dev-python/[celery](https://github.com/celery/celery) | Asynchronous task job queue based on distributed message passing
*   dev-python/[cerberus](https://github.com/pyeve/cerberus) | Lightweight and extensible data validation library for Python
*   dev-python/[chevron](https://github.com/noahmorrison/chevron) | Mustache templating language renderer
*   dev-python/[cfgv](https://github.com/asottile/cfgv) | Validate configuration and produce human readable error messages
*   dev-python/[click-completion](https://github.com/click-contrib/click-completion) | Enhanced completion for bash, fish, zsh in Click
*   dev-python/[click-didyoumean](https://github.com/click-contrib/click-didyoumean) | Enable git-like did-you-mean feature in click
*   dev-python/[click-help-colors](https://github.com/click-contrib/click-help-colors) | Colorization of help messages in Click
*   dev-python/[click-option-group](https://github.com/click-contrib/click-option-group) | Option groups missing in Click
*   dev-python/[click-repl](https://github.com/click-contrib/click-repl) | Subcommand REPL for click apps
*   dev-python/[colorpedia](https://github.com/joowani/colorpedia) | Command-line tool for looking up colors and palettes
*   dev-python/[configparser](https://github.com/jaraco/configparser) | Backport of configparser from Python 3
*   dev-python/[convertdate](https://github.com/fitnr/convertdate) | Utils for converting between date formats and calculating holidays
*   dev-python/[coreapi](https://github.com/core-api/python-client) | Python client library for Core API
*   dev-python/[coreschema](https://github.com/core-api/python-coreschema) | Python CoreSchema
*   dev-python/[crayons](https://github.com/kennethreitz/crayons) | Text UI colors
*   dev-python/[cron-descriptor](https://github.com/Salamek/cron-descriptor) | Converts cron expressions into human readable strings
*   dev-python/[crossplane](https://github.com/nginxinc/crossplane) | Fast and reliable NGINX configuration parser
*   dev-python/[ctypescrypto](https://github.com/vbwagner/ctypescrypto) | File format determination library for Python
*   dev-python/[curio](https://github.com/dabeaz/curio) | Coroutine-based library for concurrent Python systems programming
*   dev-python/[cyclonedx-python-lib](https://github.com/CycloneDX/cyclonedx-python-lib) | Python library for generating CycloneDX SBOMs
*   dev-python/[dataclasses](https://github.com/ericvsmith/dataclasses) | A backport of the dataclasses module for Python 3.6
*   dev-python/[dataclasses-jsonschema](https://github.com/s-knibbs/dataclasses-jsonschema) | JSON schema generation from dataclasses
*   dev-python/[datadiff](https://sourceforge.net/projects/datadiff/) | A library for diffs of python data structures
*   dev-python/[dateparser](https://github.com/scrapinghub/dateparser) | Date parsing library designed to parse dates from HTML pages
*   dev-python/[diagrams](https://github.com/mingrammer/diagrams) | Diagram as Code for prototyping cloud system architectures
*   dev-python/[decli](https://github.com/Woile/decli) | Minimal declarative cli tool
*   dev-python/[deep_merge](https://github.com/halfak/deep_merge) | A simple utility for merging python dictionaries
*   dev-python/[delegator-py](https://github.com/kennethreitz/delegator.py) | Simple library for dealing with subprocesses
*   dev-python/[dj-database-url](https://github.com/kennethreitz/dj-database-url) | URL bases database backend configuration in Django
*   dev-python/[dj-email-url](https://github.com/migonzalvar/dj-email-url) | URL based email backend configuration in Django
*   dev-python/[dj-search-url](https://github.com/dstufft/dj-search-url) | Environment based search backend configuration in Django
*   dev-python/[django-cache-url](https://github.com/epicserve/django-cache-url) | URL based cache backend configuration in Django
*   dev-python/[django-celery-beat](https://github.com/celery/django-celery-beat) | Celery Periodic Tasks for Django
*   dev-python/[django-configurations](https://github.com/jazzband/django-configurations) | A helper for organizing Django project settings
*   dev-python/[django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms) | DRY Django forms
*   dev-python/[django-debug-toolbar](https://github.com/django-debug-toolbar/django-debug-toolbar) | A configurable set of panels that display debug information
*   dev-python/[django-environ](https://github.com/joke2k/django-environ) | An environment variables to configure Django
*   dev-python/[django-fake-model](https://github.com/erm0l0v/django-fake-model) | A library for creating fake models in the unit tests
*   dev-python/[django-graphiql-debug-toolbar](https://github.com/flavors/django-graphiql-debug-toolbar) | Django Debug Toolbar for GraphiQL IDE
*   dev-python/[django-guardian](https://github.com/django-guardian/django-guardian) | Implementation of per object permissions for Django
*   dev-python/[django-jsonfield](https://github.com/dmkoch/django-jsonfield) | A Django field to store validated JSON in your model
*   dev-python/[django-jinja](https://github.com/niwinz/django-jinja) | Jinja2 templating language integrated in Django
*   dev-python/[django-js-asset](https://github.com/matthiask/django-js-asset) | A script tag with additional attributes for django.forms.Media
*   dev-python/[django-oauth-toolkit](https://github.com/jazzband/django-oauth-toolkit) | OAuth2 Provider for Django
*   dev-python/[django-pipeline](https://github.com/jazzband/django-pipeline) | An asset packaging library for Django
*   dev-python/[django-pglocks](https://github.com/Xof/django-pglocks) | PostgreSQL locking context managers and functions for Django
*   dev-python/[django-rest-framework-camel-case](https://github.com/vbabiy/djangorestframework-camel-case) | Camel case JSON support for Django REST framework
*   dev-python/[django-rest-framework-recursive](https://github.com/heywbj/django-rest-framework-recursive) | Recursive Serialization for Django REST framework
*   dev-python/[django-rest-swagger](https://marcgibbons.com/django-rest-swagger/) | Swagger UI for Django REST Framework
*   dev-python/[django-tables2](https://github.com/jieter/django-tables2) | Django application for creating HTML tables
*   dev-python/[dockerfile-parse](https://github.com/containerbuildsystem/dockerfile-parse) | Python library for parsing Dockerfile files
*   dev-python/[dpath](https://github.com/dpath-maintainers/dpath-python) | A python module that will check for package updates
*   dev-python/[drf-yasg](https://github.com/axnsan12/drf-yasg) | Yet another Swagger generator
*   dev-python/[editdistance](https://github.com/roy-ht/editdistance) | Fast implementation of the edit distance(Levenshtein distance)
*   dev-python/[editdistance-s](https://github.com/asottile/editdistance-s) | Fast implementation of edit (Levenshtein) distance
*   dev-python/[email-validator](https://github.com/JoshData/python-email-validator) | An email syntax and deliverability validation library
*   dev-python/[face](https://github.com/mahmoud/face) | Straightforward CLI parsing and dispatching microframework
*   dev-python/[factory_boy](https://github.com/FactoryBoy/factory_boy) | A fixtures replacement tool
*   dev-python/[fakeldap](https://github.com/zulip/fakeldap) | An implementation of a LDAPObject to fake a ldap server
*   dev-python/[faker](https://github.com/joke2k/faker) | Python package that generates fake data
*   dev-python/[filetype](https://github.com/h2non/filetype.py) | Infer file type and MIME type of any file/buffer
*   dev-python/[fire](https://github.com/google/python-fire) | Library for automatically generating CLI from object
*   dev-python/[fleep](https://github.com/floyernick/fleep-py) | File format determination library for Python
*   dev-python/[flex](https://github.com/pipermerriam/flex) | Validation tooling for Swagger 2.0 specifications
*   dev-python/[flup](https://www.saddi.com/software/flup/) | Random assortment of WSGI servers
*   dev-python/[forbiddenfruit](https://github.com/clarete/forbiddenfruit) | Patch python built-in objects
*   dev-python/[future](https://github.com/PythonCharmers/python-future) | Easy, clean, reliable Python 2/3 compatibility
*   dev-python/[gensim](https://github.com/piskvorky/gensim) | Topic Modelling for Humans
*   dev-python/[git-url-parse](https://github.com/coala/git-url-parse) | A simple GIT URL parser
*   dev-python/[glom](https://github.com/mahmoud/glom) | A declarative object transformer for conglomerating nested data
*   dev-python/[google-crc32c](https://github.com/googleapis/python-crc32c) | Hardware-based implementation of the CRC32C hashing algorithm
*   dev-python/[google-cloud-iam](https://github.com/googleapis/python-iam) | Google Cloud IAM API client library
*   dev-python/[google-cloud-core](https://github.com/googleapis/python-cloud-core) | Google Cloud API client core library
*   dev-python/[google-cloud-kms](https://github.com/googleapis/python-kms) | Google Cloud KMS API client library
*   dev-python/[google-cloud-pubsub](https://github.com/googleapis/python-pubsub) | Google Cloud Pub/Sub API client library
*   dev-python/[google-cloud-storage](https://github.com/googleapis/python-storage) | Google Cloud Storage API client library
*   dev-python/[google-cloud-testutils](https://github.com/googleapis/python-test-utils) | Google Cloud Storage API client library
*   dev-python/[google-resumable-media](https://github.com/googleapis/google-resumable-media-python) | Utilities for Google Media Downloads and Resumable Uploads
*   dev-python/[graphene](https://github.com/graphql-python/graphene) | GraphQL framework for Python
*   dev-python/[graphene-django](https://github.com/graphql-python/graphene-django) | A Django integration for Graphene
*   dev-python/[graphviz](https://github.com/xflr6/graphviz) | Simple Python interface for Graphviz
*   dev-python/[graphql-core](https://github.com/graphql-python/graphql-core) | Python port of GraphQL.js
*   dev-python/[graphql-relay](https://github.com/graphql-python/graphql-relay-py) | A library to help construct a graphql-py server supporting react-relay
*   dev-python/[grpc-google-iam-v1](https://github.com/googleapis/python-grpc-google-iam-v1) | Google GRPC IAM API client library
*   dev-python/[grpcio](https://grpc.io) | High-performance RPC framework (python libraries)
*   dev-python/[grpcio-status](https://grpc.io) | Status proto mapping for gRPC
*   dev-python/[gssapi](https://github.com/pythongssapi/python-gssapi) | A Python interface to RFC 2743/2744
*   dev-python/[hijridate](https://github.com/mhalshehri/hijri-converter) | Hijri-Gregorian date converter
*   dev-python/[hijri-converter](https://github.com/mhalshehri/hijri-converter) | Hijri-Gregorian date converter
*   dev-python/[identify](https://github.com/pre-commit/identify) | File identification library for Python
*   dev-python/[igraph](https://github.com/igraph/python-igraph) | Python interface for igraph
*   dev-python/[itypes](https://github.com/tomchristie/itypes) | Simple immutable types for python
*   dev-python/[jdatetime](https://github.com/slashmili/python-jalali) | Jalali implementation of Python's datetime module
*   dev-python/[jproperties](https://github.com/Tblue/python-jproperties) | Java Property file parser and writer for Python
*   dev-python/[jsmin](https://github.com/tikitu/jsmin) | JavaScript minifier
*   dev-python/[jsonfield](https://github.com/rpkilby/jsonfield) | A reusable Django model field for storing ad-hoc JSON data
*   dev-python/[jsonpath-ng](https://github.com/h2non/jsonpath-ng) | Python JSONPath Next-Generation
*   dev-python/[k5test](https://github.com/pythongssapi/k5test) | A library for setting up self-contained Kerberos 5 environments
*   dev-python/[langdetect](https://github.com/Mimino666/langdetect) | Language detection library ported from Google
*   dev-python/[livereload](https://github.com/lepture/python-livereload) | Python LiveReload is an awesome tool for web developers
*   dev-python/[luhn](https://github.com/mmcloughlin/luhn) | Generate and verify Luhn check digits
*   dev-python/[m9dicts](https://github.com/ssato/python-m9dicts) | A dict-like object supports recursive merge operation
*   dev-python/[markdown2](https://github.com/trentm/python-markdown2) | A fast and complete Python implementation of Markdown
*   dev-python/[markdown-include](https://github.com/cmacmackin/markdown-include) | Provides the inclusion of the contents of other Markdown documents
*   dev-python/[mock-django](https://github.com/dcramer/mock-django) | A simple library for mocking certain Django behavior
*   dev-python/[msrest](https://github.com/Azure/msrest-for-python) | AutoRest swagger generator Python client runtime
*   dev-python/[netaddr](https://github.com/drkjam/netaddr) | Network address representation and manipulation library
*   dev-python/[netapp-ontap](https://devnet.netapp.com/restapi.php) | A library for working with ONTAP's REST APIs simply in Python
*   dev-python/[ncclient](https://github.com/ncclient/ncclient) | Python library for NETCONF clients
*   dev-python/[nltk](https://github.com/nltk/nltk) | Topic Modelling for Humans
*   dev-python/[nltk-data](https://www.nltk.org/nltk_data/) | Data files for NLTK
*   dev-python/[nmslib](https://github.com/nmslib/nmslib) | Non-Metric Space Library
*   dev-python/[onetimepass](https://github.com/tadeck/onetimepass) | One-time password library for HOTP and TOTP passwords
*   dev-python/[openai](https://github.com/openai/openai-python) | The official Python library for the OpenAI API
*   dev-python/[openapi-schema-validator](https://github.com/p1c2u/openapi-schema-validator) | OpenAPI schema validation for Python
*   dev-python/[openapi-spec-validator](https://github.com/p1c2u/openapi-spec-validator) | OpenAPI Spec validator
*   dev-python/[outcome](https://github.com/python-trio/outcome) | Capture the outcome of Python function calls
*   dev-python/[oyaml](https://github.com/wimglenn/oyaml) | Ordered YAML
*   dev-python/[packageurl](https://github.com/package-url/packageurl-python) | Python implementation of the package url spec
*   dev-python/[parameterized](https://github.com/wolever/parameterized) | Parameterized testing with any Python test framework
*   dev-python/[parsel](https://github.com/scrapy/parsel) | Utility to extract data from XML/HTML documents using XPath or CSS selectors
*   dev-python/[pathspec](https://github.com/cpburnz/python-path-specification) | A utility library for pattern matching of file paths
*   dev-python/[polemarch-ansible](https://gitlab.com/vstconsulting/polemarch-ansible) | Wrapper for Ansible CLI
*   dev-python/[policyuniverse](https://github.com/Netflix-Skunkworks/policyuniverse) | Parse and Process AWS IAM Policies, Statements, ARNs
*   dev-python/[port-for](https://github.com/kmike/port-for) | An utility and python library for TCP ports management
*   dev-python/[prance](https://github.com/jfinkhaeuser/prance) | Resolving Swagger/OpenAPI 2.0 and 3.0 Parser
*   dev-python/[promise](https://github.com/syrusakbary/promise) | Python port of GraphQL.js
*   dev-python/[purl](https://github.com/codeinthehole/purl) | Simple Python URL class
*   dev-python/[py3dns](https://launchpad.net/py3dns) | Python 3 DNS library
*   dev-python/[pybeam](https://github.com/matwey/pybeam) | Python module to parse Erlang BEAM files
*   dev-python/[pycep](https://github.com/gruebel/pycep) | A Python based Bicep parser
*   dev-python/[pycfmodel](https://github.com/Skyscanner/pycfmodel) | A python model for Cloud Formation scripts
*   dev-python/[pydash](https://github.com/dgilland/pydash) | The kitchen sink of Python functional utility libraries
*   dev-python/[pyemd](https://github.com/wmayner/pyemd) | Fast EMD for Python
*   dev-python/[pygaljs](https://github.com/ionelmc/python-pygaljs) | Python package providing assets from js module for pygal
*   dev-python/[pymysql](https://github.com/PyMySQL/PyMySQL) | Pure-Python MySQL Driver
*   dev-python/[pyspnego](https://github.com/jborean93/pyspnego) | Python SPNEGO authentication library
*   dev-python/[pystache](https://github.com/PennyDreadfulMTG/pystache) | Mustache templating system for Python
*   dev-python/[pytest-benchmark](https://github.com/ionelmc/pytest-benchmark) | py.test fixture for benchmarking code
*   dev-python/[pytest-celery](https://github.com/click-contrib/click-repl) | Subcommand REPL for click apps
*   dev-python/[pytest-datadir-ng](https://github.com/Tblue/pytest-datadir-ng) | Fixtures for pytest to retrieve test resources from filesystem
*   dev-python/[pytest-django](https://github.com/pytest-dev/pytest-django) | A Django plugin for py.test
*   dev-python/[pytest-pythonpath](https://github.com/bigsassy/pytest-pythonpath) | plugin for adding to the PYTHONPATH from command line or configs
*   dev-python/[pytest-random-order](https://github.com/jbasko/pytest-random-order) | pytest plugin to randomise the order of tests
*   dev-python/[pytest-trio](https://github.com/python-trio/pytest-trio) | Python library for async concurrency and I/O
*   dev-python/[pytimeparse](https://github.com/wroberts/pytimeparse) | A library to parse time from human readable string
*   dev-python/[pythonqt](https://mevislab.github.io/pythonqt/) | A dynamic Python binding for the Qt framework
*   dev-python/[python-crontab](https://gitlab.com/doctormo/python-crontab/) | Crontab module for reading and writing crontab files
*   dev-python/[python-gilt](https://github.com/metacloud/gilt) | A GIT layering tool
*   dev-python/[python-openapi-codec](https://github.com/core-api/python-openapi-codec) | An OpenAPI codec for Core API
*   dev-python/[python-user-agents](https://github.com/selwin/python-user-agents) | A library to identify devices by parsing user agent strings
*   dev-python/[pykickstart](https://github.com/pykickstart/pykickstart) | Python library for reading and writing kickstart files
*   dev-python/[pyvcloud](https://github.com/vmware/pyvcloud) | VMware vCloud Director Python SDK
*   dev-python/[pyvmomi](https://github.com/vmware/pyvmomi) | VMware vSphere API Python Bindings
*   dev-python/[pywinrm](https://github.com/diyan/pywinrm) | Python library for Windows Remote Management
*   dev-python/[PyMeeus](https://github.com/architest/pymeeus) | Library of astronomical algorithms in Python
*   dev-python/[questionary](https://github.com/tmbo/questionary) | Python library to build pretty command line user prompts
*   dev-python/[random2](https://github.com/strichter/random2) | Python-2.7 random module ported to python-3
*   dev-python/[requests-mock](https://github.com/jamielennox/requests-mock) | Mock out responses from the requests package
*   dev-python/[reprint](https://github.com/Yinzo/reprint) | Binding variables and refreshing multi-line output in terminal
*   dev-python/[respx](https://github.com/lundberg/respx) | Mock HTTPX with request patterns and response side effects
*   dev-python/[rich](https://github.com/willmcgugan/rich) | Validate configuration and produce human readable error messages
*   dev-python/[ripe-atlas-cousteau](https://github.com/RIPE-NCC/ripe-atlas-cousteau) | Official python wrapper around RIPE Atlas API
*   dev-python/[ripe-atlas-sagan](https://github.com/RIPE-NCC/ripe-atlas-sagan) | A parsing library for RIPE Atlas measurement results
*   dev-python/[route53-transfer](https://github.com/cosmin/route53-transfer) | Generic access to configuration files in any formats
*   dev-python/[rstr](https://pypi.org/project/rstr/) | Generate random strings in Python
*   dev-python/[schema](https://github.com/keleshev/schema) | Simple data validation library
*   dev-python/[scikit-learn](https://github.com/scikit-learn/scikit-learn) | Machine learning in Python
*   dev-python/[selinux](https://github.com/pycontribs/selinux) | Pure-python selinux shim module for use in virtualenvs
*   dev-python/[sentry-sdk](https://github.com/getsentry/sentry-python) | Python client for Sentry
*   dev-python/[serializable](https://github.com/madpah/serializable) | Serialize and deserialize Python objects to and from JSON and XML
*   dev-python/[shellingham](https://github.com/sarugaku/shellingham) | Detects what shell the current Python executable is running in
*   dev-python/[shouldbe](https://github.com/directxman12/should_be) | A Python Assertions Helper
*   dev-python/[smart-open](https://github.com/piskvorky/smart_open) | Utils for streaming large files
*   dev-python/[sniffio](https://github.com/python-trio/sniffio) | Sniff out which async library your code is running under
*   dev-python/[social-auth-core](https://github.com/python-social-auth/social-core) | Python Social Auth - Core
*   dev-python/[social-auth-app-django](https://github.com/python-social-auth/social-app-django) | Python Social Auth - Application - Django
*   dev-python/[sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild) | Autorebuild documentation on change
*   dev-python/[sphinxcontrib-httpdomain](https://github.com/sphinx-contrib/httpdomain) | Documenting RESTful HTTP APIs
*   dev-python/[sphinxcontrib-mermaid](https://github.com/mgaitan/sphinxcontrib-mermaid) | Mermaid diagrams in sphinx powered docs
*   dev-python/[sphinxcontrib-openapi](https://github.com/sphinx-contrib/openapi) | Sphinx extension to generate APIs docs from OpenAPI
*   dev-python/[ssh2-python](https://github.com/ParallelSSH/ssh2-python) | Super fast SSH2 protocol library, Python bindings for libssh2
*   dev-python/[swagger_spec_validator](https://github.com/Yelp/swagger_spec_validator) | Python library that validates Swagger Specs
*   dev-python/[tablib](https://github.com/jazzband/tablib) | Format-agnostic tabular dataset library
*   dev-python/[testinfra](https://github.com/pytest-dev/pytest-testinfra) | Testinfra test your infrastructures
*   dev-python/[text-unidecode](https://github.com/kmike/text-unidecode) | The most basic Text::Unidecode port
*   dev-python/[timecop](https://github.com/bluekelp/pytimecop) | A port of TimeCop Ruby Gem for Python
*   dev-python/[tree-format](https://github.com/jml/tree-format) | Python library for printing trees on the console
*   dev-python/[types-awscrt](https://github.com/youtype/types-awscrt) | Type annotations and code completion for awscrt
*   dev-python/[types-chardet](https://github.com/python/typeshed) | Collection of library stubs for Python, with static types
*   dev-python/[types-s3transfer](https://github.com/youtype/types-s3transfer) | Type annotations and code completion for s3transfer
*   dev-python/[ua-parser](https://github.com/ua-parser/uap-python) | A python implementation of the UA Parser
*   dev-python/[ujson](https://github.com/esnme/ultrajson) | Ultra fast JSON encoder and decoder for Python
*   dev-python/[ukpostcodeparser](https://github.com/hamstah/ukpostcodeparser) | UK postcode parser library
*   dev-python/[umalqurra](https://github.com/tytkal/python-hijiri-ummalqura) | Date Api that support Hijri Umalqurra calendar
*   dev-python/[unittest-xml-reporting](https://github.com/xmlrunner/unittest-xml-reporting) | unittest-based test runner with Ant/JUnit like XML reporting
*   dev-python/[update-checker](https://github.com/bboe/update_checker) | A python module that will check for package updates
*   dev-python/[validate_email](https://github.com/syrusakbary/validate_email) | Python email validation library
*   dev-python/[validators](https://github.com/kvesteri/validators) | Python data validation library
*   dev-python/[vcd-api-schemas-type](https://github.com/vmware/vcd-api-schemas) | VMware vCloud Director Python API Schemas Type
*   dev-python/[versionfinder](https://github.com/jantman/versionfinder) | Find version of python package, installed via pip, setuptools, git
*   dev-python/[vsphere-guest-run](https://github.com/vmware/vsphere-guest-run) | Python library for guest operations
*   dev-python/[w3lib](https://github.com/scrapy/w3lib) | Library of web-related functions
*   dev-util/[actionlint](https://github.com/rhysd/actionlint) | Static checker for GitHub Actions workflow files
*   dev-util/[ansible-molecule](https://github.com/ansible/molecule) | Automated testing for Ansible roles
*   dev-util/[arctype](https://arctype.com) | SQL client for PostgreSQL and MySQL
*   dev-util/[asio_wrapper](https://github.com/compwizk/asio_wrapper) | ASIO standalone CMake installer
*   dev-util/[aws-config-rdk](https://github.com/awslabs/aws-config-rdk) | AWS Config Rules Development Kit
*   dev-util/[aws-config-rdklib](https://github.com/awslabs/aws-config-rdklib) | Rule Development Kit Library for AWS Config
*   dev-util/[bcunit](https://gitlab.linphone.org/BC/public/bcunit) | BC Unit Test Framework
*   dev-util/[beekeeper-studio-bin](https://www.beekeeperstudio.io) | SQL client for MySQL, Postgres, SQLite, SQL Server, and more
*   dev-util/[build2](https://build2.org) | Cross-platform toolchain for building and packaging C++ code
*   dev-util/[cfn-format](https://github.com/awslabs/aws-cloudformation-template-formatter) | AWS CloudFormation Template Formatter
*   dev-util/[cfn-guard](https://github.com/aws-cloudformation/cloudformation-guard) | AWS CloudFormation Guard
*   dev-util/[cfn-skeleton](https://github.com/awslabs/aws-cloudformation-template-builder) | AWS Cloudformation Template Builder
*   dev-util/[cfn-template-flip](https://github.com/awslabs/aws-cfn-template-flip) | AWS CloudFormation Template Flip
*   dev-util/[cfripper](https://github.com/Skyscanner/cfripper) | Analysing CloudFormation templates for security compliance
*   dev-util/[checkov](https://github.com/bridgecrewio/checkov) | Static code analysis tool for infrastructure-as-code
*   dev-util/[cli](https://www.codesynthesis.com/projects/cli/) | Command Line Interface compiler for C++
*   dev-util/[cloud-utils](https://launchpad.net/cloud-utils) | Utilities for interacting with a cloud
*   dev-util/[cloudsplaining](https://github.com/salesforce/cloudsplaining) | AWS IAM Security Assessment tool
*   dev-util/[css-html-js-minify](https://github.com/juancarlospaco/css-html-js-minify) | StandAlone Async cross-platform Minifier for the Web
*   dev-util/[cupt](https://github.com/jackyf/cupt) | Package manager for Debian
*   dev-util/[desed](https://github.com/SoptikHa2/desed) | Debugger for Sed
*   dev-util/[detect-secrets](https://github.com/Yelp/detect-secrets) | An enterprise friendly way of detecting and preventing secrets
*   dev-util/[dropwatch](https://github.com/nhorman/dropwatch) | Monitor for dropped network packets
*   dev-util/[dtm](https://github.com/dtm-labs/dtm) | Distributed transaction framework
*   dev-util/[duplicate-code-detection-tool](https://github.com/platisd/duplicate-code-detection-tool) | A tool to detect similarities between files within a repository
*   dev-util/[fossa-cli](https://github.com/fossas/fossa-cli) | License and vulnerability analysis
*   dev-util/[gibberish-detector](https://github.com/domanchi/gibberish-detector) | Train a model, and detect gibberish strings with it
*   dev-util/[gh](https://github.com/cli/cli) | The GitHub CLI
*   dev-util/[gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner) | GitLab Runner
*   dev-util/[hotspot](https://github.com/KDAB/hotspot) | Linux perf GUI for performance analysis
*   dev-util/[insomnia-bin](https://insomnia.rest) | HTTP and GraphQL client for developers
*   dev-util/[jwt_tool](https://github.com/ticarpi/jwt_tool) | A toolkit for testing, tweaking and cracking JSON Web Tokens
*   dev-util/[lazygit](https://github.com/jesseduffield/lazygit) | Simple terminal UI for git commands
*   dev-util/[mapforce-advanced](https://www.altova.com/mapforce) | Advanced data mapping, conversion, and transformation tool
*   dev-util/[ovftool](https://developer.vmware.com/tools) | VMware Open Virtualization Format tool
*   dev-util/[packer](https://www.packer.io) | A tool to create identical machine images for multiple platforms
*   dev-util/[policy-sentry](https://github.com/salesforce/policy_sentry) | AWS IAM Least Privilege Policy Generator
*   dev-util/[postman](https://www.postman.com) | Build, test, and document your APIs faster
*   dev-util/[rpmlint](https://github.com/rpm-software-management/rpmlint) | Tool for checking common errors in RPM packages
*   dev-util/[semgrep](https://github.com/semgrep/semgrep) | Lightweight static analysis for many languages
*   dev-util/[shfmt](https://github.com/mvdan/sh) | A shell parser, formatter, and interpreter with bash support
*   dev-util/[sqlfluff](https://github.com/sqlfluff/sqlfluff) | A SQL linter and auto-formatter
*   dev-util/[swapusage](https://github.com/hhoffstaette/swapusage) | Amount of swapped memory for running processes
*   dev-util/[taskcat](https://github.com/aws-ia/taskcat) | An OpenSource Cloudformation Deployment Framework
*   dev-util/[testmace](https://testmace.com) | Powerful IDE to work with API
*   dev-util/[tickgit](https://github.com/augmentable-dev/tickgit) | Manage your repository's TODOs as config in your codebase
*   dev-util/[xxd](https://github.com/vim/vim) | Hexdump utility from vim
*   dev-vcs/[blackbox](https://github.com/StackExchange/blackbox) | Safely store secrets in Git/Mercurial/Subversion
*   dev-vcs/[commitizen](https://github.com/commitizen-tools/commitizen) | Python commitizen client tool
*   dev-vcs/[gitaly](https://gitlab.com/gitlab-org/gitaly) | Git RPC service for handling GitLab git calls
*   dev-vcs/[gitlint](https://github.com/jorisroovers/gitlint) | Git commit message linter
*   dev-vcs/[mercurial-extension_utils](https://foss.heptapod.net/mercurial/mercurial-extension_utils) | Mercurial Extension Utils
*   dev-vcs/[mercurial_keyring](https://foss.heptapod.net/mercurial/mercurial_keyring) | Mercurial Keyring Extension
*   dev-vcs/[pre-commit](https://github.com/pre-commit/pre-commit) | A framework for multi-language pre-commit hooks
*   dev-vcs/[transcrypt](https://github.com/elasticdog/transcrypt) | Transparently encrypt files within a git repository
*   kde-misc/[applet-latte-analogclock](https://github.com/psifidotos/applet-latte-analogclock) | Analog clock applet that respects Latte items size
*   kde-misc/[applet-latte-separator](https://github.com/psifidotos/applet-latte-separator) | Plasma 5 applet that acts as a separator between applets
*   kde-misc/[applet-latte-sidebar-button](https://github.com/psifidotos/applet-latte-sidebar-button) | Plasma 5 applet to show and hide Latte Sidebars
*   kde-misc/[applet-latte-spacer](https://github.com/psifidotos/applet-latte-spacer) | Plasma 5 applet that acts as a spacer between applets
*   kde-misc/[applet-window-appmenu](https://github.com/psifidotos/applet-window-appmenu) | Plasma 5 applet in order to show window appmenu in your panels
*   kde-misc/[applet-window-buttons](https://github.com/psifidotos/applet-window-buttons) | Plasma 5 applet in order to show window buttons in your panels
*   kde-misc/[applet-window-title](https://github.com/psifidotos/applet-window-title) | Plasma 5 applet shows window title and icon in your panels
*   kde-misc/[Burn-My-Windows](https://github.com/Schneegans/Burn-My-Windows) | Disintegrate your windows with style
*   kde-misc/[qCheckGMail](https://github.com/mhogomchungu/qCheckGMail) | qCheckGmail is a Qt/C++ multiple gmail account checker
*   kde-misc/[kde-relaxingsounds](https://github.com/Prayag2/kde_relaxingsounds) | Plasma 5 widget for play relaxing sounds
*   kde-misc/[latte-indicator-dashtopanel](https://github.com/psifidotos/latte-indicator-dashtopanel) | Dash To Panel indicator for Latte Dock
*   kde-misc/[latte-indicator-unity](https://github.com/psifidotos/latte-indicator-unity) | Unity style indicator for Latte Dock
*   kde-misc/[latte-indicator-win10](https://github.com/psifidotos/latte-indicator-win10) | Windows 10 style indicator for Latte Dock
*   kde-misc/[latte-indicator-win7](https://github.com/psifidotos/latte-indicator-win7) | Windows 7 style indicator for Latte Dock
*   kde-misc/[latte_slideshow_wallpaper](https://github.com/psifidotos/latte_slideshow_wallpaper) | Plasma 5 Wallpaper plugin that informs Latte about background
*   kde-misc/[lightly](https://github.com/Luwx/Lightly) | KDE theme style with aim to be visually modern and minimalistic
*   kde-misc/[paneltransparencybutton](https://github.com/psifidotos/paneltransparencybutton) | Enable/disable transparency for specific plasma panels
*   kde-misc/[plasma-applet-ambientnoise](https://github.com//plasma-applet-ambientnoise) | Plasma 5 widget for play ambient noise
*   kde-misc/[plasma-applet-eventcalendar](https://github.com/Zren/plasma-applet-eventcalendar) | Plasmoid for a calendar and agenda with weather
*   kde-misc/[plasma-applet-favoriteFolders](https://github.com/enky-marte/plasma-applet-favoriteFolders) | Plasma 5 widget for quick access to favorite folders
*   kde-misc/[plasma-power-monitor](https://github.com/atul-g/plasma-power-monitor) | Plasma widget to monitor the power consumption of your battery
*   kde-misc/[plasmoid-wunderground-extended](https://github.com/rliwoch/plasmoid-wunderground-extended) | KDE5 Plasma Weather Widget
*   kde-misc/[pminhibition](https://github.com/popov895/pminhibition) | Plasma applet shows information about power management inhibition
*   kde-misc/[Tiled-Quicklaunch](https://github.com/Risu/Tiled-Quicklaunch) | Plasma Menu Widget for KDE
*   media-gfx/[butteraugli](https://github.com/google/butteraugli) | A tool for measuring perceived differences between images
*   media-gfx/[colorpick](https://github.com/agateau/colorpick) | Color picker and contrast checker
*   media-gfx/[depix](https://github.com/beurtschipper/Depix) | A tool for recovering passwords from pixelized screenshots
*   media-gfx/[dssim](https://github.com/kornelski/dssim) | Image similarity comparison simulating human perception
*   media-gfx/[guetzli](https://github.com/google/guetzli) | Perceptual JPEG encoder
*   media-gfx/[lsix](https://github.com/hackerb9/lsix) | Image viewer for terminal that use sixel graphics
*   media-gfx/[qView](https://interversehq.com/qview/) | Practical and minimal image viewer
*   media-gfx/[pineapple-pictures](https://github.com/BLumia/pineapple-pictures) | A homebrew lightweight image viewer
*   media-gfx/[pingo-bin](https://css-ig.net/pingo) | Fast web image optimizer
*   media-gfx/[screencloud](https://screencloud.net) | Screenshot capturing and sharing tool over various services
*   media-gfx/[xgrabcolor](http://hugo.pereira.free.fr/software/index.php) | Qt-based basic color picker
*   media-libs/[bcmatroska2](https://gitlab.linphone.org/BC/public/bcmatroska2) | Matroska media container support
*   media-libs/[bv16-floatingpoint](https://gitlab.linphone.org/BC/public/external/bv16-floatingpoint) | BroadVoice 16 kbs codec
*   media-libs/[libqpsd](https://github.com/roniemartinez/libqpsd) | PSD & PSB Plugin for Qt/C++
*   media-libs/[libyuv](https://chromium.googlesource.com/libyuv/libyuv) | Library for freeswitch yuv graphics manipulation
*   media-libs/[mediastreamer2](https://gitlab.linphone.org/BC/public/mediastreamer2) | Mediastreaming library for telephony application
*   media-libs/[qt-heif](https://github.com/jakar/qt-heif-image-plugin) | Qt plugin for HEIF images
*   media-libs/[shine](https://github.com/toots/shine) | Fixed-point mp3 encoding library
*   media-libs/[QtApng](https://github.com/Skycoder42/QtApng) | An apng image plugin for Qt to support animated PNGs
*   media-sound/[cozy](https://github.com/geigi/cozy) | Modern audiobook player
*   media-sound/[finetune](https://flavio.tordini.org/finetune) | Automatic music tagger
*   media-sound/[mpz](https://mpz-player.org) | Music player for big local collections
*   media-sound/[musique](https://github.com/flaviotordini/musique) | A finely crafted music player
*   media-sound/[plexamp](https://plexamp.com) | Music focused client for Plex
*   media-sound/[sayonara](https://sayonara-player.com) | Small, clear and fast Qt-based audio player
*   media-sound/[spotifyd](https://github.com/Spotifyd/spotifyd) | A spotify daemon
*   media-sound/[spotify-qt](https://github.com/kraxarn/spotify-qt) | Lightweight Spotify client using Qt
*   media-radio/[krudio](https://github.com/alexyalinc/krudio) | Radio tray for linux on QT
*   media-radio/[liquidsoap](https://github.com/savonet/liquidsoap) | A swiss-army knife for multimedia streaming, used for netradios
*   media-video/[ffmpeg-compat](https://ffmpeg.org) | Compatibility package for ffmpeg to provide versions 58 of libraries
*   media-video/[haruna](https://invent.kde.org/multimedia/haruna) | Video player built with Qt/QML on top of libmpv
*   media-video/[qwinff](https://github.com/qwinff/qwinff) | Qt GUI Frontend for FFmpeg
*   media-video/[rtsp-simple-server](https://github.com/aler9/rtsp-simple-server) | RTSP server and RTSP proxy to read, publish and proxy media stream
*   net-analyzer/[bandwhich](https://github.com/imsnif/bandwhich) | Network utilization by process, connection and hostname
*   net-analyzer/[dnsdiag](https://github.com/farrokhi/dnsdiag) | DNS Measurement, Troubleshooting and Security Auditing Toolset
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/goaccess.svg?header=)](https://repology.org/project/goaccess/versions) net-analyzer/[goaccess](https://goaccess.io) | A real-time web log analyzer and interactive viewer in a terminal
*   net-analyzer/[gping](https://github.com/orf/gping) | Ping, but with a graph
*   net-analyzer/[logswan](https://github.com/fcambus/logswan) | Web log analyzer using probabilistic data structures
*   net-analyzer/[netgauge](https://www.ookla.com) | Server software for testing internet bandwidth using speedtest.net
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/nuttcp.svg?header=)](https://repology.org/project/nuttcp/versions) net-analyzer/[nuttcp](https://www.nuttcp.net) | Network performance measurement tool
*   net-analyzer/[passivedns](https://github.com/gamelinux/passivedns) | Network sniffer that logs all DNS server replies
*   net-analyzer/[pkt-netflow](https://github.com/aabc/pkt-netflow) | NetFlow v5, v9, IPFIX flow data exporter
*   net-analyzer/[cymruwhois](https://github.com/JustinAzoff/python-cymruwhois) | Python client for the whois.cymru.com service
*   net-analyzer/[ripe-atlas-probe](https://github.com/RIPE-NCC/ripe-atlas-software-probe) | RIPE Atlas Software Probe
*   net-analyzer/[smtpping](https://github.com/halon/smtpping) | Simple, portable tool for measuring SMTP server delay
*   net-analyzer/[sx](https://github.com/v-byte-cpu/sx) | Fast, modern, easy-to-use network scanner
*   net-analyzer/[wtraf-bin](https://sourceforge.net/projects/wtraf/) | SNMP traffic monitor in realtime
*   net-dns/[ddns-route53](https://github.com/crazy-max/ddns-route53) | Dynamic DNS for Amazon Route 53 on a time-based schedule
*   net-dialup/[tio](https://github.com/tio/tio) | A simple serial device I/O tool
*   net-dns/[flares](https://github.com/lfaoro/flares) | CloudFlare DNS backup tool
*   net-dns/[inadyn-mt](https://sourceforge.net/projects/inadyn-mt/) | A simple dynamic DNS client
*   net-dns/[massdns](https://github.com/blechschmidt/massdns) | A high-performance DNS stub resolver
*   net-dns/[nsping](https://github.com/vovcat/nsping) | Measure reachability and latency of DNS nameservers
*   net-firewall/[ipt-ratelimit](https://github.com/aabc/ipt-ratelimit) | Ratelimit iptables module
*   net-firewall/[xt_dns](https://github.com/oskar456/xt_dns) | Netfilter extension to match various DNS atributes
*   net-firewall/[xt_nat](https://github.com/andrsharaev/xt_NAT) | Full Cone NAT module for Linux iptables
*   net-ftp/[weex](https://sourceforge.net/projects/weex/) | A non-interactive FTP client for updating web pages
*   net-im/[communi-desktop](https://github.com/communi/communi-desktop) | A cross-platform IRC framework written with Qt
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/gitter.svg?header=)](https://repology.org/project/gitter/versions) net-im/[gitter-bin](https://gitter.im) | Chat and network platform
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/slack.svg?header=)](https://repology.org/project/slack/versions) net-im/[slack](https://slack.com) | Team collaboration tool
*   net-im/[viber](https://www.viber.com/en/) | Free text and calls
*   net-libs/[bctoolbox](https://gitlab.linphone.org/BC/public/bctoolbox) | Utilities library used by Belledonne Communications softwares
*   net-libs/[bzrtp](https://gitlab.linphone.org/BC/public/bzrtp) | Media Path Key Agreement for Unicast Secure RTP
*   net-libs/[ortp](https://gitlab.linphone.org/BC/public/ortp) | Open Real-time Transport Protocol (RTP, RFC3550) stack
*   net-misc/[AdGuardHome-bin](https://github.com/AdguardTeam/AdGuardHome) | Network-wide ads & trackers blocking DNS server
*   net-misc/[amazon-workspaces-bin](https://clients.amazonworkspaces.com) | Amazon Workspace Client
*   net-misc/[awscurl](https://github.com/okigan/awscurl) | Make signed requests to AWS API
*   net-misc/[bngblaster](https://github.com/rtbrick/bngblaster) | A tool to simulate thousands of PPPoE or IPoE subscribers
*   net-misc/[comcast](https://github.com/tylertreat/Comcast) | Network problems simulator
*   net-misc/[curlie](https://github.com/rs/curlie) | The power of curl, the ease of use of httpie
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/dhcdrop.svg?header=)](https://repology.org/project/dhcdrop/versions) net-misc/[dhcdrop](http://www.netpatch.ru/devel/dhcdrop/) | Effectively suppresses illegal DHCP servers on the LAN
*   net-misc/[dnsflood](https://github.com/hawell/dns-flood) | Use raw sockets to generate DNS flood attack
*   net-misc/[droplet-agent](https://github.com/digitalocean/droplet-agent) | DigitalOcean Droplet Agent
*   net-misc/[ec2-instance-connect](https://github.com/aws/aws-ec2-instance-connect-config) | AWS EC2 Instance Connect Configuration
*   net-misc/[ec2-instance-connect-cli](https://github.com/aws/aws-ec2-instance-connect-cli) | Python client for accessing EC2 instances via EC2 Instance Connect
*   [![Gentoo Bug](https://img.shields.io/badge/Bug-536148-red.svg)](https://bugs.gentoo.org/show_bug.cgi?id=536148) net-misc/[fiche](https://github.com/solusipse/fiche) | Command line pastebin server
*   net-misc/[inverting-proxy](https://github.com/google/inverting-proxy) | Reverse proxy that inverts the direction of traffic
*   net-misc/[kafkactl](https://github.com/deviceinsight/kafkactl) | A command-line interface for interaction with Apache Kafka
*   net-misc/[kcat](https://github.com/edenhill/kcat) | Generic command line non-JVM Apache Kafka producer and consumer
*   net-misc/[kcl](https://github.com/twmb/kcl) | Your one stop shop to do anything with Kafka
*   net-misc/[lychee](https://github.com/lycheeverse/lychee) | Fast, async, stream-based link checker
*   net-misc/[mpssh](https://github.com/ndenev/mpssh) | Mass parallel ssh
*   net-misc/[ngrok-bin](https://ngrok.com/) | Secure introspected tunnels to localhost
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/pingu.svg?header=)](https://repology.org/project/pingu/versions) net-misc/[pingu](https://github.com/ncopa/pingu) | Policy routing daemon with failover and load-balancing
*   net-misc/[qfreerdp](https://github.com/zrax/qfreerdp) | Qt launcher GUI for XFreeRDP
*   net-misc/[qia](https://stg.codes) | Authorization tool for Stargazer Billing System written in Qt
*   net-misc/[msd](https://github.com/rozhuk-im/msd) | Program for IP TV streaming on the network via HTTP
*   net-misc/[ntriprelay](https://github.com/madf/ntriprelay) | NTRIP Relay
*   net-misc/[ntripserver](https://github.com/nunojpg/ntripserver) | Ntrip Version 2.0 Command Line Server
*   net-misc/[opendrop](https://github.com/seemoo-lab/opendrop) | an Open Source AirDrop Implementation
*   net-misc/[openvpn-update-resolv-conf](https://github.com/alfredopalhares/openvpn-update-resolv-conf) | Updates DNS settings are pushed by the OpenVPN server
*   net-misc/[postgrest](https://github.com/PostgREST/postgrest) | REST API for any Postgres database
*   net-misc/[redir](https://github.com/troglobit/redir) | TCP port redirector
*   net-misc/[rstatd](http://rstatd.sourceforge.net/) | Client-server linux performance statistics
*   net-misc/[s5cmd](https://github.com/peak/s5cmd) | Parallel S3 and local filesystem execution tool
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/samplicator.svg?header=)](https://repology.org/project/samplicator/versions) net-misc/[samplicator](https://github.com/sleinen/samplicator) | UDP packets forwarder and duplicator
*   net-misc/[slowhttptest](https://github.com/shekyan/slowhttptest) | Application Layer DoS attack simulator
*   net-misc/[sping](https://github.com/benjojo/sping) | Split ping, shows direction the loss or latency is on
*   net-misc/[spoofer](https://www.caida.org/projects/spoofer/) | A tool to assess of deployment of source address validation
*   net-misc/[ssmd](https://stg.codes/projects/ssmd) | SNMP Switch Management Daemon
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/stargazer.svg?header=)](https://repology.org/project/stargazer/versions) net-misc/[stargazer](https://stg.net.ua) | Billing system for small home and office networks
*   net-misc/[topola](https://topola.unity.net) | Customer accounting system, services and statistics collection management
*   net-misc/[uredir](https://github.com/troglobit/uredir) | UDP port redirector
*   net-misc/[virtualhere-usb](https://virtualhere.com) | Share USB devices over the network
*   net-misc/[websocat](https://github.com/vi/websocat) | Netcat, curl and socat for WebSockets
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/x11-ssh-askpass.svg?header=)](https://repology.org/project/x11-ssh-askpass/versions) net-misc/[x11-ssh-askpass](https://github.com/sigmavirus24/x11-ssh-askpass) | X11-based passphrase dialog for use with OpenSSH
*   net-misc/[xh](https://github.com/ducaale/xh) | Friendly and fast tool for sending HTTP requests
*   net-misc/[wuzz](https://github.com/asciimoo/wuzz) | Interactive cli tool for HTTP inspection
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/automatic.svg?header=)](https://repology.org/project/automatic/versions) net-p2p/[automatic](https://github.com/1100101/Automatic) | RSS downloader for Tranmission
*   net-p2p/[gram-wallet-bin](https://wallet.ton.org) | TON Testnet Wallet
*   net-p2p/[tremotesf](https://github.com/equeim/tremotesf2) | A remote GUI for transmission
*   [![Gentoo Bug](https://img.shields.io/badge/Bug-214969-red.svg)](https://bugs.gentoo.org/show_bug.cgi?id=214969) net-p2p/[opentracker](https://github.com/flygoast/opentracker) | High-performance bittorrent tracker
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/resilio-sync.svg?header=)](https://repology.org/project/resilio-sync/versions) net-p2p/[resilio-sync](https://www.resilio.com) | Resilient, fast and scalable file synchronization tool
*   net-voip/[linphone-desktop](https://gitlab.linphone.org/BC/public/linphone-desktop) | A free VoIP and video softphone based on the SIP protocol
*   net-voip/[twinkle](https://github.com/LubosD/twinkle) | Softphone for voice over IP and IM communication using SIP
*   net-vpn/[awsvpnclient](https://aws.amazon.com/vpn/) | AWS VPN Client
*   net-vpn/[cloudflared](https://github.com/cloudflare/cloudflared) | Argo Tunnel client
*   net-vpn/[innernet-bin](https://github.com/tonarino/innernet) | WireGuard based private network system
*   net-vpn/[forticlient](https://www.fortinet.com/products/endpoint-security/forticlient) | Fortinet VPN client
*   net-vpn/[openiked](https://github.com/openiked/openiked-portable) | Internet Key Exchange version 2 (IKEv2) daemon
*   net-vpn/[openvpn-aws](https://openvpn.net) | Patched OpenVPN with SAML support for AWS Client VPN
*   [![Gentoo Bug](https://img.shields.io/badge/Bug-498844-red.svg)](https://bugs.gentoo.org/show_bug.cgi?id=498844) net-vpn/[softether](https://www.softether.org) | Multi-protocol VPN software
*   sci-visualization/[visidata](https://github.com/saulpw/visidata) | Terminal spreadsheet multitool for discovering and arranging data
*   sys-apps/[aptly](https://github.com/aptly-dev/aptly) | A swiss army knife for Debian repository management
*   sys-apps/[choose](https://github.com/theryangeary/choose) | Fast alternative to cut and awk
*   sys-apps/[direnv](https://github.com/direnv/direnv) | Environment variable manager for shell
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/ethq.svg?header=)](https://repology.org/project/ethq/versions) sys-apps/[ethq](https://github.com/isc-projects/ethq) | Ethernet NIC Queue stats viewer
*   sys-apps/[dust](https://github.com/bootandy/dust) | More intuitive version of du
*   sys-apps/[evhz](https://git.sr.ht/~iank/evhz) | Mouse refresh rate under evdev
*   sys-apps/[firetools](https://firejail.wordpress.com) | Graphical user interface of Firajail security sandbox
*   sys-apps/[jless](https://github.com/PaulJuliusMartinez/jless) | Command-line JSON viewer
*   sys-apps/[nocache](https://github.com/Feh/nocache) | Minimize caching effects for applications
*   sys-apps/[psi-notify](https://github.com/cdown/psi-notify) | Minimalistic PSI notifier using libnotify
*   sys-apps/[sampler](https://github.com/sqshq/sampler) | Visualization for any shell command
*   sys-apps/[sd](https://github.com/chmln/sd) | An intuitive find and replace tool
*   sys-apps/[swapspace](https://github.com/Tookmund/Swapspace) | A dynamic swap space manager
*   sys-cluster/[minishift-bin](https://github.com/minishift/minishift) | Single Node OpenShift Cluster
*   sys-fs/[adhocify](https://github.com/quitesimpleorg/adhocify) | Tool which monitors for inotify events and executes script
*   sys-fs/[duf](https://github.com/muesli/duf) | Disk Usage/Free Utility
*   sys-fs/[xfs_undelete](https://github.com/ianka/xfs_undelete) | An undelete tool for the XFS filesystem
*   sys-power/[freqtop](https://github.com/stolk/freqtop) | Monitor for the CPU Frequency Scaling under Linux
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/powerstat.svg?header=)](https://repology.org/project/powerstat/versions) sys-power/[powerstat](https://launchpad.net/ubuntu/+source/powerstat) | Laptop power measuring tool
*   sys-process/[btop](https://github.com/aristocratos/btop) | A monitor of resources
*   sys-process/[falco-bin](https://falco.org) | Cloud-Native runtime security
*   sys-process/[nq](https://github.com/leahneukirchen/nq) | Unix command line queue utility
*   www-apps/[adminerevo](https://github.com/adminerevo/adminerevo) | Database management in a single PHP file
*   www-apps/[draw-io](https://github.com/jgraph/drawio) | Online diagramming web application
*   www-apps/[keeweb](https://github.com/keeweb/keeweb) | Cross-platform password manager compatible with KeePass
*   www-apps/[LookingGlass](https://github.com/ramnode/LookingGlass) | A Python-backed Looking Glass
*   www-apps/[netbox](https://github.com/netbox-community/netbox) | IP address and data center infrastructure management tool
*   www-apps/[tinyfilemanager](https://github.com/prasathmani/tinyfilemanager) | Single-file PHP file manager
*   www-apps/[webui-aria2](https://github.com/ziahamza/webui-aria2) | The worlds best and hottest interface to interact with aria2
*   www-plugins/[bypass-paywalls](https://github.com/iamadamdev/bypass-paywalls-chrome) | Bypass Paywalls browser extension
*   www-plugins/[chrome-token-signing](https://github.com/open-eid/chrome-token-signing) | Native client and extension for signing with your eID on the web
*   www-plugins/[eusw](https://iit.com.ua) | IIT End User CA-1 browser extension
*   www-plugins/[vdhcoapp-bin](https://github.com/aclap-dev/vdhcoapp) | Companion application for Video DownloadHelper browser add-on
*   www-servers/[gitlab-workhorse](https://gitlab.com/gitlab-org/gitlab-workhorse) | GitLab reverse proxy
*   www-servers/[imgproxy](https://github.com/imgproxy/imgproxy) | Server for resizing and converting remote images
*   [![Gentoo package](https://repology.org/badge/version-for-repo/gentoo/libinput-gestures.svg?header=)](https://repology.org/project/libinput-gestures/versions) x11-misc/[libinput-gestures](https://github.com/bulletmark/libinput-gestures) | Actions gestures on your touchpad using libinput
*   x11-misc/[logkeys](https://github.com/kernc/logkeys) | A Linux keylogger
*   x11-misc/[RazerGenie](https://github.com/z3ntu/RazerGenie) | Razer devices configurator
*   x11-themes/[Vimix-cursors](https://github.com/vinceliuice/Vimix-cursors) | Vimix-cursors for linux desktop
*   x11-themes/[WhiteSur-icon-theme](https://github.com/vinceliuice/WhiteSur-icon-theme) | comes in both light and dark variants

</details>
