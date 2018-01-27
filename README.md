# nest overlay

[![ebuilds 124](https://img.shields.io/badge/ebuild-124-orange.svg)](https://img.shields.io/badge/ebuild-124-orange.svg)
[![GitHub repo size in bytes](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)](https://img.shields.io/github/repo-size/SpiderX/portage-overlay.svg)

# How to use this overlay

[Local overlays](https://wiki.gentoo.org/wiki/Overlay/Local_overlay) should be managed via `/etc/portage/repos.conf/`.
To enable this overlay make sure you are using a recent Portage version (at least `2.2.14`), and crate an `/etc/portage/repos.conf/nest.conf` file containing precisely:

```
[nest]
location = /usr/local/portage/nest
sync-type = git
sync-uri = https://github.com/spiderx/portage-overlay.git
priority=9999
```

Afterwards, simply run `emerge --sync`, and Portage should seamlessly make all our ebuilds available.

# With layman

Add `https://raw.github.com/spiderx/portage-overlay/master/overlay.xml` to overlays section in `/etc/layman/layman.cfg`.

Or read the instructions on the [Gentoo Wiki](http://wiki.gentoo.org/wiki/Layman#Adding_custom_overlays), then invoke the following:

    layman -f -a nest

This overlay consists of an [Gentoo Portage](http://www.gentoo.org/) ebuilds for projects:

* [stargazer](http://stg.dp.ua/) ([452916](https://bugs.gentoo.org/show_bug.cgi?id=452916))
* [samplicator](http://samplicator.googlecode.com/) ([459310](https://bugs.gentoo.org/show_bug.cgi?id=459310))
* [ssmd](https://gitorious.org/ssmd/)
* [opentracker](http://erdgeist.org/arts/software/opentracker/) with [flygoast](https://github.com/flygoast/opentracker)'s patches ([214969](https://bugs.gentoo.org/show_bug.cgi?id=214969))
* [loki-lib](http://loki-lib.sourceforge.net/) ([482946](https://bugs.gentoo.org/show_bug.cgi?id=482946))
* [dhcdrop](http://www.netpatch.ru/dhcdrop.html) ([281994](https://bugs.gentoo.org/show_bug.cgi?id=281994))
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
