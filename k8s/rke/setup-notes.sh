
# install rke
# https://github.com/rancher/rke/releases/latest
# https://rancher.com/docs/rke/latest/en/os/

# install kubectl
# https://kubernetes.io/docs/tasks/tools/install-kubectl/


# FOR ALL NODES

# make sure ssh works from workstation with rke to nodes
# with ssh-agent or key

## install docker in all nodes
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

## add your user to docker group
sudo usermod -aG docker "user"

# once all nodes have docker running with the user ready
# from workstation create the cluster.yml configuration

rke config --name cluster.yml
# answer how many nodes, which ips, users, keys
# I have used `canal` network plugin

# then bootstrap the cluster
rke up
# optional, if using ssh-agent
rke up --ssh-agent-auth

# you get a `kube_config_cluster.yml`
export KUBECONFIG=$PWD/kube_config_cluster.yml

kubectl get nodes
