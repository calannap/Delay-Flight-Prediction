Welcome to Flight Delay Prediction!

To get started, you must have the Azure CLI installed on your local machine. Follow this guide to install it: https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-windows?view=azure-cli-latest

Next, you need to create an Azure AD service principal. (source: https://docs.microsoft.com/en-us/azure/developer/terraform/install-configure ) The service principal grants your Terraform scripts to provision resources in your Azure subscription.

If you have multiple Azure subscriptions, first query your account with az account list to get a list of subscription ID and tenant ID values:

    az account list --query "[].{name:name, subscriptionId:id, tenantId:tenantId}"
    
This will return you the subscription ID later needed. To use a selected subscription, set the subscription for this session with az account set. Set the SUBSCRIPTION_ID environment variable to hold the value of the returned id field from the subscription you want to use:

    az account set --subscription="${SUBSCRIPTION_ID}"
    
Now you can create a service principal for use with Terraform. Use az ad sp create-for-rbac, and set the scope to your subscription as follows:

    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"
    
Your appId, password, sp_name, and tenant are returned. Make a note of the appId and password.
    
 Next, you will need to create a simple secrets.sh file, where you define your secrets.
 
    echo "Setting environment variables for Terraform"
    export ARM_CLIENT_ID="your_appId
    export ARM_CLIENT_SECRET=your_password
    export ARM_SUBSCRIPTION_ID=your_subscription_id
    export ARM_TENANT_ID=your_tenant_id
    
Run the script and run

    terraform init
    terraform plan
    
If everything worked correctly, you should be able to deploy your terraformed infrastructure