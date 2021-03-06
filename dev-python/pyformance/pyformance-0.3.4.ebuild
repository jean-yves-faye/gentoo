# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{2_7,3_{4,5}} )

inherit distutils-r1

DESCRIPTION="Performance metrics, based on Coda Hale's Yammer metrics"
HOMEPAGE="https://pyformance.readthedocs.org/ https://github.com/omergertel/pyformance/ https://pypi.python.org/pypi/pyformance/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/pytest[${PYTHON_USEDEP}]
			dev-python/mock[${PYTHON_USEDEP}] )"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

python_prepare() {
	sed -i -e "s/find_packages()/find_packages(exclude=['tests'])/" setup.py || die
	sed -i -e "s/URLError, err/URLError as err/" ${PN}/reporters/influx.py || die
}

python_test() {
	py.test || die
}
