setup-server:
	ansible-playbook -i hosts -e'ansible_python_interpreter=/usr/bin/python3' wp1.yml

build:
	cabal user-config init || true
  cabal	update
	cabal configure
	cabal install

test:
	echo test not done yet && false

deploy:
	echo deploy not done yet && false
