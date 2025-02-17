# Project with app and net policies and persistent volumes

This example demonstrates edge application with a *persistent storage* need.
This configuration manages the following Zedcloud objects:
  - brand
  - model
  - datastore
  - image
  - application (with a requirement for *persistent storage*)
  - project with app policy and network policy

It is expected that edge-nodes and the corresponding per-edge-node volume-instances
are managed separately using the corresponding Zedcloud APIs and that the edge-nodes
will be *joined* (configured to be part) of this project as needed.

The important details are:

The application defines an *image* which will become a *second disk* (apart
from the first *image* which will be boot disk in the case of applications of
type VM and root file-system in the case of applications of type container).

A *volume label* selects which volume-instance will be selected when the
edge-app-instance is created and started on an edge-node. That volume-instance
MUST already exist on the edge-node. In the case of edge-app-instances created
automatically as a result of a project app policy one must ensure that the
volume-instance is created on the edge-node BEFORE it joins the project,
otherwise the creation of the edge-app-instances will fail.
      #
NOTE: A volume-instance definition can include both a *label* and *tags*. In
other for an edge-app-instance with this application to be deployed correctly
on an edge-node the volume-instance MUST be created with `label = "volume_color_red"`,
for example if a volume-instance is also created with terraform it can have the
following configuration, again only the `label` is used for this, not the `tags`.

```
    label = "volume_color_red"
    tags = {
      volume_color_red = "red"
    }
```
