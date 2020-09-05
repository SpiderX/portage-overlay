# nest overlay

[![Number of ebuilds: 409](https://img.shields.io/badge/ebuild-409-orange.svg)](https://img.shields.io/badge/ebuild-409-orange.svg)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)
[![CII Best Practices](https://bestpractices.coreinfrastructure.org/projects/2323/badge)](https://bestpractices.coreinfrastructure.org/projects/2323)
[![Codacy Badge](https://api.codacy.com/project/badge/Grade/ac3fe79fe5e64bf0b8a78dd0c63b7d8d)](https://www.codacy.com/app/SpiderX/portage-overlay?utm_source=github.com&amp;utm_medium=referral&amp;utm_content=SpiderX/portage-overlay&amp;utm_campaign=Badge_Grade)
[![Build Status](https://travis-ci.org/SpiderX/portage-overlay.svg?branch=master)](https://travis-ci.org/SpiderX/portage-overlay)

### References

+ [Overlay with metadata](https://github.com/gentoo-mirror/nest)
+ [QA Report](https://qa-reports.gentoo.org/output/repos/nest.html)
+ [Gentoo Repo QA Check](https://gitweb.gentoo.org/report/repos.git/tree/nest.html)
+ [Ebuild Upstream Scanner](http://euscan.gentooexperimental.org/maintainers/spiderx@spiderx.dp.ua/)
+ [Levelnine checks](https://gentooqa.levelnine.at/results/gentoo/listings/sort-by-maintainer/spiderx_at_spiderx.dp.ua.txt)

# How to use this overlay

For automatic install, you must have [`app-eselect/eselect-repository`](https://packages.gentoo.org/packages/app-eselect/eselect-repository)
or [`app-portage/layman`](https://packages.gentoo.org/packages/app-portage/layman) installed on your system for this to work.

#### `eselect-repository`:
```console
eselect repository enable nest
```

#### `layman`:
```console
layman -fa nest
```

For manual install, through [local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay), you should add this in `/etc/portage/repos.conf/nest.conf`:

```console
[nest]
location = /usr/local/portage/nest
sync-type = git
sync-uri = https://github.com/spiderx/portage-overlay.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.

## List of Ebuilds

This overlay consists of an [Gentoo Portage](http://www.gentoo.org/) ebuilds for projects:

* app-admin/[ansible-lint](https://github.com/ansible/ansible-lint) | Best practices checker for Ansible
* app-admin/[awslimitchecker](https://github.com/jantman/awslimitchecker) | Utility to check AWS resource limits and usage
* app-admin/[awslog](https://github.com/jaksi/awslog) | History and changes of configuration versions of AWS resources
* app-admin/[awsometag](https://github.com/mhausenblas/awsometag) | Simple command-line snippet manager
* app-admin/[awsudo](https://github.com/makethunder/awsudo) | A temporary credentials for AWS roles via sudo-like utility
* app-admin/[aws-vault](https://github.com/99designs/aws-vault) | A vault for securely storing and accessing AWS credentials
* app-admin/[azcopy](https://github.com/Azure/azure-storage-azcopy) | A command-line utility to manage Azure Storage accounts
* app-admin/[cli53](https://github.com/barnybug/cli53) | Command line tool for Amazon Route 53
* app-admin/[container-service-extension](https://github.com/vmware/container-service-extension) | Container Service Extension for vCloud Director
* app-admin/[docker-pretty-ps](https://github.com/politeauthority/docker-pretty-ps) | docker ps in colored and long output
* app-admin/[doctl](https://github.com/digitalocean/doctl) | A command line tool for DigitalOcean services
* app-admin/[fselect](https://github.com/jhspetersson/fselect) | Find files with SQL-like queries
* app-admin/[ibmcloud-bin](https://github.com/IBM-Cloud/ibm-cloud-cli-release) | IBM Cloud Developer Tools
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/qtpass.svg)](https://repology.org/metapackage/qtpass) app-admin/[qtpass](https://qtpass.org) | multi-platform GUI for pass, the standard unix password manager
* app-admin/[jl](https://github.com/koenbollen/jl) | A tool for working with structured JSON logging
* app-admin/[kconfig-hardened-check](https://github.com/a13xp0p0v/kconfig-hardened-check) | A script to check the hardening options in the Linux kernel config
* app-admin/[netutils-linux](https://github.com/strizhechenko/netutils-linux) | Suite of network stack performance tunning utilities
* app-admin/[reach](https://github.com/99designs/aws-vault) | A vault for securely storing and accessing AWS credentials
* app-admin/[reprepro](https://salsa.debian.org/brlink/reprepro) | A tool to handle local repositories of Debian packages
* app-admin/[saw](https://github.com/TylerBrock/saw) | Fast, multi-purpose tool for AWS CloudWatch Logs
* app-admin/[terraform-provider-vcd](https://www.terraform.io/docs/providers/vcd) | Terraform VMware vCloud Director provider
* app-admin/[tztail](https://github.com/thecasualcoder/tztail) | A log view in various timezones
* app-admin/[userdbadm](https://nasauber.de/opensource/userdbadm) | Tool to manage (PAM) userdb files with crypted passwords
* app-admin/[uwsgitop](https://github.com/unbit/uwsgitop) | uWSGI stats viewer
* app-admin/[vcd-cli](https://github.com/vmware/vcd-cli) | Utility to check AWS resource limits and usage
* app-admin/[yaml-vault](https://github.com/Jimdo/yaml-vault) | Utility to import/export data from HashiCorp Vault
* app-backup/[hashget](https://gitlab.com/yaroslaff/hashget) | Deduplication tool for archiving data with extremely high ratio
* app-backup/[pgbackrest](https://pgbackrest.org) | Reliable PostgreSQL Backup & Restore
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/zbackup.svg)](https://repology.org/metapackage/zbackup) app-backup/[zbackup](https://github.com/zbackup/zbackup) | A versatile deduplicating backup tool
* app-backup/[urbackup-client](https://urbackup.org) | Client Server backup system
* app-backup/[urbackup-server](https://urbackup.org) | Client Server backup system
* app-backup/[wal-g](https://github.com/wal-g/wal-g) | Archival restoration tool for databases
* app-crypt/[acmebot](https://github.com/plinss/acmebot) | ACME protocol automatic certitificate manager
* app-crypt/[acme-client](https://github.com/kristapsdz/acme-client-portable) | Secure Let's Encrypt client
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/acme.sh.svg)](https://repology.org/metapackage/acme.sh) app-crypt/[acme-sh](https://github.com/Neilpang/acme.sh) | An ACME Shell script
* app-crypt/[qesteidutil](https://github.com/open-eid/qesteidutil) | Estonian ID card management desktop utility
* app-editors/[qedit](http://hugo.pereira.free.fr/software/index.php) | Qt-based multi-purpose text editor
* app-editors/[FeatherPad](https://github.com/tsujan/FeatherPad) | Lightweight Qt5 plain-text editor
* app-editors/[micro](https://github.com/zyedidia/micro) | A modern and intuitive terminal-based text editor
* app-editors/[visual-studio-code-bin](https://code.visualstudio.com) | Editor for building and debugging modern web and cloud applications
* app-emulation/[looking-glass](https://looking-glass.hostfission.com) | A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough
* app-emulation/[qio](https://github.com/SpiderX/qio) | QEMU Init OpenRC
* app-emulation/[vmware-modules](https://github.com/mkubecek/vmware-host-modules) | VMware kernel modules
* app-emulation/[vmware-vmrc](https://www.vmware.com/go/download-vmrc) | VMware Remote Console
* app-emulation/[vmware-workstation](http://www.vmware.com/products/workstation) | Emulate a complete PC without the performance overhead
* app-forensics/[gitleaks](https://github.com/zricethezav/gitleaks) | Auditing git repository for secrets and keys
* app-metrics/[do-agent](https://github.com/digitalocean/do-agent) | DigitalOcean Agent for Enhanced Droplet Graphs
* app-metrics/[nginx-amplify-agent](https://amplify.nginx.com) | System and NGINX metric collection
* app-misc/[android-file-transfer-linux](https://whoozle.github.io/android-file-transfer-linux/) | Reliable MTP client with minimalistic UI
* app-misc/[cheat](https://github.com/cheat/cheat) | Interactive cheatsheets on the command-line
* app-misc/[cointop](https://github.com/miguelmota/cointop) | Interactive cryptocurrency monitor
* app-misc/[deco](https://deco.sourceforge.net) | Demos Commander, a free Norton Commander clone
* app-misc/[jshon](http://kmkeen.com/jshon) | JSON parser designed for maximum convenience within the shell
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/pet.svg)](https://repology.org/metapackage/pet) app-misc/[pet](https://github.com/knqyf263/pet) | Simple command-line snippet manager
* app-misc/[rmlint](https://rmlint.rtfd.org) | Removes duplicates and other lint from your filesystem
* app-misc/[xsv](https://github.com/BurntSushi/xsv) | A fast CSV command line toolkit
* app-office/[drawio-desktop-bin](https://github.com/jgraph/drawio-desktop) | Diagram drawing application built on web technology
* app-shells/[fzf](https://github.com/junegunn/fzf) | A command-line fuzzy finder
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/peco.svg)](https://repology.org/metapackage/peco) app-shells/[peco](https://github.com/peco/peco) | Simplistic interactive filtering tool
* app-text/[keening](https://github.com/vehk/keening) | A simple command line pastebin designed to be used together with ssh
* dev-cpp/[belr](https://gitlab.linphone.org/BC/public/belr) | Language recognition library by Belledonne Communications
* dev-cpp/[libxsd-frontend](https://www.codesynthesis.com/projects/libxsd-frontend) | A compiler frontend for the W3C XML Schema definition language
* dev-cpp/[libcutl](https://www.codesynthesis.com/projects/libcutl) | A collection of C++ libraries (successor of libcult)
* dev-cpp/[xsd](https://www.codesynthesis.com/products/xsd) | A cross-platform W3C XML Schema to C++ data binding compiler
* dev-db/[mssql-cli](https://github.com/dbcli/mssql-cli) | CLI for SQL Server Database
* dev-db/[pg_cron](https://github.com/citusdata/pg_cron) | Run periodic jobs in PostgreSQL
* dev-db/[odyssey](https://github.com/yandex/odyssey) | Scalable PostgreSQL connection pooler
* dev-db/[pg_page_verification](https://github.com/google/pg_page_verification) | Checksums verification on PostgreSQL data pages
* dev-db/[pg_profile](https://github.com/zubkov-andrei/pg_profile) | Postgres historic performance reports
* dev-db/[pg_repack](https://github.com/reorg/pg_repack) | PostgreSQL extension for data reorganization
* dev-db/[pgcenter](https://github.com/lesovsky/pgcenter) | Command-line admin tool for observing and troubleshooting Postgres
* dev-db/[pgtune](https://github.com/andreif/pgtune) | A high-performance PostgreSQL tuning script
* dev-db/[pipelinedb](https://www.pipelinedb.com/) | High-performance time-series aggregation for PostgreSQL
* dev-db/[postgresql_anonymizer](https://gitlab.com/dalibo/postgresql_anonymizer) | Anonymization & Data Masking for PostgreSQL
* dev-db/[soci](https://github.com/SOCI/soci) | Database access library for C++
* dev-db/[tableplus](https://tableplus.com) | Modern, native, and friendly GUI tool for relational databases
* dev-haskell/[ansi-wl-pprint](https://github.com/ekmett/ansi-wl-pprint) | The Wadler/Leijen Pretty Printer for colored ANSI terminal output
* dev-haskell/[clock](https://github.com/corsis/clock) | High-resolution clock functions
* dev-haskell/[daemons](https://github.com/scvalex/daemons) | Daemons in Haskell made fun and easy
* dev-haskell/[glob](http://iki.fi/matti.niemenmaa/glob) | Globbing library
* dev-haskell/[hspec-wai](https://github.com/hspec/hspec-wai) | Experimental Hspec support for testing WAI applications
* dev-haskell/[ini](https://github.com/chrisdone/ini) | Quick and easy configuration files in the INI format
* dev-haskell/[integer-logarithms](https://github.com/Bodigrim/integer-logarithms) | Integer logarithms
* dev-haskell/[integer-simple](http://hackage.haskell.org/package/integer-simple) | Simple Integer library
* dev-haskell/[postgresql-libpq](https://github.com/phadej/postgresql-libpq) | low-level binding to libpq
* dev-haskell/[postgresql-simple](https://github.com/phadej/postgresql-simple) | mid-level PostgreSQL client library
* dev-haskell/[scotty](https://github.com/scotty-web/scotty) | Haskell web framework
* dev-haskell/[semigroups](https://github.com/ekmett/semigroups) | Anything that associates
* dev-haskell/[tz](https://github.com/nilcons/haskell-tz) | Library for time zone conversions
* dev-haskell/[tzdata](https://github.com/nilcons/haskell-tzdata) | Distribution of the standard time zone database
* dev-haskell/[websockets](http://jaspervdj.be/websockets) | Allows you to write WebSocket-capable servers
* dev-haskell/[wai-cors](https://github.com/larskuhtz/wai-cors) | Cross-Origin resource sharing (CORS) for Wai
* dev-haskell/[wai-websockets](https://github.com/yesodweb/wai) | Provide a bridge between WAI and the websockets package
* dev-libs/[belcard](https://gitlab.linphone.org/BC/public/belcard) | VCard standard format manipulation library
* dev-libs/[belle-sip](https://github.com/BelledonneCommunications/belle-sip) | SIP (RFC3261) implementation
* dev-libs/[ccrtp](https://www.gnu.org/software/ccrtp) | GNU ccRTP - Implementation of the IETF real-time transport protocol
* dev-libs/[libcommuni](http://communi.github.io/) | A cross-platform IRC framework written with Qt
* dev-libs/[libdigidoc](https://github.com/open-eid/libdigidoc) | DigiDoc digital signature library
* dev-libs/[libdigidocpp](https://github.com/open-eid/libdigidocpp) | Library for handling digitally signed documents
* dev-libs/[liblinphone](https://gitlab.linphone.org/BC/public/liblinphone) | SIP library supporting voice/video calls and text messaging
* dev-libs/[lime](https://gitlab.linphone.org/BC/public/lime) | C++ library implementing Open Whisper System Signal protocol
* [![Gentoo Bug](https://img.shields.io/badge/Bug-482946-red.svg)](https://bugs.gentoo.org/482946) dev-libs/[loki](http://loki-lib.sourceforge.net/) | C++ library of common design patterns and idioms
* dev-libs/[xml-security-c](https://santuario.apache.org) | Apache C++ XML security libraries
* dev-libs/[zrtpcpp](https://github.com/wernerd/ZRTPCPP) | VCard standard format manipulation library
* dev-lua/[lyaml](https://github.com/gvvaughan/lyaml) | LibYAML binding for Lua
* dev-ml/[camlimages](http://gallium.inria.fr/camlimages) | An image manipulation library for ocaml
* dev-ml/[camomile](https://github.com/yoriyuki/Camomile) | Camomile is a comprehensive Unicode library for ocaml
* dev-ml/[dune](https://github.com/ocaml/dune) | A composable build system for OCaml
* dev-ml/[gd4o](https://github.com/savonet/gd4o) | OCaml interface to the GD graphics library
* dev-ml/[ocamlnet](http://projects.camlcity.org/projects/ocamlnet.html) | Modules for OCaml application-level Internet protocols
* dev-ml/[ocaml-alsa](https://github.com/savonet/ocaml-alsa) | OCaml bindings to alsa-lib
* dev-ml/[ocaml-ao](https://github.com/savonet/ocaml-ao) | OCaml bindings to libao
* dev-ml/[ocaml-bjack](https://github.com/savonet/ocaml-bjack) | OCaml blocking JACK API
* dev-ml/[ocaml-cry](https://github.com/savonet/ocaml-cry) | OCaml native module for icecast/shoutcast source protocols
* dev-ml/[ocaml-dssi](https://github.com/savonet/ocaml-dssi) | OCaml bindings to dssi
* dev-ml/[ocaml-dtools](https://github.com/savonet/ocaml-dtools) | OCaml daemon tools library
* dev-ml/[ocaml-duppy](https://github.com/savonet/ocaml-duppy) | OCaml advanced scheduler
* dev-ml/[ocaml-faad](https://github.com/savonet/ocaml-faad) | OCaml bindings to faad2
* dev-ml/[ocaml-fdkaac](https://github.com/savonet/ocaml-fdkaac) | OCaml bindings to fdk-aac
* dev-ml/[ocaml-ffmpeg](https://github.com/savonet/ocaml-ffmpeg) | OCaml bindings to ffmpeg
* dev-ml/[ocaml-flac](https://github.com/savonet/ocaml-flac) | OCaml bindings to flac
* dev-ml/[ocaml-frei0r](https://github.com/savonet/ocaml-frei0r) | OCaml bindings to frei0r plugins
* dev-ml/[ocaml-gavl](https://github.com/savonet/ocaml-gavl) | OCaml bindings to Gavl video manipulation library
* dev-ml/[ocaml-gstreamer](https://github.com/savonet/ocaml-gstreamer) | OCaml bindings to gstreamer
* dev-ml/[ocaml-inotify](https://github.com/whitequark/ocaml-inotify) | OCaml bindings to inotify
* dev-ml/[ocaml-ladspa](https://github.com/savonet/ocaml-ladspa) | OCaml bindings to LADSPA plugins
* dev-ml/[ocaml-lame](https://github.com/savonet/ocaml-lame) | OCaml bindings to lame
* dev-ml/[ocaml-lastfm](https://github.com/savonet/ocaml-lastfm) | OCaml interface for Lastfm
* dev-ml/[ocaml-lo](https://github.com/savonet/ocaml-lo) | OCaml bindings to liblo
* dev-ml/[ocaml-mad](https://github.com/savonet/ocaml-mad) | OCaml bindings to libmad
* dev-ml/[ocaml-magic](https://sourceforge.net/projects/ocaml-magic) | OCaml bindings to libmagic
* dev-ml/[ocaml-mm](https://github.com/savonet/ocaml-mm) | OCaml bindings to mm
* dev-ml/[ocaml-ogg](https://github.com/savonet/ocaml-ogg) | OCaml bindings to libogg
* dev-ml/[ocaml-opus](https://github.com/savonet/ocaml-opus) | OCaml bindings to opus
* dev-ml/[ocaml-portaudio](https://github.com/savonet/ocaml-portaudio) | OCaml bindings to portaudio
* dev-ml/[ocaml-pulseaudio](https://github.com/savonet/ocaml-pulseaudio) | OCaml bindings to pulseaudio
* dev-ml/[ocaml-samplerate](https://github.com/savonet/ocaml-samplerate) | OCaml bindings to libsamplerate
* dev-ml/[ocaml-shine](https://github.com/savonet/ocaml-shine) | OCaml bindings to libshine
* dev-ml/[ocaml-soundtouch](https://github.com/savonet/ocaml-soundtouch) | OCaml bindings to libsoundtouch
* dev-ml/[ocaml-speex](https://github.com/savonet/ocaml-speex) | OCaml bindings to speex
* dev-ml/[ocaml-syslog](http://opam.ocaml.org/packages/syslog) | OCaml syslog client functions
* dev-ml/[ocaml-taglib](https://github.com/savonet/ocaml-taglib) | OCaml bindings to taglib
* dev-ml/[ocaml-theora](https://github.com/savonet/ocaml-theora) | OCaml bindings to libtheora
* dev-ml/[ocaml-vorbis](https://github.com/savonet/ocaml-vorbis) | OCaml bindings to libvorbis
* dev-ml/[ocaml-xmlplaylist](https://github.com/savonet/ocaml-xmlplaylist) | OCaml module to parse various RSS playlist formats
* dev-ml/[xmlm](http://erratique.ch/software/xmlm) | Ocaml XML manipulation module
* dev-php/[scrypt]() | A PHP wrapper fo the scrypt hashing algorithm
* dev-python/[MarkupPy](https://github.com/tylerbakke/MarkupPy) | An HTML/XML generator
* dev-python/[adal](https://github.com/AzureAD/azure-activedirectory-library-for-python) | Library for authentication in Azure Active Directory
* dev-python/[anyconfig](https://github.com/ssato/python-anyconfig) | Generic access to configuration files in any formats
* dev-python/[apispec](https://github.com/marshmallow-code/apispec) | A pluggable API specification generator
* dev-python/[apispec-webframeworks](https://github.com/marshmallow-code/apispec-webframeworks) | Web framework plugins for apispec
* dev-python/[applicationinsights](https://github.com/microsoft/ApplicationInsights-Python) | Application Insights SDK for Python
* dev-python/[binaryornot](https://github.com/audreyfeldroy/binaryornot) | Python package to guess whether a file is binary or text
* dev-python/[cerberus](https://github.com/pyeve/cerberus) | Lightweight and extensible data validation library for Python
* dev-python/[cfgv](https://github.com/asottile/cfgv) | Validate configuration and produce human readable error messages
* dev-python/[click-completion](https://github.com/click-contrib/click-completion) | Enhanced completion for bash, fish, zsh in Click
* dev-python/[click-help-colors](https://github.com/click-contrib/click-help-colors) | Colorization of help messages in Click
* dev-python/[convertdate](https://github.com/fitnr/convertdate) | Utils for converting between date formats and calculating holidays
* dev-python/[coreapi](https://github.com/core-api/python-client) | Python client library for Core API
* dev-python/[coreschema](https://github.com/core-api/python-coreschema) | Python CoreSchema
* dev-python/[crayons](https://github.com/kennethreitz/crayons) | Text UI colors
* dev-python/[cron-descriptor](https://github.com/Salamek/cron-descriptor) | Converts cron expressions into human readable strings
* dev-python/[crossplane](https://github.com/nginxinc/crossplane) | Fast and reliable NGINX configuration parser
* dev-python/[ctypescrypto](https://github.com/vbwagner/ctypescrypto) | File format determination library for Python
* dev-python/[curio](https://github.com/dabeaz/curio) | Coroutine-based library for concurrent Python systems programming
* dev-python/[dataclasses](https://github.com/ericvsmith/dataclasses) | A backport of the dataclasses module for Python 3.6
* dev-python/[dataclasses-jsonschema](https://github.com/s-knibbs/dataclasses-jsonschema) | JSON schema generation from dataclasses
* dev-python/[datadiff](https://sourceforge.net/projects/datadiff) | A library for diffs of python data structures
* dev-python/[dateparser](https://github.com/scrapinghub/dateparser) | Date parsing library designed to parse dates from HTML pages
* dev-python/[decli](https://github.com/Woile/decli) | Minimal declarative cli tool
* dev-python/[delegator-py](https://github.com/kennethreitz/delegator.py) | Simple library for dealing with subprocesses
* dev-python/[django-celery-beat](https://github.com/celery/django-celery-beat) | Celery Periodic Tasks for Django
* dev-python/[django-configurations](https://github.com/jazzband/django-configurations) | A helper for organizing Django project settings
* dev-python/[django-cors-headers](https://github.com/ottoyiu/django-cors-headers) | Django application for Cross-Origin Resource Sharing (CORS)
* dev-python/[django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms) | DRY Django forms
* dev-python/[django-debug-toolbar](https://github.com/django-debug-toolbar/django-debug-toolbar) | A configurable set of panels that display debug information
* dev-python/[django-environ](https://github.com/joke2k/django-environ) | An environment variables to configure Django
* dev-python/[django-fake-model](https://github.com/erm0l0v/django-fake-model) | A library for creating fake models in the unit tests
* dev-python/[django-filter](https://github.com/carltongibson/django-filter) | Django application for filtering querysets
* dev-python/[django-guardian](https://github.com/django-guardian/django-guardian) | An implementation of per object permissions for Django
* dev-python/[django-jsonfield](https://github.com/dmkoch/django-jsonfield) | A Django field to store validated JSON in your model
* dev-python/[django-jinja](https://github.com/niwinz/django-jinja) | Jinja2 templating language integrated in Django
* dev-python/[django-js-asset](https://github.com/matthiask/django-js-asset) | A script tag with additional attributes for django.forms.Media
* dev-python/[django-mptt](https://github.com/django-mptt/django-mptt) | Utilities for implementing Modified Preorder Tree Traversal
* dev-python/[django-oauth-toolkit](https://github.com/jazzband/django-oauth-toolkit) | OAuth2 Provider for Django
* dev-python/[django-pipeline](https://github.com/jazzband/django-pipeline) | An asset packaging library for Django
* dev-python/[django-rest-framework](https://django-rest-framework.org) | Django REST framework
* dev-python/[django-rest-framework-camel-case](https://github.com/vbabiy/djangorestframework-camel-case) | Camel case JSON support for Django REST framework
* dev-python/[django-rest-framework-recursive](https://github.com/heywbj/django-rest-framework-recursive) | Recursive Serialization for Django REST framework
* dev-python/[django-rest-swagger](https://marcgibbons.com/django-rest-swagger) | Swagger UI for Django REST Framework
* dev-python/[django-rq](https://github.com/rq/django-rq) | An app that provides django integration for RQ (Redis Queue)
* dev-python/[django-tables2](https://github.com/jieter/django-tables2) | Django application for creating HTML tables
* dev-python/[django-taggit](https://github.com/alex/django-taggit) | Django application for simple tagging
* dev-python/[django-taggit-serializer](https://github.com/glemmaPaul/django-taggit-serializer) | Django Taggit Serializer Created for the Django REST Framework
* dev-python/[django-timezone-field](https://github.com/mfogel/django-timezone-field) | Django application for database and form fields for pytz objects
* dev-python/[drf-yasg](https://github.com/axnsan12/drf-yasg) | Yet another Swagger generator
* dev-python/[editdistance](https://github.com/roy-ht/editdistance) | Fast implementation of the edit distance(Levenshtein distance)
* dev-python/[email-validator](https://github.com/JoshData/python-email-validator) | An email syntax and deliverability validation library
* dev-python/[factory_boy](https://github.com/FactoryBoy/factory_boy) | A fixtures replacement tool
* dev-python/[fakeldap](https://github.com/zulip/fakeldap) | An implementation of a LDAPObject to fake a ldap server
* dev-python/[faker](https://github.com/joke2k/faker) | Python package that generates fake data
* dev-python/[filetype](https://github.com/h2non/filetype.py) | Infer file type and MIME type of any file/buffer
* dev-python/[fleep](https://github.com/floyernick/fleep-py) | File format determination library for Python
* dev-python/[flex](https://github.com/pipermerriam/flex) | Validation tooling for Swagger 2.0 specifications
* dev-python/[forbiddenfruit](https://github.com/clarete/forbiddenfruit) | Patch python built-in objects
* dev-python/[git-url-parse](https://github.com/coala/git-url-parse) | A simple GIT URL parser
* dev-python/[graphviz](https://github.com/xflr6/graphviz) | Simple Python interface for Graphviz
* dev-python/[gssapi](https://github.com/pythongssapi/python-gssapi) | A Python interface to RFC 2743/2744
* dev-python/[identify](https://github.com/chriskuehl/identify) | File identification library for Python
* dev-python/[ifaddr](https://github.com/floyernick/fleep-py) | Python Library to enumerate all network interfaces
* dev-python/[itypes](https://github.com/tomchristie/itypes) | Simple immutable types for python
* dev-python/[jsmin](https://github.com/tikitu/jsmin) | JavaScript minifier
* dev-python/[jsonfield](https://github.com/rpkilby/jsonfield) | A reusable Django model field for storing ad-hoc JSON data
* dev-python/[junit-xml](https://github.com/kyrus/python-junit-xml) | Generate HTML or XML in a pythonic way
* dev-python/[k5test](https://github.com/pythongssapi/k5test) | A library for setting up self-contained Kerberos 5 environments
* dev-python/[livereload](https://github.com/lepture/python-livereload) | Python LiveReload is an awesome tool for web developers
* dev-python/[m9dicts](https://github.com/ssato/python-m9dicts) | A dict-like object supports recursive merge operation
* dev-python/[markdown2](https://github.com/trentm/python-markdown2) | A fast and complete Python implementation of Markdown
* dev-python/[mock-django](https://github.com/dcramer/mock-django) | A simple library for mocking certain Django behavior
* dev-python/[msrest](https://github.com/Azure/msrest-for-python) | AutoRest swagger generator Python client runtime
* dev-python/[netaddr](https://github.com/drkjam/netaddr) | Network address representation and manipulation library
* dev-python/[netapp-ontap](https://devnet.netapp.com/restapi) | A library for working with ONTAP's REST APIs simply in Python
* dev-python/[ncclient](https://github.com/ncclient/ncclient) | Python library for NETCONF clients
* dev-python/[django-nose](https://github.com/jazzband/django-nose) | Django test runner using nose
* dev-python/[onetimepass](https://github.com/tadeck/onetimepass) | One-time password library for HOTP and TOTP passwords
* dev-python/[openapi-spec-validator](https://github.com/p1c2u/openapi-spec-validator) | Python library that validates Swagger Specs
* dev-python/[outcome](https://github.com/python-trio/outcome) | Capture the outcome of Python function calls
* dev-python/[parameterized](https://github.com/wolever/parameterized) | Parameterized testing with any Python test framework
* dev-python/[pathspec](https://github.com/cpburnz/python-path-specification) | A utility library for pattern matching of file paths
* dev-python/[polemarch-ansible](https://gitlab.com/vstconsulting/polemarch-ansible) | Wrapper for Ansible CLI
* dev-python/[port-for](https://github.com/kmike/port-for) | An utility and python library for TCP ports management
* dev-python/[prance](https://github.com/jfinkhaeuser/prance) | Resolving Swagger/OpenAPI 2.0 and 3.0 Parser
* dev-python/[purl](https://github.com/codeinthehole/purl) | Simple Python URL class
* dev-python/[pymysql](https://github.com/PyMySQL/PyMySQL) | Pure-Python MySQL Driver
* dev-python/[pystache](https://github.com/defunkt/pystache) | Mustache templating system for Python
* dev-python/[pytest-django](https://github.com/pytest-dev/pytest-django) | A Django plugin for py.test
* dev-python/[pytest-pythonpath](https://github.com/bigsassy/pytest-pythonpath) | plugin for adding to the PYTHONPATH from command line or configs
* dev-python/[pytimeparse](https://github.com/wroberts/pytimeparse) | A library to parse time from human readable string
* dev-python/[python-crontab](https://gitlab.com/doctormo/python-crontab/) | Crontab module for reading and writing crontab files
* dev-python/[python-gilt](https://github.com/metacloud/gilt) | A GIT layering tool
* dev-python/[python-openapi-codec](https://github.com/core-api/python-openapi-codec) | An OpenAPI codec for Core API
* dev-python/[python-user-agents](https://github.com/selwin/python-user-agents) | A library to identify devices by parsing user agent strings
* dev-python/[pykickstart](https://github.com/pykickstart/pykickstart) | Python library for reading and writing kickstart files
* dev-python/[pyvcloud](https://github.com/vmware/pyvcloud) | VMware vCloud Director Python SDK
* dev-python/[pyvmomi](https://github.com/vmware/pyvmomi) | VMware vSphere API Python Bindings
* dev-python/[pywinrm](https://github.com/diyan/pywinrm) | Python library for Windows Remote Management
* dev-python/[PyMeeus](https://github.com/architest/pymeeus) | Library of astronomical algorithms in Python
* dev-python/[PythonQt](https://mevislab.github.io/pythonqt) | A dynamic Python binding for the Qt framework
* dev-python/[questionary](https://github.com/tmbo/questionary) | Python library to build pretty command line user prompts
* dev-python/[random2](https://github.com/strichter/random2) | Python-2.7 random module ported to python-3
* dev-python/[requests-credssp](https://github.com/jborean93/requests-credssp) | CredSSP authentication handler for Python Requests
* dev-python/[requests-mock](https://github.com/jamielennox/requests-mock) | Mock out responses from the requests package
* dev-python/[reprint](https://github.com/Yinzo/reprint) | Binding variables and refreshing multi-line output in terminal
* dev-python/[rq](https://github.com/rq/rq) | A library for creating and processing background jobs
* dev-python/[ripe-atlas-cousteau](https://github.com/RIPE-NCC/ripe-atlas-cousteau) | Official python wrapper around RIPE Atlas API
* dev-python/[ripe-atlas-sagan](https://github.com/RIPE-NCC/ripe-atlas-cousteau) | Official python wrapper around RIPE Atlas API
* dev-python/[route53-transfer](https://github.com/cosmin/route53-transfer) | Generic access to configuration files in any formats
* dev-python/[rstr](http://bitbucket.org/leapfrogdevelopment/rstr) | Generate random strings in Python
* dev-python/[ruamel-ordereddict](https://bitbucket.org/ruamel/ordereddict) | An ordered dictionary with KIO/KVIO
* dev-python/[ruamel-std-pathlib](https://bitbucket.org/ruamel/std.pathlib) | Ruamel enhancements to pathlib and pathlib2
* dev-python/[ruamel-yaml](https://bitbucket.org/ruamel/yaml) | YAML parser/emitter that supports roundtrip comment preservation
* dev-python/[selinux](https://github.com/pycontribs/selinux) | Pure-python selinux shim module for use in virtualenvs
* dev-python/[sentry-sdk](https://github.com/getsentry/sentry-python) | Python client for Sentry
* dev-python/[sh](https://github.com/amoffat/shellingham) | Python subprocess interface
* dev-python/[shellingham](https://github.com/sarugaku/shellingham) | Detects what shell the current Python executable is running in
* dev-python/[shouldbe](https://github.com/directxman12/should_be) | A Python Assertions Helper
* dev-python/[slimit](https://slimit.readthedocs.io/en/latest) | A JavaScript minifier written in Python
* dev-python/[sniffio](https://github.com/python-trio/sniffio) | Sniff out which async library your code is running under
* dev-python/[sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-mermaid](https://github.com/mgaitan/sphinxcontrib-mermaid) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-openapi](https://github.com/ikalnytskyi/sphinxcontrib-openapi) | Sphinx extension to generate APIs docs from OpenAPI
* dev-python/[swagger_spec_validator](https://github.com/Yelp/swagger_spec_validator) | Python library that validates Swagger Specs
* dev-python/[tablib](https://github.com/jazzband/tablib) | Format-agnostic tabular dataset library
* dev-python/[testinfra](https://github.com/philpep/testinfra) | Testinfra test your infrastructures
* dev-python/[text-unidecode](https://github.com/kmike/text-unidecode) | The most basic Text::Unidecode port
* dev-python/[timecop](https://github.com/bluekelp/pytimecop) | A port of TimeCop Ruby Gem for Python
* dev-python/[tomlkit](https://github.com/sdispater/tomlkit) | Style-preserving TOML library for Python
* dev-python/[tree-format](https://github.com/jml/tree-format) | Python library for printing trees on the console
* dev-python/[trio](https://github.com/python-trio/trio) | Python library for async concurrency and I/O
* dev-python/[ua-parser](https://github.com/ua-parser/uap-python) | A python implementation of the UA Parser
* dev-python/[ujson](https://github.com/esnme/ultrajson) | Ultra fast JSON encoder and decoder for Python
* dev-python/[ukpostcodeparser](https://github.com/hamstah/ukpostcodeparser) | UK postcode parser library
* dev-python/[unittest-xml-reporting](https://github.com/xmlrunner/unittest-xml-reporting) | unittest-based test runner with Ant/JUnit like XML reporting
* dev-python/[validate_email](https://github.com/syrusakbary/validate_email) | Python email validation library
* dev-python/[validators](https://github.com/kvesteri/validators) | Python data validation library
* dev-python/[vcd-api-schemas-type](https://github.com/vmware/vcd-api-schemas) | VMware vCloud Director Python API Schemas Type
* dev-python/[versionfinder](https://github.com/jantman/versionfinder) | Find version of python package, installed via pip, setuptools, git
* dev-python/[vsphere-guest-run](https://github.com/vmware/vsphere-guest-run) | Python library for guest operations
* dev-python/[yattag](http://www.yattag.org) | Generate HTML or XML in a pythonic way
* dev-util/[ansible-molecule](https://github.com/ansible/molecule) | Automated testing for Ansible roles
* dev-util/[aws-config-rdk](https://github.com/awslabs/aws-config-rdk) | AWS Config Rules Development Kit
* dev-util/[bcunit](https://github.com/BelledonneCommunications/bcunit) | BC Unit Test Framework
* dev-util/[cfn-guard](https://github.com/aws-cloudformation/cloudformation-guard) | AWS CloudFormation Guard
* dev-util/[cfn-python-lint](https://github.com/awslabs/cfn-python-lint) | AWS CloudFormation Linter
* dev-util/[cfn-template-flip](https://github.com/awslabs/aws-cfn-template-flip) | AWS CloudFormation Template Flip
* dev-util/[cli](https://www.codesynthesis.com/projects/cli) | Command Line Interface compiler for C++
* dev-util/[cloud-utils](https://launchpad.net/cloud-utils) | Utilities for interacting with a cloud
* dev-util/[fossa-cli](https://github.com/fossas/fossa-cli) | License and vulnerability analysis
* dev-util/[gh](https://github.com/cli/cli) | The GitHub CLI
* dev-util/[gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner) | GitLab Runner
* dev-util/[insomnia-bin](https://insomnia.rest) | HTTP and GraphQL client for developers
* dev-util/[ovftool](https://www.vmware.com/support/developer/ovf) | VMware Open Virtualization Format tool
* dev-util/[packer](https://www.packer.io) | A tool to create identical machine images for multiple platforms
* dev-util/[swapusage](https://www.codesynthesis.com/hhoffstaette/swapusage) | Amount of swapped memory for running processes
* dev-util/[taskcat](https://github.com/aws-quickstart/taskcat) | An OpenSource Cloudformation Deployment Framework
* dev-util/[testmace](https://testmace.com) | Powerful IDE to work with API
* dev-util/[tickgit](https://github.com/augmentable-dev/tickgit) | Manage your repository's TODOs as config in your codebase
* dev-util/[xxd](https://github.com/vim/vim) | Hexdump utility from vim
* dev-util/[yamllint](https://github.com/adrienverge/yamllint) | A linter for YAML files
* dev-vcs/[commitizen](https://github.com/Woile/commitizen) | Python commitizen client tool
* dev-vcs/[gitaly](https://gitlab.com/gitlab-org/gitaly) | Git RPC service for handling GitLab git calls
* dev-vcs/[gitlint](https://github.com/jorisroovers/gitlint) | Git commit message linter
* dev-vcs/[mercurial-extension_utils](https://bitbucket.org/Mekk/mercurial-extension_utils) | Mercurial Extension Utils
* dev-vcs/[mercurial-keyring](https://bitbucket.org/Mekk/mercurial_keyring) | Mercurial Keyring Extension
* dev-vcs/[pre-commit](https://github.com/pre-commit/pre-commit) | A framework for multi-language pre-commit hooks
* gnome-base/[dconf](https://wiki.gnome.org/Projects/dconf) | Simple low-level configuration system
* media-gfx/[butteraugli](https://github.com/google/butteraugli) | A tool for measuring perceived differences between images
* media-gfx/[colorpick](https://github.com/agateau/colorpick) | Color picker and contrast checker
* media-gfx/[dssim](https://github.com/kornelski/dssim) | Image similarity comparison simulating human perception
* media-gfx/[guetzli](https://github.com/google/guetzli) | Perceptual JPEG encoder
* media-gfx/[lsix](https://github.com/hackerb9/lsix) | Image viewer for terminal that use sixel graphics
* media-gfx/[nomacs](https://nomacs.org) | Qt-based image viewer
* media-gfx/[qView](https://interversehq.com/qview) | Practical and minimal image viewer
* media-gfx/[pingo-bin](https://css-ig.net/pingo) | Fast web image optimizer
* media-gfx/[screencloud](https://screencloud.net) | Screenshot capturing and sharing tool over various services
* media-gfx/[xgrabcolor](http://hugo.pereira.free.fr/software/index.php) | Qt-based basic color picker
* media-libs/[bcmatroska2](https://gitlab.linphone.org/BC/public/bcmatroska2) | Matroska media container support
* media-libs/[bv16-floatingpoint](https://gitlab.linphone.org/BC/public/external/bv16-floatingpoint) | BroadVoice 16 kbs codec
* media-libs/[libqpsd](https://github.com/roniemartinez/libqpsd) | PSD & PSB Plugin for Qt/C++
* media-libs/[mediastreamer2](https://gitlab.linphone.org/BC/public/mediastreamer2) | Mediastreaming library for telephony application
* media-libs/[qt-heif](https://github.com/jakar/qt-heif-image-plugin) | Qt plugin for HEIF images
* media-libs/[shine](https://github.com/toots/shine) | Fixed-point mp3 encoding library
* media-sound/[plexamp](https://plexamp.com/) | Music focused client for Plex
* media-sound/[sayonara](https://sayonara-player.com) | Small, clear and fast Qt-based audio player
* media-radio/[krudio](https://github.com/loast/krudio) | Radio tray for linux on QT
* media-radio/[liquidsoap](http://liquidsoap.info) | A swiss-army knife for multimedia streaming, used for netradios and webtvs
* net-analyzer/[bandwhich](https://github.com/imsnif/bandwhich) | Network utilization by process, connection and hostname
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/goaccess.svg)](https://repology.org/metapackage/goaccess) net-analyzer/[goaccess](https://goaccess.io) | A real-time web log analyzer and interactive viewer in a terminal
* net-analyzer/[logswan](https://github.com/fcambus/logswan) | Web log analyzer using probabilistic data structures
* net-analyzer/[netgauge](http://www.ookla.com/) | Server software for testing internet bandwidth using speedtest.net
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/nuttcp.svg)](https://repology.org/metapackage/nuttcp) net-analyzer/[nuttcp](http://www.nuttcp.net) | Network performance measurement tool
* net-analyzer/[passivedns](https://github.com/gamelinux/passivedns) | Network sniffer that logs all DNS server replies
* net-analyzer/[pkt-netflow](https://github.com/aabc/pkt-netflow) | NetFlow v5, v9, IPFIX flow data exporter
* net-analyzer/[ripe-atlas-tools](https://github.com/RIPE-NCC/ripe-atlas-tools) | A temporary credentials for AWS roles via sudo-like utility
* net-analyzer/[wtraf-bin](https://wtraf.sourceforge.net/) | SNMP traffic monitor in realtime
* net-dns/[ddns-route53](https://github.com/crazy-max/ddns-route53) | Dynamic DNS for Amazon Route 53 on a time-based schedule
* net-dns/[r53ddns](https://github.com/coord-e/r53ddns) | Updates A record in Route53 with current global IP
* net-dns/[flares](https://github.com/lfaoro/flares) | CloudFlare DNS backup tool
* net-dns/[inadyn-mt](http://inadyn-mt.sourceforge.net/) | A simple dynamic DNS client
* net-dns/[massdns](https://github.com/blechschmidt/massdns) | A high-performance DNS stub resolver
* net-dns/[nsping](https://github.com/vovcat/nsping) | Measure reachability and latency of DNS nameservers
* net-firewall/[ipt-ratelimit](https://github.com/aabc/ipt-ratelimit) | Ratelimit iptables module
* net-ftp/[weex](https://sourceforge.net/projects/weex) | A non-interactive FTP client for updating web pages
* net-im/[communi-desktop](https://github.com/communi/communi-desktop) | A cross-platform IRC framework written with Qt
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/gitter.svg)](https://repology.org/metapackage/gitter) net-im/[gitter-bin](https://www.gitter.im) | Chat and network platform
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/slack.svg)](https://repology.org/metapackage/slack) net-im/[slack](https://www.slack.com) | Team collaboration tool
* net-im/[viber](http://www.viber.com) | Free text and calls
* net-im/[vk-messenger-bin](https://vk.com/messenger) | Simple and Easy App for Messaging on VK
* net-im/[zoom-bin](https://zoom.us) | Video conferencing and web conferencing service
* net-libs/[bctoolbox](https://gitlab.linphone.org/BC/public/bctoolbox) | Utilities library used by Belledonne Communications softwares
* net-libs/[bzrtp](https://gitlab.linphone.org/BC/public/bzrtp) | Media Path Key Agreement for Unicast Secure RTP
* net-libs/[ortp](https://gitlab.linphone.org/BC/public/ortp) | Open Real-time Transport Protocol (RTP, RFC3550) stack
* net-misc/[comcast](https://github.com/tylertreat/Comcast) | Network problems simulator
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/dhcdrop.svg)](https://repology.org/metapackage/dhcdrop) net-misc/[dhcdrop](http://www.netpatch.ru/dhcdrop.html) | Effectively suppresses illegal DHCP servers on the LAN
* net-misc/[dnsflood](https://github.com/hawell/dns-flood) | Use raw sockets to generate DNS flood attack
* [![Gentoo Bug](https://img.shields.io/badge/Bug-536148-red.svg)](https://bugs.gentoo.org/536148) net-misc/[fiche](https://github.com/solusipse/fiche) | Command line pastebin server
* net-misc/[mpssh](https://github.com/ndenev/mpssh) | Mass parallel ssh
* net-misc/[ngrok-bin](https://ngrok.com/) | Secure introspected tunnels to localhost
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/pingu.svg)](https://repology.org/metapackage/pingu) net-misc/[pingu](https://github.com/ncopa/pingu) | Policy routing daemon with failover and load-balancing
* net-misc/[qfreerdp](https://github.com/zrax/qfreerdp) | Qt launcher GUI for XFreeRDP
* net-misc/[qia](http://stg.codes) | Authorization tool for Stargazer Billing System written in Qt
* net-misc/[opendrop](https://github.com/seemoo-lab/opendrop) | an Open Source AirDrop Implementation
* net-misc/[redir](https://github.com/troglobit/redir) | TCP port redirector
* net-misc/[rstatd](http://rstatd.sourceforge.net/) | Client-server linux performance statistics
* net-misc/[s5cmd](https://github.com/peak/s5cmd) | Parallel S3 and local filesystem execution tool
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/samplicator.svg)](https://repology.org/metapackage/samplicator) net-misc/[samplicator](https://github.com/sleinen/samplicator) | UDP packets forwarder and duplicator
* net-misc/[slowhttptest](https://github.com/shekyan/slowhttptest) | Application Layer DoS attack simulator
* net-misc/[spoofer](https://spoofer.caida.org) | A tool to assess of deployment of source address validation
* net-misc/[ssmd](http://stg.codes/projects/ssmd) | SNMP Switch Management Daemon
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/stargazer.svg)](https://repology.org/metapackage/stargazer) net-misc/[stargazer](http://stg.net.ua/) | Billing system for small home and office networks
* net-misc/[topola](https://topola.unity.net) | Customer accounting system, services and statistics collection management
* net-misc/[uredir](https://github.com/troglobit/uredir) | UDP port redirector
* net-misc/[virtualhere-usb](https://virtualhere.com) | Share USB devices over the network
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/x11-ssh-askpass.svg)](https://repology.org/metapackage/x11-ssh-askpass) net-misc/[x11-ssh-askpass](https://github.com/sigmavirus24/x11-ssh-askpass) | X11-based passphrase dialog for use with OpenSSH
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/automatic.svg)](https://repology.org/metapackage/automatic) net-p2p/[automatic](https://github.com/1100101/Automatic) | RSS downloader for Tranmission
* net-p2p/[gram-wallet-bin](https://https://wallet.ton.org) | TON Testnet Wallet
* net-p2p/[tremotesf](https://github.com/equeim/tremotesf2) | A remote GUI for transmission
* [![Gentoo Bug](https://img.shields.io/badge/Bug-214969-red.svg)](https://bugs.gentoo.org/214969) net-p2p/[opentracker](https://github.com/flygoast/opentracker) | High-performance bittorrent tracker
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/resilio-sync.svg)](https://repology.org/metapackage/resilio-sync) net-p2p/[resilio-sync](https://resilio.com) | Resilient, fast and scalable file synchronization tool
* net-voip/[linphone-desktop](https://gitlab.linphone.org/BC/public/linphone-desktop) | A free VoIP and video softphone based on the SIP protocol
* net-voip/[twinkle](https://github.com/LubosD/twinkle) | Softphone for voice over IP and IM communication using SIP
* [![Gentoo Bug](https://img.shields.io/badge/Bug-498844-red.svg)](https://bugs.gentoo.org/498844) net-vpn/[softether](http://www.softether.org/) | Multi-protocol VPN software
* sci-visualization/[visidata](https://github.com/saulpw/visidata) | Terminal spreadsheet multitool for discovering and arranging data
* sys-apps/[aptly](https://github.com/aptly-dev/aptly) | A swiss army knife for Debian repository management
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/ethq.svg)](https://repology.org/metapackage/ethq) sys-apps/[ethq](https://github.com/isc-projects/ethq) | Ethernet NIC Queue stats viewer
* sys-apps/[evhz](https://gitlab.com/iankelling/evhz) | Mouse refresh rate under evdev
* sys-apps/[firetools](https://firejail.wordpress.com) | Graphical user interface of Firajail security sandbox
* sys-apps/[nocache](https://github.com/Feh/nocache) | Minimize caching effects for applications
* sys-apps/[psi-notify](https://github.com/cdown/psi-notify) | Minimalistic PSI notifier using libnotify
* sys-apps/[swapspace](https://github.com/Tookmund/Swapspace) | A dynamic swap space manager
* sys-cluster/[minishift-bin](https://github.com/minishift/minishift) | Single Node OpenShift Cluster
* sys-fs/[adhocify](https://github.com/quitesimpleorg/adhocify) | Tool which monitors for inotify events and executes script
* sys-fs/[xfs_undelete](https://github.com/ianka/xfs_undelete) | An undelete tool for the XFS filesystem
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/powerstat.svg)](https://repology.org/metapackage/powerstat) sys-power/[powerstat](https://launchpad.net/ubuntu/+source/powerstat) | Laptop power measuring tool
* www-apps/[draw-io](https://github.com/jgraph/drawio) | Online diagramming web application
* www-apps/[keeweb](https://github.com/keeweb/keeweb) | Cross-platform password manager compatible with KeePass
* www-apps/[LookingGlass](https://github.com/ramnode/LookingGlass) | A Python-backed Looking Glass
* www-apps/[netbox](https://github.com/netbox-community/netbox) | IP address and data center infrastructure management tool
* www-apps/[webui-aria2](https://github.com/ziahamza/webui-aria2) | The worlds best and hottest interface to interact with aria2
* www-plugins/[chrome-token-signing](https://github.com/open-eid/chrome-token-signing) | Native client and extension for signing with your eID on the web
* www-servers/[gitlab-workhorse](https://gitlab.com/gitlab-org/gitlab-workhorse) | GitLab reverse proxy
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/libinput-gestures.svg)](https://repology.org/metapackage/libinput-gestures) x11-misc/[libinput-gestures](https://github.com/bulletmark/libinput-gestures) | Actions gestures on your touchpad using libinput
* x11-misc/[logkeys](https://github.com/kernc/logkeys) | A Linux keylogger
* x11-misc/[openrazer](https://openrazer.github.io) | Linux drivers for the Razer devices
* x11-misc/[RazerGenie](https://github.com/z3ntu/RazerGenie) | Razer devices configurator
