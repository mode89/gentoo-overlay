# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MY_P="${PN}-v${PV}"

DESCRIPTION="A Free Toolkit for developing mapping applications"
HOMEPAGE="http://www.mapnik.org/"
SRC_URI="http://mapnik.s3.amazonaws.com/dist/v${PV}/${MY_P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
