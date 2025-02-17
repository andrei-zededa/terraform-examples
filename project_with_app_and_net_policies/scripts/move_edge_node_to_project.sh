#!/usr/bin/env bash

set -eu;

# Needed tools.
_curl="$(command -v curl) --fail-with-body --fail-early -sSL --no-progress-meter --no-progress-bar";
_jq="$(command -v jq) -er";

# Needed environment variables.
_zedcloud_url="$ZEDEDA_CLOUD_URL";
_zedcloud_token="$ZEDEDA_CLOUD_TOKEN";

node="$1";
proj="$2";

is_uuid() {
	local string="$1";
	[[ $string =~ ^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$ ]]
	return $?;
}

# Get the node config by name or ID.
node_conf="";
node_id="";
if is_uuid "$node"; then
	rc="0";
	result="$($_curl -XGET -H "Content-Type: application/json"		\
		-H "Authorization: Bearer ${_zedcloud_token}"			\
		"https://${_zedcloud_url}/api/v1/devices/id/${node}")" || {
			rc="$?";
			echo "$result" | $_jq '.' || echo "$result";
			exit "$rc";
		};
		# -w '%{stderr}HTTP_STATUS=%{response_code}\n'			\
	node_conf="$result";
	node_id="$node";
else
	rc="0";
	result="$($_curl -XGET -H "Content-Type: application/json"		\
		-H "Authorization: Bearer ${_zedcloud_token}"			\
		"https://${_zedcloud_url}/api/v1/devices/name/${node}")" || {
			rc="$?";
			echo "$result" | $_jq '.' || echo "$result";
			exit "$rc";
		};
		# -w '%{stderr}HTTP_STATUS=%{response_code}\n'			\
	node_conf="$result";
	node_id="$(echo "$node_conf" | $_jq '.id')";
fi

# Get the project or use the ID and assume it's a correct, existing project.
proj_conf="";
proj_id="";
if is_uuid "$proj"; then
	proj_id="$proj";
else
	rc="0";
	result="$($_curl -XGET -H "Content-Type: application/json"		\
		-H "Authorization: Bearer ${_zedcloud_token}"			\
		"https://${_zedcloud_url}/api/v1/projects/name/${proj}")" || {
			rc="$?";
			echo "$result" | $_jq '.' || echo "$result";
			exit "$rc";
		};
		# -w '%{stderr}HTTP_STATUS=%{response_code}\n'			\
	proj_conf="$result";
	proj_id="$(echo "$proj_conf" | $_jq '.id')";
fi

# Build the new node conf.
# shellcheck disable=SC2016 # This is an internal `jq` expansion, not a shell one.
new_node_conf="$(echo "$node_conf" | $_jq --arg proj_id "$proj_id" '.projectId = $proj_id')";

# Send it.
result="$($_curl -XPUT -H "Content-Type: application/json"		\
	-H "Authorization: Bearer ${_zedcloud_token}"			\
	"https://${_zedcloud_url}/api/v1/devices/id/${node_id}"		\
	-d "$new_node_conf")" || rc="$?";
	# -w '%{stderr}HTTP_STATUS=%{response_code}\n'			\

echo "$result" | $_jq '.' || echo "$result";
exit "$rc";
