# nest overlay

[![Number of ebuilds: 392](https://img.shields.io/badge/ebuild-392-orange.svg)](https://img.shields.io/badge/ebuild-392-orange.svg)
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
* app-admin/[awsudo](https://github.com/makethunder/awsudo) | A temporary credentials for AWS roles via sudo-like utility
* app-admin/[aws-vault](https://github.com/99designs/aws-vault) | A vault for securely storing and accessing AWS credentials
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
* app-admin/[tztail](https://github.com/thecasualcoder/tztail) | A log view in various timezones
* app-admin/[userdbadm](https://nasauber.de/opensource/userdbadm) | Tool to manage (PAM) userdb files with crypted passwords
* app-admin/[uwsgitop](https://github.com/unbit/uwsgitop) | uWSGI stats viewer
* app-admin/[yaml-vault](https://github.com/Jimdo/yaml-vault) | Utility to import/export data from HashiCorp Vault
* app-backup/[hashget](https://gitlab.com/yaroslaff/hashget) | Deduplication tool for archiving data with extremely high ratio
* app-backup/[pgbackrest](https://pgbackrest.org) | Reliable PostgreSQL Backup & Restore
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/zbackup.svg)](https://repology.org/metapackage/zbackup) app-backup/[zbackup](http://zbackup.org/) | A versatile deduplicating backup tool
* app-backup/[urbackup-client](https://urbackup.org) | Client Server backup system
* app-backup/[urbackup-server](https://urbackup.org) | Client Server backup system
* app-crypt/[acmebot](https://github.com/plinss/acmebot) | ACME protocol automatic certitificate manager
* app-crypt/[acme-client](https://github.com/kristapsdz/acme-client-portable) | Secure Let's Encrypt client
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/acme.sh.svg)](https://repology.org/metapackage/acme.sh) app-crypt/[acme-sh](https://github.com/Neilpang/acme.sh) | An ACME Shell script
* app-crypt/[qesteidutil](https://github.com/open-eid/qesteidutil) | Estonian ID card management desktop utility
* app-editors/[qedit](http://hugo.pereira.free.fr/software/index.php) | Qt-based multi-purpose text editor
* app-editors/[FeatherPad](https://github.com/tsujan/FeatherPad) | Lightweight Qt5 plain-text editor
* app-editors/[visual-studio-code-bin](https://code.visualstudio.com) | Editor for building and debugging modern web and cloud applications
* app-emulation/[looking-glass](https://looking-glass.hostfission.com) | A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough
* app-emulation/[qio](https://github.com/SpiderX/qio) | QEMU Init OpenRC
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
* dev-cpp/[libxsd-frontend](https://www.codesynthesis.com/projects/libxsd-frontend) | A compiler frontend for the W3C XML Schema definition language
* dev-cpp/[libcutl](https://www.codesynthesis.com/projects/libcutl) | A collection of C++ libraries (successor of libcult)
* dev-cpp/[xsd](https://www.codesynthesis.com/products/xsd) | A cross-platform W3C XML Schema to C++ data binding compiler
* dev-db/[pg_cron](https://github.com/citusdata/pg_cron) | Run periodic jobs in PostgreSQL
* dev-db/[odyssey](https://github.com/yandex/odyssey) | Scalable PostgreSQL connection pooler
* dev-db/[pg_page_verification](https://github.com/google/pg_page_verification) | Checksums verification on PostgreSQL data pages
* dev-db/[pg_profile](https://github.com/zubkov-andrei/pg_profile) | Postgres historic performance reports
* dev-db/[pg_repack](https://github.com/reorg/pg_repack) | PostgreSQL extension for data reorganization
* dev-db/[pgcenter](https://github.com/lesovsky/pgcenter) | Command-line admin tool for observing and troubleshooting Postgres
* dev-db/[pgtune](https://github.com/andreif/pgtune) | A high-performance PostgreSQL tuning script
* dev-db/[pipelinedb](https://www.pipelinedb.com/) | High-performance time-series aggregation for PostgreSQL
* dev-libs/[libcommuni](http://communi.github.io/) | A cross-platform IRC framework written with Qt
* dev-libs/[libdigidoc](https://github.com/open-eid/libdigidoc) | DigiDoc digital signature library
* dev-libs/[libdigidocpp](https://github.com/open-eid/libdigidocpp) | Library for handling digitally signed documents
* [![Gentoo Bug](https://img.shields.io/badge/Bug-482946-red.svg)](https://bugs.gentoo.org/482946) dev-libs/[loki](http://loki-lib.sourceforge.net/) | C++ library of common design patterns and idioms
* dev-libs/[xml-security-c](https://santuario.apache.org) | Apache C++ XML security libraries
* dev-go/[keyring](https://github.com/99designs/keyring) | Library with uniform interface across a range of secure credential stores
* dev-haskell/[adjunctions](https://github.com/ekmett/adjunctions) | Adjunctions and representable functors
* dev-haskell/[aeson](https://github.com/bos/aeson) | Fast JSON parsing and encoding
* dev-haskell/[ansi-terminal](https://github.com/feuerbach/ansi-terminal) | Simple ANSI terminal support, with Windows compatibility
* dev-haskell/[ansi-wl-pprint](https://github.com/ekmett/ansi-wl-pprint) | The Wadler/Leijen Pretty Printer for colored ANSI terminal output
* dev-haskell/[async](https://github.com/simonmar/async) | Run IO operations asynchronously and wait for their results
* dev-haskell/[base-compat](https://github.com/haskell-compat/base-compat) | A compatibility layer for base
* dev-haskell/[base-compat-batteries](https://github.com/haskell-compat/base-compat) | Base-compat with extra batteries
* dev-haskell/[base-orphans](https://github.com/haskell-compat/base-orphans) | Backwards-compatible orphan instances for base
* dev-haskell/[bifunctors](https://github.com/ekmett/bifunctors) | Haskell 98 bifunctors, bifoldables and bitraversables
* dev-haskell/[bsb-http-chunked](https://github.com/sjakobi/bsb-http-chunked) | Chunked HTTP transfer encoding for bytestring builders
* dev-haskell/[call-stack](https://github.com/sol/call-stack) | Use GHC call-stacks in a backward compatible way
* dev-haskell/[clock](https://github.com/corsis/clock) | High-resolution clock functions
* dev-haskell/[concurrent-output](https://git.joeyh.name/index.cgi/concurrent-output.git) | Ungarble output from several threads or commands
* dev-haskell/[contravariant](https://github.com/ekmett/contravariant) | Contravariant functors
* dev-haskell/[comonad](https://github.com/ekmett/comonad) | Haskell 98 compatible comonads
* dev-haskell/[cryptonite](https://github.com/haskell-crypto/cryptonite) | Cryptography Primitives sink
* dev-haskell/[daemons](https://github.com/scvalex/daemons) | Daemons in Haskell made fun and easy
* dev-haskell/[diff](https://hackage.haskell.org/package/Diff) | O(ND) diff algorithm in haskell
* dev-haskell/[distributive](https://github.com/ekmett/distributive) | Distributive functors
* dev-haskell/[dlist](https://github.com/spl/dlist) | Difference lists
* dev-haskell/[either](https://github.com/ekmett/either) | An either monad transformer
* dev-haskell/[errors](https://github.com/Gabriel439/Haskell-Errors-Library) | Simplified error-handling
* dev-haskell/[exceptions](https://github.com/ekmett/exceptions) | Extensible optionally-pure exceptions
* dev-haskell/[fast-logger](https://github.com/kazu-yamamoto/logger) | A fast logging system
* dev-haskell/[free](https://github.com/ekmett/free) | Monads for free
* dev-haskell/[glob](http://iki.fi/matti.niemenmaa/glob) | Globbing library
* dev-haskell/[hedgehog](https://hedgehog.qa) | Hedgehog will eat all your bugs
* dev-haskell/[hunit](https://github.com/hspec/HUnit) | A unit testing framework for Haskell
* dev-haskell/[hspec](http://hspec.github.io) | A Testing Framework for Haskell
* dev-haskell/[hspec-core](http://hspec.github.io) | A Testing Framework for Haskell
* dev-haskell/[hspec-discover](http://hspec.github.io) | Automatically discover and run Hspec tests
* dev-haskell/[hspec-expectations](https://github.com/hspec/hspec-expectations) | Catchy combinators for HUnit
* dev-haskell/[hspec-meta](http://hspec.github.io) | A version of Hspec which is used to test Hspec itself
* dev-haskell/[hspec-wai](https://github.com/hspec/hspec-wai) | Experimental Hspec support for testing WAI applications
* dev-haskell/[http2](https://github.com/kazu-yamamoto/http2) | HTTP/2.0 library including frames and HPACK
* dev-haskell/[http-types](https://github.com/aristidb/http-types) | Generic HTTP types for Haskell (for both client and server code)
* dev-haskell/[ini](https://github.com/chrisdone/ini) | Quick and easy configuration files in the INI format
* dev-haskell/[integer-logarithms](https://github.com/Bodigrim/integer-logarithms) | Integer logarithms
* dev-haskell/[integer-simple](http://hackage.haskell.org/package/integer-simple) | Simple Integer library
* dev-haskell/[invariant](https://github.com/nfrisby/invariant-functors) | Haskell 98 invariant functors
* dev-haskell/[kan-extensions](https://github.com/ekmett/kan-extensions) | Kan extensions
* dev-haskell/[lens](https://github.com/ekmett/lens) | Lenses, Folds and Traversals
* dev-haskell/[lifted-async](https://github.com/maoe/lifted-async) | Run lifted IO operations asynchronously and wait for their results
* dev-haskell/[nats](https://github.com/ekmett/nats) | Natural numbers
* dev-haskell/[network-byte-order](https://github.com/kazu-yamamoto/network-byte-order) | Network byte order utilities
* dev-haskell/[mmorph](https://github.com/Gabriel439/Haskell-MMorph-Library) | Monad morphisms
* dev-haskell/[quickcheck](https://github.com/nick8325/quickcheck) | Automatic testing of Haskell programs
* dev-haskell/[quickcheck-instances](https://github.com/phadej/qc-instances) | Common quickcheck instances
* dev-haskell/[quickcheck-io](https://github.com/hspec/quickcheck-io) | Use HUnit assertions as QuickCheck properties
* dev-haskell/[pipes](https://github.com/Gabriel439/Haskell-Pipes-Library) | Compositional pipelines
* dev-haskell/[primitive](https://github.com/haskell/primitive) | Primitive memory-related operations
* dev-haskell/[profunctors](https://github.com/ekmett/profunctors) | Profunctors
* dev-haskell/[optparse-applicative](https://github.com/pcapriotti/optparse-applicative) | Utilities and combinators for parsing command line options
* dev-haskell/[resourcet](https://github.com/snoyberg/conduit) | Deterministic allocation and freeing of scarce resources
* dev-haskell/[scientific](https://github.com/basvandijk/scientific) | Numbers represented using scientific notation
* dev-haskell/[scotty](https://github.com/scotty-web/scotty) | Haskell web framework
* dev-haskell/[semigroupoids](https://github.com/ekmett/semigroupoids) | Semigroupoids: Category sans id
* dev-haskell/[semigroups](https://github.com/ekmett/semigroups) | Anything that associates
* dev-haskell/[splitmix](https://github.com/phadej/splitmix) | Fast Splittable PRNG
* dev-haskell/[streaming-commons](https://github.com/fpco/streaming-commons) | Common lower-level functions needed by various streaming data libraries
* dev-haskell/[tasty](https://github.com/feuerbach/tasty) | Modern and extensible testing framework
* dev-haskell/[tasty-ant-xml](https://github.com/ocharles/tasty-ant-xml) | Render tasty output to XML for Jenkins
* dev-haskell/[tasty-expected-failure](https://github.com/nomeata/tasty-expected-failure) | Mark tasty tests as failure expected
* dev-haskell/[tasty-hedgehog](https://github.com/qfpl/tasty-hedgehog) | Integration for tasty and hedgehog
* dev-haskell/[tasty-hunit](https://github.com/feuerbach/tasty) | HUnit support for the Tasty test framework
* dev-haskell/[tasty-quickcheck](https://github.com/feuerbach/tasty) | QuickCheck support for the Tasty test framework
* dev-haskell/[text](https://github.com/haskell/text) | An efficient packed Unicode text type
* dev-haskell/[th-abstraction](https://github.com/glguy/th-abstraction) | Uniform interface to reified data type information
* dev-haskell/[time-compat](https://github.com/phadej/time-compat) | Compatibility with old-time for the time package
* dev-haskell/[time-manager](https://github.com/yesodweb/wai) | Scalable timer
* dev-haskell/[transformers-base](https://github.com/mvv/transformers-base) | Lift computations from the bottom of a transformer stack
* dev-haskell/[transformers-compat](https://github.com/ekmett/transformers-compat) | A small compatibility shim for dev-haskell/transformers
* dev-haskell/[type-equality](https://github.com/hesselink/type-equality) | Type equality, coercion/cast and other operations
* dev-haskell/[tz](https://github.com/nilcons/haskell-tz) | Library for time zone conversions
* dev-haskell/[tzdata](https://github.com/nilcons/haskell-tzdata) | Distribution of the standard time zone database
* dev-haskell/[unix-time](https://github.com/kazu-yamamoto/unix-time) | Unix time parser/formatter and utilities
* dev-haskell/[unliftio-core](https://github.com/fpco/unliftio) | The MonadUnliftIO typeclass for unlifting monads to IO
* dev-haskell/[vector](https://github.com/haskell/vector) | Efficient Arrays
* dev-haskell/[websockets](http://jaspervdj.be/websockets) | Allows you to write WebSocket-capable servers
* dev-haskell/[wai-cors](https://github.com/larskuhtz/wai-cors) | Cross-Origin resource sharing (CORS) for Wai
* dev-haskell/[wai-extra](https://github.com/yesodweb/wai) | Provides some basic WAI handlers and middleware
* dev-haskell/[wai-logger](http://hackage.haskell.org/package/wai-logger) | A logging system for WAI
* dev-haskell/[wai-websockets](https://github.com/yesodweb/wai) | Provide a bridge between WAI and the websockets package
* dev-haskell/[warp](https://github.com/yesodweb/wai) | A fast, light-weight web server for WAI applications
* dev-haskell/[wcwidth](https://github.com/solidsnack/wcwidth) | Native wcwidth
* dev-haskell/[wl-pprint-annotated](https://github.com/minad/wl-pprint-annotated) | Pretty printer with annotations
* dev-haskell/[x509](https://github.com/vincenthz/hs-certificate) | X509 reader and writer
* dev-haskell/[x509-store](https://github.com/vincenthz/hs-certificate) | X.509 collection accessing and storing methods
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
* dev-python/[GitPython](https://github.com/gitpython-developers/GitPython) | A python library used to interact with Git repositories
* dev-python/[adal](https://github.com/AzureAD/azure-activedirectory-library-for-python) | Library for authentication in Azure Active Directory
* dev-python/[anyconfig](https://github.com/ssato/python-anyconfig) | Generic access to configuration files in any formats
* dev-python/[applicationinsights](https://pypi.python.org/pypi/applicationinsights/) | Application Insights API surface
* dev-python/[aws-sam-translator](https://github.com/awslabs/serverless-application-model) | A library to transform SAM templates into AWS CloudFormation templates
* dev-python/[cerberus](https://github.com/pyeve/cerberus) | Lightweight and extensible data validation library for Python
* dev-python/[click-completion](https://github.com/click-contrib/click-completion) | Enhanced completion for bash, fish, zsh in Click
* dev-python/[coreapi](https://github.com/core-api/python-client) | Python client library for Core API
* dev-python/[coreschema](https://github.com/core-api/python-coreschema) | Python CoreSchema
* dev-python/[crayons](https://github.com/kennethreitz/crayons) | Text UI colors
* dev-python/[cron-descriptor](https://github.com/Salamek/cron-descriptor) | Converts cron expressions into human readable strings
* dev-python/[crossplane](https://github.com/nginxinc/crossplane) | Fast and reliable NGINX configuration parser
* dev-python/[ctypescrypto](https://github.com/vbwagner/ctypescrypto) | File format determination library for Python
* dev-python/[datadiff](https://datadiff.sourceforge.net) | A library for diffs of python data structures
* dev-python/[decli](https://github.com/Woile/decli) | Minimal declarative cli tool
* dev-python/[delegator-py](https://github.com/kennethreitz/delegator.py) | Simple library for dealing with subprocesses
* dev-python/[dateparser](https://github.com/scrapinghub/dateparser) | Date parsing library designed to parse dates from HTML pages
* dev-python/[django-celery-beat](https://github.com/celery/django-celery-beat) | Celery Periodic Tasks for Django
* dev-python/[django-cors-headers](https://github.com/ottoyiu/django-cors-headers) | Django application for Cross-Origin Resource Sharing (CORS)
* dev-python/[django-crispy-forms](https://github.com/django-crispy-forms/django-crispy-forms) | DRY Django forms
* dev-python/[django-debug-toolbar](https://github.com/django-debug-toolbar/django-debug-toolbar) | A configurable set of panels that display debug information
* dev-python/[django-environ](https://github.com/joke2k/django-environ) | An environment variables to configure Django
* dev-python/[django-filter](https://github.com/carltongibson/django-filter) | Django application for filtering querysets
* dev-python/[django-guardian](https://github.com/django-guardian/django-guardian) | An implementation of per object permissions for Django
* dev-python/[django-jsonfield](https://github.com/dmkoch/django-jsonfield) | A Django field to store validated JSON in your model
* dev-python/[django-jinja](https://github.com/niwinz/django-jinja) | Jinja2 templating language integrated in Django
* dev-python/[django-js-asset](https://github.com/matthiask/django-js-asset) | A script tag with additional attributes for django.forms.Media
* dev-python/[django-mptt](https://github.com/django-mptt/django-mptt) | Utilities for implementing Modified Preorder Tree Traversal
* dev-python/[django-oauth-toolkit](https://github.com/jazzband/django-oauth-toolkit) | OAuth2 Provider for Django
* dev-python/[django-pipeline](https://github.com/jazzband/django-pipeline) | An asset packaging library for Django
* dev-python/[django-rest-framework](https://django-rest-framework.org/) | Django REST framework
* dev-python/[django-rest-framework-camel-case](https://github.com/vbabiy/djangorestframework-camel-case) | Camel case JSON support for Django REST framework
* dev-python/[django-rest-framework-recursive](https://github.com/heywbj/django-rest-framework-recursive) | Recursive Serialization for Django REST framework
* dev-python/[django-rest-swagger](https://marcgibbons.com/django-rest-swagger/) | Swagger UI for Django REST Framework
* dev-python/[django-rq](https://github.com/rq/django-rq) | An app that provides django integration for RQ (Redis Queue)
* dev-python/[django-tables2](https://github.com/jieter/django-tables2) | Django application for creating HTML tables
* dev-python/[django-taggit](https://github.com/alex/django-taggit) | Django application for simple tagging
* dev-python/[django-taggit-serializer](https://github.com/glemmaPaul/django-taggit-serializer) | Django Taggit Serializer Created for the Django REST Framework
* dev-python/[django-timezone-field](https://github.com/mfogel/django-timezone-field) | Django application for database and form fields for pytz objects
* dev-python/[drf-yasg](https://github.com/axnsan12/drf-yasg) | Yet another Swagger generator
* dev-python/[email-validator](https://github.com/JoshData/python-email-validator) | An email syntax and deliverability validation library
* dev-python/[factory_boy](https://github.com/FactoryBoy/factory_boy) | A fixtures replacement tool
* dev-python/[fakeldap](https://github.com/zulip/fakeldap) | An implementation of a LDAPObject to fake a ldap server
* dev-python/[faker](https://github.com/joke2k/faker) | Python package that generates fake data
* dev-python/[filetype](https://github.com/h2non/filetype.py) | Infer file type and MIME type of any file/buffer
* dev-python/[fleep](https://github.com/floyernick/fleep-py) | File format determination library for Python
* dev-python/[flex](https://github.com/pipermerriam/flex) | Validation tooling for Swagger 2.0 specifications
* dev-python/[fudge](http://farmdev.com/projects/fudge) | Replace real objects with fakes (mocks, stubs, etc) while testing
* dev-python/[git-url-parse](https://github.com/coala/git-url-parse) | A simple GIT URL parser
* dev-python/[graphviz](https://github.com/xflr6/graphviz) | Simple Python interface for Graphviz
* dev-python/[ifaddr](https://github.com/floyernick/fleep-py) | Python Library to enumerate all network interfaces
* dev-python/[itypes](https://github.com/tomchristie/itypes) | Simple immutable types for python
* dev-python/[jsmin](https://github.com/tikitu/jsmin) | JavaScript minifier
* dev-python/[livereload](https://github.com/lepture/python-livereload) | Python LiveReload is an awesome tool for web developers
* dev-python/[m9dicts](https://github.com/ssato/python-m9dicts) | A dict-like object supports recursive merge operation
* dev-python/[markdown2](https://github.com/trentm/python-markdown2) | A fast and complete Python implementation of Markdown
* dev-python/[mock-django](https://github.com/dcramer/mock-django) | A simple library for mocking certain Django behavior
* dev-python/[msrest](https://pypi.python.org/pypi/msrest/) | AutoRest swagger generator Python client runtime
* dev-python/[ncclient](https://github.com/ncclient/ncclient) | Python library for NETCONF clients
* dev-python/[onetimepass](https://github.com/tadeck/onetimepass) | One-time password library for HOTP and TOTP passwords
* dev-python/[parameterized](https://github.com/wolever/parameterized) | Parameterized testing with any Python test framework
* dev-python/[pathspec](https://github.com/cpburnz/python-path-specification) | A utility library for pattern matching of file paths
* dev-python/[polemarch-ansible](https://gitlab.com/vstconsulting/polemarch-ansible) | Wrapper for Ansible CLI
* dev-python/[port-for](https://github.com/kmike/port-for) | An utility and python library for TCP ports management
* dev-python/[pytest-pythonpath](https://pypi.org/project/pytest-pythonpath) | plugin for adding to the PYTHONPATH from command line or configs
* dev-python/[pytimeparse](https://github.com/wroberts/pytimeparse) | A library to parse time from human readable string
* dev-python/[python-crontab](https://github.com/doctormo/python-coreschema) | Crontab module for reading and writing crontab files
* dev-python/[python-gilt](https://github.com/metacloud/gilt) | A GIT layering tool
* dev-python/[python-openapi-codec](https://github.com/core-api/python-openapi-codec) | An OpenAPI codec for Core API
* dev-python/[python-user-agents](https://github.com/selwin/python-user-agents) | A library to identify devices by parsing user agent strings
* dev-python/[pywinrm](https://github.com/diyan/pywinrm) | Python library for Windows Remote Management
* dev-python/[PythonQt](http://pythonqt.sourceforge.net/) | A dynamic Python binding for the Qt framework
* dev-python/[questionary](https://github.com/tmbo/questionary) | Python library to build pretty command line user prompts
* dev-python/[random2](https://github.com/strichter/random2) | Python-2.7 random module ported to python-3
* dev-python/[requests-credssp](https://github.com/jborean93/requests-credssp) | CredSSP authentication handler for Python Requests
* dev-python/[rq](https://github.com/rq/rq) | A library for creating and processing background jobs
* dev-python/[rstr](http://bitbucket.org/leapfrogdevelopment/rstr) | Generate random strings in Python
* dev-python/[ruamel-ordereddict](https://bitbucket.org/ruamel/ordereddict) | An ordered dictionary with KIO/KVIO
* dev-python/[ruamel-std-pathlib](https://bitbucket.org/ruamel/std.pathlib) | Ruamel enhancements to pathlib and pathlib2
* dev-python/[ruamel-yaml](https://bitbucket.org/ruamel/yaml) | YAML parser/emitter that supports roundtrip comment preservation
* dev-python/[selectors2](https://github.com/SethMichaelLarson/selectors2) | Portable replacement to the standard library selectors module
* dev-python/[sentry-sdk](https://github.com/getsentry/sentry-python) | Python client for Sentry
* dev-python/[shellingham](https://github.com/sarugaku/shellingham) | Detects what shell the current Python executable is running in
* dev-python/[slimit](https://slimit.readthedocs.io/en/latest) | A JavaScript minifier written in Python
* dev-python/[sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-mermaid](https://github.com/mgaitan/sphinxcontrib-mermaid) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-openapi](https://github.com/ikalnytskyi/sphinxcontrib-openapi) | Sphinx extension to generate APIs docs from OpenAPI
* dev-python/[swagger_spec_validator](https://github.com/Yelp/swagger_spec_validator) | Python library that validates Swagger Specs
* dev-python/[tablib](http://python-tablib.org/) | A format-agnostic tabular dataset library written in Python
* dev-python/[testinfra](https://github.com/philpep/testinfra) | Testinfra test your infrastructures
* dev-python/[text-unidecode](https://github.com/kmike/text-unidecode) | The most basic Text::Unidecode port
* dev-python/[timecop](https://github.com/bluekelp/pytimecop) | A port of TimeCop Ruby Gem for Python
* dev-python/[toml](https://github.com/uiri/toml) | Python Library for Tom's Obvious, Minimal Language
* dev-python/[tomlkit](https://github.com/sdispater/decli) | Style-preserving TOML library for Python
* dev-python/[tree-format](https://github.com/jml/tree-format) | Python library for printing trees on the console
* dev-python/[ua-parser](https://datadiff.sourceforge.net/) | A library for diffs of python data structures
* dev-python/[whaaaaat](https://github.com/finklabs/whaaaaat) | A collection of common interactive command line user interfaces
* dev-python/[ukpostcodeparser](https://github.com/hamstah/ukpostcodeparser) | UK postcode parser library
* dev-python/[validate_email](https://github.com/syrusakbary/validate_email) | Python email validation library
* dev-python/[validators](https://github.com/kvesteri/validators) | Python data validation library
* dev-python/[versionfinder](https://github.com/jantman/versionfinder) | Find version of python package, installed via pip, setuptools, git
* dev-python/[yattag](http://www.yattag.org) | Generate HTML or XML in a pythonic way
* dev-util/[ansible-molecule](https://github.com/ansible/molecule) | Automated testing for Ansible roles
* dev-util/[build2](https://build2.org) | A cross-platform toolchain for building and packaging C++ code
* dev-util/[cfn-python-lint](https://github.com/awslabs/cfn-python-lint) | AWS CloudFormation Linter
* dev-util/[cfn-template-flip](https://github.com/awslabs/aws-cfn-template-flip) | AWS CloudFormation Template Flip
* dev-util/[cli](https://www.codesynthesis.com/projects/cli) | Command Line Interface compiler for C++
* dev-util/[fossa-cli](https://github.com/fossas/fossa-cli) | License and vulnerability analysis
* dev-util/[gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner) | GitLab Runner
* dev-util/[insomnia-bin](https://insomnia.rest) | HTTP and GraphQL client for developers
* dev-util/[taskcat](https://github.com/aws-quickstart/taskcat) | An OpenSource Cloudformation Deployment Framework
* dev-util/[testmace-bin](https://testmace.com) | Powerful IDE to work with API
* dev-util/[tickgit](https://github.com/augmentable-dev/tickgit) | Manage your repository's TODOs as config in your codebase
* dev-util/[xxd](https://github.com/vim/vim) | Hexdump utility from vim
* dev-util/[yamllint](https://github.com/adrienverge/yamllint) | A linter for YAML files
* dev-vcs/[commitizen](https://github.com/Woile/commitizen) | Python commitizen client tool
* dev-vcs/[gitlint](https://github.com/jorisroovers/gitlint) | Git commit message linter
* dev-vcs/[mercurial-extension_utils](https://bitbucket.org/Mekk/mercurial-extension_utils) | Mercurial Extension Utils
* dev-vcs/[mercurial-keyring](https://bitbucket.org/Mekk/mercurial_keyring) | Mercurial Keyring Extension
* media-gfx/[butteraugli](https://github.com/google/butteraugli) | A tool for measuring perceived differences between images
* media-gfx/[colorpick](https://github.com/agateau/colorpick) | Color picker and contrast checker
* media-gfx/[dssim](https://github.com/kornelski/dssim) | Image similarity comparison simulating human perception
* media-gfx/[guetzli](https://github.com/google/guetzli) | Perceptual JPEG encoder
* media-gfx/[lsix](https://github.com/hackerb9/lsix) | Image viewer for terminal that use sixel graphics
* media-gfx/[nomacs](https://nomacs.org) | Qt-based image viewer
* media-gfx/[qView](https://interversehq.com/qview) | Practical and minimal image viewer
* media-gfx/[pingo-bin](https://css-ig.net/pingo) | Fast web image optimizer
* media-gfx/[screencloud](https://screencloud.net/) | Screenshot capturing and sharing tool over various services
* media-gfx/[xgrabcolor](http://hugo.pereira.free.fr/software/index.php) | Qt-based basic color picker
* media-libs/[libqpsd](https://github.com/roniemartinez/libqpsd) | PSD & PSB Plugin for Qt/C++
* media-libs/[qt-heif](https://github.com/jakar/qt-heif-image-plugin) | Qt plugin for HEIF images
* media-libs/[shine](https://github.com/toots/shine) | Fixed-point mp3 encoding library
* media-radio/[krudio](https://github.com/loast/krudio) | Radio tray for linux on QT
* media-radio/[liquidsoap](http://liquidsoap.info) | A swiss-army knife for multimedia streaming, used for netradios and webtvs
* net-analyzer/[bandwhich](https://github.com/imsnif/bandwhich) | Network utilization by process, connection and hostname
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/goaccess.svg)](https://repology.org/metapackage/goaccess) net-analyzer/[goaccess](https://goaccess.io) | A real-time web log analyzer and interactive viewer in a terminal
* net-analyzer/[logswan](https://github.com/fcambus/logswan) | Web log analyzer using probabilistic data structures
* net-analyzer/[netgauge](http://www.ookla.com/) | Server software for testing internet bandwidth using speedtest.net
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/nuttcp.svg)](https://repology.org/metapackage/nuttcp) net-analyzer/[nuttcp](http://www.nuttcp.net/) | Network performance measurement tool
* net-analyzer/[passivedns](https://github.com/gamelinux/passivedns) | Network sniffer that logs all DNS server replies
* net-analyzer/[wtraf-bin](https://wtraf.sourceforge.net/) | SNMP traffic monitor in realtime
* net-dns/[flares](https://github.com/lfaoro/flares) | CloudFlare DNS backup tool
* net-dns/[inadyn-mt](http://inadyn-mt.sourceforge.net/) | A simple dynamic DNS client
* net-dns/[nsping](https://github.com/vovcat/nsping) | Measure reachability and latency of DNS nameservers
* net-firewall/[ipt_netflow](https://sourceforge.net/projects/ipt-netflow) | Netflow iptables module
* net-firewall/[ipt_ratelimit](https://github.com/aabc/ipt-ratelimit) | Ratelimit iptables module
* net-im/[communi-desktop](https://github.com/communi/communi-desktop) | A cross-platform IRC framework written with Qt
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/gitter.svg)](https://repology.org/metapackage/gitter) net-im/[gitter-bin](https://www.gitter.im) | Chat and network platform
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/slack.svg)](https://repology.org/metapackage/slack) net-im/[slack-bin](https://www.slack.com/) | Team collaboration tool
* net-im/[viber-bin](http://www.viber.com) | Free text and calls
* net-im/[vk-messenger-bin](https://vk.com/messenger) | Simple and Easy App for Messaging on VK
* net-misc/[comcast](https://github.com/tylertreat/Comcast) | Network problems simulator
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/dhcdrop.svg)](https://repology.org/metapackage/dhcdrop) net-misc/[dhcdrop](http://www.netpatch.ru/dhcdrop.html) | Effectively suppresses illegal DHCP servers on the LAN
* [![Gentoo Bug](https://img.shields.io/badge/Bug-536148-red.svg)](https://bugs.gentoo.org/536148) net-misc/[fiche](https://github.com/solusipse/fiche) | Command line pastebin server
* net-misc/[ngrok-bin](https://ngrok.com/) | Secure introspected tunnels to localhost
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/pingu.svg)](https://repology.org/metapackage/pingu) net-misc/[pingu](https://github.com/ncopa/pingu) | Policy routing daemon with failover and load-balancing
* net-misc/[qfreerdp](https://github.com/zrax/qfreerdp) | Qt launcher GUI for XFreeRDP
* net-misc/[qia](http://stg.codes/) | Authorization tool for Stargazer Billing System written in Qt
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
* net-misc/[virtualhere-usb-bin](https://virtualhere.com/) | Share USB devices over the network
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/automatic.svg)](https://repology.org/metapackage/automatic) net-p2p/[automatic](https://github.com/1100101/Automatic) | RSS downloader for Tranmission
* net-p2p/[gram-wallet-bin](https://https://wallet.ton.org) | TON Testnet Wallet
* net-p2p/[tremotesf](https://github.com/equeim/tremotesf2) | A remote GUI for transmission
* [![Gentoo Bug](https://img.shields.io/badge/Bug-214969-red.svg)](https://bugs.gentoo.org/214969) net-p2p/[opentracker](https://github.com/flygoast/opentracker) | High-performance bittorrent tracker
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/resilio-sync.svg)](https://repology.org/metapackage/resilio-sync) net-p2p/[resilio-sync](https://resilio.com/) | Resilient, fast and scalable file synchronization tool
* [![Gentoo Bug](https://img.shields.io/badge/Bug-498844-red.svg)](https://bugs.gentoo.org/498844) net-vpn/[softether](http://www.softether.org/) | Multi-protocol VPN software
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/ethq.svg)](https://repology.org/metapackage/ethq) sys-apps/[ethq](https://github.com/isc-projects/ethq) | Ethernet NIC Queue stats viewer
* sys-apps/[firetools](https://firejail.wordpress.com) | Graphical user interface of Firajail security sandbox
* sys-cluster/[minishift-bin](https://github.com/minishift/minishift) | Single Node OpenShift Cluster
* sys-fs/[adhocify](https://github.com/quitesimpleorg/adhocify) | Tool which monitors for inotify events and executes script
* sys-fs/[xfs_undelete](https://github.com/ianka/xfs_undelete) | An undelete tool for the XFS filesystem
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/powerstat.svg)](https://repology.org/metapackage/powerstat) sys-power/[powerstat](https://launchpad.net/ubuntu/+source/powerstat) | Laptop power measuring tool
* www-apps/[draw-io](https://github.com/jgraph/drawio) | Online diagramming web application
* www-apps/[keeweb](https://github.com/keeweb/keeweb) | Cross-platform password manager compatible with KeePass
* www-apps/[LookingGlass](https://github.com/ramnode/LookingGlass) | A Python-backed Looking Glass
* www-apps/[netbox](https://github.com/digitalocean/netbox) | IP address management (IPAM) and data center infrastructure management (DCIM)
* www-apps/[noc-tower](https://code.getnoc.com/noc/tower/) | NOCProject supervisor
* www-apps/[webui-aria2](https://github.com/ziahamza/webui-aria2) | The worlds best and hottest interface to interact with aria2
* www-plugins/[chrome-token-signing](https://github.com/open-eid/chrome-token-signing) | Native client and extension for signing with your eID on the web
* www-servers/[gitlab-gitaly](https://gitlab.com/gitlab-org/gitaly) | Gitaly is a Git RPC service for handling GitLab git calls
* www-servers/[gitlab-workhorse](https://gitlab.com/gitlab-org/gitlab-workhorse) | GitLab reverse proxy
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/libinput-gestures.svg)](https://repology.org/metapackage/libinput-gestures) x11-misc/[libinput-gestures](https://github.com/bulletmark/libinput-gestures) | Actions gestures on your touchpad using libinput
* x11-misc/[logkeys](https://github.com/kernc/logkeys) | A Linux keylogger
* x11-misc/[openrazer](https://openrazer.github.io) | Linux drivers for the Razer devices
* x11-misc/[RazerGenie](https://github.com/z3ntu/RazerGenie) | Razer devices configurator
