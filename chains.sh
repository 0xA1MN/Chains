#!/bin/bash

echo "   ____ _           _             	 " 
echo "  / ___| |__   __ _(_)_ __  ___   	 "
echo " | |   | '_ \ / _\` | | '_ \/ __|  	 "
echo " | |___| | | | (_| | | | | \__ \_ 	 "
echo "  \____|_| |_|\__,_|_|_| |_|___(_) by A1MN."
echo "                       		 	 "

# notify discord config @ ~/.config/notify/provider-config.yaml

# stop all on ctrl+c
trap "exit" INT
# -------------------------- Assets Identifying - Subdomains --------------------------
subdomains(){
	echo "[+] Playing With Subdomains"
	# crt.sh
	while read line
	    do curl -s "https://crt.sh/?q=$line&output=json" | jq '.[].name_value' | sed 's/\"//g' | sed 's/\*.//g' | sed 's/\\/\n/g' | sort -u
	done < /tmp/pure_scope.txt | httpx -silent >> ~/$outFolder/Assets_Identifying/subdomains/separated/crtsh.live
	echo "    Crt.sh 				@ ~/$outFolder/Assets_Identifying/subdomains/separated/crtsh.live"
	# echo "Crt.sh Done" | notify -id general -silent

	# assetfinder
	while read line
	        do assetfinder -subs-only $line
	done < /tmp/pure_scope.txt | httpx -silent >> ~/$outFolder/Assets_Identifying/subdomains/separated/assetfinder.live
	echo "    Assetfinder 			@ ~/$outFolder/Assets_Identifying/subdomains/separated/Assetfinder.live"
	# echo "Assetfinder Done" | notify -id general -silent

	# subfinder
	subfinder -silent -dL /tmp/pure_scope.txt | httpx -silent >> ~/$outFolder/Assets_Identifying/subdomains/separated/subfinder.live
	echo "    Subfinder 				@ ~/$outFolder/Assets_Identifying/subdomains/separated/subfinder.live"
	# echo "Subfinder Done" | notify -id general -silent

	# amass enum passive 
	amass enum -passive -df /tmp/pure_scope.txt | httpx -silent >> ~/$outFolder/Assets_Identifying/subdomains/separated/amass_enum_passive.live
	echo "    Amass Enum Passive 			@ ~/$outFolder/Assets_Identifying/subdomains/separated/amass_enum_passive.live"
	# echo "Amass Enum Passive Done" | notify -id general -silent

	# amass enum active
	amass enum -active -brute -w ./wordlists/dns/subdomains-top1million-20000.txt -df /tmp/pure_scope.txt | httpx -silent >> ~/$outFolder/Assets_Identifying/subdomains/separated/amass_enum_active.live
	echo "    Amass Enum Active 			@ ~/$outFolder/Assets_Identifying/subdomains/separated/amass_enum_active.live"
	# echo "Amass Enum Active Done" | notify -id general -silent

	# warp-up all subs
	cat ~/$outFolder/Assets_Identifying/subdomains/separated/*.live | sort -u > ~/$outFolder/Assets_Identifying/subdomains/subs.live
	cat ~/$outFolder/Assets_Identifying/subdomains/subs.live | httpx -follow-redirects -silent > ~/$outFolder/Assets_Identifying/subdomains/subs.live.redirection
	echo "    All Live Subs 			@ ~/$outFolder/Assets_Identifying/subdomains/subs.live"
	# echo "All Live Subs Done" | notify -id general -silent
	echo "    Final Destination 			@ ~/$outFolder/Assets_Identifying/subdomains/subs.live.redirection"
	# echo "Final Destination Done" | notify -id general -silent

	# screening live subs
	gowitness file -f ~/$outFolder/Assets_Identifying/subdomains/subs.live -P ~/$outFolder/Assets_Identifying/goWitness.subs 1>/dev/null
	echo "    GoWitness 				@ ~/$outFolder/Assets_Identifying/goWitness.subs"
	# echo "GoWitness Done" | notify -id general -silent
}
# ---------------------------- Content Gathering - Spidering ----------------------------
Spidering(){
	# gospider
	echo "[+] Spidering"
	gospider -S ~/$outFolder/Assets_Identifying/subdomains/subs.live -o ~/$outFolder/Content_Gathering/spidering -c 10 -d 3 -t 20  1>/dev/null
	echo "    GoSpider						@ ~/$outFolder/Content_Gathering/spidering"
	# echo "GoSpider Done" | notify -id general -silent
}
# ---------------------------- Content Gathering - params ----------------------------
params(){
	arjun -T 10 -i ~/$outFolder/Assets_Identifying/subdomains/subs.live -oB ~/$outFolder/Content_Gathering/params/127.0.0.1:8080 -oT ~/$outFolder/Content_Gathering/params/result.txt 1>/dev/null
	echo "    Arjun						@ ~/$outFolder/Content_Gathering/params/"
	# echo "Arjun Done" | notify -id general -silent
}
# ----------------------- Content Gathering - URLS ----------------------------
waybackurls(){
	echo "[+] Playing With URLs"
	# waybackurls
	for i in $(cat ~/$outFolder/Assets_Identifying/subdomains/subs.live); do
	  	waybackurls $i >> ~/$outFolder/Content_Gathering/waybackurls/waybackurls.pure 	
		echo "$i" | gau >> ~/$outFolder/Content_Gathering/waybackurls/waybackurls.pure
		echo "$i" | hakrawler -subs >> ~/$outFolder/Content_Gathering/waybackurls/waybackurls.pure
	done
	echo "    Waybackurls Pure			@ ~/$outFolder/Content_Gathering/waybackurls/waybackurls.pure"
	# echo "Waybackurls Pure Done" | notify -id general -silent

	# grep available endpoint
	cat ~/$outFolder/Content_Gathering/waybackurls/waybackurls.pure | grep = | qsreplace -a > ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq
	echo "    Smart Endpoints			@ ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq"
	# echo "Smart Endpoints Done" | notify -id general -silent

	# grep possible vulnerable files by gf 
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf ssrf > ~/$outFolder/Content_Gathering/vulnerable.URLs/ssrf 
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf sqli > ~/$outFolder/Content_Gathering/vulnerable.URLs/sqli
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf xss > ~/$outFolder/Content_Gathering/vulnerable.URLs/xss
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf lfi > ~/$outFolder/Content_Gathering/vulnerable.URLs/lfi
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf idor > ~/$outFolder/Content_Gathering/vulnerable.URLs/idor
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf redirect > ~/$outFolder/Content_Gathering/vulnerable.URLs/redirect
	cat ~/$outFolder/Content_Gathering/waybackurls/endpoints.qs.eq | gf rce > ~/$outFolder/Content_Gathering/vulnerable.URLs/rce
	echo "    Vulnerable URLs			@ ~/$outFolder/Content_Gathering/vulnerable.URLs"
	# echo "Vulnerable URLs Done" | notify -id general -silent
}
# ---------------------------- Fuzzing - Ports ----------------------------
port_scan(){
	#  naabu -> nmap
	echo "[+] Playing With Ports"
	cat ~/$outFolder/Assets_Identifying/subdomains/subs.live | cut -d "/" -f 3 | naabu -silent -p - -nmap-cli 'nmap -sV -oN ~/$outFolder/Fuzzing/nmap/nmap.read -oG ~/$outFolder/Fuzzing/nmap/nmap.gnmap' > ~/$outFolder/Fuzzing/naabu.nmap
	echo "    Naabu and Nmap			@ ~/$outFolder/Fuzzing/naabu.nmap"
	# echo "Naabu and Nmap Done" | notify -id general -silent
	echo "    Nmap Read 				@ ~/$outFolder/Fuzzing/nmap/nmap.read"
	echo "    Nmap Grep 				@ ~/$outFolder/Fuzzing/nmap/nmap.gnmap"

	# brutespray
	# sudo apt-get install brutespray
	echo "    BruteSpray ..."
	brutespray --file ~/$outFolder/Fuzzing/nmap/nmap.gnmap
	mv ./brutespray-output ~/$outFolder/Fuzzing
	echo "    BruteSpray-Output 			@ ~/$outFolder/Fuzzing/brutespray-output"
	# echo "BruteSpray-Output Done" | notify -id general -silent
}
# ---------------------------- Fuzzing - scanners ----------------------------
vuln_scan(){
	# nuclei
	# install cent to manage templates
	echo "[+] Nuclei"
	nuclei -l ~/$outFolder/Assets_Identifying/subdomains/subs.live -t ~/cent-nuclei-templates/ -o ~/$outFolder/Fuzzing/nuclie/nuclie_reports.txt -me ~/$outFolder/Fuzzing/nuclie/nuclie_reports -rl 30 -silent
	echo "    Nuclei Summary  			@ ~/$outFolder/Fuzzing/nuclie/nuclie_reports.txt"

	# jaeles
	# $ jaeles config init # to clone signs
	echo "[+] Jaeles"
	jaeles scan -s ~/.jaeles/jaeles-signatures -U ~/$outFolder/Assets_Identifying/subdomains/subs.live -o ~/$outFolder/Fuzzing/jaeles | 1 > /dev/null
	echo "    Jaeles Summary  			@ ~/$outFolder/Fuzzing/jaeles/jaeles-summary.txt"
	# more signs
	# https://github.com/ghsec/ghsec-jaeles-signatures
}
# ---------------------------- Clean-up -----------------------------
clean(){
	find ~/$outFolder -type d -empty -delete -o -type f -empty  -delete
}
# --------------------------- Script-Flow ----------------------------
# check inputs
if [ -z ${1} ] && [ -z ${2} ]; then
    	echo "Invalid Format ./chains.sh [scope.txt] [OutFolder]"
	exit
else
	scope=$1
	outFolder=$2

    # File structure
	mkdir ~/$outFolder
	mkdir ~/$outFolder/Vulns

	mkdir ~/$outFolder/Assets_Identifying
	mkdir ~/$outFolder/Assets_Identifying/subdomains
	mkdir ~/$outFolder/Assets_Identifying/subdomains/separated

	mkdir ~/$outFolder/Content_Gathering
	mkdir ~/$outFolder/Content_Gathering/dorking
	mkdir ~/$outFolder/Content_Gathering/dorking/gitDorker
	mkdir ~/$outFolder/Content_Gathering/dorking/go-dork
	mkdir ~/$outFolder/Content_Gathering/waybackurls
	mkdir ~/$outFolder/Content_Gathering/vulnerable.URLs
	mkdir ~/$outFolder/Content_Gathering/spidering
	mkdir ~/$outFolder/Content_Gathering/params
	
	mkdir ~/$outFolder/Fuzzing
	mkdir ~/$outFolder/Fuzzing/nmap
	mkdir ~/$outFolder/Fuzzing/nuclie
	mkdir ~/$outFolder/Fuzzing/jaeles

	# scope prep ...
	cp $scope /tmp/scope.txt
	sed "s/*.//" /tmp/scope.txt > /tmp/pure_scope.txt

	# output place
	echo "Output @ ~/$outFolder"

	# selection
	read -p "Select path ...
        [1] Subdomains & Spidering 
        [2] Waybackurls & Manual Fuzzing
        [3] Port scan 
        [4] Vulns Scan		
        [5] All 
        > " choice

	case $choice in
	    	1)
		      	subdomains
		      	Spidering
	            params
		      	clean
		      	;;
			2)
				if [ -f ~/$outFolder/Assets_Identifying/subdomains/subs.live ]
				then
					waybackurls
					clean
				else
					subdomains
					waybackurls
					clean
				fi
    			;;
	    	3)
	            if [ -f ~/$outFolder/Assets_Identifying/subdomains/subs.live ]
	            then
	                port_scan
	                clean

	            else
	                subdomains
	                port_scan
	                clean
	            fi
            	;;
	    	4)
	            if [ -f ~/$outFolder/Assets_Identifying/subdomains/subs.live ]
	            then
	            	vuln_manual
	                vuln_scan
	                clean

	            else
	                subdomains
	                vuln_manual
	                vuln_scan
	                clean
	            fi
				;;		
	    	5)
		        if [ -f ~/$outFolder/Assets_Identifying/subdomains/subs.live ]
	            then
	                waybackurls
	                port_scan
	                vuln_scan
	                clean

	            else
	                subdomains
	                waybackurls
	                Spidering
	                params
	                port_scan
	                vuln_scan
	                clean
	            fi
				;;
	    	*)
	    		echo "Sorry, invalid input"
	     		;;
	esac
fi
