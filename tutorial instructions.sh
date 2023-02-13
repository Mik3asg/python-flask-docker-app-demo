# Running a Python application in the local machine
    server.py ()"Hello World"                                    # flask python application
    install flask
    run python ./server.py command in the local directory
    open browser and type http://localhost:5000/ to check app is running

# Containerising the app
    create Dockerfile = text doc contains all commands an user could call on a command line to assemble an image
    containerised image to be built (packacking)
    execute commands in the image itself

# Run the container in the local machine
    get Docker Desktop running 
    check by running docker --version
    docker build -t flaskappdemo .                               # the final dot means it's in the local folder 
                                                                 # build an image from the app
                                                                 # if building a new images, then run docker build -t flaskappdemo:1.1 . 

    docker run -d -p 5000:5000 flaskappdemo                      # run the container from the image 
                                                                 # to run a new Container from an updated images, then <tag>

    docker images
    docker ps    

# Deploy the container in Cloud AWS
    docker push mik3asg/python-flask-app-demo:tagname            # create Repo on Docker Hub
    docker login                                                 # login to Docker Hub via CLI
    docker tag ca03d91888fd mik3asg/python-flask-app-demo:1.0    # build from the Docker file (post build -t and run -d -p) the <docker image>
                                                                 # mik3asg/python-flask-app-demo:latest (Docker Hub)

    docker images                                                # check the images with 1.0 tag
    docker push mik3asg/python-flask-app-demo:1.0                # push image to Docker Hub
    aws configure                                                
    ekctl create cluster
    kubectl get pods
    kubectl create deployment <DEPLOYMENT_NAME> --image=<IMAGE_NAME>    # command to generate a deployment file
    kubectl create deployment python-flask-app-demo --image=mik3asg/python-flask-app-demo:1.0 --dry-run=client -o yaml > flaskdeployment.yaml        
    kubectl apply -f flashdeployment.yaml                               # deploy the image in the pod
    kubectl get pods                                                    # check pod status
    
# Expose Container externally
    define Service (-> pointing to Pod) in the deployment file itself 
    kubectl get service
        External-IP of lb-service: a46a02e5907f5418a940f01d4a2cd2ec-538607324.eu-west-3.elb.amazonaws.com
        Copy/Paste the LB IP@ in a new web browser to access web app running on a Pod on a EKS cluster using a LB service

## Scale pods
# update manually Replicas attribute from 1 to 3 in the deployment file 
    kubectl apply -f flashdeployment.yaml                               
# scale up or down the number of replicas by using the kubectl scale command
# this command will change the number of replicas in the deployment, and Kubernetes will automatically create or delete the necessary number of pods to match the desired state. The deployment definition file remains unchanged.
    kubectl scale deployment python-flask-app-demo --replicas=5 

# Clean up (Delete EKS cluster and pods)
    aws eks list-clusters   # find out the EKS cluster names
    kubectl scale deployment python-flask-app-demo --replicas=0  # scale down to 0 pod = delete pods
    aws eks delete-cluster --name floral-sheepdog-1676022508
    
# Commands 
    aws eks list-nodegroups --cluster-name floral-sheepdog-1676022508                                  # find out the nodegroups (e.g."nodegroups": "ng-9d5e07ab")
    aws eks delete-nodegroup --cluster-name floral-sheepdog-1676022508 --nodegroup-name ng-9d5e07ab    # delete a nodegroup
    




