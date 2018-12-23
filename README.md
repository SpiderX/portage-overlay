# nest overlay

[![Number of ebuilds: 213](https://img.shields.io/badge/ebuild-213-orange.svg)](https://img.shields.io/badge/ebuild-213-orange.svg)
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

* app-admin/[awslog](https://github.com/jaksi/awslog) | History and changes of configuration versions of AWS resources
* app-admin/[awsudo](https://github.com/makethunder/awsudo) | A temporary credentials for AWS roles via sudo-like utility
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/qtpass.svg)](https://repology.org/metapackage/qtpass) app-admin/[qtpass](https://qtpass.org/) | multi-platform GUI for pass, the standard unix password manager
* app-admin/[jl](https://github.com/koenbollen/jl) | A tool for working with structured JSON logging
* app-admin/[reprepro](https://mirrorer.alioth.debian.org/) | A tool to handle local repositories of Debian packages
* app-admin/[tztail](https://github.com/thecasualcoder/tztail) | A log view in various timezones
* app-admin/[userdbadm](http://nasauber.de/opensource/userdbadm) | Tool to manage (PAM) userdb files with crypted passwords
* app-admin/[uwsgitop](https://github.com/unbit/uwsgitop/) | uWSGI stats viewer
* app-backup/[pgbackrest](https://pgbackrest.org) | Reliable PostgreSQL Backup & Restore
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/zbackup.svg)](https://repology.org/metapackage/zbackup) app-backup/[zbackup](http://zbackup.org/) | A versatile deduplicating backup tool
* app-crypt/[acmebot](https://github.com/plinss/acmebot) | ACME protocol automatic certitificate manager
* app-crypt/[acme-client](https://github.com/kristapsdz/acme-client-portable) | Secure Let's Encrypt client
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/acme-sh.svg)](https://repology.org/metapackage/acme-sh) app-crypt/[acme-sh](https://github.com/Neilpang/acme.sh) | An ACME Shell script
* app-crypt/[qesteidutil](https://github.com/open-eid/qesteidutil) | Estonian ID card management desktop utility
* app-emulation/[looking-glass](https://looking-glass.hostfission.com) | A low latency KVM FrameRelay implementation for guests with VGA PCI Passthrough
* app-emulation/[qio](https://github.com/SpiderX/qio) | QEMU Init OpenRC
* app-forensics/[gitleaks](https://github.com/zricethezav/gitleaks) | Auditing git repository for secrets and keys
* app-metrics/[do-agent](https://github.com/digitalocean/do-agent) | DigitalOcean Agent for Enhanced Droplet Graphs
* app-metrics/[nginx-amplify-agent](https://amplify.nginx.com) | System and NGINX metric collection
* app-misc/[android-file-transfer-linux](https://whoozle.github.io/android-file-transfer-linux/) | Reliable MTP client with minimalistic UI
* app-misc/[cointop](https://github.com/miguelmota/cointop) | Interactive cryptocurrency monitor
* app-misc/[jshon](http://kmkeen.com/jshon) | JSON parser designed for maximum convenience within the shell
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/pet.svg)](https://repology.org/metapackage/pet) app-misc/[pet](https://github.com/knqyf263/pet) | Simple command-line snippet manager
* app-misc/[rmlint](http://rmlint.rtfd.org) | Removes duplicates and other lint from your filesystem
* app-misc/[xsv](https://github.com/BurntSushi/xsv) | A fast CSV command line toolkit
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/peco.svg)](https://repology.org/metapackage/peco) app-shells/[peco](https://github.com/peco/peco) | Simplistic interactive filtering tool
* app-text/[keening](https://github.com/vehk/keening) | A simple command line pastebin designed to be used together with ssh
* dev-db/[odyssey](https://github.com/yandex/odyssey) | Scalable PostgreSQL connection pooler
* dev-db/[pg_page_verification](https://github.com/google/pg_page_verification) | Checksums verification on PostgreSQL data pages
* dev-db/[pg_profile](https://github.com/zubkov-andrei/pg_profile) | Postgres historic performance reports
* dev-db/[pgtune](https://github.com/andreif/pgtune) | A high-performance PostgreSQL tuning script
* dev-db/[pipelinedb](https://www.pipelinedb.com/) | High-performance time-series aggregation for PostgreSQL
* dev-libs/[libcommuni](http://communi.github.io/) | A cross-platform IRC framework written with Qt
* dev-libs/[libdigidoc](https://github.com/open-eid/libdigidoc) | DigiDoc digital signature library
* [![Gentoo Bug](https://img.shields.io/badge/Bug-482946-red.svg)](https://bugs.gentoo.org/482946) dev-libs/[loki](http://loki-lib.sourceforge.net/) | C++ library of common design patterns and idioms
* dev-lua/[lyaml](https://github.com/gvvaughan/lyaml) | LibYAML binding for Lua
* dev-haskell/[daemons](https://github.com/scvalex/daemons) | Daemons in Haskell made fun and easy
* dev-haskell/[ini](https://github.com/chrisdone/ini) | Quick and easy configuration files in the INI format
* dev-haskell/[scotty](https://github.com/scotty-web/scotty) | A Haskell web framework, using WAI and Warp
* dev-haskell/[tz](https://github.com/nilcons/haskell-tz) | Library for time zone conversions
* dev-haskell/[tzdata](https://github.com/nilcons/haskell-tzdata) | Distribution of the standard time zone database
* dev-haskell/[wai-cors](https://github.com/larskuhtz/wai-cors) | Cross-Origin resource sharing (CORS) for Wai
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
* dev-ml/[ocaml-magic](https://github.com/savonet/ocaml-magic) | OCaml bindings to libmagic
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
* dev-php/[scrypt]() | A PHP wrapper fo the scrypt hashing algorithm
* dev-python/[adal](https://pypi.python.org/pypi/adal/) | Library for authentication in Azure Active Directory
* dev-python/[anyconfig](https://github.com/ssato/python-anyconfig) | Generic access to configuration files in any formats
* dev-python/[applicationinsights](https://pypi.python.org/pypi/applicationinsights/) | Application Insights API surface
* dev-python/[aws-sam-translator](https://github.com/awslabs/serverless-application-model) | A library to transform SAM templates into AWS CloudFormation templates
* dev-python/[crayons](https://github.com/kennethreitz/crayons) | Text UI colors
* dev-python/[crossplane](https://github.com/nginxinc/crossplane) | Fast and reliable NGINX configuration parser
* dev-python/[datadiff](https://datadiff.sourceforge.net) | A library for diffs of python data structures
* dev-python/[delegator-py](https://github.com/kennethreitz/delegator.py) | Simple library for dealing with subprocesses
* dev-python/[dateparser](https://github.com/scrapinghub/dateparser) | Date parsing library designed to parse dates from HTML pages
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
* dev-python/[django-pipeline](https://github.com/jazzband/django-pipeline) | An asset packaging library for Django
* dev-python/[django-rest-framework](https://django-rest-framework.org/) | Django REST framework
* dev-python/[django-rest-framework-camel-case](https://github.com/vbabiy/djangorestframework-camel-case) | Camel case JSON support for Django REST framework
* dev-python/[django-rest-framework-recursive](https://github.com/heywbj/django-rest-framework-recursive) | Recursive Serialization for Django REST framework
* dev-python/[django-rest-swagger](https://marcgibbons.com/django-rest-swagger/) | Swagger UI for Django REST Framework
* dev-python/[django-tables2](https://github.com/jieter/django-tables2) | Django application for creating HTML tables
* dev-python/[django-taggit](https://github.com/alex/django-taggit) | Django application for simple tagging
* dev-python/[django-timezone-field](https://github.com/mfogel/django-timezone-field) | Django application for database and form fields for pytz objects
* dev-python/[drf-yasg](https://github.com/axnsan12/drf-yasg) | Yet another Swagger generator
* dev-python/[email-validator](https://github.com/JoshData/python-email-validator) | An email syntax and deliverability validation library
* dev-python/[factory_boy](https://github.com/FactoryBoy/factory_boy) | A fixtures replacement tool
* dev-python/[faker](https://github.com/joke2k/faker) | Python package that generates fake data
* dev-python/[flex](https://github.com/pipermerriam/flex) | Validation tooling for Swagger 2.0 specifications
* dev-python/[graphviz](https://github.com/xflr6/graphviz) | Simple Python interface for Graphviz
* dev-python/[itypes](https://github.com/tomchristie/itypes) | Simple immutable types for python
* dev-python/[livereload](https://github.com/lepture/python-livereload) | Python LiveReload is an awesome tool for web developers
* dev-python/[m9dicts](https://github.com/ssato/python-m9dicts) | A dict-like object supports recursive merge operation
* dev-python/[markdown2](https://github.com/trentm/python-markdown2) | A fast and complete Python implementation of Markdown
* dev-python/[mock-django](https://github.com/dcramer/mock-django) | A simple library for mocking certain Django behavior
* dev-python/[msrest](https://pypi.python.org/pypi/msrest/) | AutoRest swagger generator Python client runtime
* dev-python/[ncclient](https://github.com/ncclient/ncclient) | Python library for NETCONF clients
* dev-python/[polemarch-ansible](https://gitlab.com/vstconsulting/polemarch-ansible) | Wrapper for Ansible CLI
* dev-python/[port-for](https://github.com/kmike/port-for) | An utility and python library for TCP ports management
* dev-python/[pytimeparse](https://github.com/wroberts/pytimeparse) | A library to parse time from human readable string
* dev-python/[python-coreapi](https://github.com/core-api/python-client) | Python client library for Core API
* dev-python/[python-coreschema](https://github.com/core-api/python-coreschema) | Python CoreSchema
* dev-python/[python-openapi-codec](https://github.com/core-api/python-openapi-codec) | An OpenAPI codec for Core API
* dev-python/[python-user-agents](https://github.com/selwin/python-user-agents) | A library to identify devices by parsing user agent strings
* dev-python/[pywinrm](https://github.com/diyan/pywinrm) | Python library for Windows Remote Management
* dev-python/[PythonQt](http://pythonqt.sourceforge.net/) | A dynamic Python binding for the Qt framework
* dev-python/[requests-credssp](https://github.com/jborean93/requests-credssp) | CredSSP authentication handler for Python Requests
* dev-python/[rstr](http://bitbucket.org/leapfrogdevelopment/rstr) | Generate random strings in Python
* dev-python/[ruamel-ordereddict](https://bitbucket.org/ruamel/ordereddict) | An ordered dictionary with KIO/KVIO
* dev-python/[ruamel-std-pathlib](https://bitbucket.org/ruamel/std.pathlib) | Ruamel enhancements to pathlib and pathlib2
* dev-python/[ruamel-yaml](https://bitbucket.org/ruamel/yaml) | YAML parser/emitter that supports roundtrip comment preservation
* dev-python/[selectors2](https://github.com/SethMichaelLarson/selectors2) | Portable replacement to the standard library selectors module
* dev-python/[sphinx-autobuild](https://github.com/GaretJax/sphinx-autobuild) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-mermaid](https://github.com/mgaitan/sphinxcontrib-mermaid) | Mermaid diagrams in sphinx powered docs
* dev-python/[sphinxcontrib-openapi](https://github.com/ikalnytskyi/sphinxcontrib-openapi) | Sphinx extension to generate APIs docs from OpenAPI
* dev-python/[swagger_spec_validator](https://github.com/Yelp/swagger_spec_validator) | Python library that validates Swagger Specs
* dev-python/[tablib](http://python-tablib.org/) | A format-agnostic tabular dataset library written in Python
* dev-python/[testinfra](https://github.com/philpep/testinfra) | An unit tests in Python to test actual state of servers
* dev-python/[text-unidecode](https://github.com/kmike/text-unidecode) | The most basic Text::Unidecode port
* dev-python/[toml](https://github.com/uiri/toml) | Python Library for Tom's Obvious, Minimal Language
* dev-python/[ua-parser](https://datadiff.sourceforge.net/) | A library for diffs of python data structures
* dev-python/[whaaaaat](https://github.com/finklabs/whaaaaat) | A collection of common interactive command line user interfaces
* dev-python/[ukpostcodeparser](https://github.com/hamstah/ukpostcodeparser) | UK postcode parser library
* dev-python/[validate_email](https://github.com/syrusakbary/validate_email) | Python email validation library
* dev-util/[ansible-lint](https://github.com/willthames/ansible-lint) | Best practices checker for Ansible
* dev-util/[ansible-molecule](https://github.com/metacloud/ansible-molecule) | Automated testing for Ansible roles
* dev-util/[cfn-python-lint](https://github.com/awslabs/cfn-python-lint) | AWS CloudFormation Linter
* dev-util/[fossa-cli](https://github.com/fossas/fossa-cli) | License and vulnerability analysis
* dev-util/[gitlab-runner](https://gitlab.com/gitlab-org/gitlab-runner) | The official GitLab CI runner
* dev-vcs/[commitizen](https://github.com/Woile/commitizen) | Python commitizen client tool
* dev-vcs/[gitlint](https://github.com/jorisroovers/gitlint) | Git commit message linter
* dev-vcs/[mercurial-extension_utils](https://bitbucket.org/Mekk/mercurial-extension_utils) | Mercurial Extension Utils
* dev-vcs/[mercurial-keyring](https://bitbucket.org/Mekk/mercurial_keyring) | Mercurial Keyring Extension
* media-gfx/[butteraugli](https://github.com/google/butteraugli) | A tool for measuring perceived differences between images
* media-gfx/[screencloud](https://screencloud.net/) | Screenshot capturing and sharing tool over various services
* media-libs/[shine](https://github.com/toots/shine) | Fixed-point mp3 encoding library
* media-radio/[krudio](https://github.com/loast/krudio) | Radio tray for linux on QT
* media-radio/[liquidsoap](http://liquidsoap.fm/) | A swiss-army knife for multimedia streaming, used for netradios and webtvs
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/goaccess.svg)](https://repology.org/metapackage/goaccess) net-analyzer/[goaccess](https://goaccess.io) | A real-time web log analyzer and interactive viewer that runs in a terminal
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
* net-im/[gitter-bin](http://www.gitter.im/) | Chat and network platform
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/slack.svg)](https://repology.org/metapackage/slack) net-im/[slack-bin](http://www.slack.com/) | Team collaboration tool
* net-im/[viber-bin](http://www.viber.com/) | Free text and calls
* net-im/[vk-messenger-bin](https://vk.com/messenger) | Simple and Easy App for Messaging on VK
* net-misc/[comcast](https://github.com/tylertreat/Comcast) | Network problems simulator
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/dhcdrop.svg)](https://repology.org/metapackage/dhcdrop) net-misc/[dhcdrop](http://www.netpatch.ru/dhcdrop.html) | Effectively suppresses illegal DHCP servers on the LAN
* [![Gentoo Bug](https://img.shields.io/badge/Bug-536148-red.svg)](https://bugs.gentoo.org/536148) net-misc/[fiche](https://github.com/solusipse/fiche) | Command line pastebin server
* net-misc/[mcproxy](https://mcproxy.realmv6.org/) | IGMP/MLD Proxy daemon
* net-misc/[ngrok-bin](https://ngrok.com/) | Secure introspected tunnels to localhost
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/pingu.svg)](https://repology.org/metapackage/pingu) net-misc/[pingu](https://github.com/ncopa/pingu) | Policy routing daemon with failover and load-balancing
* net-misc/[qfreerdp](https://github.com/zrax/qfreerdp) | Qt launcher GUI for XFreeRDP
* net-misc/[qia](http://stg.codes/) | Authorization tool for Stargazer Billing System written in Qt
* net-misc/[redir](https://github.com/troglobit/redir) | TCP port redirector
* net-misc/[rstatd](http://rstatd.sourceforge.net/) | Client-server linux performance statistics
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/samplicator.svg)](https://repology.org/metapackage/samplicator) net-misc/[samplicator](https://github.com/sleinen/samplicator) | UDP packets forwarder and duplicator
* net-misc/[slowhttptest](https://github.com/shekyan/slowhttptest) | Application Layer DoS attack simulator
* net-misc/[spoofer](https://spoofer.caida.org) | A tool to assess of deployment of source address validation
* net-misc/[ssmd](http://stg.codes/projects/ssmd) | SNMP Switch Management Daemon
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/stargazer.svg)](https://repology.org/metapackage/stargazer) net-misc/[stargazer](http://stg.net.ua/) | Billing system for small home and office networks
* net-misc/[topola](https://topola.unity.net) | Customer accounting system, services and statistics collection management
* net-misc/[uredir](https://github.com/troglobit/uredir) | UDP port redirector
* net-misc/[virtualhere-usb-bin](https://virtualhere.com/) | Share USB devices over the network
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/automatic.svg)](https://repology.org/metapackage/automatic) net-p2p/[automatic](https://github.com/1100101/Automatic) | RSS downloader for Tranmission
* net-p2p/[tremotesf](https://github.com/equeim/tremotesf2) | A remote GUI for transmission
* [![Gentoo Bug](https://img.shields.io/badge/Bug-214969-red.svg)](https://bugs.gentoo.org/214969) net-p2p/[opentracker](https://github.com/flygoast/opentracker) | High-performance bittorrent tracker
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/resilio-sync.svg)](https://repology.org/metapackage/resilio-sync) net-p2p/[resilio-sync](https://resilio.com/) | Resilient, fast and scalable file synchronization tool
* [![Gentoo Bug](https://img.shields.io/badge/Bug-498844-red.svg)](https://bugs.gentoo.org/498844) net-vpn/[softether](http://www.softether.org/) | Multi-protocol VPN software
* net-wireless/[unifi](https://unifi-sdn.ubnt.com/) | Management Controller for Ubiquiti Networks UniFi APs
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/ethq.svg)](https://repology.org/metapackage/ethq) sys-apps/[ethq](https://github.com/isc-projects/ethq) | Ethernet NIC Queue stats viewer
* sys-apps/[firetools](https://firejail.wordpress.com/) | Graphical user interface of Firajail security sandbox
* sys-fs/[adhocify](https://github.com/quitesimpleorg/adhocify) | Tool which monitors for inotify events and executes script
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/powerstat.svg)](https://repology.org/metapackage/powerstat) sys-power/[powerstat](https://launchpad.net/ubuntu/+source/powerstat) | Laptop power measuring tool
* www-apps/[draw-io](https://github.com/jgraph/drawio) | Online diagramming web application
* www-apps/[LookingGlass](https://github.com/ramnode/LookingGlass) | A Python-backed Looking Glass
* www-apps/[netbox](https://github.com/digitalocean/netbox) | IP address management (IPAM) and data center infrastructure management (DCIM)
* www-apps/[noc-tower](https://code.getnoc.com/noc/tower/) | NOCProject supervisor
* www-apps/[webui-aria2](https://github.com/ziahamza/webui-aria2) | The worlds best and hottest interface to interact with aria2
* www-plugins/[chrome-token-signing](https://github.com/open-eid/chrome-token-signing) | Native client and extension for signing with your eID on the web
* www-servers/[gitlab-gitaly](https://gitlab.com/gitlab-org/gitaly) | Gitaly is a Git RPC service for handling GitLab git calls
* www-servers/[gitlab-workhorse](https://gitlab.com/gitlab-org/gitlab-workhorse) | GitLab reverse proxy
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/libinput-gestures.svg)](https://repology.org/metapackage/libinput-gestures) x11-misc/[libinput-gestures](https://github.com/bulletmark/libinput-gestures) | Actions gestures on your touchpad using libinput
* x11-misc/[logkeys](https://github.com/kernc/logkeys) | A Linux keylogger
