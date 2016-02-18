# Copyright (c) 2016, Arkadiusz Drabczyk, arkadiusz@drabczyk.org
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# * Redistributions of source code must retain the above copyright
#   notice, this list of conditions and the following disclaimer.
# * Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
# * Neither the name of the <organization> nor the
#   names of its contributors may be used to endorse or promote products
#   derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
# <COPYRIGHT HOLDER> BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF
# USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT
# OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

# bm.sh: extract POSIX compliant bookmarking system for shell

bm_config=~/.bmrc

# bm
_bm_find()
{
    string=$(grep " $1$" "$bm_config" 2>/dev/null)

    if [ -z "$string" ]
    then
	echo No such bookmark: "$1"
	return 1
    fi

    dir=$(echo "$string" | sed "s, $1$,,")

    if [ -n "$2" ]
    then
	cd "$dir" || return 2
    fi

    return 0
}

_bm_add()
{
    if [ -z "$1" ]
    then
	echo Name of bookmark to add missing
	return 3
    fi

    if _bm_find "$1" >/dev/null 2>&1
    then
	echo Bookmark already exists
	return 4
    fi

    # validate
    if echo "$1" | grep -qE '^[a-zA-Z0-9_]+$'
    then
	echo "$PWD" "$1" >> "$bm_config"
    else
	echo "bookmark name can only contain [a-zA-Z0-9_]"
	return 5
    fi
}

_bm_rm()
{
    if [ -z "$1" ]
    then
	echo Name of bookmark to remove missing
	return 6
    fi

    _bm_find "$1" >/dev/null 2>&1
    if [ $? -eq 1 ]
    then
	echo No such bookmark: "$1"
	return 7
    fi

    sed -i "/ $1$/d" "$bm_config"
}

_bm_list()
{
    if ! cat "$bm_config" 2>/dev/null
    then
	echo Unable to read "$bm_config". You probably have no bookmarks added.
	return 8
    fi
}

bm()
{
    if [ $# -eq 0 ]
    then
	echo Argument missing
	return 9
    fi
    case "$1" in
	add )
	    shift
            _bm_add "$1";;
	rm )
	    shift
	    _bm_rm "$1";;
	ls )
            _bm_list;;
	* )
	    _bm_find "$1" 1;;
    esac
}
