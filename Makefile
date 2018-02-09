setup-server:
	ansible-playbook -i hosts -e'ansible_python_interpreter=/usr/bin/python3' wp1.yml

build:
	cabal user-config update || true
	cabal update
	cabal install --only-dependencies
	cabal configure
	cabal install

test:
	cabal test

deploy:
	echo deploy not done yet && false
