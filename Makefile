setup-server:
	ansible-playbook -i hosts -e'ansible_python_interpreter=/usr/bin/python3' wp1.yml

build:
	mkdir -p ~/.cabal
	cp cabal_config ~/.cabal/config
	cabal update
	cabal install --only-dependencies
	cabal configure
	cabal build

test:
	echo fuck you

deploy:
	echo $(USER)
	pwd
	cp -R public_html /home/ubuntu/
	pkill -9 cabal || true
	nohup cabal run &
