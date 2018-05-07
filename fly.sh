#!/bin/bash
set -e
fly -t oeqcm login -n oeqcm -p oeqcm -u oeqcm -c https://concourse.egira.saab.se
fly set-pipeline --target oeqcm \
 --config build-pipeline.yaml --pipeline semver-resource-image --var "private_repo_key=$(cat ~/.ssh/gitlab)"\
 --var "registry=docker.egira.saab.se:5000"  --var "registry-user="  --var "registry-password="\
 --var "git-branch=master" --var "git-repo=ssh://git@git.work:23/oeqcm/semver.git" \
 --var "cluster-ca=$(grep -E 'certificate-authority-data' ~/.kube/config  | cut -f2 -d':' | tr -d ' ')" \
 --var "cluster-token=$(kubectl describe secret $(kubectl get secrets | grep default | cut -f1 -d ' ') | grep -E '^token' | cut -f2 -d':' | tr -d '\t' | tr -d ' ')"
