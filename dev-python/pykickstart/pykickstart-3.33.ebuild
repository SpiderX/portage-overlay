# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="Python library for reading and writing kickstart files"
HOMEPAGE="https://github.com/pykickstart/pykickstart"
SRC_URI="https://github.com/pykickstart/${PN}/archive/r${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vim-syntax"

RDEPEND="dev-python/polib[${PYTHON_USEDEP}]
	dev-python/requests[${PYTHON_USEDEP}]
	vim-syntax? ( || ( app-editors/vim app-editors/gvim ) )"

S="${WORKDIR}/${PN}-r${PV}"

distutils_enable_tests nose

python_test() {
	PYTHONPATH=. NOSE_IGNORE_CONFIG_FILES=y "${EPYTHON}" -m nose \
		-s -v -I __init__.py -I baseclass.py --processes=-1 \
		--process-timeout=60 tests/post.py tests/handlers.py \
		tests/baseclass.py tests/pre.py tests/packages.py \
		tests/include.py tests/preprocess.py tests/newsection.py \
		tests/errors.py tests/attrs.py tests/base.py \
		tests/command_usage.py tests/__init__.py tests/script.py \
		tests/pre-install.py tests/seen.py tests/load.py tests/version.py \
		tests/misc.py tests/options.py tests/commands/keyboard.py \
		tests/commands/clearpart.py tests/commands/__init__.py \
		tests/commands/cdrom.py tests/commands/partition.py \
		tests/commands/services.py tests/commands/multipath.py \
		tests/commands/skipx.py tests/commands/sshkey.py \
		tests/commands/harddrive.py tests/commands/langsupport.py \
		tests/commands/authconfig.py tests/commands/snapshot.py \
		tests/commands/bootloader.py tests/commands/dmraid.py \
		tests/commands/nfs.py tests/commands/ostreesetup.py \
		tests/commands/firstboot.py tests/commands/selinux.py \
		tests/commands/iscsi.py tests/commands/user.py \
		tests/commands/authselect.py tests/commands/rhsm.py \
		tests/commands/mouse.py tests/commands/method.py \
		tests/commands/ignoredisk.py tests/commands/zfcp.py \
		tests/commands/liveimg.py tests/commands/fcoe.py \
		tests/commands/nvdimm.py tests/commands/interactive.py \
		tests/commands/driverdisk.py tests/commands/realm.py \
		tests/commands/deviceprobe.py tests/commands/install.py \
		tests/commands/reqpart.py tests/commands/upgrade.py \
		tests/commands/device.py tests/commands/rescue.py \
		tests/commands/repo.py tests/commands/module.py \
		tests/commands/autostep.py tests/commands/eula.py \
		tests/commands/logvol.py tests/commands/iscsiname.py \
		tests/commands/updates.py tests/commands/raid.py \
		tests/commands/mediacheck.py tests/commands/volgroup.py \
		tests/commands/vnc.py tests/commands/network.py \
		tests/commands/btrfs.py tests/commands/displaymode.py \
		tests/commands/sshpw.py tests/commands/lilocheck.py \
		tests/commands/group.py tests/commands/zipl.py \
		tests/commands/hmc.py tests/commands/rootpw.py \
		tests/commands/autopart.py \
		tests/commands/unsupported_hardware.py \
		tests/commands/timezone.py tests/commands/reboot.py \
		tests/commands/syspurpose.py tests/commands/lang.py \
		tests/commands/logging.py tests/commands/url.py \
		tests/commands/xconfig.py tests/commands/firewall.py \
		tests/commands/key.py tests/commands/monitor.py \
		tests/commands/zerombr.py tests/commands/mount.py \
		tests/tools/utils.py tests/tools/ksvalidator.py \
		tests/tools/__init__.py
}

src_install() {
	distutils-r1_src_install

	if use vim-syntax ; then
		insinto /usr/share/vim/vimfiles
		doins data/kickstart.vim
	fi
}
