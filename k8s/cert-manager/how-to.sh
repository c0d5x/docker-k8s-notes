
# install CRDs
kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.1/cert-manager.yaml

# create namespace
kubectl create namespace cert-manager

# more CRDs
# kubectl apply --validate=false -f https://github.com/jetstack/cert-manager/releases/download/v0.16.1/cert-manager.crds.yaml
kubectl apply -f staging-issuer.yaml

# check pods were deployed
kubectl get pods --namespace cert-manager


kubectl apply -f test-certs.yml

# check if test cert worked
kubectl describe certificate -n cert-manager-test

kubectl delete -f test-certs.yml


