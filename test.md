investigate possibility of migrating from Arbor WS/SOAP

Now that we are already using Sightline API for most of things, it would make sense to drop Arbor WS if not needed.

This would require:
1.  investigating if it's even possible
2.  rewriting the existing code handling Alerts to use sightline
3.  updating the code that uses Managed Objects (they are returned differently by both APIs)
4.  If the format of returned alerts has changed, we need to figure out what to do about the alerts that are already in the database. Some of the ideas include writing format converter or simply having a cutoff point from which the alerts are expected to be in 'new' format.
5.  Verifying if the query behaviour in Sightline is the same (especially when it comes to sanitizing and escaping input)
6.  Updating FakeAPIs
