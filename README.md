docker-webex
============

Run [Cisco WebEx][1] inside docker.

To use it simply clone this repository and run the `webex.sh` script.<br/>
This will build the image and execute firefox in the resulting container
ready to go to the WebEx site.


**Note:** `docker --privileged` will give extended privileges to this container
and it's not recommended!

Status
------

* Audio and various sharing options work.
* Webcam video is limited to view-only. This is a limitation on the
  Linux client.

[1]: https://www.webex.com/test-meeting.html
