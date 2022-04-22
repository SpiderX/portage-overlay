# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils systemd xdg

MY_PV="$(ver_rs 3 -)"
MY_PN="VMware-Remote-Console"
MY_P="${MY_PN}-${MY_PV}.x86_64.bundle"

DESCRIPTION="VMware Remote Console"
HOMEPAGE="https://docs.vmware.com/en/VMware-Remote-Console/index.html"
SRC_URI="${MY_P}"

LICENSE="vmware"
SLOT="0"
KEYWORDS="-* ~amd64"
IUSE="standalone"
RESTRICT="bindist fetch mirror"

RDEPEND="app-emulation/vmware-workstation
	standalone? ( !app-emulation/vmware-workstation )"
BDEPEND="sys-apps/fix-gnustack
	sys-libs/ncurses-compat:5"

S="${WORKDIR}/src"

pkg_nofetch() {
	einfo "Please the client file ${A} from"
	einfo "${HOMEPAGE}"
	einfo "and place it into your DISTDIR directory"
}

src_unpack() {
	# Bundle doesn't allow extraction via symlinks or relative paths
	cp "${DISTDIR}"/"${MY_P}" "${WORKDIR}"/ || die "cp failed"
	sh "${WORKDIR}"/"${MY_P}" --console --required --eulas-agreed -x "${S}" \
		|| die "bundle extract failed"
}

src_prepare() {
	default

	# Replace placeholder path
	sed -i  -e "s:@@BINARY@@:${EPREFIX}/opt/vmware/bin/vmrc:g" \
		-e "/^Encoding/d" \
		vmware-vmrc-app/share/applications/vmware-vmrc.desktop \
		|| die "sed for vmware-vmrc.desktop failed"

	if use standalone ; then
		local vmware_installer_version
		vmware_installer_version="$(grep -oPm1 '(?<=<version>)[^<]+' vmware-installer/manifest.xml)"

		sed -i  -e "s/@@VERSION@@/${vmware_installer_version}/" \
			-e "s,@@VMWARE_INSTALLER@@,/opt/vmware-vmrc/lib/vmware-installer/${vmware_installer_version}," \
			vmware-installer/bootstrap || die "sed for vmware-installer/bootstrap failed"
	fi
}

src_install() {
	einstalldocs

	into /opt/vmware
	dobin vmware-vmrc-app/bin/vmrc

	# libvmplayer.so/libvmplayer.so from app-emulation/vmware-workstation
	dodir opt/vmware/lib/vmware/lib/libvmrc.so
	dosym ../libvmplayer.so/libvmplayer.so \
		opt/vmware/lib/vmware/lib//libvmrc.so/libvmrc.so
	# appLoader from app-emulation/vmware-workstation
	dosym appLoader opt/vmware/lib/vmware/bin/vmrc

	domenu vmware-vmrc-app/share/applications/vmware-vmrc.desktop

	doicon vmware-vmrc/lib/share/pixmaps/{vmware-vmrc,vmrc_sidebar}.png

	for size in 16x16 24x24 32x32 48x48 ; do
		doicon -s "${size}" vmware-vmrc/share/icons/hicolor/"${size}"/apps/vmware-vmrc.png
	done

	insinto /usr/share/metainfo
	doins vmware-vmrc-app/share/appdata/vmware-vmrc.appdata.xml

	pax-mark -m "${ED}"/opt/vmware/lib/vmware/bin/vmrc

	if use standalone ; then
		local vmware_installer_version
		vmware_installer_version="$(grep -oPm1 '(?<=<version>)[^<]+' vmware-installer/manifest.xml)"

		# Install revdep-rebuild entry
		insinto /etc/revdep-rebuild
		echo 'SEARCH_DIRS_MASK="/opt/vmware"' > "${T}"/10vmware-vmrc
		doins "${T}"/10vmware-vmrc

		# Install the binaries
		into /opt/vmware
		dobin vmware-usbarbitrator/bin/vmware-usbarbitrator \
			vmware-vmrc-app/bin/vmware-gksu

		# Install the libraries
		insinto /opt/vmware/lib/vmware
		doins -r vmware-installer/lib/. \
			vmware-player-core/lib/lib/libvmware-zenity.so/libvmware-zenity.so \
			vmware-player-core/lib/share/. \
			vmware-vmrc/lib/share/pixmaps/{vmrc_sidebar,vmware-vmrc}.png \
			vmware-vmrc-app/lib/.

		# Install the installer
		insinto /opt/vmware/lib/vmware-installer/"${vmware_installer_version}"
		doins -r vmware-installer/{vmis,vmis-launcher,vmware-installer,vmware-installer.py}
		fperms 0755 /opt/vmware/lib/vmware-installer/"${vmware_installer_version}"/{vmis-launcher,vmware-installer}
		dosym ../lib/vmware-installer/"${vmware_installer_version}"/vmware-installer /opt/vmware/bin/vmware-installer
		insinto /etc/vmware-installer
		doins vmware-installer/bootstrap

		# Install vmware-vmrc ancillaries
		for size in 16x16 22x22 24x24 32x32 48x48 ; do
			if [ "${size}" == "16x16" ] || [ "$size" == "32x32" ] ; then
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-certificate.png
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{easter-egg,team}.png
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vm-legacy,vm}.png
			fi
			if [ "${size}" == "22x22" ] || [ "$size" == "24x24" ] ; then
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-certificate.png
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vm}.png
			fi
			if [ "${size}" == "48x48" ] ; then
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{easter-egg,snapshot,team}.png
				doicon -s "${size}" -c mimetypes vmware-vmrc/share/icons/hicolor/"${size}"/mimetypes/application-x-vmware-{vm-clone,vmdisk,vmfoundry,vm-legacy,vm}.png
			fi
		done
		doicon -s scalable -c mimetypes vmware-vmrc/share/icons/hicolor/scalable/mimetypes/application-certificate.svg
		doicon -s scalable -c mimetypes vmware-vmrc/share/icons/hicolor/scalable/mimetypes/application-x-vmware-{easter-egg,snapshot,team}.svg
		doicon -s scalable -c mimetypes vmware-vmrc/share/icons/hicolor/scalable/mimetypes/application-x-vmware-{vm-clone,vmfoundry,vm-legacy,vm}.svg

		exeinto /opt/vmware/lib/vmware/setup
		doexe vmware-vmrc-setup/vmware-config

		# Create symlinks for the various tools
		dosym appLoader /opt/vmware/lib/vmware/bin/vmware-gksu
		dosym appLoader /opt/vmware/lib/vmware/bin/vmware-setup-helper

		# Fix permissions
		fperms 0755 /opt/vmware/lib/vmware/bin/appLoader
		fperms 0755 /opt/vmware/lib/vmware/setup/vmware-config
		fperms 0755 /opt/vmware/lib/vmware/lib/libvmware-gksu.so/gksu-run-helper

		# Create environment
		local envd
		envd="${T}"/90vmware-vmrc
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

		# Install initscript for vmware-usb
		newinitd "${FILESDIR}"/vmware-usb.initd vmware-usb
		systemd_dounit "${FILESDIR}"/vmware-usb.service
	fi
}
