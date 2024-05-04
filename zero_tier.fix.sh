#!/bin/bash
#set -x
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
# #   Script for Fixing Issue with ZeroTier after Unraid Server Restart                                                                   # #
# #   (needs ZeroTier container)                                                                                                          # #
# #   by - SpaceInvaderOne                                                                                                                # # 
# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
#
# Main Variables
####################
#
# time to wait from array start for docker service to be running (script will exit if time exceeded)
wait_time_docker_service=300            # max wait time in seconds for Docker service to be ready (default 300second or 5 minutes)
# container name
zerotier_container="ZeroTier"   # change this if your ZeroTier container has a different name
# zero tier container wait times before running
max_checks_zerotier=10                   # max number of checks to see if zero tier is running
wait_time_zerotier_container=30          # wait time between checks
####################

# check if docker service is running before moving forward
check_docker() {
    timeout=$wait_time_docker_service
    elapsed=0
    interval=10  # check every 10 seconds

    while ! /etc/rc.d/rc.docker status &>/dev/null; do
        sleep $interval
        elapsed=$((elapsed + interval))
        if [ $elapsed -ge $timeout ]; then
            echo "Docker service did not start within $timeout seconds. Exiting"
            exit 1
        fi
    done
}
####################

# check if the ZeroTier container is running
check_zerotier_container() {
    count=0
    while [ $count -lt $max_checks_zerotier ]; do
        if docker ps | grep -q "$zerotier_container"; then
            return 0
        else
            sleep $wait_time_zerotier_container
        fi
        count=$((count + 1))
    done
    echo "ZeroTier container is not running after $max_checks_zerotier checks. Exiting"
    exit 1
}
####################

# validate and restart Nginx
validate_and_restart_nginx() {
    if nginx -t; then
        /etc/rc.d/rc.nginx restart
    else
        echo "Nginx test failed."
       
        exit 1
    fi
}
####################
## run functions
#
check_docker
check_zerotier_container
validate_and_restart_nginx
