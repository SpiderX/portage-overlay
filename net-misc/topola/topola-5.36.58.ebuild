# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2086

EAPI=8

TOPOLA_BASE_PV="5.36.07"
TOPOLA_BASE_P="${PN}-base-${TOPOLA_BASE_PV}"
TOPOLA_BASE_URI="http://topola.unity.net/files/base/${TOPOLA_BASE_P}.bin"

TOPOLA_UNLICENSED_BIN_PV="${PV}"
TOPOLA_UNLICENSED_BIN_P="${PN}-bin_unl-${TOPOLA_UNLICENSED_BIN_PV}"
TOPOLA_UNLICENSED_BIN_URI="http://topola.unity.net/files/base/${TOPOLA_UNLICENSED_BIN_P}.bin"

TOPOLA_LICENSED_BIN_PV="${PV}"
TOPOLA_LICENSED_BIN_P="${PN}-bin-${TOPOLA_LICENSED_BIN_PV}"
TOPOLA_LICENSED_BIN_URI="http://topola.unity.net/files/base/${TOPOLA_LICENSED_BIN_P}.bin"

TOPOLA_AGENT_PV="5.36.63"
TOPOLA_AGENT_P="${PN}-taremote_src-${TOPOLA_AGENT_PV}"
TOPOLA_AGENT_URI="http://topola.unity.net/files/taremote/${TOPOLA_AGENT_P}.bin"

inherit toolchain-funcs unpacker user-info

DESCRIPTION="Customer accounting system, services and statistics collection management"
HOMEPAGE="https://topola.unity.net"
LICENSE="all-rights-reserved"

SRC_URI="base? ( ${TOPOLA_BASE_URI} )
	unlicensed-bin? ( http://topola.unity.net/files/bin_unl/${TOPOLA_UNLICENSED_BIN_P}.bin )
	licensed-bin? ( http://topola.unity.net/files/bin/${TOPOLA_LICENSED_BIN_P}.bin )
	taremote? ( ${TOPOLA_AGENT_URI} )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="elibc_glibc base unlicensed-bin licensed-bin +taremote +xinetd"
RESTRICT="mirror"
REQUIRED_USE="	|| ( taremote base )
		elibc_glibc
		unlicensed-bin? ( base elibc_glibc !licensed-bin )
		licensed-bin? ( base elibc_glibc !unlicensed-bin )"
S=${WORKDIR}

RDEPEND="acct-user/topola
	virtual/cron
	elibc_glibc? ( sys-libs/glibc:2.2 )
	xinetd? ( sys-apps/xinetd )"

QA_PREBUILT="opt/topola/bin/admin.cgi
	opt/topola/bin/ofubase"

pkg_nofetch() {
	if use licensed-bin; then
		eerror "Please go to"
		eerror "  https://${HOMEPAGE}"
		eerror "  and download"
		eerror "TopolA: Main binaries i686+x86_64 (Licensed):"
		eerror "    ${TOPOLA_LICENSED_BIN_P}.bin"
		eerror "After downloading, put it into your DISTDIR directory."
	fi
}

my_unpack() {
	local name=$1
	# upack_makeself will extract to $WORKDIR,
	# so we explicitly change directory
	mkdir "${S}"/"${name}" || die "mkdir to ${name} failed"
	cd "${S}"/"${name}"    || die "cd to ${name} failed"
	unpack_makeself "${MY_A[0]}" "$2" tail
	MY_A=("${MY_A[@]:1}")
	unset name
}

src_unpack() {
	# Put $A into array for further access to its elements
	IFS=" " read -r -a MY_A <<<${A}
	use base           && my_unpack "${TOPOLA_BASE_P}" 88
	use unlicensed-bin && my_unpack "${TOPOLA_UNLICENSED_BIN_P}" 90
	use licensed-bin   && my_unpack "${TOPOLA_LICENSED_BIN_P}" 90
	use taremote       && my_unpack "${TOPOLA_AGENT_P}" 88
	unset MY_A
}

src_prepare() {
	if use base; then
		cd "${S}"/"${TOPOLA_BASE_P}" || die "cd to ${TOPOLA_BASE_P} failed"
		# fix paths in configuration files
		eapply "${FILESDIR}"/"${PN}"-base-5.35.01-conf.patch
		# screen variables, rename TPA_HOME to TPAHOME for hold real "home path" value
		eapply "${FILESDIR}"/"${PN}"-base-5.35.01-tpafunc.patch
	fi
	if use unlicensed-bin; then
		cd "${S}"/"${TOPOLA_UNLICENSED_BIN_P}" || die "cd to ${TOPOLA_UNLICENSED_BIN_P} failed"
		# rename TPA_HOME to TPAHOME for hold real "home path" value
		eapply "${FILESDIR}"/"${PN}"-bin_unl-5.36.58-tpafunc.patch
	fi
	if use licensed-bin; then
		cd "${S}"/"${TOPOLA_LICENSED_BIN_P}" || die "cd to ${TOPOLA_LICENSED_BIN_P} failed"
		# rename TPA_HOME to TPAHOME for hold real "home path" value
		eapply "${FILESDIR}"/"${PN}"-bin_unl-5.36.58-tpafunc.patch
	fi
	if use taremote; then
		cd "${S}"/"${TOPOLA_AGENT_P}" || die "cd to ${TOPOLA_AGENT_P} failed"
		# Respect FLAGS, fix binary install path
		eapply "${FILESDIR}"/"${PN}"-taremote-5.36.58-Makefile.patch
		# screen variables, rename TPA_HOME to TPAHOME for hold real "home path" value
		eapply "${FILESDIR}"/"${PN}"-taremote-5.36.58-tpafunc.patch
		# screen sed, remove warning
		eapply "${FILESDIR}"/"${PN}"-taremote-5.36.58-tpainst.patch

		sed -i "s/\${MAKE}/\${MAKE} CC=$(tc-getCC)/" tpainst.sh \
			|| die "sed failed for tpainst.sh"
	fi

	default
}

src_install() {
	local MY_D
	MY_D="${D}$(egethome topola)"
	dodir "$(egethome topola)"
	if use base; then
		cd "${S}"/"${TOPOLA_BASE_P}" \
			|| die "cd to ${TOPOLA_BASE_P} failed"
		# pass variables to install script
		# Note: USER is needed to fill TPA_INSTALLER in .topola
		#       HOME is needed to create .topola
		#       TPAHOME holds real user home
		TPA_OWNER="${PN}" USER="${PN}" TPA_HOME="${MY_D}" \
		HOME="${MY_D}" TPAHOME="$(egethome topola)" \
			./tpainst.sh || die "${TOPOLA_BASE_P}/tpainst.sh failed"

		if use xinetd ; then
			insinto /etc/xinetd.d
			doins "${MY_D}"/docs/etc/xinetd.d/ofubase
		fi
	fi
	if use unlicensed-bin; then
		# change TPA_HOME path for further tpainst.sh execution
		sed "s#$(egethome topola)#${MY_D}#" -i "${MY_D}"/.topola \
			|| die "first sed execution for .topola failed"

		cd "${S}"/"${TOPOLA_UNLICENSED_BIN_P}" \
			|| die "cd to ${TOPOLA_UNLICENSED_BIN_P} failed"
		TPA_OWNER="${PN}" USER="${PN}" TPA_HOME="${MY_D}" \
		HOME_DIR="${MY_D}" TPAHOME="$(egethome topola)" \
			./tpainst.sh || die "${TOPOLA_UNLICENSED_BIN_P}/tpainst.sh failed"

		# revert TPA_HOME path back
		sed "s#${D}##" -i "${MY_D}"/.topola \
			|| die "sed second execution for .topola failed"
	fi
	if use licensed-bin; then
		# change TPA_HOME path for further tpainst.sh execution
		sed "s#$(egethome topola)#${MY_D}#" -i "${MY_D}"/.topola \
			|| die "first sed execution for .topola failed"

		cd "${S}"/"${TOPOLA_LICENSED_BIN_P}" \
			|| die "cd to ${TOPOLA_LICENSED_BIN_P} failed"
		TPA_OWNER="${PN}" USER="${PN}" TPA_HOME="${MY_D}" \
		HOME_DIR="${MY_D}" TPAHOME="$(egethome topola)" \
			./tpainst.sh || die "${TOPOLA_LICENSED_BIN_P}/tpainst.sh failed"

		# revert TPA_HOME path back
		sed "s#${D}##" -i "${MY_D}"/.topola \
			|| die "sed second execution for .topola failed"
	fi
	if use taremote; then
		# change TPA_HOME path for further tpainst.sh execution
		if use base ; then
			sed "s#$(egethome topola)#${MY_D}#" -i "${MY_D}"/.topola \
			|| die "first sed execution for .topola failed"
		fi

		cd "${S}"/"${TOPOLA_AGENT_P}" \
			|| die "cd to ${TOPOLA_AGENT_P} failed"
		TPA_OWNER="${PN}" USER="${PN}" TPA_HOME="${MY_D}" \
		HOME_DIR="${MY_D}" TPAHOME="$(egethome topola)" \
			./tpainst.sh || die "${TOPOLA_AGENT_P}/tpainst.sh failed"

		# revert TPA_HOME path back
		if use base ; then
			sed "s#${D}##" -i "${MY_D}"/.topola \
				|| die "sed second execution for .topola failed"
		fi

		if use xinetd ; then
			insinto /etc/xinetd.d
			doins "${MY_D}"/docs/etc/xinetd.d/taremote
		fi

		# remove unneeded files
		rm -r "${MY_D}"/docs/ || die "remove ${MY_D}/docs/ failed"
		rm -r "${MY_D}"/src/  || die "remove ${MY_D}/src/ failed"

		fowners -R "${PN}":"${PN}" "$(egethome topola)"
	fi
	unset MY_D
}

pkg_postinst() {
	elog "--"
	elog
	elog "You may need to add these lines to /etc/services:"
	elog
	use base     && elog "ofubase		4766/tcp	# Ofubase core calls"
	use taremote && elog "taremote		4767/tcp	# Remote agent statistic"
	elog
}
