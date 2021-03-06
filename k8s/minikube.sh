minikube start
minikube status
minikube stop
minikube delete
minikube dashboard
minikube pause


# start with cpus and mem
minikube start --cpus 4 --memory 14000

minikube config view

minikube config set cpus 4
minikube config set driver docker
minikube config set memory 8192

minikube docker-env
minikube ip
minikube logs

minikube addons list
minikube addons enable metrics-server
minikube addons enable dashboard

kubectl expose deployment nginx-deployment --type=NodePort --name=nginx-deployment
minikube service list
minikube service nginx-deployment
minikube service nginx-deployment --url


# Create deployment and expose with load balancer locally
kubectl create deployment hello-node --image=k8s.gcr.io/echoserver:1.4
kubectl expose deployment hello-node --type=LoadBalancer --port=8080
minikube service hello-node
