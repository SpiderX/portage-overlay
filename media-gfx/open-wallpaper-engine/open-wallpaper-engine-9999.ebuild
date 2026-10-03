# Copyright 1999-2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CHROMIUM_LANGS="af am ar bg bn ca cs da de el en-GB en-US es-419 es et fa fil fi \
	fr gu he hi hr hu id it ja kn ko lt lv ml mr ms nb nl pl pt-BR pt-PT ro \
	ru sk sl sr sv sw ta te th tr uk ur vi zh-CN zh-TW"
LLVM_COMPAT=( {17..23} )

inherit chromium-2 edo git-r3 flag-o-matic llvm-r2

CEF_VER="149.0.4+g2f1bfd8+chromium-149.0.7827.156" #wrt 529604
LICRYPTO_PV="0.1.1"
RSTD_PV="0.1.5"
VVK_PV="0.1.0"
VRENTO_COMMIT="a781859c940325a909c77613b5b2795cc3d65e48"
WAVSEN_COMMIT="73be92f4f9db0179e93e3f28d62077a2aed77a8e"

DESCRIPTION="Open source implementation of Wallpaper Engine for Linux"
HOMEPAGE="https://github.com/waywallen/open-wallpaper-engine"
EGIT_REPO_URI="https://github.com/waywallen/${PN}.git"
SRC_URI="https://cef-builds.spotifycdn.com/cef_binary_149.0.4%2Bg2f1bfd8%2Bchromium-149.0.7827.156_linux64_minimal.tar.bz2 -> cef-${CEF_VER}-linux64.tar.bz2
	https://github.com/litocpp/licrypto/archive/v${LICRYPTO_PV}.tar.gz -> licrypto-${LICRYPTO_PV}.tar.gz
	https://github.com/litocpp/rstd/archive/v${RSTD_PV}.tar.gz -> rstd-${RSTD_PV}.tar.gz
	https://github.com/litocpp/vvk/archive/v${VVK_PV}.tar.gz -> vvk-${VVK_PV}.tar.gz
	https://github.com/vecren/vrento/archive/${VRENTO_COMMIT}.tar.gz -> vrento-${VRENTO_COMMIT}.tar.gz
	https://github.com/hypengw/wavsen/archive/${WAVSEN_COMMIT}.tar.gz -> wavsen-${WAVSEN_COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="test waywallen"
RESTRICT="!test? ( test )"

RDEPEND="app-accessibility/at-spi2-core:2
	app-arch/lz4:=
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi:=
	dev-libs/nspr
	dev-libs/nss
	dev-libs/quickjs-ng:=
	dev-libs/spirv-reflect
	dev-libs/wayland
	dev-util/glslang:0/16.3
	media-libs/alsa-lib
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	>=media-libs/glfw-3.4[wayland]
	media-libs/libglvnd
	media-libs/libva
	media-libs/mesa
	media-libs/libpulse
	media-video/ffmpeg:=
	net-print/cups
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/libX11
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrandr
	x11-libs/libxcb:0/1.12
	x11-libs/libxkbcommon
	x11-libs/pango
	virtual/libudev
	virtual/zlib:=
	waywallen? ( gui-apps/waywallen )"
DEPEND="${RDEPEND}
	>=dev-cpp/eigen-5.0.1
	dev-util/vulkan-headers"
BDEPEND="$(llvm_gen_dep 'llvm-core/clang:${LLVM_SLOT}=
		llvm-core/lld:${LLVM_SLOT}=')
	dev-build/cmake
	dev-build/lito
	dev-util/patchelf
	virtual/pkgconfig"

PATCHES=( "${FILESDIR}/${PN}"-0.3.0-lito.toml.patch
	"${FILESDIR}/${PN}"-0.3.0-source-local.patch )

QA_PREBUILT="usr/lib*/open-wallpaper-engine/lib{cef,EGL,GLESv2,vk_swiftshader}.so
	usr/lib*/open-wallpaper-engine/libvulkan.so.1"

src_unpack() {
	default
	git-r3_src_unpack
}

src_prepare() {
	default

	eapply --directory="${WORKDIR}/vrento-${VRENTO_COMMIT}" \
		"${FILESDIR}/${PN}-0.3.0-vrento-wavsen.patch"

	ln -s "${WORKDIR}/licrypto-${LICRYPTO_PV}" .licrypto || die
	ln -s "${WORKDIR}/rstd-${RSTD_PV}" .rstd || die
	ln -s "${WORKDIR}/vvk-${VVK_PV}" .vvk || die
	ln -s "${WORKDIR}/vrento-${VRENTO_COMMIT}" .vrento || die
	ln -s "${WORKDIR}/wavsen-${WAVSEN_COMMIT}" .wavsen || die
	ln -s "${WORKDIR}/wavsen-${WAVSEN_COMMIT}" .vrento/.wavsen || die

	# lito requires materialized external assets to reside within its build
	# directory and resolves symlinks when validating them, so stage the
	# Portage-fetched CEF distribution there instead of symlinking it.
	edo mkdir -p build/plain
	edo cp -a "${WORKDIR}"/cef_binary_${CEF_VER}_linux64_minimal build/plain/.cef

	edo pushd build/plain/.cef/Resources/locales
	chromium_remove_language_paks
	edo popd
}

src_configure() {
	append-cflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0
	append-cxxflags -U_FORTIFY_SOURCE -D_FORTIFY_SOURCE=0
}

src_compile() {
	edo lito build --profile plain --use-env-flags

	use waywallen && edo lito build --profile plain --use-env-flags \
			-p owe-waywallen-scene-renderer -p owe-waywallen-web-renderer

	# build all usable test targets in one pass. Repeated lito test
	# invocations can cause inconsistent incremental rebuilds.
	use test && edo lito test --profile plain --use-env-flags --no-run -p owe-tests \
		--target={audio,cli,core,parser,render-resource,scene-parse,scene-runtime,scene-schema,script-runtime,shader-parse,web-state}-tests
}

src_test() {
	local test filter
	local -a exclude

	# these test suites are self-contained and do not require Wallpaper Engine assets or Steam Workshop content
	for test in {audio,cli,core,render-resource,script-runtime,shader-parse,web-state}-tests ; do
		edo build/plain/test/owe-tests/"${test}"
	done

	# exclude tests requiring assets shipped with the proprietary Wallpaper Engine installation.
	# Workshop-dependent tests handle unavailable content themselves and are left enabled as skips.
	exclude=( MaterialParser.ModelMaterialsIgnoreObsoleteAlphaAndDisableBlendedDepthWrites
		MaterialParser.ShaderKeysAreCaseSensitiveAndPrecedeUniformShorthand
		ParticleDocument.PreservesRendererDefaultsAndDeclarationOrder )
	printf -v filter '%s:' "${exclude[@]}"
	edo build/plain/test/owe-tests/parser-tests --gtest_filter=*-"${filter%:}"

	# exclude tests requiring proprietary Wallpaper Engine assets and the corpus smoke test,
	# which requires Steam Workshop content. Individual Workshop-dependent tests gracefully skip themselves.
	exclude=( 'BloomParsing.*' 'ImageAlignmentParsing.*' 'ImageColorBlendParsing.*' 'ImageEffectJson.*'
		'SceneCameraParsing.*' 'SceneLightParsing.*' 'SceneLinkedSources.*'
		SceneObjectExpansion.ShapeOwnsItsWallpaperLayerIdentity 'SceneParseSmoke.*' 'SceneShadowParsing.*'
		SceneObjectExpansion.UserVisibilityRestoresImageDescendants 'TextColorBlendParsing.*' )
	printf -v filter '%s:' "${exclude[@]}"
	edo build/plain/test/owe-tests/scene-parse-tests --gtest_filter=*-"${filter%:}"

	# two parser integration tests require proprietary Wallpaper Engine assets.
	# LightUniformSource.PublishesWorldDirectionAndType is an upstream intermittent floating-point test.
	exclude=( LightUniformSource.PublishesWorldDirectionAndType SceneParserScript.DynamicObjectsUseSceneIdentity
		SceneParserText.AlignmentDoesNotMoveChildFrames )
	printf -v filter '%s:' "${exclude[@]}"
	edo build/plain/test/owe-tests/scene-runtime-tests --gtest_filter=*-"${filter%:}"

	# corpus-observation tests require a collection of Steam Workshop projects.
	# Keep the six source-only schema tests enabled.
	edo build/plain/test/owe-tests/scene-schema-tests \
		--gtest_filter=*-SceneSchema.EveryParsed*KeyIsObservedSomewhere

	# version-corpus-tests and tex-schema-tests are intentionally not built or run:
	# their coverage depends on a Steam Workshop corpus, which cannot be provided by the package sources.
}

src_install() {
	dobin build/plain/bin/owe-sceneviewer/SceneViewer

	exeinto /usr/"$(get_libdir)"/open-wallpaper-engine
	doexe build/plain/bin/owe-webviewer/WebViewer \
		build/plain/.cef/Release/lib{cef,EGL,GLESv2,vk_swiftshader}.so \
		build/plain/.cef/Release/libvulkan.so.1

	insinto /usr/"$(get_libdir)"/open-wallpaper-engine
	doins build/plain/.cef/Release/v8_context_snapshot.bin \
		build/plain/.cef/Release/vk_swiftshader_icd.json \
		build/plain/.cef/Resources/chrome_{1,2}00_percent.pak \
		build/plain/.cef/Resources/resources.pak \
		build/plain/.cef/Resources/icudtl.dat
	doins -r build/plain/.cef/Resources/locales

	edo patchelf --set-rpath '$ORIGIN' "${ED}"/usr/"$(get_libdir)"/open-wallpaper-engine/WebViewer

	dosym ../"$(get_libdir)"/open-wallpaper-engine/WebViewer /usr/bin/WebViewer

	if use waywallen ; then
		# lito generate the Waywallen plugin tree in a temporary prefix; only the plugin files are installed
		# below, while the renderer and CEF layout is handled separately
		edo lito install --profile plain --use-env-flags --prefix "${T}"/owe-waywallen -p owe-waywallen-plugin
		# upstream installs the Waywallen web renderer under lib/weweb; use the shared CEF runtime directory
		# instead to avoid installing a duplicate copy
		sed -i "/bin/s|lib/weweb|$(get_libdir)/open-wallpaper-engine|" \
			"${T}"/owe-waywallen/share/waywallen/plugins/org.waywallen.open-wallpaper-engine/plugin.toml \
			|| die "sed failed for plugin"

		dobin build/plain/bin/owe-waywallen-scene-renderer/waywallen-wescene-renderer
		exeinto /usr/"$(get_libdir)"/open-wallpaper-engine
		doexe build/plain/bin/owe-waywallen-web-renderer/waywallen-weweb-renderer

		edo patchelf --set-rpath '$ORIGIN' "${ED}"/usr/"$(get_libdir)"/open-wallpaper-engine/waywallen-weweb-renderer

		insinto /usr/share/waywallen/plugins
		doins -r "${T}"/owe-waywallen/share/waywallen/plugins/org.waywallen.open-wallpaper-engine
	fi
}
