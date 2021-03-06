# set path to include oc client
eval $(minishift oc-env)

# cli login to OpenShift server (use your IP and credentials)
oc login -u dev -p dev https://192.168.42.44:8443


# find out as who you are logged in
oc whoami

# web login: https://192.168.42.44:8443/console


# show all projects of all users
oc config get-contexts


# show your projects
oc projects

 
# change to an application
oc <project-name>


# create a new project (with user-friendly display name)
oc new-project image-uploader --display-name='Image Uploader Project'


# create a new application
oc new-app --image-stream=php --code=https://github.com/OpenShiftInAction/image-uploader.git --name=app-cli


# service (svc) info
oc describe svc/app-cli
# Name:              app-cli
# Namespace:         image-uploader
# Labels:            app=app-cli
# Annotations:       openshift.io/generated-by=OpenShiftNewApp
# Selector:          app=app-cli,deploymentconfig=app-cli
# Type:              ClusterIP
# IP:                172.30.173.70
# Port:              8080-tcp  8080/TCP
# TargetPort:        8080/TCP
# Endpoints:         172.17.0.7:8080
# Port:              8443-tcp  8443/TCP
# TargetPort:        8443/TCP
# Endpoints:         172.17.0.7:8443
# Session Affinity:  None
# Events:            <none>


# create route 
oc expose svc/app-cli


# build config (bc) info
oc describe bc/app-cli
# Name:		app-cli
# Namespace:	image-uploader
# Created:	2 weeks ago
# Labels:		app=app-cli
# Annotations:	openshift.io/generated-by=OpenShiftNewApp
# Latest Version:	1
# 
# Strategy:	Source
# URL:		https://github.com/OpenShiftInAction/image-uploader.git
# From Image:	ImageStreamTag openshift/php:7.1
# Output to:	ImageStreamTag app-cli:latest
# 
# Build Run Policy:	Serial
# Triggered by:		Config, ImageChange
# Webhook GitHub:
# 	URL:	https://192.168.42.44:8443/apis/build.openshift.io/v1/namespaces/image-uploader/buildconfigs/app-cli/webhooks/<secret>/github
# Webhook Generic:
# 	URL:		https://192.168.42.44:8443/apis/build.openshift.io/v1/namespaces/image-uploader/buildconfigs/app-cli/webhooks/<secret>/generic
# 	AllowEnv:	false
# Builds History Limit:
# 	Successful:	5
# 	Failed:		5
# 
# Build		Status		Duration	Creation Time
# app-cli-1 	complete 	20s 		2020-10-26 17:10:22 +0100 CET
# 
# Events:	<none>





# deployment config (dc) info
oc describe dc/app-cli
# Name:		app-cli
# Namespace:	image-uploader
# Created:	2 weeks ago
# Labels:		app=app-cli
# Annotations:	openshift.io/generated-by=OpenShiftNewApp
# Latest Version:	1
# Selector:	app=app-cli,deploymentconfig=app-cli
# Replicas:	1
# Triggers:	Config, Image(app-cli@latest, auto=true)
# Strategy:	Rolling
# Template:
# Pod Template:
#   Labels:	app=app-cli
# 		deploymentconfig=app-cli
#   Annotations:	openshift.io/generated-by=OpenShiftNewApp
#   Containers:
#    app-cli:
#     Image:		172.30.1.1:5000/image-uploader/app-cli@sha256:39dbc4a09e5aef3e105111645d832dcd6c976ad85069946d47a64bb98723579d
#     Ports:		8080/TCP, 8443/TCP
#     Host Ports:		0/TCP, 0/TCP
#     Environment:	<none>
#     Mounts:		<none>
#   Volumes:		<none>
# 
# Deployment #1 (latest):
# 	Name:		app-cli-1
# 	Created:	2 weeks ago
# 	Status:		Complete
# 	Replicas:	1 current / 1 desired
# 	Selector:	app=app-cli,deployment=app-cli-1,deploymentconfig=app-cli
# 	Labels:		app=app-cli,openshift.io/deployment-config.name=app-cli
# 	Pods Status:	1 Running / 0 Waiting / 0 Succeeded / 0 Failed
# 
# Events:	<none>


# route info
oc describe route/app-cli
# Name:			app-cli
# Namespace:		image-uploader
# Created:		2 weeks ago
# Labels:			app=app-cli
# Annotations:		openshift.io/host.generated=true
# Requested Host:		app-cli-image-uploader.192.168.42.44.nip.io
# 			  exposed on router router 2 weeks ago
# Path:			<none>
# TLS Termination:	<none>
# Insecure Policy:	<none>
# Endpoint Port:		8080-tcp
# 
# Service:	app-cli
# Weight:		100 (100%)
# Endpoints:	172.17.0.7:8080, 172.17.0.7:8443



# pod info
oc get pods
# NAME              READY     STATUS      RESTARTS   AGE
# app-cli-1-build   0/1       Completed   0          13d
 app-cli-1-jwdv8   1/1       Running     8          13d


# further pod info
oc get pods -o wide

# info on all resources (pods, replication controller, services, deployment
# configs, build configs, imagestreams, routes)
oc get all

# demo chapter 3.4 - managing resources from the command line
oc login -u developer -p developer
oc new-project firstproject
oc new-app --docker-image=nginx:1.14 --name=nginx
oc status
oc get pods
oc describe pod <podname>
oc get svc
oc describe service nginx
oc port-forward <podname> 33080:80
curl -s http://localhost:33080


# second demo chapter 3.4 - managing resources from the cli
oc new-project mysql
oc new-app --docker-image=mysql:latest --name=mysql-openshift \
        -e MYSQL_USER=myuser \
        -e MYSQL_PASSWORD=password \
        -e MYSQL_DATABASE=mydb \
        -e MYSQL_ROOT_PASSWORD=password
        
        
# build an application from a git repository using the php image stream
oc new-app php~http://gitserver.local/app --name=myapp


# create only the yaml file to create a new application (without building)
oc -o yaml new-app php~http://gitserver/local/app --name=myapp > s2i.yaml


# 
oc -o yaml new-app php~http://github.com/sandervanvugt/simpleapp \
        --name=simple-app > simple-app.yaml
        
# show recent events
oc get events

# what happended in a specific pod
oc logs <podname>

# show all pod details
oc describe pod <podname>

# show all projects
oc projects

# delete everything using label 'simpleapp'
oc delete all -l app=simpleapp

# 
oc delete all --all

