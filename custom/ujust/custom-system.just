# vim: set ft=make :
#######################
### custom-system.just
#######################
## Example system configuration commands
## These are simplified examples adapted from Bluefin

# Example toggle command with user choice
# [group('System')]
# toggle-example-feature:
#     #!/usr/bin/bash
#     source /usr/lib/ujust/ujust.sh
#     echo "This is an example toggle command."
#     echo "Current status: [check your status here]"
#     OPTION=$(Choose "Enable" "Disable" "Cancel")
#     case "$OPTION" in
#         "Enable")
#             echo "Enabling feature..."
#             # Add your enable logic here
#             ;;
#         "Disable")
#             echo "Disabling feature..."
#             # Add your disable logic here
#             ;;
#         "Cancel")
#             echo "No changes made."
#             ;;
#     esac

# Clean up container images and volumes
[group('Maintenance')]
clean-containers:
    #!/usr/bin/bash
    echo "Cleaning up Podman containers, images, and volumes..."
    podman system prune -af
    podman volume prune -f
    echo "Cleanup complete!"

