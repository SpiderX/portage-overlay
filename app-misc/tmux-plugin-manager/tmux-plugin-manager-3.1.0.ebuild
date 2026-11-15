# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=9

inherit readme.gentoo-r1

MY_PN="tpm"
MY_P="${MY_PN}-${PV}"
COMMIT="33fa65fbfb72ba6dd106c21bf5ee6cc353ecdbb6"

DESCRIPTION="Tmux Plugin Manager"
HOMEPAGE="https://github.com/tmux-plugins/tpm"
SRC_URI="https://github.com/tmux-plugins/${MY_PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	test? ( https://github.com/tmux-plugins/tmux-test/archive/${COMMIT}.tar.gz -> ${P}-test.tar.gz )"
S="${WORKDIR}/${MY_P}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"
RESTRICT="test"
PROPERTIES="test_network"

RDEPEND="app-misc/tmux
	dev-vcs/git"
BDEPEND="test? ( dev-tcltk/expect )"

PATCHES=( "${FILESDIR}/${PN}"-3.1.0-tests-clean-plugins.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-failed-plugins-download.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-multiple-plugins-download.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-plugin-download.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-plugin-installation.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-plugin-sourcing.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-update-all-plugins.patch
	"${FILESDIR}/${PN}"-3.1.0-tests-update-single-plugin.patch )

DOC_CONTENTS="Add the following into .tmux.conf:\\n
set-environment -g TMUX_PLUGIN_MANAGER_PATH '/usr/share/tmux-plugins'\\n
to install plugins via portage and manage them via tpm."

src_prepare() {
	default

	if use test ; then
		edo rmdir lib/tmux-test
		edo ln -s ../../tmux-test-"${COMMIT}" lib/tmux-test
	fi
}

src_test() {
	# initialize the tmux-test framework
	edo lib/tmux-test/setup

	# isolate test configuration and plugin installations from the user's
	# environment, and use a private directory for tmux server sockets
	local -x HOME="${T}" TMUX_TMPDIR="${T}/tmux-sockets"

	# tmux requires its socket directory to be accessible only to the owner
	mkdir -p "${TMUX_TMPDIR}" || die
	chmod 700 "${TMUX_TMPDIR}" || die

	# prevent tests from connecting to an existing tmux session
	unset TMUX

	# run the complete test suite, including Expect-based key-binding tests
	edo tests/run_tests_in_isolation
}

src_install() {
	einstalldocs
	insinto /usr/share/tmux-plugin-manager
	doins -r bin bindings scripts tpm
	fperms -R +x /usr/share/tmux-plugin-manager/bin{,dings}/ \
		/usr/share/tmux-plugin-manager/scripts/check_tmux_version.sh \
		/usr/share/tmux-plugin-manager/scripts/{clean,install,source}_plugins.sh \
		/usr/share/tmux-plugin-manager/scripts/update_plugin{,_prompt_handler}.sh \
		/usr/share/tmux-plugin-manager/tpm
	readme.gentoo_create_doc
}

pkg_postinst() {
	readme.gentoo_print_elog
}
