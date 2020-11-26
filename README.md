# Blast Public

Kubernetes External k8s services.  Pretty much anything not living on the local cluster and that needs external connectivity.

This repo is more of an implementation of various services in the [Blast Apps](https://github.com/ssmiller25/blast-apps) repo.  It can be copied and adjusted to fit one's needs if desired. 

## Principles

- Can run on **any** k8s cluster, but targeting [Civo Kube100 Beta](https://www.civo.com/?ref=39ec91) (Referral link)
  - Will only install Civo Marketplace Apps that would be installed as part of a base [Blast](https://github.com/ssmiller25/blast) cluster.
- Leveraged Kustomize against [Blast Apps](https://github.com/ssmiller25/blast-apps) to perform any needed adjustments.

