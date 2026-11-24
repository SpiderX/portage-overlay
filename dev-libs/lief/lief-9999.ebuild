# Copyright 19399-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{12..15} )

inherit cmake edo git-r3 python-single-r1

DESCRIPTION="Library to Instrument Executable Formats (C++, Python, Rust)"
HOMEPAGE="https://github.com/lief-project/LIEF"
EGIT_REPO_URI="https://github.com/lief-project/${PN^^}.git"
SRC_URI="test? ( https://lief-tests.s3.fr-par.scw.cloud/lief_tests.zip -> ${PN}-1.0.0-tests.zip )"

LICENSE="Apache-2.0"
SLOT="0"
IUSE="cpp json python rust test"
RESTRICT="!test? ( test )"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} ) test? ( json python )"

# needs net-libs/mbedtls:4
RDEPEND="dev-cpp/expected
	dev-cpp/frozen
	dev-cpp/span
	dev-libs/utfcpp
	>=dev-libs/spdlog-1.17.0
	json? ( dev-cpp/nlohmann_json )
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	python? ( $(python_gen_cond_dep '<dev-python/nanobind-3[${PYTHON_USEDEP}]') )"
BDEPEND="app-arch/unzip
	dev-util/patchelf
	test? ( python? ( $(python_gen_cond_dep 'dev-python/pytest[${PYTHON_USEDEP}]') ) )"

EPYTEST_PLUGINS=()
EPYTEST_DESELECT=(
	# requires x32 ABI support (CONFIG_X86_X32_ABI)
	tests/elf/test_builder.py::test_ld_relocations
)

src_unpack() {
	git-r3_src_unpack
	default
}

src_prepare() {
	cmake_src_prepare

	sed -i '/^libdir/s|lib"|@CMAKE_INSTALL_LIBDIR@"|' cmake/LIEF.pc.in \
		|| die "sed failed for pkgconf"
	sed -i '/rodata.search_all/s|b"|"|' tests/abstract/test_abstract.py \
		|| die "sed failed for test_abstract.py"
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=ON
		-DCMAKE_DISABLE_FIND_PACKAGE_Git=ON
		-DFETCHCONTENT_FULLY_DISCONNECTED=OFF
		-DFETCHCONTENT_UPDATES_DISCONNECTED=ON
		-DLIEF_C_API="$(usex cpp ON OFF)"
		-DLIEF_ENABLE_JSON="$(usex json ON OFF)"
		-DLIEF_EXAMPLES=OFF
		-DLIEF_EXTERNAL_SPAN_DIR=/usr/include
		-DLIEF_EXTERNAL_SPDLOG=ON
		-DLIEF_INSTALL=ON
		-DLIEF_OPT_EXTERNAL_EXPECTED=ON
		-DLIEF_OPT_EXTERNAL_SPAN=ON
		-DLIEF_OPT_FROZEN_EXTERNAL=ON
		-DLIEF_OPT_NANOBIND_EXTERNAL=ON
		-DLIEF_OPT_NLOHMANN_JSON_EXTERNAL=ON
		-DLIEF_OPT_MBEDTLS_EXTERNAL=OFF
		-DLIEF_OPT_UTFCPP_EXTERNAL=ON
		-DLIEF_PYTHON_API="$(usex python ON OFF)"
		-DLIEF_RUST_API="$(usex rust ON OFF)"
		-DLIEF_TESTS="$(usex test ON OFF)"
		-DLIEF_USE_CCACHE=OFF
	)

	if use python ; then
		mycmakeargs+=(
			-DPython_EXECUTABLE="${PYTHON}"
			-Dnanobind_DIR="$("${PYTHON}" -m nanobind --cmake_dir)"
		)
	fi

	cmake_src_configure
}

src_test() {
	export LIEF_SAMPLES_DIR="${WORKDIR}"

	cmake_src_test

	if use python ; then
		edo ln -s "${BUILD_DIR}"/api/python/_lief.so "${S}"/api/python/lief/_lief.so

		LD_LIBRARY_PATH="${BUILD_DIR}${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}" \
		PYTHONPATH="${S}/api/python:${BUILD_DIR}/api/python" epytest
	fi
}

src_install() {
	cmake_src_install

	if use python ; then
		python_moduleinto lief
		python_domodule "${S}"/api/python/lief/. "${BUILD_DIR}"/api/python/_lief.so
		fperms +x usr/lib/"${EPYTHON}"/site-packages/lief/_lief.so

		edo patchelf --remove-rpath "${D}$(python_get_sitedir)"/lief/_lief.so
	fi
}
