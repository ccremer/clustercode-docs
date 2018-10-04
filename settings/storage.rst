Storage Settings
----------------

Variables
^^^^^^^^^

.. csv-table::
   :header: "Key", "Type", "Default", "Description"

    CC_MEDIA_INPUT_DIR, String, ``/input``, The root path of your input folder. See below.
    CC_MEDIA_OUTPUT_DIR, String, ``/output``, The root path of your output folder.
    CC_PROFILE_DIR, String, ``/profiles``, The root path of your profiles directory.
    CC_TRANSCODE_TEMP_DIR, String, ``/var/tmp/clustercode``, The location of the temporary files during conversion.

Media Input directory
^^^^^^^^^^^^^^^^^^^^^

clustercode recursively scans this folder for new video files that need
encoding. But, don't just mount your whole library here! clustercode supports
prioritized tasks, meaning that you can control the order of the conversions.
But to find out which order, you need to create **subdirectories** with the
number as priority and put your videos in here. Examples:

-   ``/input/movie1.mp4`` **will not** work!
-   ``/input/0/movie1.mp4`` **will** work.
-   ``/input/1/movie2.mkv`` will be converted before ``/input/0/movie1.mp4``

Now if you don't care about the order, just mount everything in
``/input/0/your-movie-lib-here``. But here is another example, which might make
sense.

-   ``/input/0/movies/loopdaeD.mkv``
-   ``/input/1/series/sgnikiV/season1/ep1.mp4``

Now, every TV episode will be picked up before all movies. If another cluster
member is currently converting the last video in ``/input/1/``, then clustercode
will start looking in ``/input/0``. The numbers do not need to be subsequent,
but the higher it is, the higher the priority. Only use positive integers, so
``/input/0`` is your least important input folder, ever! However the priority
number does not make the conversion faster in any way. Also, note thate the
input directories **need write permissions**.

Ideally every cluster member has access to the same library, meaning that it's a
shared storage (NFS, GlusterFS etc). If you have a cluster member that has
additional or different video files to convert, mount them in another priority.
Example:

#.  Member A has movies and series, which are on a NFS share.
#.  Member B has movies, series and anime, but anime is local storage.
#.  Let's assume that series are more important, you end up with this structure:
    ``/input/0/movies``, ``/input/1/series``. Now mount in member B another
    directory: ``/input/2/anime``.

Of course, only Member B will encode the anime files, as A doesn't have access
to. The way clustercode checks if another task is currently being processed by a
node is to compare the relative file paths, e.g. ``0/movies/a-movie.mkv``. With
different priorities it is ensured that the same video is not being processed
multiple times.

Media Output Directory
^^^^^^^^^^^^^^^^^^^^^^

The converted video files will be stored here. But only after they have been
successfully encoded. There are strategies how the cleanup exactly happens and
which directory structure within is being applied. See :ref:`Cleanup Settings`
for more details.

Profile Directory
^^^^^^^^^^^^^^^^^

The profiles are stored here. At first run, ``default.ffmpeg`` and
``x265.ffmpeg`` will be created here. The default uses common x264 parameters
for ffmpeg and is the last resort for profiles if others couldn't be matched.

Temporary Directory
^^^^^^^^^^^^^^^^^^^

This is where the currently processing video file is being created. In Docker
containers the files are stored with the image filesystem by default, rather
than a tmpfs in ``/tmp``, which consumes RAM. If you have special storage needs,
you can mount it from outside. If a container stops during conversion, this
directory will not get cleaned and the conversion process cannot resume from
where it left.
