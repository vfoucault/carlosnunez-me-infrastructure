#!/usr/bin/env bash

SUPPORTED_ENVIRONMENTS=$(find config -type f -name "infrastructure_config*" \
  -exec sh -c "echo {} | cut -f2-d '.'" \;`)

usage() {
  print "deploy.sh [target_environment]\n"
  print "Deploys infrastructure for carlosnunez.me\n\n"
  print "\ttarget_environment: The environment to deploy onto. \
Supported environments: $SUPPORTED_ENVIRONMENTS"
}

env_support_check() {
  env_to_check="$1"
  supported_envs="$2"
  matching_envs_found=$(echo "$supported_envs" | grep "${env_to_check}")
  [ "$matching_envs_found" != "" ]
}

NUMBER_OF_ARGS_EXPECTED=1
if [ "$#" != "$NUMBER_OF_ARGS_EXPECTED" ]
then
  usage
  return 1
fi

target_env=$1
is_env_supported=env_support_check $target_env $SUPPORTED_ENVIRONMENTS
if !$is_env_supported
then
  print "ERROR: '${target_env}' not found in '${SUPPORTED_ENVIRONMENTS}'\n"
  usage
  return 1
fi
