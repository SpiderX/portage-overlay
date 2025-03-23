# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop toolchain-funcs xdg

DESCRIPTION="A lightweight text editor written in Lua"
HOMEPAGE="https://github.com/rxi/lite"
SRC_URI="https://github.com/rxi/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-libs/libsdl2"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}"-paths.patch )

src_prepare() {
	default

	# Respect flags, verbose build
	sed -i  -e '/cflags="-/s/-O3 -g //' \
		-e '/^cflags=/s/"/"$CFLAGS /' \
		-e '/^lflags=/s/"/"$LDFLAGS /' \
		-e "s/compiler=\"gcc\"/compiler=\"$(tc-getCC)\"/" \
		-e 's/$compiler -c/$compiler -v -c/' \
		-e "/o \$lflags/s/\$compiler/$(tc-getCC)/" build.sh \
			|| die "sed failed for build.sh"
}

src_compile() {
	./build.sh || die "build.sh failed"
}

src_install() {
	einstalldocs
	dobin lite
	insinto /usr/share/lite
	doins -r data/.
	doicon "${FILESDIR}"/lite.png
	doicon -s 64 "${FILESDIR}"/lite.png
	make_desktop_entry lite Lite "" "TextEditor;Development;IDE"
}
