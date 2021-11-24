# apt -y update 
# apt -y install golang 
# # export go path to rc files 
# echo "export PATH=$PATH:~/go/bin/" >> .zshrc
# echo "export PATH=$PATH:~/go/bin/" >> .bashrc

# # jaeles install error
# echo "export CGO_CFLAGS=\"-g -O2 -Wno-return-local-addr\"" >> .zshrc
# echo "export CGO_CFLAGS=\"-g -O2 -Wno-return-local-addr\"" >> .bashrc

echo "install Golang First"

# httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# assetfinder
go install -v github.com/tomnomnom/assetfinder@latest
# subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
# amass
go get -v github.com/OWASP/Amass/v3/...

# waybackurls
go install -v github.com/tomnomnom/waybackurls@latest
# gau
go install -v github.com/lc/gau@latest
# hakrawler
go install github.com/hakluke/hakrawler@latest

# gospider
go install github.com/jaeles-project/gospider@latest

# gf ... extened
go install -v github.com/tomnomnom/gf@latest
git clone https://github.com/1ndianl33t/Gf-Patterns
mkdir -p ~/.gf
mv ~/Gf-Patterns/*.json ~/.gf
rm -rf Gf-Patterns
rm -rf Gf-Patterns
# qsreplace
go install -v github.com/tomnomnom/qsreplace@latest
# anew
go install -v github.com/tomnomnom/anew@latest
# jq
sudo apt -y install jq


# naabu
sudo apt install -y libpcap-dev
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
# nmap
apt install -y nmap

# brutespray
sudo apt -y install brutespray

# nuclei
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/xm1k3/cent@latest
# jaeles
go install -v github.com/jaeles-project/jaeles@latest
jaeles config init
jaeles config update --repo http://github.com/jaeles-project/another-signatures --user admin --pass admin

# notify
go install -v github.com/projectdiscovery/notify/cmd/notify@latest

# gowitness
go install github.com/sensepost/gowitness@latest

# arjun
pip3 install arjun
