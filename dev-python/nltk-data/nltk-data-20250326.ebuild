# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit check-reqs

DESCRIPTION="Data files for NLTK"
HOMEPAGE="https://www.nltk.org/nltk_data/"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
RESTRICT="bindist mirror"

BDEPEND="app-arch/unzip"

PACKAGES_ZIP=(
	corpora/bcp47
	corpora/comtrans
	corpora/conll2007
	corpora/extended_omw
	corpora/jeita
	corpora/knbc
	corpora/machado
	corpora/masc_tagged
	corpora/nombank.1.0
	corpora/omw
	corpora/omw-1.4
	corpora/panlex_swadesh
	corpora/propbank
	corpora/reuters
	corpora/semcor
	corpora/universal_treebanks_v20
	corpora/wordnet
	corpora/wordnet2021
	corpora/wordnet31
	sentiment/vader_lexicon
	stemmers/snowball_data
)

PACKAGES_UNPACK=(
	chunkers/maxent_ne_chunker
	chunkers/maxent_ne_chunker_tab
	corpora/abc
	corpora/alpino
	corpora/biocreative_ppi
	corpora/brown
	corpora/brown_tei
	corpora/cess_cat
	corpora/cess_esp
	corpora/chat80
	corpora/city_database
	corpora/cmudict
	corpora/comparative_sentences
	corpora/conll2000
	corpora/conll2002
	corpora/crubadan
	corpora/dependency_treebank
	corpora/dolch
	corpora/english_wordnet
	corpora/europarl_raw
	corpora/floresta
	corpora/framenet_v15
	corpora/framenet_v17
	corpora/gazetteers
	corpora/genesis
	corpora/gutenberg
	corpora/ieer
	corpora/inaugural
	corpora/indian
	corpora/kimmo
	corpora/lin_thesaurus
	corpora/mac_morpho
	corpora/movie_reviews
	corpora/mte_teip5
	corpora/names
	corpora/nonbreaking_prefixes
	corpora/nps_chat
	corpora/opinion_lexicon
	corpora/paradigms
	corpora/pe08
	corpora/pil
	corpora/pl196x
	corpora/ppattach
	corpora/problem_reports
	corpora/product_reviews_1
	corpora/product_reviews_2
	corpora/pros_cons
	corpora/ptb
	corpora/qc
	corpora/rte
	corpora/senseval
	corpora/sentence_polarity
	corpora/sentiwordnet
	corpora/shakespeare
	corpora/sinica_treebank
	corpora/smultron
	corpora/state_union
	corpora/stopwords
	corpora/subjectivity
	corpora/swadesh
	corpora/switchboard
	corpora/timit
	corpora/toolbox
	corpora/treebank
	corpora/twitter_samples
	corpora/udhr
	corpora/udhr2
	corpora/unicode_samples
	corpora/verbnet
	corpora/verbnet3
	corpora/webtext
	corpora/wordnet2022
	corpora/wordnet_ic
	corpora/words
	corpora/ycoe
	grammars/basque_grammars
	grammars/book_grammars
	grammars/large_grammars
	grammars/sample_grammars
	grammars/spanish_grammars
	help/tagsets
	help/tagsets_json
	misc/mwa_ppdb
	misc/perluniprops
	models/bllip_wsj_no_aux
	models/moses_sample
	models/wmt15_eval
	models/word2vec_sample
	stemmers/porter_test
	stemmers/rslp
	taggers/averaged_perceptron_tagger
	taggers/averaged_perceptron_tagger_eng
	taggers/averaged_perceptron_tagger_ru
	taggers/averaged_perceptron_tagger_rus
	taggers/maxent_treebank_pos_tagger
	taggers/maxent_treebank_pos_tagger_tab
	taggers/universal_tagset
	tokenizers/punkt
	tokenizers/punkt_tab
)

add_data() {
	local data="${1}"

	for data ; do
		SRC_URI+="
			https://raw.githubusercontent.com/nltk/nltk_data/gh-pages/packages/${data}.zip
				-> nltk-${data#*/}-${PV}.zip"
	done
}

add_data "${PACKAGES_ZIP[@]}" "${PACKAGES_UNPACK[@]}"

CHECKREQS_DISK_USR=3G
CHECKREQS_DISK_BUILD=${CHECKREQS_DISK_USR}

unpack_data() {
	local data="${1}"

	for data ; do
		local cat="${data%/*}"
		local pkg="${data#*/}"

		mkdir -p "${S}/${cat}" || die
		cd "${S}/${cat}" || die
		unpack "nltk-${pkg}-${PV}.zip"
	done
}

src_unpack() {
	unpack_data "${PACKAGES_UNPACK[@]}"
}

install_zips() {
	local data="${1}"

	for data ; do
		local cat="${data%/*}"
		local pkg="${data#*/}"

		insinto "/usr/share/nltk_data/${cat}"
		newins "${DISTDIR}/nltk-${pkg}-${PV}.zip" "${pkg}.zip"
	done
}

src_install() {
	dodir /usr/share/nltk_data
	mv ./* "${ED}/usr/share/nltk_data" || die

	install_zips "${PACKAGES_ZIP[@]}"
}
