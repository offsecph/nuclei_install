# nuclei_install
Portable binaries of nuclei / katana / httpx / aquatone scanners to latest versions

### Download
```bash
git clone https://github.com/offsecph/nuclei_install
```

### Installation

Cloning this repo:

amd64
```bash
cd nuclei_install
chmod +x ./install.sh amd64
./install.sh
```

arm64
```bash
cd nuclei_install
chmod +x ./install.sh arm64
./install.sh
```

via curl:

```
mkdir nuclei_install
cd nuclei_install
curl -sSf https://raw.githubusercontent.com/offsecph/nuclei_install/master/install.sh | bash
```

### Nuclei Templates
All .yaml files were imported to nuclei-templates/all for quick and easy use
