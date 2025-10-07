#!/bin/bash
# A script to list version numbers of critical development tools and do some additional checks
# From : https://www.linuxfromscratch.org/lfs/view/stable-systemd/chapter02/hostreqs.html

GREEN="\e[32m"
UNDERLINE="\e[4m"
ENDCOLOR="\e[0m"

LC_ALL=C 
#PATH=/usr/bin:/bin

grep --version > /dev/null 2> /dev/null || bail "grep does not work"
sed '' /dev/null || bail "sed does not work"
sort   /dev/null || bail "sort does not work"

bail() { echo "FATAL: $1"; exit 1; }

version_check()
{
  if ! type -p $2 &>/dev/null
  then 
    echo "ERROR: Cannot find $2 ($1)"; return 1; 
  fi
  v=$($2 --version 2>&1 | grep -E -o '[0-9]+\.[0-9\.]+[a-z]*' | head -n1)
  if printf '%s\n' $3 $v | sort --version-sort --check &>/dev/null
  then 
    printf "OK:    %-9s %-6s >= $3\n" "$1" "$v"; return 0;
  else 
    printf "ERROR: %-9s is TOO OLD ($3 or later required)\n" "$1"; 
    return 1; 
  fi
}

echo -e "${GREEN}[Version Check]${ENDCOLOR}"
# Coreutils first because --version-sort needs Coreutils >= 7.0
version_check Coreutils      sort     8.1 || bail "Coreutils too old, stop"
version_check Bash           bash     3.2
version_check Binutils       ld       2.13.1
version_check Bison          bison    2.7
version_check Diffutils      diff     2.8.1
version_check Findutils      find     4.2.31
version_check Gawk           gawk     4.0.1
version_check GCC            gcc      5.4
version_check "GCC (C++)"    g++      5.4
version_check Grep           grep     2.5.1a
version_check Gzip           gzip     1.3.12
version_check M4             m4       1.4.10
version_check Make           make     4.0
version_check Patch          patch    2.5.4
version_check Perl           perl     5.8.8
version_check Python         python3  3.4
version_check Sed            sed      4.1.5
version_check Tar            tar      1.22
version_check Texinfo        texi2any 5.0
version_check Xz             xz       5.0.0
echo

alias_check() {
  if $1 --version 2>&1 | grep -qi $2
  then printf "OK:    %-4s is $2\n" "$1";
  else printf "ERROR: %-4s is NOT $2\n" "$1"; fi
}

echo -e "${GREEN}[Alias Check]${ENDCOLOR}"
alias_check sh Bash
alias_check awk GNU
alias_check yacc Bison
echo

echo -e "${GREEN}[Compiler Check]${ENDCOLOR}"
if printf "int main(){}" | gcc -x c -
then echo "OK:    gcc works";
else echo "ERROR: gcc does NOT work"; fi
rm -f a.out
if printf "int main(){}" | g++ -x c++ -
then echo "OK:    g++ works";
else echo "ERROR: g++ does NOT work"; fi
rm -f a.out
echo

kernel_check()
{
  kver=$(uname -r | grep -E -o '^[0-9\.]+')
  if printf '%s\n' $1 $kver | sort --version-sort --check &>/dev/null
  then 
    printf "OK:    Linux Kernel $kver >= $1\n"; return 0;
  else 
    printf "ERROR: Linux Kernel ($kver) is TOO OLD ($1 or later required)\n" "$kver"; 
    return 1; 
  fi
}

echo -e "${GREEN}[Kernel Check]${ENDCOLOR}"
kernel_check 5.4
echo

echo -e "${GREEN}[Core Check]${ENDCOLOR}"
if [ "$(nproc)" = "" ]; then
  echo "ERROR: nproc is not available or it produces empty output"
else
  echo "OK: nproc reports $(nproc) logical cores are available"
fi
echo
