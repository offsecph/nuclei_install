#!/bin/bash

function clean_up() {
    rm -rf $PWD/tools $PWD/nuclei-templates
}

function install_aquatone() {
    if [ ! -f "$PWD/aquatone" ]; then
	curl https://api.github.com/repos/michenriksen/aquatone/releases \
		| grep "browser_download_url.*_linux_amd64_*.*.*zip" \
		| head -n1 \
		| cut -d: -f2,3 \
		| tr -d '"' \
		| wget -qi - -P $PWD/tools/aquatone

        unzip $PWD/tools/aquatone/aquatone_linux_amd64_*.*.*.zip -d $PWD/tools/aquatone
        rm -rf $PWD/tools/aquatone/aquatone_linux_amd64_*.*.*.zip
    fi
    
    if [[ `dpkg-query -l chromium | grep ii | awk '{print $2}'` != "chromium" ]]; then
        apt-get install -y chromium
    fi
}

function install_aquatone_arm64() {                                        
    if [ ! -f "$PWD/aquatone" ]; then                                
        curl https://api.github.com/repos/michenriksen/aquatone/releases \
                | grep "browser_download_url.*_linux_arm64_*.*.*zip" \
                | head -n1 \                                         
                | cut -d: -f2,3 \
		| tr -d '"' \                                        
                | wget -qi - -P $PWD/tools/aquatone                  
                                                                     
        unzip $PWD/tools/aquatone/aquatone_linux_arm64_*.*.*.zip -d $PWD/tools/aquatone_arm64
        rm -rf $PWD/tools/aquatone/aquatone_linux_arm64_*.*.*.zip    
    fi                                                               
                                                                     
    if [[ `dpkg-query -l chromium | grep ii | awk '{print $2}'` != "chromium" ]]; then
        apt-get install -y chromium
    fi                                                               
}  

function install_nuclei() {                                                                                                                
    if [ ! -f "$PWD/nuclei" ]; then                                  
        curl https://api.github.com/repos/projectdiscovery/nuclei/releases \
                | grep "browser_download_url.*_linux_amd64.zip" \
                | head -n1 \    
                | cut -d: -f2,3 \                                    
                | tr -d '"' \                                                                                                              
                | wget -qi - -P $PWD/tools/nuclei          

        unzip $PWD/tools/nuclei/nuclei_*.*.*_linux_amd64.zip -d $PWD/tools/nuclei/
        rm -rf $PWD/tools/nuclei/nuclei_*.*.*_linux_amd64.zip
    fi                                                               
} 

function install_nuclei_arm64() {
    if [ ! -f "$PWD/nuclei" ]; then
	curl https://api.github.com/repos/projectdiscovery/nuclei/releases \
		| grep "browser_download_url.*_linux_arm64.zip" \
		| head -n1 \
		| cut -d: -f2,3 \
		| tr -d '"' \
		| wget -qi - -P $PWD/tools/nuclei

        unzip $PWD/tools/nuclei/nuclei_*.*.*_linux_arm64.zip -d $PWD/tools/nuclei_arm64/
        rm -rf $PWD/tools/nuclei/nuclei_*.*.*_linux_arm64.zip
    fi
}

function install_httpx() {
    if [ ! -f "$PWD/httpx" ]; then
        curl https://api.github.com/repos/projectdiscovery/httpx/releases \
		| grep "browser_download_url.*_linux_amd64.zip" \
		| head -n1 \
		| cut -d: -f2,3 \
		| sed 's/"//g' \
		| wget -qi - -P $PWD/tools/httpx
        unzip $PWD/tools/httpx/httpx_*.*.*_linux_amd64.zip -d $PWD/tools/httpx
        rm -rf $PWD/tools/httpx/httpx_*.*.*_linux_amd64.zip
    fi
}

function install_httpx_arm64() {                                                                                                                 
    if [ ! -f "$PWD/httpx" ]; then                                                                                                         
        curl https://api.github.com/repos/projectdiscovery/httpx/releases \                                                                
                | grep "browser_download_url.*_linux_arm64.zip" \                                                                          
                | head -n1 \                                         
                | cut -d: -f2,3 \                                    
                | sed 's/"//g' \                                                                                                                                                                                                                                                      
                | wget -qi - -P $PWD/tools/httpx                                                                                                                                                                                                                                   
        unzip $PWD/tools/httpx/httpx_*.*.*_linux_arm64.zip -d $PWD/tools/httpx_arm64                                                             
        rm -rf $PWD/tools/httpx/httpx_*.*.*_linux_arm64.zip                                                                                
    fi                                                                                                                                     
}

function install_katana() {
    if [ ! -f "$PWD/katana" ]; then
        curl https://api.github.com/repos/projectdiscovery/katana/releases \
		| grep "browser_download_url.*_linux_amd64.zip" \
		| head -n1 \
		| cut -d: -f2,3 \
		| sed 's/"//g' \
		| wget -qi - -P $PWD/tools/katana
        unzip $PWD/tools/katana/katana_*.*.*_linux_amd64.zip -d $PWD/tools/katana
        rm -rf $PWD/tools/katana/katana_*.*.*_linux_amd64.zip
    fi
}

function install_katana_arm64() {
    if [ ! -f "$PWD/katana" ]; then
        curl https://api.github.com/repos/projectdiscovery/katana/releases \
                | grep "browser_download_url.*_linux_arm64.zip" \
                | head -n1 \
                | cut -d: -f2,3 \
                | sed 's/"//g' \
                | wget -qi - -P $PWD/tools/katana
        unzip $PWD/tools/katana/katana_*.*.*_linux_arm64.zip -d $PWD/tools/katana_arm64
        rm -rf $PWD/tools/katana/katana_*.*.*_linux_arm64.zip
    fi
}

function install_nuclei_templates() {
    rm -rf $PWD/nuclei-templates 2>/dev/null
    git clone https://github.com/projectdiscovery/nuclei-templates $PWD/nuclei-templates/
    mkdir -p $PWD/nuclei-templates/all 2>/dev/null
    find $PWD/nuclei-templates -type f -name *.yaml | xargs -I % cp -rfv % $PWD/nuclei-templates/all 2>/dev/null
}

if [ $# -lt 2 ]; then
    echo "OPTIONS:
arm64 | amd64
USAGE:
./install.sh <arg>
"
exit 1
fi

if [ $1 == 'amd64' ]; then
    clean_up
    install_aquatone
    install_nuclei
    install_httpx
    install_katana
    install_nuclei_templates
fi

if [ $1 == 'arm64' ]; then
    clean_up
    install_aquatone_arm64
    install_nuclei_arm64
    install_httpx_arm64
    install_katana_arm64
    install_nuclei_templates
fi
