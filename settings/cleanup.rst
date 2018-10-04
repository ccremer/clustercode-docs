Cleanup Settings
^^^^^^^^^^^^^^^^

Variables
*********

.. csv-table::
   :header: "Key", "Type", "Default", "Description"

    CC_CLEANUP_STRATEGY, Ordered Enum, ``STRUCTURED_OUTPUT MARK_SOURCE CHOWN``,	The enabled cleanup strategies.
    CC_CLEANUP_OVERWRITE, Boolean, ``true``, Whether to overwrite existing files in the /output dir.
    CC_CLEANUP_CHOWN_GROUPID, Integer, ``0``, The group id when changing file owner (Linux).
    CC_CLEANUP_CHOWN_USERID, Integer, ``0``, The user id when changing file owner (Linux).
    CC_CLEANUP_MARK_SOURCE_DIR,	String, ``/input/done``, The directory in which the done files will be created.
