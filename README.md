# Chains - Automate the Boring Recon

## Description

Automation for Small and Medium Scopes

```
➜  Chains git:(main) ✗ ./chains.sh Scope.txt Target.com
   ____ _           _             	 
  / ___| |__   __ _(_)_ __  ___   	 
 | |   | '_ \ / _` | | '_ \/ __|  	 
 | |___| | | | (_| | | | | \__ \_ 	 
  \____|_| |_|\__,_|_|_| |_|___(_) by A1MN.
                       		 	 
Output @ ~/Target.com
Select path ...
        [1] Subdomains & Spidering 
        [2] Waybackurls
        [3] Port scan 
        [4] Vulns Scan		
        [5] All 
        > 5
      
[+] Playing With Subdomains
    Crt.sh 				              	@ ~/Target.com/Assets_Identifying/subdomains/separated/crtsh.live
    Assetfinder 			          	@ ~/Target.com/Assets_Identifying/subdomains/separated/Assetfinder.live
    Subfinder 				          	@ ~/Target.com/Assets_Identifying/subdomains/separated/subfinder.live
    Amass Enum Passive 			    	@ ~/Target.com/Assets_Identifying/subdomains/separated/amass_enum_passive.live
    Amass Enum Active 			    	@ ~/Target.com/Assets_Identifying/subdomains/separated/amass_enum_active.live
    All Live Subs 		        		@ ~/Target.com/Assets_Identifying/subdomains/subs.live
    Final Destination 	       			@ ~/Target.com/Assets_Identifying/subdomains/subs.live.redirection
    GoWitness 				          	@ ~/Target.com/Assets_Identifying/goWitness.subs

[+] Spidering
    GoSpider					        @ ~/Target.com/Content_Gathering/spidering
    Arjun						        @ ~/Target.com/Content_Gathering/params/

[+] Playing With URLs
    Waybackurls Pure		      		@ ~/Target.com/Content_Gathering/waybackurls/waybackurls.pure
    Smart Endpoints		        		@ ~/Target.com/Content_Gathering/waybackurls/endpoints.qs.eq
    Vulnerable URLs		        		@ ~/Target.com/Content_Gathering/vulnerable.URLs

[+] Playing With Ports
    Naabu and Nmap		        		@ ~/Target.com/Fuzzing/naabu.nmap
    Nmap Read 			          		@ ~/Target.com/Fuzzing/nmap/nmap.read
    Nmap Grep 			          		@ ~/Target.com/Fuzzing/nmap/nmap.gnmap
    BruteSpray ...
    BruteSpray-Output	 		    	@ ~/Target.com/Fuzzing/brutespray-output

[+] Nuclei
    Nuclei Summary  				    @ ~/Target.com/Fuzzing/nuclie/nuclie_reports.txt

[+] Jaeles
    Jaeles Summary  			      	@ ~/Target.com/Fuzzing/jaeles/jaeles-summary.txt
```



## Installation

Install **golang** first ..

```
@ sudo ./setup.sh
```

## How to use

```
$ ./chains scope.txt out_folder
```

you will find out folder in your home directory

## Tools

GoLang tools are Amazing ...

1. Assetfinder
2. Amass
3. Crt.sh
4. Httpx
5. GoWitness
6. Waybackurl
7. Gau
8. Hakrawler
9. Qsreplace
10. GF
11. Arjun
12. GoSpider
13. Naabu
14. Nmap
15. BruteSpray
16. Nuclie
17. Cent
18. Jaeles

## Flow

![](README.assets/flow.png)

