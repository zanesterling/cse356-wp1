setup:
	ansible-playbook -i hosts -e'ansible_python_interpreter=/usr/bin/python3' wp1.yml
