setup-server:
	ansible-playbook -i hosts -e'ansible_python_interpreter=/usr/bin/python3' wp1.yml

build:
	mkdir -p ~/.cabal
	cp cabal_config ~/.cabal/config
	cabal update
	cabal install --only-dependencies
	cabal configure
	cabal install

test:
	cabal test

deploy:
	rm -rf /home/ubuntu/public_html
	cp -R public_html /home/ubuntu/public_html
