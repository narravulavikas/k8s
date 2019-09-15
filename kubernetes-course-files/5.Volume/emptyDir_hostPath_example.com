apiVersion: v1
kind: Pod
metadata:
  name: emptydir-pod
  namespace: default
  spec:
  containers:
  - name: my-nginx
    image: nginx
    volumeMounts:
    - name: emptydir-vol
      mountPath: /nginxdata
  - name: my-memcach
    image: memcached
    volumeMounts: 
    - name: hostpath-vol
      mountPath: /memchacheddata
  volumes:
  - name: emptydir-vol
    emptyDir: {}
  - name: hostpath-vol
    hostPath:
      path: /data
      type: DirectoryOrCreate
