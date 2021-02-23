# Add the stable public charts
# WAS helm repo add stable https://charts.helm.sh/stable
helm repo add stable https://kubernetes-charts.storage.googleapis.com

# download link
# https://github.com/kubernetes/helm/releases

# snap
# sudo snap install helm

# update helm's repo
helm repo update

# install / uninstall a chart
helm install mychart stable/_chart_
helm delete mychart

# create an initial chart
helm create myservice

# debug and find problem
helm lint
helm template --debug
helm install --dry-run --debug
helm get manifest
helm inspect values

# fetch charts
helm fetch
helm fetch stable/mongodb-replicaset

# status
helm status _chartname_

# history
helm history _chartname_

# rollback
helm history _chartname_ # to list the revisions
helm rollback _chartname_ _revisiontogo_
