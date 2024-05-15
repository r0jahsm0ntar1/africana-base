#!/usr/bin/env python3 
# -*- coding: utf-8 -*-"
"""
This file is part of the UFONet project, https://ufonet.03c8.net

Copyright (c) 2013/2020 | psy <epsylon@riseup.net>

You should have received a copy of the GNU General Public License along
with UFONet; if not, write to the Free Software Foundation, Inc., 51
Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
"""
from random import randrange

class RandomIP(object):
    """
    Class to generate random valid IP's
    """
    def _generateip(self, string):
        notvalid = [10, 127, 169, 172, 192]
        first = randrange(1, 256)
        while first is notvalid:
            first = randrange(1, 256)
        _ip = ".".join([str(first), str(randrange(1, 256)),
        str(randrange(1, 256)), str(randrange(1, 256))])
        return _ip
