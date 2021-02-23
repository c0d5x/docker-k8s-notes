export KUBE_EDITOR="vim"
kubectl config view
kubectl cluster-info


# deployment
kubectl apply -f ./mydeploymentfile.yml
kubectl diff -f ./mydeploymentfile.yml
kubectl create deployment nginx --image=nginx

kubectl get deployment mydeployment
kubectl describe deployment mydeployment
kubectl edit deployment mydeployment
kubectl expose deployment mydeployment --type=LoadBalancer --name=mydeployment
kubectl delete deployment mydeployment --grace-period=0 --force
kubectl delete pods,services,deployments -l app=jenkins --namespace techops-jenkins

kubectl autoscale deployment mydeployment --min=2 --max=10

kubectl rollout status deployment mydeployment
kubectl rollout restart deployment mydeployment

# nodes
kubectl get nodes
kubectl describe nodes
kubectl get node --selector='!node-role.kubernetes.io/master'
kubectl top nodes
kubectl top nodes --sort-by=cpu


# services
kubectl get services
kubectl get services --sort-by=.metadata.name
kubectl get pod,svc -n kubernetes-dashboard
kubectl get pod,svc --all-namespaces
kubectl describe services
kubectl delete service mydeployment --grace-period=0 --force
kubectl delete pods,services,deployments -l app=jenkins --namespace techops-jenkins

# logs
kubectl logs -l app=nginx
kubectl logs -f -l app=elasticsearch --max-log-requests 7
# print logs of exited container
kubectl logs nginx-78f5d695bd-czm8z -p
# from a specific datetime
kubectl logs nginx-78f5d695bd-czm8z --since=1h
kubectl logs nginx-78f5d695bd-czm8z --since-time=2019-11-01T15:00:00Z

# events
kubectl get events
kubectl get events --sort-by=.metadata.creationTimestamp
kubectl get events --sort-by='{.firstTimestamp}'
kubectl get events --sort-by='{.lastTimestamp}'
kubectl get events mypod.timestamp

# labels
kubectl label pods mypod new-label=awesome

# pods
kubectl get pods --show-labels
kubectl get pods --all-namespaces
kubectl get pods -o wide
kubectl get pods --sort-by='.status.containerStatuses[0].restartCount'
kubectl get pods --field-selector=status.phase=Running
kubectl get pod,svc -n kubernetes-dashboard
kubectl get pod,svc --all-namespaces
kubectl describe pod mypod
kubectl delete pod mypod
kubectl delete pods,services -l app=jenkins --namespace techops-jenkins
kubectl delete pods,services,deployments -l app=jenkins --namespace techops-jenkins

kubectl top pods --sort-by=cpu --all-namespaces
kubectl top pods --sort-by=memory --all-namespaces

kubectl exec mypod -- ls /
# when pod has more than one container
kubectl exec -i -t mypod --container main-app -- /bin/bash

# run a specific image
kubectl run -i --tty busybox --image=busybox -- sh
kubectl run nginx --image=nginx --restart=Never -n mynamespace

# run an ubuntu pod for troubleshooting
kubectl run -i --tty ubuntu --image=ubuntu -- /bin/bash
kubectl attach ubuntu -c ubuntu -it


# replicasets
kubectl get replicaset
kubectl describe replicaset

# port forwards
kubectl port-forward hello-world-... 8080:8080
kubectl port-forward pod/mypod 5000 5000
kubectl port-forward deployment/mydeployment 6000 6000

# PV, PVC
kubectl get pv
kubectl describe pv
kubectl get pvc
kubectl describe pvc
kubectl get pv --sort-by=.spec.capacity.storage


# Deleting resources

# Delete pods and services with same names "baz" and "foo"
kubectl delete pod,service baz foo
kubectl delete pods,services -l name=mylabel
kubectl -n mynamespace delete pod,svc --all
# Delete all pods matching the awk pattern1 or pattern2
kubectl get pods -n mynamespace --no-headers=true|awk '/pattern1|pattern2/{print $1}'|xargs kubectl delete -n mynamespace pod

# Updating & Rollout
kubectl set image deployment/frontend www=image:v2
kubectl set image deployment nginx-deployment nginx=nginx:1.12.1
kubectl rollout history deployment/frontend
kubectl rollout undo deployment/frontend
kubectl rollout undo deployment/frontend --to-revision=2
kubectl rollout status -w deployment/frontend
kubectl rollout restart deployment/frontend

# Docker secret
# DOCKER_REGISTRY_SERVER: https://index.docker.io/v1/ for DockerHub
kubectl create secret docker-registry NAME \
  --docker-server=DOCKER_REGISTRY_SERVER \
  --docker-username=DOCKER_USER \
  --docker-password=DOCKER_PASSWORD \
  --docker-email=DOCKER_EMAIL

kubectl get secret NAME --output=yaml

# deployment using the secret creds
apiVersion: v1
kind: Pod
metadata:
  name: private-reg
spec:
  imagePullSecrets:
    - name: NAME
  containers:
    - name: private-reg-container
      image: your-private-image

# docker registry using AWS
kubectl create secret docker-registry aws-ecr-credentials \
--docker-server=$ECR_REGISTRY \
--docker-username=AWS \
--docker-password=$(aws ecr get-login | awk '{print $6}') \
--docker-email=$IAM_EMAIL \
--namespace=$KUBE_NAMESPACE

# then in deployment.yml
spec:
  imagePullSecrets:
    - name: aws-ecr-credentials


# cluster and context
kubectl config get-clusters
kubectl config get-contexts
kubectl config current-context
kubectl config use-context my-cluster-name
kubectl config set-context --current --namespace=ggckad-s2
kubectl config view -o jsonpath='{.users[*].name}'
