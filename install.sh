#!/usr/bin/env sh

set -e
cat <<EOF
Typical installation of the Local Environment 
    1. ### Install Packages
    2. ### Create Kubernetes Cluster
    3. ### Deploy Helm Charts 
EOF
sleep 5
export path_folder="config"

             echo      "----- ............................. -----"
             echo           "--- INSTALL DEPENDENCIES ---"
             echo      "----- ............................. -----"
             
source config/dependency.sh
sleep 5 && sudo docker ps -a || true
             echo      "----- ............................. -----"
             echo           "---  LOAD-TERRAFORM-FILES  ---"
             echo      "----- ............................. -----"
sleep 5         
terraform init || exit 1
terraform validate || exit 1 
terraform plan && terraform apply -auto-approve
sleep 10 && kubectl get pods -A && sleep 5

             echo      "----- ............................. -----"
             echo         "---  LOAD-ARGO-APPLICATIONS  ---"
             echo      "----- ............................. -----"      
             
sleep 5 &&       
kubectl apply -f ./${path_folder}/app.yaml
               printf "\nWaiting for application will be ready... \n"
printf "\nYou should see 'dashboard' as a reponse below (if you do the ingress is working):\n"
sleep 5 && kubectl get nodes -o wide && sleep 5
terraform state list


             echo      "----- ............................. -----"
             echo           "---  CLUSTER IS READY  ---"
             echo      "----- ............................. -----"