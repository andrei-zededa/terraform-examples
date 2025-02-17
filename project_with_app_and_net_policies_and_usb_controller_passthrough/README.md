# Project with app and net policies and USB controller passthrough

This example demonstrates how USB controller passthrough can be configured
through a project app policy.

The important details are:

  - An edge application *interfaces* of type `IO_TYPE_USB_CONTROLLER`, those
    can be *optional* or not.

  - The project app policy specifies that when a corresponding edge-app-instance
    is created and started on an edge-node it will have a *direct attach interface*.
    In the `io` sub-section of that `interface` we have the type `IO_TYPE_USB_CONTROLLER`
    and a match either based on the *logical label* name defined in the model or
    on *tags* defined in the per-edge-node interfaces. The app policy must also
    correctly specify the interface **name** as it was configured in the edge
    application.

  - The model configures the *logical label* of an `io_member` of type (ztype)
    `IO_TYPE_USB_CONTROLLER`.

  - The edge-node can specify tags for each of it's USB controllers. That
    `interface` configuration in the edge-node must match the *logical label*
    defined by the model to correctly attach the tags to the USB controller.
