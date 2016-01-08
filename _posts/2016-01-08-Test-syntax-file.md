---
layout: default
title: This is a page where i test my syntax before i put it in a page.
---

{% highlight python %}

from pushbullet import Pushbullet

pb = Pushbullet('')

push = pb.push_note("FLEXGET ERROR","Flexget gave a CRITICAL error and stopped working")

{% endhighlight %}
