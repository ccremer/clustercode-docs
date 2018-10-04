Upgrade
=======

This section covers the general instructions on how to upgrade to newer 
versions. Note that when you perform the upgrade, you will lose all current 
encoding jobs. The whole cluster needs to run on the same version. Running 
the cluster with different versions is not supported and will not work. So, 
each time you upgrade, prepare for a cold restart of the cluster.

Preparation
^^^^^^^^^^^

#.  Read the release notes.
#.  Add or modify the settings that changed or were added in the new version 
    either in ``clustercode.properties`` (windows) or as env variables in your 
    ``docker-compose.yml`` (docker/linux) file.
#.  On **ALL** nodes (even arbiter nodes) pull the latest version by running 
    ``docker pull braindoctor/clustercode:latest.``

Upgrading
^^^^^^^^^

Docker
******

#.  Stop **and remove** all containers by running 
    ``docker stop clustercode; docker rm clustercode``. Not a single node should
    be running at this time.
#.  Now, one node after the other, re-create the nodes using 
    ``docker-compose up -d``.

Windows
*******

#.  Download the binaries and replace ``clustercode.jar`` with the one in the 
    zip file.
#.  Restart the nodes by running ``clustercode.cmd``.
