# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-utils

DESCRIPTION="FORTRAN reference implementation of LAPACK Linear Algebra PACKage"
HOMEPAGE="http://www.netlib.org/lapack/index.html"
SRC_URI="http://www.netlib.org/lapack/lapack-3.6.1.tgz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/lapack-3.6.1"

src_configure() {
	local mycmakeargs=(
		-DCBLAS=ON
		-DBUILD_SHARED_LIBS=ON
		-DBUILD_STATIC_LIBS=OFF
		-DBUILD_TESTING=OFF
		-DLAPACKE=ON
	)

	cmake-utils_src_configure
}
