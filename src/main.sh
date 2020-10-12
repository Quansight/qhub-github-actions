#!/bin/bash

function stripColors {
  echo "${1}" | sed 's/\x1b\[[0-9;]*m//g'
}

function installQhub {
  echo "Downloading QHub v${qhubVersion}"
  pip install qhub
  echo "Successfully unzipped QHub v${qhubVersion}"
}

function parseInputs {
  # Required inputs
  if [ "${INPUT_QHUB_ACTIONS_VERSION}" != "" ]; then
    qhubVersion=${INPUT_QHUB_ACTIONS_VERSION}
  else
    echo "Input qhub_version cannot be empty"
    exit 1
  fi

  if [ "${INPUT_QHUB_ACTIONS_SUBCOMMAND}" != "" ]; then
    qhubSubcommand=${INPUT_QHUB_ACTIONS_SUBCOMMAND}
  else
    echo "Input qhub_subcommand cannot be empty"
    exit 1
  fi

  # Optional inputs
  qhubWorkingDir="."
  if [[ -n "${INPUT_QHUB_ACTIONS_WORKING_DIR}" ]]; then
    qhubWorkingDir=${INPUT_QHUB_ACTIONS_WORKING_DIR}
  fi

  qhubComment=0
  if [ "${INPUT_QHUB_ACTIONS_COMMENT}" == "1" ] || [ "${INPUT_QHUB_ACTIONS_COMMENT}" == "true" ]; then
    qhubComment=1
  fi
}

function main {
  # Source the other files to gain access to their functions
  scriptDir=$(dirname ${0})
  source ${scriptDir}/qhub_init.sh
  source ${scriptDir}/qhub_validate.sh
  source ${scriptDir}/qhub_generate.sh
  source ${scriptDir}/qhub_push.sh

  parseInputs
  cd ${GITHUB_WORKSPACE}/${qhubWorkingDir}
  echo ${GITHUB_WORKSPACE}

  case "${qhubSubcommand}" in
    init)
      installQhub
      qhubInit ${*}
      ;;
    validate)
      installQhub
      qhubValidate ${*}
      ;;
    generate)
      installQhub
      qhubGenerate ${*}
      ;;
    push)
      installQhub
      qhubPush ${*}
      ;;
    *)
      echo "Error: Must provide a valid value for qhub subcommand"
      exit 1
      ;;
  esac
}

main "${*}"