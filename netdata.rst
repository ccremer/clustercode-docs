Netdata
-------

Overview
^^^^^^^^

Clustercode 1.1 has a netdata plugin which gets the percentage, fps and bitrate
of the current conversion progress. **This plugin works only with ffmpeg-based
nodes!**

.. image:: _static/netdata.png

Installation
^^^^^^^^^^^^

#.  Install netdata according to their instructions.
#.  Install nodejs. If you package manager complains about legacy ``node``, try
    installing ``nodejs``.
#.  On your netdata server, execute:

    .. code-block:: none

        wget https://github.com/ccremer/netdata/raw/clustercode/node.d/clustercode.node.js -O /usr/libexec/netdata/node.d/clustercode.node.js

#.  Open your editor (nano, vim, gedit, etc) and create
    ``/etc/netdata/node.d/clustercode.conf``. In your Distro it might not be
    ``/etc/netdata``, but search for node.d in netdata's config.
#.  Paste and modify hostname and job name. Make sure the API is reachable on
    the configured port:

    .. code-block:: json

        {
            "enable_autodetect": false,
            "update_every": 2,
            "nodes": [
                {
                    "name": "node-1",
                    "hostname": "node-1.ip.or.dns:8080",
                    "update_every": 2,
                    "progress_api": "/api/v1/progress/ffmpeg"
                }
            ]
        }

#.  [Optional] Modify ``/usr/share/netdata/web/dashboard_info.js`` with your
    editor and append the following section before the last closing tag }; at
    the end of the file:

    .. code-block:: none

        'clustercode.progress.percentage': {
            valueRange: "[0, 100]"
        }

#.  Restart netdata service with ``service netdata`` restart
