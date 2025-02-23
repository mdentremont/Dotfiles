Use dotdrop to sync dotfiles:

- git submodule update --init --recursive
- python3 -m venv venv
- source venv/bin/activate
- pip3 install -r dotdrop/requirements.txt
- chmod +x dotdrop.sh
- ./dotdrop.sh install --cfg config-linux.yaml
