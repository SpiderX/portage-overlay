# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop pax-utils unpacker xdg

DESCRIPTION="Automatic music tagger"
HOMEPAGE="https://flavio.tordini.org/finetune"
SRC_URI="https://flavio.tordini.org/files/${PN}/${PN}.deb -> ${P}.deb"
S="${WORKDIR}"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist mirror"

RDEPEND="dev-qt/qtcore:5
	dev-qt/qtdbus:5
	dev-qt/qtdeclarative:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	media-libs/chromaprint:=[tools]
	media-libs/taglib"

QA_PREBUILT="usr/bin/finetune"

src_prepare() {
	default

	sed -i '/Categories/s/Qt;/Qt;AudioVideo;/' \
		usr/share/applications/finetune.desktop \
		|| die "sed failed for finetune.desktop"
}

src_install() {
	dobin usr/bin/finetune
	pax-mark m "${ED}"/usr/bin/finetune

	domenu usr/share/applications/finetune.desktop

	newicon -s scalable usr/share/icons/hicolor/scalable/apps/finetune.svg \
		finetune.svg
	for size in 16x16 22x22 32x32 48x48 64x64 128x128 256x256 512x512 ; do
		newicon -s "${size%%x*}" usr/share/icons/hicolor/"${size}"/apps/finetune.png \
			finetune.png
	done
	dosym ../icons/hicolor/512x512/apps/finetune.png \
		/usr/share/pixmaps/finetune.png

	insinto /usr/share/menu
	doins usr/share/menu/finetune
}
