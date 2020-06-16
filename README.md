# Howto

- build docker image
    ```
    $ docker build -t slasmartres/netcoremicroservices .
    ```
- run docker image
    ```
    $ docker run -p 3000:80 slasmartres/netcoremicroservices
    ```
- navigate to http://localhost:3000/weatherforecast
- login to docker hub
    ```
    $ docker login
    ```
- upload image to docker hub
    ```
    docker tag netcoremicroservices slasmartres/netcoremicroservices
    $ docker push slasmartres/netcoremicroservices
    ```
- login to Azure
    ```
    $ az login
    ```
- install Azure Kubernetes Service CLI
    ```
    $ az aks install-cli
    ```
- create a resource group
    ```
    $ az group create --name NetCoreMicroservicesResources --location westus
    ```
- create an AKS cluster
    ```
    $ az aks create \
    --resource-group NetCoreMicroservicesResources \
    --name NetCoreMicroservicesCluster \
    --node-count 1 \
    --enable-addons http_application_routing \
    --generate-ssh-keys
    ```
- get credentials to deploy the application to the kubernetes cluster
    ```
    $ az aks get-credentials  \
    --resource-group NetCoreMicroservicesResources \
    --name NetCoreMicroservicesCluster
    ```
- create the yaml file used to deploy
    ```
    $ touch deploy-netcoremicroservices.yaml
    ```
- run the deployment
    ```
    $ kubectl apply -f deploy-netcoremicroservices.yaml
    ```
- get kubernetes services and get the external IP that the service is available on
    ```
    $ kubectl get services netcoremicroservices
    NAME                   TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)        AGE
    netcoremicroservices   LoadBalancer   <cluster-ip>   <external-ip>   80:31307/TCP   91s
    ```
- navigate to http://[external-ip]/weatherforecast
