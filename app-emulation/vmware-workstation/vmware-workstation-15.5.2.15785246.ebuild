# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..8} )

inherit desktop pam python-any-r1 readme.gentoo-r1 systemd xdg-utils

PV_BUILD=$(ver_cut 4)
MY_PN="VMware-Workstation-Full"
MY_PV=$(ver_cut 1-3)
MY_P="${MY_PN}-${MY_PV}-${PV_BUILD}"

VMWARE_FUSION_VER="11.5.3/15870345"
SYSTEMD_UNITS_TAG="gentoo-02"
UNLOCKER_VERSION="3.0.3"

DESCRIPTION="Emulate a complete PC without the performance overhead"
HOMEPAGE="http://www.vmware.com/products/workstation"
SRC_URI="https://download3.vmware.com/software/wkst/file/${MY_P}.x86_64.bundle
	macos-guests? ( https://github.com/paolo-projects/unlocker/archive/${UNLOCKER_VERSION}.tar.gz -> unlocker-${UNLOCKER_VERSION}.tar.gz
			https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/${VMWARE_FUSION_VER}/core/com.vmware.fusion.zip.tar -> com.vmware.fusion-${PV}.zip.tar )
	systemd? ( https://github.com/akhuettel/systemd-vmware/archive/${SYSTEMD_UNITS_TAG}.tar.gz -> vmware-systemd-${SYSTEMD_UNITS_TAG}.tgz )"

LICENSE="GPL-2 GPL-3 MIT-with-advertising vmware"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cups macos-guests +modules ovftool systemd vix"
IUSE_VMWARE_GUESTS="darwin linux linuxPreGlibc25 netware solaris windows winPre2k winPreVista"
for guest in ${IUSE_VMWARE_GUESTS}; do
	IUSE+=" vmware-tools-${guest}"
done
REQUIRED_USE="vmware-tools-darwin? ( macos-guests )"
RESTRICT="mirror preserve-libs strip"

CDEPEND="dev-db/sqlite:3"
RDEPEND="!gnome-base/dconf
	app-arch/bzip2:=
	app-shells/bash:0
	dev-cpp/gtkmm:3.0
	dev-libs/dbus-glib
	dev-libs/gmp:0
	dev-libs/icu:=
	dev-libs/json-c:=
	dev-libs/nettle:0
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/libart_lgpl
	media-libs/libcanberra
	media-libs/libvorbis
	media-libs/mesa
	media-plugins/alsa-plugins[speex]
	net-dns/libidn:=
	net-libs/gnutls:=
	sys-apps/tcp-wrappers
	sys-apps/util-linux
	x11-libs/libXxf86vm
	sys-fs/fuse:3
	x11-libs/libdrm
	x11-libs/libxshmfence
	x11-libs/startup-notification
	x11-libs/xcb-util
	x11-themes/hicolor-icon-theme
	!app-emulation/vmware-player
	!app-emulation/vmware-tools
	cups? ( net-print/cups )
	modules? ( >=app-emulation/vmware-modules-${MY_PV} )
	ovftool? ( !dev-util/ovftool )
	${CDEPEND}"
DEPEND="${PYTHON_DEPS}"
BDEPEND="${CDEPEND}
	app-arch/unzip
	sys-apps/fix-gnustack
	sys-libs/ncurses-compat:5
	ovftool? ( app-admin/chrpath )"

S="${WORKDIR}"/extracted

src_unpack() {
	for AFILE in ${A}; do
		if [ "${AFILE##*.}" == "bundle" ]; then
			cp "${DISTDIR}/${AFILE}" "${WORKDIR}"
		else
			unpack "${AFILE}"
		fi
	done

	sh "${MY_P}".x86_64.bundle --console --required --eulas-agreed -x extracted \
		|| die "bundle extract failed"

	if ! use vix; then
		rm -r extracted/vmware-vix-core extracted/vmware-vix-lib-Workstation* \
			|| die "removing vix failed"
	fi

	if use vmware-tools-darwin ; then
		unzip -j -d extracted/vmware-tools-darwin/ com.vmware.fusion.zip \
			"payload/VMware Fusion.app/Contents/Library/isoimages/darwin.iso" \
			|| die "unzip for darwin.iso failed"
	fi
}

src_prepare() {
	default

	# 459566
	mkdir vmware-network-editor/lib/lib \
		|| die "mkdir for /opt/vmware/bin/vmware failed"
	mv vmware-network-editor/lib/libvmware-netcfg.so \
		vmware-network-editor/lib/lib/ \
		|| die "moving libvmware-netcfg.so failed"

	rm -f vmware-workstation-server/bin/{openssl,configure-hostd.sh} \
		|| die "removing vmware-workstation-server/bin failed"

	rm -f vmware-installer/bin/configure-initscript.sh \
		|| die "removing configure-initscript.sh failed"

	if use ovftool ; then
		chrpath -d vmware-ovftool/libcurl.so.4 || die "chrpath failed"
	fi

	if use macos-guests ; then
		sed -i  -e "s#vmx_path = '/usr#vmx_path = '${ED}/opt/vmware#" \
			-e "s#os.path.isfile('/usr#os.path.isfile('${ED}/opt/vmware#" \
			-e "s#vmwarebase = '/usr#vmwarebase = '${ED}/opt/vmware#" \
			"${WORKDIR}"/unlocker-"${UNLOCKER_VERSION}"/unlocker.py
	fi

	DOC_CONTENTS="/etc/env.d is updated during ${PN} installation. Please run:\\n
'env-update && source /etc/profile'\\n
Before you can use ${PN}, you must configure a default network setup.
You can do this by running 'emerge --config ${PN}'.\\n
To be able to run ${PN} your user must be in the vmware group.\\n"
}

src_install() {
	local vmware_installer_version
	vmware_installer_version=$(grep -oPm1 "(?<=<version>)[^<]+" vmware-installer/manifest.xml)

	# Install revdep-rebuild entry
	insinto /etc/revdep-rebuild
	echo 'SEARCH_DIRS_MASK="/opt/vmware"' > "${T}"/10vmware-workstation
	doins "${T}"/10vmware-workstation

	# Install the binaries
	into /opt/vmware
	dobin vmware-vmx/bin/vmnet-{bridge,dhcpd,natd,netifup,sniffer} \
		vmware-vmx/bin/vmware-{collect-host-support-info,gksu,modconfig,networks,ping} \
		vmware-workstation/bin/{vmss2core,vmware,vmware-tray,vmware-vdiskmanager} \
		vmware-vprobe/bin/vmware-vprobe \
		vmware-workstation-server/vmware-hostd \
		vmware-player-app/bin/vmware-license-{check,enter}.sh \
		vmware-usbarbitrator/bin/vmware-usbarbitrator
	dosbin vmware-vmx/sbin/{vmware-authd,vmware-authdlauncher}

	# Install the libraries
	insinto /opt/vmware/lib/vmware
	doins -r vmware-network-editor/lib/. \
		vmware-player-app/lib/. \
		vmware-vmx/lib/. \
		vmware-vprobe/lib/. \
		vmware-workstation/lib/. \
		vmware-workstation-server/lib/. \
		vmware-vmx/roms
	rm -rf "${ED}"/opt/vmware/lib/vmware/lib{nfc-types,soclient,vim-types}.so \
		"${ED}"/opt/vmware/lib/vmware/libvm{acore,omi,ware-hostd,ware-wssc-adminTool}.so \
		"${ED}"/opt/vmware/lib/vmware/diskLibWrapper.so \
		|| die "removing libraries failed"

	# Install the installer
	insinto /opt/vmware/lib/vmware-installer/"${vmware_installer_version}"
	doins -r vmware-installer/{cdsHelper,vmis,vmis-launcher,vmware-cds-helper,vmware-installer,vmware-installer.py}
	fperms 0755 /opt/vmware/lib/vmware-installer/"${vmware_installer_version}"/{vmis-launcher,cdsHelper,vmware-installer}
	dosym ../lib/vmware-installer/"${vmware_installer_version}"/vmware-installer /opt/vmware/bin/vmware-installer
	insinto /etc/vmware-installer
	doins vmware-installer/bootstrap
	sed -i  -e "s/@@VERSION@@/${vmware_installer_version}/" \
		-e "s,@@VMWARE_INSTALLER@@,/opt/vmware/lib/vmware-installer/${vmware_installer_version}," \
		"${ED}"/etc/vmware-installer/bootstrap || die "sed for vmware-installer/bootstrap failed"

	# Install vmware-workstation ancillaries
	insinto /usr/share/metainfo
	doins vmware-workstation/share/appdata/vmware-workstation.appdata.xml
	domenu vmware-workstation/share/applications/vmware-workstation.desktop
	for size in 16x16 22x22 24x24 32x32 48x48 256x256 ; do
		doicon -s "${size}" vmware-workstation/share/icons/hicolor/"${size}"/apps/vmware-workstation.png
	done
	dosym ../icons/hicolor/256x256/apps/vmware-workstation.png \
		/usr/share/pixmaps/vmware-workstation.png

	# Install vmware-player ancillaries
	insinto /usr/share/metainfo
	doins vmware-player-app/share/appdata/vmware-player.appdata.xml
	domenu vmware-player-app/share/applications/vmware-player.desktop
	for size in 16x16 22x22 24x24 32x32 48x48 256x256 ; do
		doicon -s "${size}" vmware-player-app/share/icons/hicolor/"${size}"/apps/vmware-player.png
		if [ "${size}" == "16x16" ] || [ "$size" == "32x32" ] ; then
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-certificate.png
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{easter-egg,team}.png
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vm-legacy,vm}.png
		fi
		if [ "${size}" == "22x22" ] || [ "$size" == "24x24" ] ; then
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-certificate.png
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vm}.png
		fi
		if [ "${size}" == "48x48" ] ; then
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{easter-egg,snapshot,team}.png
			doicon -s "${size}" -c mimetypes vmware-player-app/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vmdisk,vmfoundry,vm-legacy,vm}.png
		fi
	done
	doicon -s scalable -c mimetypes vmware-player-app/share/icons/hicolor/scalable/mimetypes/application-certificate.svg
	doicon -s scalable -c mimetypes vmware-player-app/share/icons/hicolor/scalable/mimetypes/application-x-vmware-{easter-egg,snapshot,team}.svg
	doicon -s scalable -c mimetypes vmware-player-app/share/icons/hicolor/scalable/mimetypes/application-x-vmware-{vm-clone,vmfoundry,vm-legacy,vm}.svg
	dosym ../icons/hicolor/256x256/apps/vmware-player.png \
		/usr/share/pixmaps/vmware-player.png
	insinto usr/share/mime/packages
	doins vmware-player-app/share/mime/packages/vmware-player.xml

	# Install vmware-network-editor ancillaries
	domenu vmware-network-editor-ui/share/applications/vmware-netcfg.desktop
	for size in 16x16 22x22 24x24 32x32 48x48 256x256 ; do
		doicon -s "${size}" vmware-network-editor-ui/share/icons/hicolor/"${size}"/apps/vmware-netcfg.png
	done
	dosym ../icons/hicolor/256x256/apps/vmware-netcfg.png \
		/usr/share/pixmaps/vmware-netcfg.png

	if use cups ; then
		exeinto "$(cups-config --serverbin)"/filter
		doexe vmware-player-app/extras/thnucups

		insinto /etc/cups
		doins vmware-player-app/etc/cups/thnuclnt.{convs,types}
	fi

	exeinto /opt/vmware/lib/vmware/setup
	doexe vmware-player-setup/vmware-config

	# Install pam
	pamd_mimic_system vmware-authd auth account

	# Install fuse
	insinto /etc/modprobe.d
	newins vmware-vmx/etc/modprobe.d/modprobe-vmware-fuse.conf vmware-fuse.conf

	# Install vmware-workstation-server
	cd vmware-workstation-server \
		|| die "cd to vmware-workstation-server failed"

	# Replace server startup script
	into /opt/vmware/lib/vmware
	dobin "${FILESDIR}"/configure-hostd.sh

	# Install libraries
	insinto /opt/vmware/lib/vmware/lib
	doins -r lib/.

	into /opt/vmware
	for tool in vmware-hostd wssc-adminTool ; do
		cat > "${T}/${tool}" <<-EOF
			#!/usr/bin/env bash
			set -e

			. /etc/vmware/bootstrap

			exec /opt/vmware/lib/vmware/bin/"${tool}" \\
				"\$@"
		EOF
		dobin "${T}/${tool}"
	done

	insinto /opt/vmware/lib/vmware
	doins -r hostd

	# Create the configuration
	insinto /etc/vmware
	doins -r config/etc/vmware/.
	doins -r etc/vmware/.

	keepdir "/var/lib/vmware/Shared VMs" /var/log/vmware

	cd - >/dev/null || die "cd from vmware-workstation-server failed"

	# Install vmware-vix
	if use vix ; then
		into /opt/vmware
		dobin vmware-vix-core/bin/vmrun

		# Install libraries
		insinto /opt/vmware/lib/vmware-vix
		doins -r vmware-vix-core/lib/.
		doins -r vmware-vix-lib-Workstation1500/lib/.
		dosym vmware-vix/libvixAllProducts.so /opt/vmware/lib/libbvixAllProducts.so

		# Install headers
		insinto /usr/include/vmware-vix
		doins vmware-vix-core/include/{vix,vm_basic_types}.h
	fi

	# Install ovftool
	if use ovftool ; then
		cd "${S}"/vmware-ovftool || die "cd to vmware-ovftool failed"

		insinto /opt/vmware/lib/vmware-ovftool
		doins -r .

		chmod 0755 "${ED}"/opt/vmware/lib/vmware-ovftool/{ovftool,ovftool.bin}
		dosym ../lib/vmware-ovftool/ovftool /opt/vmware/bin/ovftool

		cd - >/dev/null || die "cd from vmware-ovftool failed"
	fi

	# Create symlinks for the various tools
	local tool
	for tool in thnuclnt vmware vmplayer{,-daemon} licenseTool vmamqpd \
			vmware-{app-control,enter-serial,gksu,fuseUI,hostd,modconfig{,-console},netcfg,setup-helper,tray,unity-helper,vim-cmd,vmblock-fuse,vprobe,wssc-adminTool,zenity} ; do
		dosym appLoader /opt/vmware/lib/vmware/bin/"${tool}"
	done
	dosym ../lib/vmware/bin/vmplayer /opt/vmware/bin/vmplayer
	dosym ../lib/vmware/bin/vmware /opt/vmware/bin/vmware
	dosym ../lib/vmware/bin/vmware-fuseUI /opt/vmware/bin/vmware-fuseUI
	dosym ../lib/vmware/bin/vmware-netcfg /opt/vmware/bin/vmware-netcfg
	dosym ../../opt/vmware/lib/vmware/icu /etc/vmware/icu

	# Fix permissions
	fperms 0755 /opt/vmware/lib/vmware/bin/{appLoader,fusermount,mkisofs,vmware-remotemks}
	fperms 0755 /opt/vmware/lib/vmware/setup/vmware-config
	fperms 4711 /opt/vmware/lib/vmware/bin/vmware-vmx{,-debug,-stats}
	fperms 0755 /opt/vmware/lib/vmware/lib/libvmware-gksu.so/gksu-run-helper
	fperms 4711 /opt/vmware/sbin/vmware-authd
	fperms 0755 /opt/vmware/bin/{vmware-hostd,wssc-adminTool}
	fperms 1777 "/var/lib/vmware/Shared VMs"
	use vix && fperms 0755 /opt/vmware/lib/vmware-vix/setup/vmware-config

	fix-gnustack -f "${ED}"/opt/vmware/lib/vmware/lib/libvmware-gksu.so/libvmware-gksu.so > /dev/null \
		|| die "removing execstack flag failed"

	# Create environment
	local envd
	envd="${T}"/90vmware
	cat > "${envd}" <<-EOF
		PATH="/opt/vmware/bin"
		ROOTPATH="/opt/vmware/bin"
		CONFIG_PROTECT_MASK="/etc/vmware-installer"
		VMWARE_USE_SHIPPED_LIBS=1
	EOF
	doenvd "${envd}"

	# Create the configuration directory
	dodir /etc/vmware

	# Set bootstrap configuration
	cat > "${ED}"/etc/vmware/bootstrap <<-EOF
		BINDIR='/opt/vmware/bin'
		LIBDIR='/opt/vmware/lib'
	EOF

	# Set configuration
	cat > "${ED}"/etc/vmware/config <<-EOF
		.encoding = "UTF-8"
		bindir = "/opt/vmware/bin"
		libdir = "/opt/vmware/lib/vmware"
		initscriptdir = "/etc/init.d"
		authd.fullpath = "/opt/vmware/sbin/vmware-authd"
		gksu.rootMethod = "su"
		VMCI_CONFED = "no"
		VMBLOCK_CONFED = "no"
		VSOCK_CONFED = "no"
		NETWORKING = "yes"
		player.product.version = "${MY_PV}"
		product.buildNumber = "${PV_BUILD}"
		product.version = "${MY_PV}"
		product.name = "VMware Workstation"
		workstation.product.version = "${MY_PV}"
		vmware.fullpath = "/opt/vmware/bin/vmware"
		installerDefaults.componentDownloadEnabled = "no"
		installerDefaults.autoSoftwareUpdateEnabled.epoch = "4641104763"
		installerDefaults.dataCollectionEnabled.epoch = "7910652514"
		installerDefaults.dataCollectionEnabled = "no"
		installerDefaults.transferVersion = "1"
		installerDefaults.autoSoftwareUpdateEnabled = "no"
		acceptEULA = "yes"
		acceptOVFEULA = "yes"
		authd.client.port = "902"
		authd.proxy.nfc = "vmware-hostd:ha-nfc"
		authd.soapserver = "TRUE"
	EOF

	if use vix; then
		cat >> "${ED}"/etc/vmware/config <<-EOF
			vix.libdir = "/opt/vmware/lib/vmware-vix"
			vix.config.version = "1"
		EOF
	fi

	# Set configuration for GTK pixbuf
	sed -i -e "s:@@LIBCONF_DIR@@:/opt/vmware/lib/vmware/libconf:g" \
		"${ED}"/opt/vmware/lib/vmware/libconf/etc/gtk-3.0/gdk-pixbuf.loaders \
		|| die "sed for gdk-pixbuf.loaders failed"

	# Fix desktop files
	sed -i  -e "s:@@BINARY@@:${EPREFIX}/opt/vmware/bin/vmplayer:g" \
		-e "/^Encoding/d" \
		"${ED}"/usr/share/applications/vmware-player.desktop \
		|| die "sed for vmware-player.desktop failed"
	sed -i  -e "s:@@BINARY@@:${EPREFIX}/opt/vmware/bin/vmware:g" \
		-e "/^Encoding/d" \
		"${ED}"/usr/share/applications/vmware-workstation.desktop \
		|| die "sed for vmware-workstation.desktop failed"
	sed -i  -e "s:@@BINARY@@:${EPREFIX}/opt/vmware/bin/vmware-netcfg:g" \
		-e "/^Encoding/d" \
		"${ED}"/usr/share/applications/vmware-netcfg.desktop \
		|| die "sed for vmware-netcfg.desktop failed"

	# Set configuration fro datastores
	sed -i  -e "s:##{DS_NAME}##:standard:g" \
		-e "s:##{DS_PATH}##:/var/lib/vmware/Shared VMs:g" \
		"${ED}"/etc/vmware/hostd/datastores.xml \
		|| die "sed for hostd/datastores.xml failed"

	# Set configuration for proxy
	sed -i  -e "s:##{HTTP_PORT}##:-1:g" \
		-e "s:##{HTTPS_PORT}##:443:g" \
		-e "s:##{PIPE_PREFIX}##:/var/run/vmware/:g" \
		"${ED}"/etc/vmware/hostd/proxy.xml \
		|| die "sed for hostd/proxy.xml failed"

	# Set configuration for vmvare-workstation-server
	# (details in vmware-workstation-server.py)
	sed -i  -e "s:##{BUILD_CFGDIR}##:/etc/vmware/hostd/:g" \
		-e "s:##{CFGALTDIR}##:/etc/vmware/hostd/:g" \
		-e "s:##{CFGDIR}##:/etc/vmware/:g" \
		-e "s:##{ENABLE_AUTH}##:true:g" \
		-e "s:##{HOSTDMODE}##:ws:g" \
		-e "s:##{HOSTD_CFGDIR}##:/etc/vmware/hostd/:g" \
		-e "s:##{HOSTD_MOCKUP}##:false:g" \
		-e "s:##{LIBDIR}##:/opt/vmware/lib/vmware:g" \
		-e "s:##{LIBDIR_INSTALLED}##:/opt/vmware/lib/vmware/:g" \
		-e "s:##{LOGDIR}##:/var/log/vmware/:g" \
		-e "s:##{LOGLEVEL}##:verbose:g" \
		-e "s:##{MOCKUP}##:mockup-host-config.xml:g" \
		-e "s:##{PLUGINDIR}##:./:g" \
		-e "s:##{SHLIB_PREFIX}##:lib:g" \
		-e "s:##{SHLIB_SUFFIX}##:.so:g" \
		-e "s:##{USE_BLKLISTSVC}##:false:g" \
		-e "s:##{USE_CBRCSVC}##:false:g" \
		-e "s:##{USE_CIMSVC}##:false:g" \
		-e "s:##{USE_DIRECTORYSVC}##:false:g" \
		-e "s:##{USE_DIRECTORYSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_DYNAMIC_PLUGIN_LOADING}##:false:g" \
		-e "s:##{USE_DYNAMO}##:false:g" \
		-e "s:##{USE_DYNSVC}##:false:g" \
		-e "s:##{USE_GUESTSVC}##:false:g" \
		-e "s:##{USE_HBRSVC}##:false:g" \
		-e "s:##{USE_HBRSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_HOSTSPECSVC}##:false:g" \
		-e "s:##{USE_HOSTSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_HTTPNFCSVC}##:false:g" \
		-e "s:##{USE_HTTPNFCSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_LICENSESVC_MOCKUP}##:false:g" \
		-e "s:##{USE_NFCSVC}##:true:g" \
		-e "s:##{USE_NFCSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_OVFMGRSVC}##:true:g" \
		-e "s:##{USE_PARTITIONSVC}##:false:g" \
		-e "s:##{USE_SECURESOAP}##:false:g" \
		-e "s:##{USE_SNMPSVC}##:false:g" \
		-e "s:##{USE_SOLO_MOCKUP}##:false:g" \
		-e "s:##{USE_STATSSVC}##:false:g" \
		-e "s:##{USE_STATSSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_VCSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_VSLMSVC}##:false:g" \
		-e "s:##{USE_VSLMSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_VDISKSVC}##:false:g" \
		-e "s:##{USE_VDISKSVC_MOCKUP}##:false:g" \
		-e "s:##{USE_VMSVC_MOCKUP}##:false:g" \
		-e "s:##{VM_INVENTORY}##:vmInventory.xml:g" \
		-e "s:##{VM_RESOURCES}##:vmResources.xml:g" \
		-e "s:##{WEBSERVER_PORT_ENTRY}##::g" \
		-e "s:##{WORKINGDIR}##:./:g" \
		"${ED}"/etc/vmware/hostd/config.xml \
		|| die "sed for hostd/config.xml failed"

	# Set configuration for environments
	sed -i -e "s:##{ENV_LOCATION}##:/etc/vmware/hostd/env/:g" \
		"${ED}"/etc/vmware/hostd/environments.xml \
		|| die "sed for hostd/environments.xml failed"

	# Set configuration for clients
	sed -i -e "s:@@AUTHD_PORT@@:902:g" \
		"${ED}"/opt/vmware/lib/vmware/hostd/docroot/client/clients.xml \
		|| die "sed for client/clients.xml failed"

	# Install initscript for vmware-workstation
	newinitd "${FILESDIR}"/vmware-net.initd vmware-net
	newinitd "${FILESDIR}"/vmware-usb.initd vmware-usb
	newinitd "${FILESDIR}"/vmware-server.initd vmware-server
	use systemd && systemd_dounit "${WORKDIR}"/systemd-vmware-"${SYSTEMD_UNITS_TAG}"/vmware-{authentication,usb,vmblock,vmci,vmmon,vmnet,vmsock}.service \
			vmware.target

	# enable macOS guests support
	if use macos-guests ; then
		python "${WORKDIR}"/unlocker-"${UNLOCKER_VERSION}"/unlocker.py >/dev/null || die "unlocker.py failed"
	fi

	# install vmware tools
	for guest in ${IUSE_VMWARE_GUESTS} ; do
		if use vmware-tools-"${guest}" ; then
			local dbfile
			dbfile="${ED}"/etc/vmware-installer/database
			if ! [ -e "${dbfile}" ] ; then
				touch "${dbfile}" || die "create database failed"
				sqlite3 "${dbfile}" "CREATE TABLE settings(key VARCHAR PRIMARY KEY, value VARCHAR NOT NULL, component_name VARCHAR NOT NULL);" \
					|| die "sqlite3 for create table settings failed"
				sqlite3 "${dbfile}" "INSERT INTO settings(key,value,component_name) VALUES('db.schemaVersion','2','vmware-installer');" \
					|| die "sqlite3 for insert table settings failed"
				sqlite3 "${dbfile}" "CREATE TABLE components(id INTEGER PRIMARY KEY, name VARCHAR NOT NULL, version VARCHAR NOT NULL, buildNumber INTEGER NOT NULL, component_core_id INTEGER NOT NULL, longName VARCHAR NOT NULL, description VARCHAR, type INTEGER NOT NULL);" \
					|| die "sqlite3 for create table components failed"
			fi
			local manifest
			manifest="vmware-tools-${guest}/manifest.xml"
			if [ -e "${manifest}" ] ; then
				local version
				version="$(grep -oPm1 '(?<=<version>)[^<]+' "${manifest}")"
				sqlite3 "${dbfile}" "INSERT INTO components(name,version,buildNumber,component_core_id,longName,description,type) VALUES(\"vmware-tools-$guest\",\"$version\",\"${PV_BUILD}\",1,\"$guest\",\"$guest\",1);" \
					|| die "sqlite3 for insert table components failed"
			else
				sqlite3 "${dbfile}" "INSERT INTO components(name,version,buildNumber,component_core_id,longName,description,type) VALUES(\"vmware-tools-$guest\",\"${VMWARE_FUSION_VER%/*}\",\"${VMWARE_FUSION_VER#*/}\",1,\"$guest\",\"$guest\",1);" \
					|| die "sqlite3 for macos insert table components failed"
			fi
			insinto /opt/vmware/lib/vmware/isoimages
			doins vmware-tools-"${guest}"/"${guest}".iso
		fi
	done

	readme.gentoo_create_doc
}

pkg_config() {
	/opt/vmware/bin/vmware-networks --postinstall vmware-workstation,old,new \
		|| die "vmware-networks failed"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	readme.gentoo_print_elog
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
}
