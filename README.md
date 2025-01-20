
docker-compose up -d

brew install terraform minikube k9s
pip3 install terraform-local

tflocal init
tflocal plan
tflocal apply

