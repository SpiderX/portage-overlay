# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
WEBAPP_NO_AUTO_INSTALL="yes"
WEBAPP_MANUAL_SLOT="yes"

inherit python-r1 webapp

DESCRIPTION="IP address management (IPAM) and data center infrastructure management (DCIM)"
HOMEPAGE="https://github.com/digitalocean/netbox"
SRC_URI="https://github.com/digitalocean/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DOCS=( README.md CONTRIBUTING.md )
RDEPEND=">=dev-python/django-1.9[${PYTHON_USEDEP}]
	>=dev-python/cryptography-1.3[${PYTHON_USEDEP}]
	>=dev-python/django-debug-toolbar-1.4[${PYTHON_USEDEP}]
	>=dev-python/django-filter-0.13[${PYTHON_USEDEP}]
	>=dev-python/django-tables2-1.1.2[${PYTHON_USEDEP}]
	>=dev-python/django-rest-swagger-0.3.8[${PYTHON_USEDEP}]
	>=dev-python/django-rest-framework-3.2.1[${PYTHON_USEDEP}]
	>=dev-python/graphviz-0.4.4[${PYTHON_USEDEP}]
	dev-python/markdown[${PYTHON_USEDEP}]
	>=dev-python/ncclient-0.5.2[${PYTHON_USEDEP}]
	dev-python/netaddr[${PYTHON_USEDEP}]
	dev-python/paramiko[${PYTHON_USEDEP}]
	dev-python/psycopg:2[${PYTHON_USEDEP}]
	>=dev-python/py-gfm-0.1.1[${PYTHON_USEDEP}]
	dev-python/pycrypto[${PYTHON_USEDEP}]
	dev-python/python-sqlparse[${PYTHON_USEDEP}]
	dev-python/xmltodict[${PYTHON_USEDEP}]
	dev-python/natsort[${PYTHON_USEDEP}]"

pkg_setup() {
	python_setup
	webapp_pkg_setup
}

src_install() {
	webapp_src_preinst

	insinto "${MY_HTDOCSDIR}"
	doins -r ${PN}/

	webapp_configfile "${MY_HTDOCSDIR}"/netbox/configuration.example.py
	webapp_src_install
}

pkg_config() {
	einfo "Enter you vhost_root/vhost_htdocs. Default: localhost/htdocs"
	read answer
	PATH="${ROOT}"/var/www/"${answer}"/${PN}
	unset answer

	if [ -f "${PATH}/${PN}/configuration.py" ] ; then
		einfo "Applies database migrations from ${PATH} ?"
		einfo
		while [ "$correct" != "true" ] ; do
			einfo "Are you ready to continue? (y/n)"
			read answer
			if [[ $answer =~ ^[Yy]([Ee][Ss])?$ ]] ; then
				correct="true"
			elif [[ $answer =~ ^[Nn]([Oo])?$ ]] ; then
				die "Aborting migration."
			else
				echo "Answer not recognized"
			fi
		done
	# Apply database migrations
	"${PATH}"/manage.py migrate
	fi
}
