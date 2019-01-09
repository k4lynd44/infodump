#!/bin/bash

#cwd=$(pwd)
cwd=$HOME

# read the options
#TEMP=`getopt -o a::bc: --long arga::,argb,argc: -n 'infodump.sh' -- "$@"`
#eval set -- "$TEMP"





if [ -e /etc/debian_version ]; then
OS="Debian `cat /etc/debian_version`"
elif [ -e /etc/redhat-release ]; then
OS=`cat /etc/redhat-release`
elif [ -e /etc/SuSE-release ]; then
OS=`cat /etc/SuSE-release |head -n1`
elif [ -e /etc/gentoo-release ]; then
OS=`< /etc/gentoo-release`
else
OS='unknown'
fi

if [[ $# -eq 0 ]] ; then
	echo "Few arguments: enter -h to show menu"
	exit 0
fi

while test $# -gt 0; do

		

	case "$1" in
		-h|--help) 
			echo "Usage: "
			echo "-f shows structure of filesystem" 
			echo "-of shows all files without hidden files"
			echo "-hof shows all files including hidden files"
			echo "-p shows all installed packages"
			echo "-ap shows all active process"
			echo "-all execute all commands --- max depth is 3 "
			exit 0
		        ;;
#Shows structure of filesystem at the chosen depth level
		-f)
		    echo "Set the depth level"	
		    read choice	
		    (find . -maxdepth $choice > $cwd/filesystemStructure.txt) &>/dev/null
		    echo "Completed"
		    shift
		    ;;	
#Shows all files at the chocen depth level
		-of)
			echo "Set the depth level"	
		        read choice	
			(find . -maxdepth $choice -type f > $cwd/allFilesWithoutHidden.txt) &>/dev/null
			echo "Completed"
			shift
			;;

		-hof)
			(ls -paR / | grep -v / > $cwd/allFiles.txt) &>/dev/null
			echo "Completed"
			shift
			;;

		-p)
			if [[ $OS =~ "Debian" ]]
			then
				dpkg --list > $cwd/allAInstalledPkg.txt
				echo "Completed"
				
			elif [[ $OS =~ "RedHat" || $OS =~ "Fedora" || $OS =~ "CentOS" ]]
				echo "Completed"
			then
				rpm -qa > $cwd/allAInstalledPkg.txt
			elif [[ $OS =~ "Gentoo" ]]
			then
				ls -d /var/db/pkg/*/*| cut -f5- -d/ > $cwd/allAInstalledPkg.txt
				echo "Completed"
			else
				echo "OS is unknow" 
			fi
			shift
			;;	
		-ap)
			ps -ux > $cwd/allActiveProcess.txt
			echo "Completed"
			shift
			;;
		-all)
			(find . -maxdepth 3 > $cwd/filesystemStructure.txt) &>/dev/null	
			(find . -maxdepth 3 -type f > $cwd/allFilesWithoutHidden.txt) &>/dev/null
			if [[ $OS =~ "Debian" ]]
			then
				dpkg --list > $cwd/allAInstalledPkg.txt
				
				
			elif [[ $OS =~ "RedHat" || $OS =~ "Fedora" || $OS =~ "CentOS" ]]
			then
				rpm -qa > $cwd/allAInstalledPkg.txt
			elif [[ $OS =~ "Gentoo" ]]
			then
				ls -d /var/db/pkg/*/*| cut -f5- -d/ > $cwd/allAInstalledPkg.txt
			else
				echo "OS is unknow"	
			fi
		
			ps -ux > $cwd/allActiveProcess.txt
			echo "Completed"
			shift
			;;

		*)
			echo "Invalid option"
			break
			;;
	esac
done
