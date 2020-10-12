#!/bin/bash

function qhubValidate {
  # Gather the output of `qhub validate`.
  echo "validate: info: validating QHub configuration in qhub-config.yaml"
  validateOutput=$(qhub validate qhub-config.yaml 2>&1)
  validateExitCode=${?}

  # Exit code of 0 indicates success. Print the output and exit.
  if [ ${validateExitCode} -eq 0 ]; then
    echo "validate: info: successfully validated QHub configuration}"
    echo "${validateOutput}"
    echo
    exit ${validateExitCode}
  fi

  # Exit code of !0 indicates failure.
  echo "validate: error: failed to validate Qhub configuration}"
  echo "${validateOutput}"
  echo

  # Comment on the pull request if necessary.
  if [ "$GITHUB_EVENT_NAME" == "pull_request" ] && [ "${qhubComment}" == "1" ]; then
    validateCommentWrapper="#### \`qhub validate\` Failed
\`\`\`
${validateOutput}
\`\`\`
*Workflow: \`${GITHUB_WORKFLOW}\`, Action: \`${GITHUB_ACTION}\`*"

    validateCommentWrapper=$(stripColors "${validateCommentWrapper}")
    echo "validate: info: creating JSON"
    validatePayload=$(echo "${validateCommentWrapper}" | jq -R --slurp '{body: .}')
    validateCommentsURL=$(cat ${GITHUB_EVENT_PATH} | jq -r .pull_request.comments_url)
    echo "validate: info: commenting on the pull request"
    echo "${validatePayload}" | curl -s -S -H "Authorization: token ${GITHUB_TOKEN}" --header "Content-Type: application/json" --data @- "${validateCommentsURL}" > /dev/null
  fi

  exit ${validateExitCode}
}
