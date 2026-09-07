# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# Eclass functions pass "$@" to debug-print-function and public helpers may be
# called with arguments by inheriting ebuilds; ShellCheck cannot see those
# external call sites.
# shellcheck disable=SC2119,SC2120

# @ECLASS: composer.eclass
# @MAINTAINER:
# Vladimir Pavljuchenkov <spiderx@spiderx.dp.ua>
# @SUPPORTED_EAPIS: 8 9
# @BLURB: common helpers for packaging Composer-based PHP packages
# @DESCRIPTION:
# Provides common functionality for packaging PHP packages that use the
# Composer ecosystem.
#
# The eclass is intended for Composer-style PHP libraries and applications
# packaged using system dependencies instead of bundled Composer dependencies.
#
# It provides common helpers for PHP dependencies, installation of
# distro-provided autoloaders, test setup and PHPUnit execution.
#
# The eclass does not imply that the Composer executable itself must be used
# during package build or installation.

case ${EAPI} in
	8|9) ;;
	*) die "${ECLASS}: EAPI ${EAPI:-0} not supported" ;;
esac

[[ ${EAPI} == 8 ]] && inherit edo

if [[ -z ${_COMPOSER_ECLASS} ]]; then
_COMPOSER_ECLASS=1


# ---------------------------------------------------------------------------
# Composer package metadata
# ---------------------------------------------------------------------------

# @ECLASS_VARIABLE: COMPOSER_VENDOR
# @PRE_INHERIT
# @DESCRIPTION:
# Composer vendor name.
#
# Defaults to the part of PN preceding the first '-'.
: "${COMPOSER_VENDOR:=${PN%%-*}}"

# @ECLASS_VARIABLE: COMPOSER_PKG
# @PRE_INHERIT
# @DESCRIPTION:
# Composer package name.
#
# Defaults to the part of PN following the first '-'.
: "${COMPOSER_PKG:=${PN#*-}}"

# @ECLASS_VARIABLE: COMPOSER_PN
# @PRE_INHERIT
# @DESCRIPTION:
# Full Composer package name in vendor/package form.
: "${COMPOSER_PN:=${COMPOSER_VENDOR}/${COMPOSER_PKG}}"

# @ECLASS_VARIABLE: COMPOSER_SRC
# @PRE_INHERIT
# @DESCRIPTION:
# Temporary Composer-style source directory.
: "${COMPOSER_SRC:=${T}/composer/${COMPOSER_PKG}}"

# GitHub release archives normally use the Composer package name rather than
# PN as their top-level directory. Live ebuilds use the standard ${P}
# checkout directory provided by git-r3.
# Override Portage's standard ${WORKDIR}/${P} default for Composer packages.
[[ ${PV} != *9999* ]] && S="${WORKDIR}/${COMPOSER_PKG}-${PV}"


# ---------------------------------------------------------------------------
# PHP configuration
# ---------------------------------------------------------------------------

# Minimum PHP version supported by composer.eclass itself.
_COMPOSER_ECLASS_PHP_MIN_VER="8.2"

# @ECLASS_VARIABLE: PHP_MIN_VER
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Minimum PHP version required by the package.
#
# If unset, defaults to the minimum PHP version supported by composer.eclass.
#
# Example:
# @CODE
# PHP_MIN_VER="8.3"
# inherit composer
# @CODE

# @ECLASS_VARIABLE: PHP_REQ_USE
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# List of USE flags required on dev-lang/php, formatted as a USE dependency
# string.
#
# Example:
# @CODE
# PHP_REQ_USE="pcntl?,sockets"
# inherit composer
# @CODE
#
# This results in a dependency similar to:
# @CODE
# >=dev-lang/php-8.2:*[pcntl?,sockets]
# @CODE

if [[ -n ${PHP_MIN_VER} ]]; then
	if ver_test "${PHP_MIN_VER}" -lt "${_COMPOSER_ECLASS_PHP_MIN_VER}"; then
		die "PHP_MIN_VER must be at least ${_COMPOSER_ECLASS_PHP_MIN_VER}"
	fi
else
	PHP_MIN_VER="${_COMPOSER_ECLASS_PHP_MIN_VER}"
fi


# ---------------------------------------------------------------------------
# Installation configuration
# ---------------------------------------------------------------------------

# @ECLASS_VARIABLE: COMPOSER_INSTALL_PATH
# @PRE_INHERIT
# @DEFAULT_UNSET
# @DESCRIPTION:
# Installation path relative to /usr/share/php.
#
# If unset or empty, files are installed directly into /usr/share/php.
#
# Example:
# @CODE
# COMPOSER_INSTALL_PATH="Symfony/Component/OptionsResolver"
# inherit composer
# @CODE
#
# Files are installed below:
# @CODE
# /usr/share/php/Symfony/Component/OptionsResolver
# @CODE

# @ECLASS_VARIABLE: COMPOSER_INSTALL_SRC
# @PRE_INHERIT
# @DESCRIPTION:
# Relative source directory whose contents are installed.
#
# Defaults to "src".
#
# Set to "." for packages whose PHP sources are stored in the top-level
# source directory rather than a dedicated src directory.
: "${COMPOSER_INSTALL_SRC:=src}"

# @ECLASS_VARIABLE: COMPOSER_INSTALL_AUTOLOAD
# @PRE_INHERIT
# @DESCRIPTION:
# Relative source-tree directory where autoload.php from FILESDIR is
# installed.
#
# Defaults to COMPOSER_INSTALL_SRC.
: "${COMPOSER_INSTALL_AUTOLOAD:=${COMPOSER_INSTALL_SRC}}"


# ---------------------------------------------------------------------------
# Test configuration
# ---------------------------------------------------------------------------

# @ECLASS_VARIABLE: COMPOSER_TEST_FILES
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of additional test files and directories to copy from COMPOSER_SRC
# into the package source tree.
#
# The PHPUnit configuration file and the standard test directory are detected
# and copied automatically.
#
# Example:
# @CODE
# COMPOSER_TEST_FILES=(
#     fixtures
#     examples
# )
# @CODE

# @ECLASS_VARIABLE: COMPOSER_TEST_PATCHES
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of test-only patch files or directories containing test-only patches
# for release ebuilds.
#
# Live ebuilds already contain their test suite and should use PATCHES instead.
# Entries are passed to eapply and therefore follow standard eapply semantics.
#
# Example:
# @CODE
# COMPOSER_TEST_PATCHES=(
#     "${FILESDIR}/${PN}"-tests.patch
#     "${WORKDIR}/${P}-tests-patches"
# )
# @CODE


# ---------------------------------------------------------------------------
# PHPUnit configuration
# ---------------------------------------------------------------------------

# @ECLASS_VARIABLE: EPHPUNIT_BOOTSTRAP
# @DEFAULT_UNSET
# @DESCRIPTION:
# Bootstrap file passed to PHPUnit via --bootstrap.

# @ECLASS_VARIABLE: EPHPUNIT_EXCLUDE_FILTER
# @DEFAULT_UNSET
# @DESCRIPTION:
# Test name pattern passed to PHPUnit via --exclude-filter.

# @ECLASS_VARIABLE: EPHPUNIT_EXCLUDE_GROUP
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of PHPUnit test groups to exclude.
#
# Example:
# @CODE
# EPHPUNIT_EXCLUDE_GROUP=(
#     ssl
#     cluster
#     sentinel
# )
# @CODE

# @ECLASS_VARIABLE: EPHPUNIT_TESTSUITE
# @DEFAULT_UNSET
# @DESCRIPTION:
# PHPUnit test suite passed via --testsuite.

# @ECLASS_VARIABLE: EPHPUNIT_ARGS
# @DEFAULT_UNSET
# @DESCRIPTION:
# Array of additional arguments passed to PHPUnit.
#
# This can be used for PHPUnit options that are not handled directly by
# composer.eclass.


# ---------------------------------------------------------------------------
# Dependencies
# ---------------------------------------------------------------------------

_COMPOSER_PHP_DEP=">=dev-lang/php-${PHP_MIN_VER}:*"

if [[ -n ${PHP_REQ_USE} ]]; then
	_COMPOSER_PHP_DEP+="[${PHP_REQ_USE}]"
fi

RDEPEND+="
	${_COMPOSER_PHP_DEP}
	dev-php/fedora-autoloader
"

unset _COMPOSER_PHP_DEP


# ---------------------------------------------------------------------------
# Internal helpers
# ---------------------------------------------------------------------------

# @FUNCTION: _composer_test_fetch
# @INTERNAL
# @DESCRIPTION:
# Create a Composer checkout containing the complete package sources and test
# suite in COMPOSER_SRC.
_composer_test_fetch() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	edo composer create-project -q --no-install --prefer-source "${COMPOSER_PN}:${PV}" "${COMPOSER_SRC}"
}

# @FUNCTION: _composer_test_copy
# @INTERNAL
# @DESCRIPTION:
# Copy the PHPUnit configuration file, standard test directory and additional
# files listed in COMPOSER_TEST_FILES from COMPOSER_SRC into the package
# source tree.
#
# Exactly one of phpunit.xml or phpunit.xml.dist must exist.
# Exactly one of tests, Tests or test must exist.
_composer_test_copy() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	local file phpunit_config test_dir
	local -a configs=() files=() test_dirs=()

	for file in phpunit.xml phpunit.xml.dist; do
		[[ -e ${COMPOSER_SRC}/${file} ]] && configs+=( "${file}" )
	done

	case ${#configs[@]} in
		1)
			phpunit_config=${configs[0]}
		;;
		0)
			die "neither phpunit.xml nor phpunit.xml.dist found in ${COMPOSER_SRC}"
		;;
		*)
			die "both phpunit.xml and phpunit.xml.dist found in ${COMPOSER_SRC}"
		;;
	esac

	for file in tests Tests test; do
		[[ -d ${COMPOSER_SRC}/${file} ]] && test_dirs+=( "${file}" )
	done

	case ${#test_dirs[@]} in
		1)
			test_dir=${test_dirs[0]}
		;;
		0)
			die "none of tests, Tests or test found in ${COMPOSER_SRC}"
		;;
		*)
			die "multiple standard test directories found in ${COMPOSER_SRC}: ${test_dirs[*]}"
		;;
	esac

	files+=(
		"${COMPOSER_SRC}/${phpunit_config}"
		"${COMPOSER_SRC}/${test_dir}"
	)

	if declare -p COMPOSER_TEST_FILES &>/dev/null; then
		for file in "${COMPOSER_TEST_FILES[@]}"; do
			[[ -e ${COMPOSER_SRC}/${file} ]] || die "${file} not found in ${COMPOSER_SRC}"
			files+=( "${COMPOSER_SRC}/${file}" )
		done
	fi

	edo cp -r "${files[@]}" "${S}"
}


# ---------------------------------------------------------------------------
# Public helpers
# ---------------------------------------------------------------------------

# @FUNCTION: composer_enable_tests
# @USAGE: <test-runner>
# @DESCRIPTION:
# Enable the common test setup for Composer packages.
#
# Release ebuilds fetch their test suite using Composer and therefore require
# network access during testing. Live ebuilds use tests already present in the
# source checkout.
#
# The selected test runner adds its own test dependency.
#
# This function is intended to be called from global scope.
# Additional package-specific test dependencies should be added to BDEPEND
# separately.
composer_enable_tests() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	[[ $# -eq 1 ]] || die "usage: ${FUNCNAME[0]} <test-runner>"

	local test_dep

	case ${1} in
		phpunit)
			test_dep="dev-php/phpunit"
		;;
		*)
			die "${FUNCNAME[0]}: unsupported test runner: ${1}"
		;;
	esac

	IUSE+=" test"

	if [[ ${PV} == *9999* ]]; then
		RESTRICT+=" !test? ( test )"
		BDEPEND+=" test? ( ${test_dep} )"
	else
		RESTRICT+=" test"
		PROPERTIES+=" test_network"
		BDEPEND+=" test? ( dev-php/composer ${test_dep} )"
	fi

	# We need to ensure successful return in case we're called last,
	# otherwise Portage may wrongly assume sourcing failed.
	return 0
}

# @FUNCTION: composer_prepare_tests
# @DESCRIPTION:
# Prepare the Composer checkout for testing.
#
# Copies the PHPUnit configuration file, standard test directory and any
# additional files listed in COMPOSER_TEST_FILES into the package source
# tree. If COMPOSER_TEST_PATCHES exists, test-only patches are applied
# afterwards.
composer_prepare_tests() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	_composer_test_fetch
	_composer_test_copy

	if declare -p COMPOSER_TEST_PATCHES &>/dev/null && (( ${#COMPOSER_TEST_PATCHES[@]} )); then
		composer_test_patch
	fi
}

# @FUNCTION: composer_test_patch
# @DESCRIPTION:
# Apply test-only patches listed in COMPOSER_TEST_PATCHES using eapply.
composer_test_patch() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	declare -p COMPOSER_TEST_PATCHES &>/dev/null || die "COMPOSER_TEST_PATCHES is not defined"
	(( ${#COMPOSER_TEST_PATCHES[@]} )) || die "COMPOSER_TEST_PATCHES is empty"

	eapply -- "${COMPOSER_TEST_PATCHES[@]}"
}

# @FUNCTION: ephpunit
# @USAGE: [<args>...]
# @DESCRIPTION:
# Run PHPUnit using the common Composer eclass configuration.
#
# Code coverage is disabled and testdox output is enabled by default.
# EPHPUNIT_* options are added first, followed by arguments supplied directly
# to this function.
ephpunit() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	local group
	local -a args=(
		--no-coverage
		--testdox
	)

	if [[ -n ${EPHPUNIT_BOOTSTRAP} ]]; then
		args+=( --bootstrap "${EPHPUNIT_BOOTSTRAP}" )
	fi

	if [[ -n ${EPHPUNIT_EXCLUDE_FILTER} ]]; then
		args+=( --exclude-filter "${EPHPUNIT_EXCLUDE_FILTER}" )
	fi

	if declare -p EPHPUNIT_EXCLUDE_GROUP &>/dev/null; then
		for group in "${EPHPUNIT_EXCLUDE_GROUP[@]}"; do
			args+=( --exclude-group "${group}" )
		done
	fi

	if [[ -n ${EPHPUNIT_TESTSUITE} ]]; then
		args+=( --testsuite "${EPHPUNIT_TESTSUITE}" )
	fi

	if declare -p EPHPUNIT_ARGS &>/dev/null; then
		args+=( "${EPHPUNIT_ARGS[@]}" )
	fi

	edo phpunit "${args[@]}" "$@"
}


# ---------------------------------------------------------------------------
# Phase functions
# ---------------------------------------------------------------------------

# @FUNCTION: composer_src_prepare
# @DESCRIPTION:
# Default src_prepare implementation for Composer packages.
#
# Installs distro-provided Composer autoload files from FILESDIR when present,
# then performs the standard source preparation.
composer_src_prepare() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	if [[ -f ${FILESDIR}/autoload.php ]]; then
		edo install -D -m 644 "${FILESDIR}/autoload.php" "${COMPOSER_INSTALL_AUTOLOAD%/}/autoload.php"
	fi

	if [[ -f ${FILESDIR}/autoload-test.php ]]; then
		edo install -D -m 644 "${FILESDIR}/autoload-test.php" vendor/autoload.php
	fi

	if [[ -f ${FILESDIR}/installed.php ]]; then
		edo install -D -m 644 "${FILESDIR}/installed.php" vendor/installed.php
	fi

	default_src_prepare
}

# @FUNCTION: composer_src_install
# @DESCRIPTION:
# Default src_install implementation for Composer packages.
#
# Installs documentation and PHP sources below /usr/share/php. The optional
# COMPOSER_INSTALL_PATH variable specifies a package-specific path relative
# to /usr/share/php. COMPOSER_INSTALL_SRC specifies the relative source
# directory whose contents should be installed.
composer_src_install() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	local install_path="/usr/share/php"

	einstalldocs

	if [[ -n ${COMPOSER_INSTALL_PATH} ]]; then
		install_path+="/${COMPOSER_INSTALL_PATH}"
	fi

	insinto "${install_path}"

	case ${COMPOSER_INSTALL_SRC} in
		.)
			find . -regextype posix-extended \
				-mindepth 1 -maxdepth 1 \
				\( -name '*.php' -o -type d \) \
				! -regex '\./(bin|[Tt]ests|vendor)' \
				-exec doins -r {} +
		;;
		*)
			doins -r "${COMPOSER_INSTALL_SRC}"/.
		;;
	esac
}

# @FUNCTION: composer_src_test
# @DESCRIPTION:
# Default src_test implementation for Composer packages.
#
# Prepares the upstream test suite and runs PHPUnit.
composer_src_test() {
	debug-print-function "${FUNCNAME[0]}" "$@"

	[[ ${PV} != *9999* ]] && composer_prepare_tests

	ephpunit
}

fi

EXPORT_FUNCTIONS src_prepare src_install src_test
