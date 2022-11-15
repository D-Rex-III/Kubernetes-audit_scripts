pods_with_liveness_probes=""
pods_without_liveness_probes=""

for namespace in `kubectl get namespaces | grep -v NAME | cut -d ' ' -f 1` ; do
  for pod in `kubectl get pods -n $namespace | grep -v NAME | cut -d ' ' -f 1` ; do
        liveness_check=`kubectl get pods $pod -n $namespace -o yaml | grep livenessProbe`
        if [ ! -z "$liveness_check" ]; then
           pods_with_liveness_probes="$pods_with_liveness_probes\n$pod,$namespace"
        else
           pods_without_liveness_probes="$pods_without_liveness_probes\n$pod,$namespace"
        fi
  done
done

echo "Pods With Liveness Checks"
echo $pods_with_liveness_probes

echo ""
echo ""
echo "========="
echo ""
echo ""

echo "Pods Without Liveness Checks"
echo $pods_without_liveness_probes