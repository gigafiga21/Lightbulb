#!/bin/bash
# Simple script to list version numbers of critical development tools
# Got from LFS book v9.1, chapter 2

if [ `command -v busybox` ]; then
    # BusyBox version if it installed
    # Is using in checkCommand function
    BUSYBOX=`busybox 2>&1 | head -n 1 | cut -d ' ' -f 1-2`;
fi

# Displays info about shell command
# {String} $1 - command name
# {String} $2 - expected version
# {String} $3 - actual version
function checkCommand {
    if [[ -n "$BUSYBOX" && `busybox 2>&1 | grep -i $1` ]]; then
        printf "+ $1 found\n";
        printf "  Expected version: >= $2\n";
        printf "  Found version: $BUSYBOX\n";
    elif [ `command -v $1` ]; then
        printf "+ $1 found\n";
        printf "  Expected version: >= $2\n";
        printf "  Found version: ";
        eval $3;
    else
        printf -- "- $1 not found\n";
        return 1;
    fi

    return 0;
}

# bash
VERSION="bash --version | head -n1 | cut -d\" \" -f2-4";
checkCommand bash 3.2 "$VERSION";
if [ -n `readlink -f /bin/sh | grep -q bash` ]; then
    printf "  ERROR: /bin/sh should be a symbolic or hard link to bash\n";
fi

# binutils
VERSION="ld --version | head -n1 | cut -d\" \" -f3-";
checkCommand ld 2.25 "$VERSION";

# bison
VERSION="bison --version | head -n1";
checkCommand bison 2.7 "$VERSION";
if [ $? == 0 ]; then
    if [ -x /usr/bin/yacc ]; then
        printf "  WARNING: yacc is `/usr/bin/yacc --version | head -n1`";
    elif [[ -h /usr/bin/yacc && `readlink -f /usr/bin/yacc` != `command -v bison` ]]; then
        printf "  ERROR: /usr/bin/yacc should be a link to bison\n";
    else
        printf "  ERROR: yacc not found\n";
    fi
fi

# bzip2
VERSION="bzip2 --version 2>&1 < /dev/null | head -n1 | cut -d\" \" -f1,6-";
checkCommand bzip2 1.0.4 "$VERSION";

# coreutils
VERSION="chown --version | head -n1 | cut -d\")\" -f2";
checkCommand chown 6.9 "$VERSION";

# diffutils
VERSION="diff --version | head -n1";
checkCommand diff 2.8.1 "$VERSION";

# findutils
VERSION="find --version | head -n1";
checkCommand find 4.2.31 "$VERSION";

# gawk
VERSION="gawk --version | head -n1";
checkCommand gawk 4.0.1 "$VERSION";
if [ $? == 0 ]; then
    if [ -x /usr/bin/awk ]; then
        printf "  WARNING: awk is `/usr/bin/awk --version | head -n1`\n";
    elif [[ -h /usr/bin/awk && `readlink -f /usr/bin/awk` != `command -v gawk` ]]; then
        printf "  ERROR: /usr/bin/awk should be a link to gawk\n";
    else 
        printf "  ERROR: awk not found\n";
    fi
fi

# gcc
VERSION="gcc --version | head -n1";
checkCommand gcc 6.2 "$VERSION";

# g++
VERSION="g++ --version | head -n1";
checkCommand g++ 6.2 "$VERSION";
if [ $? == 0 ]; then
    echo 'int main(){}' > dummy.c && g++ -o dummy dummy.c;
    if [ -x dummy ]; then
        printf "  Additional info: g++ compilation OK\n";
    else
        printf "  ERROR: g++ test compilation failed\n";
    fi
    rm -f dummy.c dummy
fi

# glibc
VERSION="ldd --version 2>&1 | head -n2 | sed 'N;s/\n/, /g'";
checkCommand ldd 2.11 "$VERSION";

# grep
VERSION="grep --version | head -n1";
checkCommand grep 2.5.1a "$VERSION";

# gzip
VERSION="gzip --version | head -n1";
checkCommand gzip 1.3.12 "$VERSION";

# Linux kernel
printf "+ Linux kernel\n";
printf "  Expected version: >= 3.2\n";
printf "  Found version: ";
cat /proc/version

# m4
VERSION="m4 --version | head -n1";
checkCommand m4 1.4.10 "$VERSION";

# make
VERSION="make --version | head -n1";
checkCommand make 4.0 "$VERSION";

# perl
VERSION="echo Perl \`perl -V:version\`";
checkCommand perl 5.8.8 "$VERSION";

# python3
VERSION="python3 --version";
checkCommand python3 3.4 "$VERSION";

# sed
VERSION="sed --version | head -n1";
checkCommand sed 4.1.5 "$VERSION";

# tar
VERSION="tar --version | head -n1";
checkCommand tar 1.22 "$VERSION";

# texinfo
VERSION="makeinfo --version | head -n1";
checkCommand makeinfo 4.7 "$VERSION";

# xz
VERSION="xz --version | head -n1";
checkCommand xz 5.0.0 "$VERSION";
