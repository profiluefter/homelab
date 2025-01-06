# TODO list

* [ ] Deploy [ffs-to-rss](https://github.com/profiluefter/ffs-to-rss)
  * Needs to be built from the repository (no hosted image currently)
    * Well, I could just add that to the repository, but that would be too easy
  * Create Tekton pipeline to deploy it
  * Have a container registry to deploy it to
    * currently not available
* [ ] Container Registry
    * for custom built container images (e.g. fss-to-rss)
    * Harbor?
      * they have [an operator](https://github.com/goharbor/harbor-operator) but it's currently not maintained
* [x] Fix Redis Operator
* [ ] Deploy Overleaf with Authentik Auth
  * Overleaf is open-source
  * OAuth2 authentication can be done using [this project](https://github.com/smhaller/ldap-overleaf-sl)
* [ ] MongoDB Operator
  * Required for overleaf
  * [This community operator](https://github.com/mongodb/mongodb-kubernetes-operator) looks promising
* [ ] Make authentik configuration declarative
  * they have [plans](https://github.com/goauthentik/authentik/issues/5675) to create a kubernetes operator in the future
* [ ] Internal Certificate Authority using certmanager for things like DB connections and internal k8s webhooks
  * maybe activate the webhook feature of the redis operator when this exists
  * use for all postgres and redis instances
