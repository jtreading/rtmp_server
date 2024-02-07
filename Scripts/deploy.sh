#!/bin/bash

# Set your AWS profile name
AWS_PROFILE="default"

# Set the AWS region where you want to deploy the stack
AWS_REGION="us-east-1"

# Set the name for your CloudFormation stack
STACK_NAME="RTMP-Server-Stack-Demo"

# Set the path to your CloudFormation template file
TEMPLATE_FILE="../CloudFormation/nginx.yml"

# Set parameter values
IngressIP="0.0.0.0"
AllowSSH="false"
InstanceType="t2.micro"
KeypairName="RTMPKeypair"
AMI="ami-058bd2d568351da34"
ProjectName="RTMP-Server"
Environment="Development"

# Define parameters for the parameter overrides
PARAMETER_OVERRIDES="ParameterKey=IngressIP,ParameterValue=$IngressIP ParameterKey=AllowSSH,ParameterValue=$AllowSSH ParameterKey=InstanceType,ParameterValue=$InstanceType ParameterKey=KeypairName,ParameterValue=$KeypairName ParameterKey=AMI,ParameterValue=$AMI ParameterKey=ProjectName,ParameterValue=$ProjectName ParameterKey=Environment,ParameterValue=$Environment"

# Create the CloudFormation stack with parameters
echo "Creating CloudFormation stack..."
aws cloudformation create-stack \
    --profile $AWS_PROFILE \
    --region $AWS_REGION \
    --stack-name $STACK_NAME \
    --template-body file://$TEMPLATE_FILE \
    --capabilities CAPABILITY_IAM \
    --parameters $PARAMETER_OVERRIDES

# Wait for stack creation to complete
echo "Waiting for stack creation to complete..."
aws cloudformation wait stack-create-complete \
    --profile $AWS_PROFILE \
    --region $AWS_REGION \
    --stack-name $STACK_NAME

# Check stack creation status
STACK_STATUS=$(aws cloudformation describe-stacks \
    --profile $AWS_PROFILE \
    --region $AWS_REGION \
    --stack-name $STACK_NAME \
    --query 'Stacks[0].StackStatus' \
    --output text)

if [ $STACK_STATUS = "CREATE_COMPLETE" ]; then
    echo "Stack creation completed successfully."
    # Get stack outputs
    echo "Fetching stack outputs..."
    STACK_OUTPUTS=$(aws cloudformation describe-stacks \
        --profile $AWS_PROFILE \
        --region $AWS_REGION \
        --stack-name $STACK_NAME \
        --query 'Stacks[0].Outputs')

    echo "Stack outputs:"
    echo "$STACK_OUTPUTS"
else
    echo "Stack creation failed. Status: $STACK_STATUS"
fi
