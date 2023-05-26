# Kubernetes Client

This images specific for CI/CD especialy Gitlab CI/CD, Gitlab Action.

Includes:

- `kubectl`
- `helm`

for example 

```yaml
stages:
  - test
  - build
  - publish
  - deploy

variables:
  MAVEN_CLI_OPTS: "--show-version"
  

image: maven:3.6.3-jdk-11

deploy_k8s:
  image:
    name: dimmaryanto93/k8s-kubectl-helm:1.23.14-release
  stage: deploy
  tags:
    - kubernetes
  before_script:
    - mkdir -p ~/.kube
    - cat $KUBE_CONFIG > ~/.kube/config
  script:
    - sed -i "s/IMAGE_TAG/$CI_COMMIT_TAG/g" deployment.yaml
    - cat deployment.yaml
  after_script:
    - kubectl apply -f deployment.yaml
    - kubectl get service,po -n gitlab-managed-apps -o wide
  only:
    - /-release/
```
