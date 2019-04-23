#!/bin/zsh

setupAWSEnv() {
  export AWS_KEY=`aws configure get default.aws_access_key_id`
  export AWS_SECRET=`aws configure get default.aws_secret_access_key`
  export AWS_REGION=eu-west-1
}

AWSkick() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
      aws ecs update-service --cluster $args[1] --service $args[2] --force-new-deployment
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 0 ]]; then
    print -P '%F{green}Done!%f'
  else
    print -P '$0 <cluster>/<service>'
  fi
}

AWSstate() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
      aws ecs describe-services --cluster $args[1] --services $args[2] | jq -r .services[].events[0].message
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 1 ]]; then
    print -P '$0 <cluster>/<service>'
  fi
}

AWStaskenv() {
  err=0
  if [[ $# -gt 0 ]]; then
    args=("${(s:/:)1}")
    if [[ $#args -gt 1 ]]; then
			aws ecs describe-services --cluster $args[1] --service $args[2] | jq -r .services[].taskDefinition | xargs -I {} aws ecs describe-task-definition --task-definition {} | jq .taskDefinition.containerDefinitions[].environment
      err=$?
    else
      err=1
    fi
  else
    err=1
  fi

  if [[ $err -eq 1 ]]; then
    print -P '$0 <cluster>/<service>'
  fi
}

AWSpipe() {
  err=0
  if [[ $# -gt 1 ]]; then
    case $1 in
      approve)
        aws codepipeline get-pipeline-state --name $2 | jq -r ".stageStates[].actionStates[].latestExecution.token | select(. != null)" | xargs -I {} aws codepipeline put-approval-result --pipeline-name schedmail-prod --stage-name Deploy --action-name ApproveChangeSet --result summary=auto,status=Approved --token {}
        err=$?
        ;;
      reject)
        aws codepipeline get-pipeline-state --name $2 | jq -r ".stageStates[].actionStates[].latestExecution.token | select(. != null)" | xargs -I {} aws codepipeline put-approval-result --pipeline-name schedmail-prod --stage-name Deploy --action-name ApproveChangeSet --result summary=auto,status=Rejected --token {}
        err=$?
        ;;
      *)
        err=1
        ;;
    esac
  else
    err=1
  fi

  if [[ $err -eq 0 ]]; then
    print -P '%F{green}Done!%f'
  else
    print -P '$0 <approve|reject> <pipeline>'
  fi
}

AWSlinestate() {
  if [[ $# -gt 0 ]]; then
    DATA=$(aws codepipeline get-pipeline-state --name $1)
    if [[ $? -ne 0 ]]; then
      print -P '%F{red}no such pipe%f'
      return -1
    fi

    for STATE in $(echo $DATA | jq -cr ".stageStates[].actionStates[]"); do
      NAME=$(echo $STATE | jq -r ".actionName")
      STATUS=$(echo $STATE | jq -r ".latestExecution.status")
      SUMMARY=$(echo $STATE | jq -r ".latestExecution.summary")
      TIMESTAMP=$(echo $STATE | jq -r ".latestExecution.lastStatusChange" | xargs -I foo date -d @foo)

      OUTPUT="$NAME ➡"
      case $STATUS in
        Succeeded)
          OUTPUT="$OUTPUT %F{green}$STATUS%f"
          ;;
        "In Progress")
          OUTPUT="$OUTPUT %F{yellow}$STATUS%f"
          ;;
        *)
          OUTPUT="$OUTPUT %F{red}$STATUS%f"
          ;;
      esac
      if [ $SUMMARY != "null" ]; then
        OUTPUT="$OUTPUT\n├$SUMMARY"
      fi
      OUTPUT="$OUTPUT\n└$TIMESTAMP"

      print -P "$OUTPUT\n"
    done
  else
    print -P '$0 <pipeline>'
  fi
}

alias aws-env='setupAWSEnv'
alias aws-kick='AWSkick'
alias aws-state='AWSstate'
alias aws-task-env='AWStaskenv'
alias aws-pipe='AWSpipe'
alias aws-line-state='AWSlinestate'
