# Terraform IAC Workshop

This repo is the basis for some workshops that happened at SumUp about IaC. It goes into some simple implementations and more advanced full environments using localstack and minikube.

## Setup

To run localstack:

`docker-compose up -d`

To install dependencies:

`brew install terraform minikube kubectl k9s`

To run terraform using localstack:

`pip3 install terraform-local`

`tflocal init`

`tflocal plan`

`tflocal apply`
