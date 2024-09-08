# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck disable=SC2124

EAPI=8

inherit flag-o-matic multilib-minimal toolchain-funcs

MY_PN="${PN/-compat/}"
MY_PV="4.4.5"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Compatibility package for ffmpeg to provide versions 58 of libraries"
HOMEPAGE="https://ffmpeg.org"
SRC_URI="https://ffmpeg.org/releases/${MY_P}.tar.xz"
S="${WORKDIR}/${MY_P}"

LICENSE="!gpl? ( LGPL-2.1 ) gpl? ( GPL-2 )"
SLOT="${PV}"
KEYWORDS="~amd64"

# Options to use as use_enable in the foo[:bar] form.
# This will feed configure with $(use_enable foo bar)
# or $(use_enable foo foo) if no :bar is set.
# foo is added to IUSE.
FFMPEG_FLAG_MAP=(
		+bzip2:bzlib cpudetection:runtime-cpudetect debug gcrypt +gnutls gmp
		+gpl hardcoded-tables +iconv libxml2 lzma +network opencl
		openssl +postproc samba:libsmbclient sdl:ffplay sdl:sdl2 vaapi vdpau vulkan
		X:xlib X:libxcb X:libxcb-shm X:libxcb-xfixes +zlib
		# libavdevice options
		cdio:libcdio iec61883:libiec61883 ieee1394:libdc1394 libcaca openal
		opengl
		# indevs
		libv4l:libv4l2 pulseaudio:libpulse libdrm jack:libjack
		# decoders
		amr:libopencore-amrwb amr:libopencore-amrnb codec2:libcodec2 +dav1d:libdav1d fdk:libfdk-aac
		jpeg2k:libopenjpeg bluray:libbluray gme:libgme gsm:libgsm
		libaribb24 modplug:libmodplug opus:libopus qsv:libmfx libilbc librtmp ssh:libssh
		speex:libspeex srt:libsrt svg:librsvg nvenc:ffnvcodec
		vorbis:libvorbis vpx:libvpx zvbi:libzvbi
		# libavfilter options
		appkit
		bs2b:libbs2b chromaprint cuda:cuda-llvm flite:libflite frei0r fribidi:libfribidi
		fontconfig glslang:libglslang ladspa libass libtesseract lv2 truetype:libfreetype
		vidstab:libvidstab vmaf:libvmaf rubberband:librubberband zeromq:libzmq zimg:libzimg
		# libswresample options
		libsoxr
		# Threads; we only support pthread for now but ffmpeg supports more
		+threads:pthreads
)

# Same as above but for encoders, i.e. they do something only with USE=encode.
FFMPEG_ENCODER_FLAG_MAP=(
	amrenc:libvo-amrwbenc kvazaar:libkvazaar libaom mp3:libmp3lame
	openh264:libopenh264 rav1e:librav1e snappy:libsnappy svt-av1:libsvtav1
	theora:libtheora twolame:libtwolame webp:libwebp x264:libx264
	x265:libx265 xvid:libxvid
)

IUSE="alsa +encode oss +pic sndio v4l
	${FFMPEG_FLAG_MAP[@]%:*}
	${FFMPEG_ENCODER_FLAG_MAP[@]%:*}"

# Strings for CPU features in the useflag[:configure_option] form
# if :configure_option isn't set, it will use 'useflag' as configure option
ARM_CPU_FEATURES=(
	cpu_flags_arm_thumb:armv5te
	cpu_flags_arm_v6:armv6
	cpu_flags_arm_thumb2:armv6t2
	cpu_flags_arm_neon:neon
	cpu_flags_arm_vfp:vfp
	cpu_flags_arm_vfpv3:vfpv3
	cpu_flags_arm_v8:armv8
)
ARM_CPU_REQUIRED_USE="arm64? ( cpu_flags_arm_v8 )
	cpu_flags_arm_v8? ( cpu_flags_arm_vfpv3 cpu_flags_arm_neon )
	cpu_flags_arm_neon? (
		cpu_flags_arm_vfp
		arm? ( cpu_flags_arm_thumb2 )
	)
	cpu_flags_arm_vfpv3? ( cpu_flags_arm_vfp )
	cpu_flags_arm_thumb2? ( cpu_flags_arm_v6 )
	cpu_flags_arm_v6? (
		arm? ( cpu_flags_arm_thumb )
	)"
MIPS_CPU_FEATURES=( mipsdspr1:mipsdsp mipsdspr2 mipsfpu )
PPC_CPU_FEATURES=( cpu_flags_ppc_altivec:altivec cpu_flags_ppc_vsx:vsx cpu_flags_ppc_vsx2:power8 )
PPC_CPU_REQUIRED_USE="
	cpu_flags_ppc_vsx? ( cpu_flags_ppc_altivec )
	cpu_flags_ppc_vsx2? ( cpu_flags_ppc_vsx )
"
X86_CPU_FEATURES_RAW=( 3dnow:amd3dnow 3dnowext:amd3dnowext aes:aesni avx:avx avx2:avx2 fma3:fma3 fma4:fma4 mmx:mmx
					   mmxext:mmxext sse:sse sse2:sse2 sse3:sse3 ssse3:ssse3 sse4_1:sse4 sse4_2:sse42 xop:xop )
X86_CPU_FEATURES=( "${X86_CPU_FEATURES_RAW[@]/#/cpu_flags_x86_}" )
X86_CPU_REQUIRED_USE="
	cpu_flags_x86_avx2? ( cpu_flags_x86_avx )
	cpu_flags_x86_fma4? ( cpu_flags_x86_avx )
	cpu_flags_x86_fma3? ( cpu_flags_x86_avx )
	cpu_flags_x86_xop?  ( cpu_flags_x86_avx )
	cpu_flags_x86_avx?  ( cpu_flags_x86_sse4_2 )
	cpu_flags_x86_aes? ( cpu_flags_x86_sse4_2 )
	cpu_flags_x86_sse4_2?  ( cpu_flags_x86_sse4_1 )
	cpu_flags_x86_sse4_1?  ( cpu_flags_x86_ssse3 )
	cpu_flags_x86_ssse3?  ( cpu_flags_x86_sse3 )
	cpu_flags_x86_sse3?  ( cpu_flags_x86_sse2 )
	cpu_flags_x86_sse2?  ( cpu_flags_x86_sse )
	cpu_flags_x86_sse?  ( cpu_flags_x86_mmxext )
	cpu_flags_x86_mmxext?  ( cpu_flags_x86_mmx )
	cpu_flags_x86_3dnowext?  ( cpu_flags_x86_3dnow )
	cpu_flags_x86_3dnow?  ( cpu_flags_x86_mmx )
"
CPU_FEATURES_MAP=(
	"${ARM_CPU_FEATURES[@]}"
	"${MIPS_CPU_FEATURES[@]}"
	"${PPC_CPU_FEATURES[@]}"
	"${X86_CPU_FEATURES[@]}"
)
IUSE="${IUSE} ${CPU_FEATURES_MAP[@]%:*}"
CPU_REQUIRED_USE="${ARM_CPU_REQUIRED_USE} ${PPC_CPU_REQUIRED_USE} ${X86_CPU_REQUIRED_USE}"

RDEPEND="!media-video/ffmpeg:0/56.58.58
	alsa? ( media-libs/alsa-lib[${MULTILIB_USEDEP}] )
	amr? ( media-libs/opencore-amr[${MULTILIB_USEDEP}] )
	bluray? ( media-libs/libbluray:=[${MULTILIB_USEDEP}] )
	bs2b? ( media-libs/libbs2b[${MULTILIB_USEDEP}] )
	bzip2? ( app-arch/bzip2[${MULTILIB_USEDEP}] )
	cdio? ( dev-libs/libcdio-paranoia:=[${MULTILIB_USEDEP}] )
	chromaprint? ( media-libs/chromaprint[${MULTILIB_USEDEP}] )
	codec2? ( media-libs/codec2:=[${MULTILIB_USEDEP}] )
	dav1d? ( media-libs/dav1d:0=[${MULTILIB_USEDEP}] )
	encode? (
		amrenc? ( media-libs/vo-amrwbenc[${MULTILIB_USEDEP}] )
		kvazaar? ( media-libs/kvazaar[${MULTILIB_USEDEP}] )
		mp3? ( media-sound/lame[${MULTILIB_USEDEP}] )
		openh264? ( media-libs/openh264:=[${MULTILIB_USEDEP}] )
		rav1e? ( media-video/rav1e:=[capi] )
		snappy? ( app-arch/snappy:=[${MULTILIB_USEDEP}] )
		theora? ( media-libs/libogg[${MULTILIB_USEDEP}]
			media-libs/libtheora[encode,${MULTILIB_USEDEP}] )
		twolame? ( media-sound/twolame[${MULTILIB_USEDEP}] )
		webp? ( media-libs/libwebp:=[${MULTILIB_USEDEP}] )
		x264? ( media-libs/x264:=[${MULTILIB_USEDEP}] )
		x265? ( media-libs/x265:=[${MULTILIB_USEDEP}] )
		xvid? ( media-libs/xvid[${MULTILIB_USEDEP}] )
	)
	fdk? ( media-libs/fdk-aac:=[${MULTILIB_USEDEP}] )
	flite? ( app-accessibility/flite[${MULTILIB_USEDEP}] )
	fontconfig? ( media-libs/fontconfig:1.0[${MULTILIB_USEDEP}] )
	frei0r? ( media-plugins/frei0r-plugins[${MULTILIB_USEDEP}] )
	fribidi? ( dev-libs/fribidi[${MULTILIB_USEDEP}] )
	gcrypt? ( dev-libs/libgcrypt:0=[${MULTILIB_USEDEP}] )
	glslang? ( dev-util/glslang:=[${MULTILIB_USEDEP}] )
	gme? ( media-libs/game-music-emu[${MULTILIB_USEDEP}] )
	gmp? ( dev-libs/gmp:0=[${MULTILIB_USEDEP}] )
	gsm? ( media-sound/gsm[${MULTILIB_USEDEP}] )
	iconv? ( virtual/libiconv[${MULTILIB_USEDEP}] )
	iec61883? ( media-libs/libiec61883[${MULTILIB_USEDEP}]
		sys-libs/libraw1394[${MULTILIB_USEDEP}]
		sys-libs/libavc1394[${MULTILIB_USEDEP}] )
	ieee1394? ( media-libs/libdc1394:2=[${MULTILIB_USEDEP}]
		sys-libs/libraw1394[${MULTILIB_USEDEP}] )
	jack? ( virtual/jack[${MULTILIB_USEDEP}] )
	jpeg2k? ( media-libs/openjpeg:2[${MULTILIB_USEDEP}] )
	libaom? ( media-libs/libaom:=[${MULTILIB_USEDEP}] )
	libaribb24? ( media-libs/aribb24[${MULTILIB_USEDEP}] )
	libass? ( media-libs/libass:=[${MULTILIB_USEDEP}] )
	libcaca? ( media-libs/libcaca[${MULTILIB_USEDEP}] )
	libdrm? ( x11-libs/libdrm[${MULTILIB_USEDEP}] )
	libilbc? ( media-libs/libilbc:=[${MULTILIB_USEDEP}] )
	librtmp? ( media-video/rtmpdump[${MULTILIB_USEDEP}] )
	libsoxr? ( media-libs/soxr[${MULTILIB_USEDEP}] )
	libtesseract? ( app-text/tesseract:=[${MULTILIB_USEDEP}] )
	libv4l? ( media-libs/libv4l:=[${MULTILIB_USEDEP}] )
	libxml2? ( dev-libs/libxml2:=[${MULTILIB_USEDEP}] )
	lv2? ( media-libs/lv2[${MULTILIB_USEDEP}]
		media-libs/lilv[${MULTILIB_USEDEP}] )
	lzma? ( app-arch/xz-utils[${MULTILIB_USEDEP}] )
	modplug? ( media-libs/libmodplug[${MULTILIB_USEDEP}] )
	openal? ( media-libs/openal[${MULTILIB_USEDEP}] )
	opencl? ( virtual/opencl[${MULTILIB_USEDEP}] )
	opengl? ( virtual/opengl[${MULTILIB_USEDEP}] )
	opus? ( media-libs/opus[${MULTILIB_USEDEP}] )
	pulseaudio? ( media-libs/libpulse[${MULTILIB_USEDEP}] )
	qsv? ( media-libs/intel-mediasdk[${MULTILIB_USEDEP}] )
	rubberband? ( media-libs/rubberband[${MULTILIB_USEDEP}] )
	samba? ( net-fs/samba[client,${MULTILIB_USEDEP}] )
	sdl? ( media-libs/libsdl2[sound,video,${MULTILIB_USEDEP}] )
	sndio? ( media-sound/sndio:=[${MULTILIB_USEDEP}] )
	speex? ( media-libs/speex[${MULTILIB_USEDEP}] )
	srt? ( net-libs/srt:=[${MULTILIB_USEDEP}] )
	ssh? ( net-libs/libssh:=[sftp,${MULTILIB_USEDEP}] )
	svg? ( gnome-base/librsvg:2=[${MULTILIB_USEDEP}]
		x11-libs/cairo[${MULTILIB_USEDEP}] )
	nvenc? ( <media-libs/nv-codec-headers-12 )
	svt-av1? ( media-libs/svt-av1[${MULTILIB_USEDEP}] )
	truetype? ( media-libs/freetype:2[${MULTILIB_USEDEP}] )
	vaapi? ( media-libs/libva:0=[${MULTILIB_USEDEP}] )
	vdpau? ( x11-libs/libvdpau[${MULTILIB_USEDEP}] )
	vidstab? ( media-libs/vidstab[${MULTILIB_USEDEP}] )
	vmaf? ( media-libs/libvmaf[${MULTILIB_USEDEP}] )
	vorbis? ( media-libs/libvorbis[${MULTILIB_USEDEP}]
		media-libs/libogg[${MULTILIB_USEDEP}] )
	vpx? ( media-libs/libvpx:=[${MULTILIB_USEDEP}] )
	vulkan? ( media-libs/vulkan-loader:=[${MULTILIB_USEDEP}] )
	X? ( x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		x11-libs/libXv[${MULTILIB_USEDEP}]
		x11-libs/libxcb:=[${MULTILIB_USEDEP}] )
	zeromq? ( net-libs/zeromq:= )
	zimg? ( media-libs/zimg:=[${MULTILIB_USEDEP}] )
	zlib? ( sys-libs/zlib:=[${MULTILIB_USEDEP}] )
	zvbi? ( media-libs/zvbi[${MULTILIB_USEDEP}] )"
RDEPEND="${RDEPEND}
	openssl? ( dev-libs/openssl:0=[${MULTILIB_USEDEP}] )
	!openssl? ( gnutls? ( net-libs/gnutls:=[${MULTILIB_USEDEP}] ) )"
DEPEND="${RDEPEND}
	ladspa? ( media-libs/ladspa-sdk[${MULTILIB_USEDEP}] )
	v4l? ( sys-kernel/linux-headers )"

BDEPEND="dev-build/make
	virtual/pkgconfig
	cpu_flags_x86_mmx? ( || ( dev-lang/nasm dev-lang/yasm ) )
	cuda? ( sys-devel/clang[llvm_targets_NVPTX] )"

REQUIRED_USE="cuda? ( nvenc ) glslang? ( vulkan ) libv4l? ( v4l ) ${CPU_REQUIRED_USE}"
RESTRICT="test gpl? ( openssl? ( bindist ) fdk? ( bindist ) )"

PATCHES=( "${FILESDIR}"/chromium-r1.patch
	"${FILESDIR}/${MY_PN}"-5.0-backport-ranlib-build-fix.patch
	"${FILESDIR}/${MY_PN}"-4.4.3-get_cabac_inline_x86-32-bit.patch
	"${FILESDIR}/${MY_PN}"-4.4.4-wint-conversion-vulkan.patch
	"${FILESDIR}/${MY_PN}"-4.4.4-opencl-parallel-gmake-fix.patch )

build_separate_libffmpeg() {
	use opencl
}

src_prepare() {
	eapply "${FILESDIR}/vmaf-models-default-path.patch"

	default

	# -fdiagnostics-color=auto gets appended after user flags which
	# will ignore user's preference.
	sed -i -e '/check_cflags -fdiagnostics-color=auto/d' configure || die

	echo "include \$(SRC_PATH)/ffbuild/libffmpeg.mak" >> Makefile || die
}

multilib_src_configure() {
	local myconf=( )

	# only libraries needed
	myconf+=( --disable-programs )

	# bug 842201
	use ia64 && tc-is-gcc && append-flags \
		-fno-tree-ccp \
		-fno-tree-dominator-opts \
		-fno-tree-fre \
		-fno-code-hoisting \
		-fno-tree-pre \
		-fno-tree-vrp

	local ffuse=( "${FFMPEG_FLAG_MAP[@]}" )
	use openssl && myconf+=( --enable-nonfree )
	use samba && myconf+=( --enable-version3 )

	# Encoders
	if use encode ; then
		ffuse+=( "${FFMPEG_ENCODER_FLAG_MAP[@]}" )

		# Licensing.
		if use amrenc ; then
			myconf+=( --enable-version3 )
		fi
	else
		myconf+=( --disable-encoders )
	fi

	# Indevs
	use v4l || myconf+=( --disable-indev=v4l2 --disable-outdev=v4l2 )
	for i in alsa oss jack sndio ; do
		use "${i}" || myconf+=( --disable-indev="${i}" )
	done

	# Outdevs
	for i in alsa oss sndio ; do
		use "${i}" || myconf+=( --disable-outdev="${i}" )
	done

	# Decoders
	use amr && myconf+=( --enable-version3 )
	use gmp && myconf+=( --enable-version3 )
	use libaribb24 && myconf+=( --enable-version3 )
	use fdk && use gpl && myconf+=( --enable-nonfree )

	for i in "${ffuse[@]#+}" ; do
		myconf+=( "$(use_enable "${i%:*}" "${i#*:}")" )
	done

	if use openssl ; then
		myconf+=( --disable-gnutls )
	fi

	# CPU features
	for i in "${CPU_FEATURES_MAP[@]}" ; do
		use "${i%:*}" || myconf+=( --disable-"${i#*:}" )
	done

	if use pic ; then
		myconf+=( --enable-pic )
		# disable asm code if PIC is required
		# as the provided asm decidedly is not PIC for x86.
		[[ "${ABI}" == x86 ]] && myconf+=( --disable-asm )
	fi
	[[ "${ABI}" == x32 ]] && myconf+=( --disable-asm ) #427004

	# Try to get cpu type based on CFLAGS.
	# Bug #172723
	# We need to do this so that features of that CPU will be better used
	# If they contain an unknown CPU it will not hurt since ffmpeg's configure
	# will just ignore it.
	for i in "$(get-flag mcpu)" "$(get-flag march)" ; do
		[[ "${i}" = native ]] && i="host" # bug #273421
		myconf+=( --cpu="${i}" )
		break
	done

	# LTO support, bug #566282, bug #754654, bug #772854
	[[ "${ABI}" != x86 ]] && tc-is-lto && myconf+=( "--enable-lto" )
	filter-lto

	# cross compile support
	if tc-is-cross-compiler ; then
		myconf+=( --enable-cross-compile --arch="$(tc-arch-kernel)" --cross-prefix="${CHOST}"- --host-cc="$(tc-getBUILD_CC)" )
		case "${CHOST}" in
			*mingw32*)
				myconf+=( --target-os=mingw32 )
				;;
			*linux*)
				myconf+=( --target-os=linux )
				;;
		esac
	fi

	set -- "${S}/configure" \
		--prefix="${EPREFIX}/usr" \
		--libdir="${EPREFIX}/usr/$(get_libdir)" \
		--shlibdir="${EPREFIX}/usr/$(get_libdir)" \
		--enable-shared \
		--disable-static \
		--disable-doc \
		--cc="$(tc-getCC)" \
		--cxx="$(tc-getCXX)" \
		--ar="$(tc-getAR)" \
		--nm="$(tc-getNM)" \
		--strip="$(tc-getSTRIP)" \
		--ranlib="$(tc-getRANLIB)" \
		--pkg-config="$(tc-getPKG_CONFIG)" \
		--optflags="${CFLAGS}" \
		--enable-avfilter \
		--enable-avresample \
		--disable-stripping \
		--disable-optimizations \
		--disable-libcelt \
		"${myconf[@]}"
	echo "${@}"
	"${@}" || die
}

multilib_src_compile() {
	emake V=1
}

multilib_src_install() {
	emake V=1 DESTDIR="${D}" install-libs
}

multilib_src_install_all() {
	find "${ED}" -type l -name "*.so" -exec rm -rv {} + || die "symlinks removing failed"
}
