package app.rbac

default resource_access = false

resource_access {
	is_admin
}

resource_access {
	some resource
	user_resource[resource]

	resource == "*"
}

resource_access {
	some resource
	user_resource[resource]

    input.resource == resource
}

resource_access {
    some i, j

    input.resource == user_hierarchy_resource[i][j]
}

is_admin {
    data.actors[input.organization][input.actor].role == "admin"
}

is_data_manager {
    data.actors[input.organization][input.actor].role == "data_manager"
}

is_user {
    data.actors[input.organization][input.actor].role == "user"
}

user_resource[resource] {
    some i

    resource := data.actors[input.organization][input.actor].resources[i]
}

user_hierarchy_resource[r] {
  	r := graph.reachable(
  	    data.hierarchy_graph[input.organization],
  	    data.actors[input.organization][input.actor].resources
  	)
}
