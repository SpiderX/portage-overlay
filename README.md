# nest overlay

[![Number of ebuilds: 129](https://img.shields.io/badge/ebuild-129-orange.svg)](https://img.shields.io/badge/ebuild-129-orange.svg)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)
[![Build Status](https://travis-ci.org/SpiderX/portage-overlay.svg?branch=master)](https://travis-ci.org/SpiderX/portage-overlay)

### References

+ [Overlay with metadata](https://github.com/gentoo-mirror/nest)
+ [QA Report](https://qa-reports.gentoo.org/output/repos/nest.html)
+ [Gentoo Repo QA Check](http://gentoo.github.io/repo-qa-check-results/nest.html)
+ [Ebuild Upstream Scanner](http://euscan.gentooexperimental.org/maintainers/spiderx@spiderx.dp.ua/)
+ [Levelnine checks](https://gentoo.levelnine.at/full-sort-by-maintainer/spiderx_at_spiderx.dp.ua.txt)

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

```
[nest]
location = /usr/local/portage/nest
sync-type = git
sync-uri = https://github.com/spiderx/portage-overlay.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.

## List of Ebuilds

This overlay consists of an [Gentoo Portage](http://www.gentoo.org/) ebuilds for projects:

* [![Gentoo Bug](https://img.shields.io/badge/Bug-452916-red.svg)](https://bugs.gentoo.org/452916) [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/stargazer.svg)](https://repology.org/metapackage/stargazer) net-misc/[stargazer](http://stg.codes/) | Billing system for small home and office networks
* [![Gentoo Bug](https://img.shields.io/badge/Bug-459310-red.svg)](https://bugs.gentoo.org/459310) [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/samplicator.svg)](https://repology.org/metapackage/samplicator) net-misc/[samplicator](https://github.com/sleinen/samplicator) | UDP packets forwarder and duplicator
* [ssmd](https://gitorious.org/ssmd/)
* [![Gentoo Bug](https://img.shields.io/badge/Bug-214969-red.svg)](https://bugs.gentoo.org/214969) net-p2p/[opentracker](http://erdgeist.org/arts/software/opentracker) with [flygoast](https://github.com/flygoast/opentracker)'s patches | High-performance bittorrent tracker
* [loki-lib](http://loki-lib.sourceforge.net/) ([482946](https://bugs.gentoo.org/show_bug.cgi?id=482946))
* [![Gentoo package](https://repology.org/badge/version-only-for-repo/gentoo/dhcdrop.svg)](https://repology.org/metapackage/dhcdrop) net-misc/[dhcdrop](http://www.netpatch.ru/dhcdrop.html) ([281994](https://bugs.gentoo.org/show_bug.cgi?id=281994))
* [nuttcp](nuttcp.net/) ([486788](https://bugs.gentoo.org/show_bug.cgi?id=486788))
* [ipt_netflow](http://sourceforge.net/projects/ipt-netflow/)
* [softether](http://www.softether.org/) ([498844](https://bugs.gentoo.org/show_bug.cgi?id=498844))
* [sysdig](http://www.sysdig.org/) ([510718](https://bugs.gentoo.org/show_bug.cgi?id=510718))
* [netgauge](http://www.ookla.com/netgauge)
* [fiche](https://github.com/solusipse/fiche) ([536148](https://bugs.gentoo.org/show_bug.cgi?id=536148))
* [peervpn](http://www.peervpn.net/) ([531468](https://bugs.gentoo.org/show_bug.cgi?id=531468))
* [goaccess](http://goaccess.io/) ([530112](https://bugs.gentoo.org/show_bug.cgi?id=530112))
* [comcast](https://github.com/tylertreat/Comcast)
* [gitlab-git-http-server](https://gitlab.com/gitlab-org/gitlab-git-http-server)
* [zbackup](http://zbackup.org/) ([576796](https://bugs.gentoo.org/show_bug.cgi?id=576796))
* [slack](http://slack.com/) ([575786](https://bugs.gentoo.org/show_bug.cgi?id=575786))
