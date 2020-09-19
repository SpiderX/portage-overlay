# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit pax-utils readme.gentoo-r1 rpm systemd tmpfiles

DESCRIPTION="RIPE Atlas Software Probe"
HOMEPAGE="https://github.com/RIPE-NCC/ripe-atlas-software-probe"
SRC_URI="https://ftp.ripe.net/ripe/atlas/software-probe/centos8/x86_64/atlasswprobe-${PV}-1.el8.x86_64.rpm"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ipv6"
RESTRICT="bindist mirror"

RDEPEND="acct-user/ripe-atlas
	dev-libs/libevent:0="

QA_PREBUILT="/opt/ripe-atlas/bb-13.3/bin/busybox"

S="${WORKDIR}"

DOC_CONTENTS="After launch probe go to:\\n
https://atlas.ripe.net/apply/swprobe\\n
and register probe using SSH public key from:\\n
/var/lib/ripe-atlas/etc/probe_key.pub\\n"

src_prepare() {
	default

	# Change paths to atlas dir
	sed -i '/RPM_BASE_DIR/s|usr/local/atlas|opt/ripe-atlas|' \
		usr/local/atlas/bin/arch/centos-sw-probe/centos-sw-probe-common.sh \
		|| die "sed failed for centos-sw-probe-common.sh"
	sed -i '/{BASE_DIR:=/s|home/atlas|/var/lib/ripe-atlas|' \
		usr/local/atlas/bin/common-pre.sh \
		|| die "sed failed for common-pre.sh"
	# Chanage user
	sed -i '/chown -R /s|atlas|ripe-atlas|g' \
		usr/local/atlas/bin/arch/centos-sw-probe/centos-sw-probe-ATLAS.sh \
		|| die "sed failed for centos-sw-probe-ATLAS.sh"
	# Use full path for config
	sed -i 's|bin/config.sh|/var/lib/ripe-atlas/bin/config.sh|' \
		usr/local/atlas/bin/ATLAS || die "sed failed for ATLAS"
	# Disable IPv6 hosts
	if ! use ipv6 ; then
		sed -i  -e '/REG_3_HOST/s/2001:67c:2e8:11::c100:13f6/reg03.atlas.ripe.net/' \
			-e '/REG_6_HOST/s/2001:67c:2e8:11::c100:13f7/reg04.atlas.ripe.net/' \
			usr/local/atlas/etc/reg_servers.sh.prod || die "sed failed for reg_servers.sh.prod"
	fi
	# Remove bundled libs
	rm -rf usr/local/atlas/lib || die "rm failed"
}

src_install() {
	# Create needed directories
	keepdir /var/lib/ripe-atlas/{bin,state} /opt/ripe-atlas
	# https://github.com/RIPE-NCC/ripe-atlas-software-probe/issues/23
	cp -a usr/local/atlas/. "${ED}"/opt/ripe-atlas/ || die "cp failed"

	# Create config
	echo 'DEVICE_NAME="centos-sw-probe"
ATLAS_BASE="/var/lib/ripe-atlas"
ATLAS_STATIC="/opt/ripe-atlas"
SUB_ARCH="centos-rpm-atlasswprobe-5020-centos-7"' > \
		"${ED}"/var/lib/ripe-atlas/bin/config.sh || die "echo failed for config.sh"
	# Set runnning mode
	echo prod > "${ED}"/var/lib/ripe-atlas/state/mode || die "echo failed for mode"

	readme.gentoo_create_doc
	pax-mark m "${ED}"/opt/ripe-atlas/bb-13.3/bin/busybox

	newtmpfiles "${FILESDIR}"/ripe-atlas-probe.tmpfile ripe-atlas-probe.conf
	newinitd "${FILESDIR}"/ripe-atlas-probe.initd ripe-atlas-probe
	systemd_dounit "${FILESDIR}"/ripe-atlas-probe.service
}

pkg_postinst() {
	tmpfiles_process ripe-atlas-probe.conf
	readme.gentoo_print_elog
}
