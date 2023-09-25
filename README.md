# Employee Management System
  It's an application to add and view employee Details.

# Backend
    backend is written in go version 1.19
    backend server starts at port 8080
  
    ## How to run
        1. Make sure you have go version 1.19 installed
        2. go get ./...
        3. DB_HOST=<POSTGRES_HOST> DB_USER=<POSTGRES_USER> DB_PASSWORD=<POSTGRES_PASSWORD> DB_NAME=<POSTGRES_DB_NAME> DB_PORT=<POSTGRES_PORT> ALLOWED_ORIGINS=<ALLOWED_ORGINS_VALUE> go run main.go

# Frontend
    Frontend is written in ReactJS
    Frontend server starts at port 3000
    
        ## How to run
            1. Make sure you have node version 14.17.0 installed
            2. npm install
            3. npm start


## Here are the steps
1. create a new IAM profile for terraform and generate API keys
2. Chage the API key file path in this file
3. https://github.com/sunil-sahoo/interview_techverito/blob/master/terraform/terraform.tfvars
4. Then run terraform plan and terraform apply

For the CI/CD we are using Github actions.
1. Pipeline files are under.github/workflows
2. Image Build is set to automatic on code push to master branch
3. Deploy however is kept for manual trigger
4. Before we can do the build and deploy, we need to set Github Action secrets
5. Here are the list of secrets
6. AWS_ACCESS_KEY_ID,AWS_SECRET_ACCESS_KEY (we need to create a new user with ECR write access)
7. HOST,SSH_KEY,USERNAME
8. Here Host is the IP address  of the VM
9. SSH_KEY is the SSH private key
10. USERNAME is the SSH username
    
