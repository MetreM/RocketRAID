# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils linux-mod

MY_P=rr231x_0x-linux-src-v${PV}-091022-1618
DESCRIPTION="Kernel Module for the HighPoint RocketRaid 232x RAID Adapter"
HOMEPAGE="http://www.highpoint-tech.com"
SRC_URI="http://www.highpoint-tech.com/BIOS_Driver/rr231x_00/Linux/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="app-text/dos2unix"

S=${WORKDIR}
MY_S="${S}/rr231x_0x-linux-src-v2.5"

BUILD_TARGETS=""
BUILD_TARGET_ARCH="${ARCH}"
MODULE_NAMES="rr2310_00(block:${MY_S}/product/rr2310pm/linux:${MY_S}/product/rr2310pm/linux)"

src_unpack() {
	unpack ${A}
	cd "${MY_S}"
	dos2unix -ascii inc/linux/Makefile.def
	epatch "${FILESDIR}"/rr231x_0x-linux-src-v2.5-kernel-3.11.patch
	linux-mod_pkg_setup
	BUILD_PARMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR}"
}

src_compile() {
	cd ${MY_S}/product/rr2310pm/linux
	emake || die
}

src_install() {
	linux-mod_src_install
}

pkg_postinst() {
	linux-mod_pkg_postinst
	elog "Please add \"rr2310_00\" to:"
	elog "/etc/conf.d/modules"
}
